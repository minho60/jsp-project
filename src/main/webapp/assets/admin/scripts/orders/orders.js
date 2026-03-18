/**
 * 주문 내역 페이지 스크립트
 */

import { Popover } from "../components/popover.js";
import { Tabs } from "../components/tabs.js";
import { Pagination } from "../components/pagination.js";

// 주문 상태 enum (탭 + 뱃지 용도)
const OrderStatus = Object.freeze({
  ALL: { key: "ALL", label: "전체" },
  PAYMENT_PENDING: { key: "PAYMENT_PENDING", label: "결제대기" },
  PREPARING_PRODUCT: { key: "PREPARING_PRODUCT", label: "상품준비중" },
  SHIPPING_PENDING: { key: "SHIPPING_PENDING", label: "배송대기" },
  SHIPPING_IN_PROGRESS: { key: "SHIPPING_IN_PROGRESS", label: "배송중" },
  DELIVERED: { key: "DELIVERED", label: "배송완료" },
  CANCEL_REQUESTED: { key: "CANCEL_REQUESTED", label: "취소접수" },
  CANCELLING: { key: "CANCELLING", label: "취소중" },
  CANCELLED: { key: "CANCELLED", label: "취소완료" },
  RETURN_REQUESTED: { key: "RETURN_REQUESTED", label: "반품요청" },
  RETURN_PICKUP_IN_PROGRESS: { key: "RETURN_PICKUP_IN_PROGRESS", label: "반품수거중" },
  RETURNED: { key: "RETURNED", label: "반품완료" },
});

// 상태별 뱃지 색상 매핑
const STATUS_BADGE_COLORS = {
  PAYMENT_PENDING: "amber",
  PREPARING_PRODUCT: "blue",
  SHIPPING_PENDING: "purple",
  SHIPPING_IN_PROGRESS: "primary",
  DELIVERED: "green",
  CANCEL_REQUESTED: "amber",
  CANCELLING: "gray",
  CANCELLED: "red",
  RETURN_REQUESTED: "amber",
  RETURN_PICKUP_IN_PROGRESS: "gray",
  RETURNED: "red",
};

// 페이지네이션 설정
const ITEMS_PER_PAGE = 10;

// 전역 상태
const orders = window.orders || [];
let sortState = { key: "orderNumber", dir: "desc", type: "number" };
let searchKeyword = "";
let selectedTabStatus = "ALL";
let selectedMemberFilter = "";

// 팝오버 인스턴스 관리
let orderMorePopovers = [];
let headerPopovers = [];

// Pagination 인스턴스
let pagination = null;

// DOM 요소
const tabList = document.getElementById("order-tab-list");
const tbody = document.getElementById("orders-table-body");

// ─── 초기화 ─────────────────────────────────────

document.addEventListener("DOMContentLoaded", () => {
  initTabs();
  initHeaderPopovers();
  initPagination();
  initFilters();
  renderTable();
  lucide.createIcons();
});

// ─── 탭 ─────────────────────────────────────────

function initTabs() {
  // 탭 동적 생성
  for (const status of Object.values(OrderStatus)) {
    const count = getOrderCountByStatus(status.key);
    tabList.insertAdjacentHTML(
      "beforeend",
      `
      <button class="tab" data-status="${status.key}">
        <span>${status.label}</span>
        ${count > 0 ? `<div class="badge primary full">${count}</div>` : ""}
      </button>
      `,
    );
  }

  // 전체 탭 활성화
  tabList.querySelector("[data-status=ALL]").classList.add("active");

  new Tabs(tabList);

  // 탭 변경 이벤트
  tabList.addEventListener("tabchange", () => {
    selectedTabStatus = getSelectedTabStatus();
    pagination.reset();
    renderTable();
  });
}

function getOrderCountByStatus(statusKey) {
  if (statusKey === "ALL") return orders.length;
  return orders.filter((o) => o.orderState === statusKey).length;
}

function getSelectedTabStatus() {
  const activeTab = tabList.querySelector(".active");
  return activeTab ? activeTab.getAttribute("data-status") : "ALL";
}

// ─── 헤더 정렬 팝오버 ──────────────────────────────

function initHeaderPopovers() {
  const headerButtons = document.querySelectorAll(".header-sort-btn");

  headerButtons.forEach((btn) => {
    const key = btn.dataset.sortKey;
    const type = btn.dataset.sortType || "string";

    const popover = new Popover(key);
    headerPopovers.push(popover);

    popover.addOpenEvent((e) => {
      e.trigger.classList.add("active");
      const content = e.content;

      content.innerHTML = `
        <button data-dir="asc" class="btn sm ghost">
          <i data-lucide="arrow-up${type === "number" ? "-0-1" : ""}"></i>
          <span>오름차순</span>
        </button>
        <button data-dir="desc" class="btn sm ghost">
          <i data-lucide="arrow-down${type === "number" ? "-1-0" : ""}"></i>
          <span>내림차순</span>
        </button>
      `;

      lucide.createIcons({ root: content });

      const dirBtns = content.querySelectorAll("button[data-dir]");
      for (let dirBtn of dirBtns) {
        dirBtn.addEventListener("click", (ev) => {
          const btn = ev.target.closest("button");
          if (!btn) return;
          const dir = btn.dataset.dir;
          applySort(key, dir, type);
          popover.close();
        });
      }
    });

    popover.addCloseEvent((e) => {
      e.trigger.classList.remove("active");
      e.content.innerHTML = "";
    });
  });
}

function applySort(key, dir, type) {
  sortState = { key, dir, type };
  pagination.reset();
  renderTable();

  // 헤더 아이콘 업데이트
  const headerButtons = document.querySelectorAll(".header-sort-btn");
  headerButtons.forEach((btn) => {
    const icon = btn.querySelector(".header-icon");
    if (!icon) return;
    if (btn.dataset.sortKey === key) {
      icon.setAttribute(
        "data-lucide",
        dir === "asc" ? "arrow-up" : "arrow-down",
      );
    } else {
      icon.setAttribute("data-lucide", "chevrons-up-down");
    }
  });
  lucide.createIcons();
}

// ─── 페이지네이션 ───────────────────────────────────

function initPagination() {
  pagination = new Pagination({
    infoSelector: "#pagination-info",
    controlsSelector: "#pagination-controls",
    limit: ITEMS_PER_PAGE,
    onPageChange: () => renderTable(),
  });
}

// ─── 필터 / 검색 ────────────────────────────────────

function initFilters() {
  const memberFilter = document.getElementById("member-filter");
  const searchInput = document.getElementById("search-order");

  memberFilter?.addEventListener("change", () => {
    selectedMemberFilter = memberFilter.value;
    pagination.reset();
    renderTable();
  });

  searchInput?.addEventListener("input", debounce(() => {
    searchKeyword = searchInput.value.trim().toLowerCase();
    pagination.reset();
    renderTable();
  }, 300));
}

// ─── 테이블 렌더링 ───────────────────────────────────

function renderTable() {
  // 기존 팝오버 해제
  orderMorePopovers.forEach((p) => p.free());
  orderMorePopovers = [];

  // 필터 적용
  let list = [...orders];

  // 탭 상태 필터
  if (selectedTabStatus && selectedTabStatus !== "ALL") {
    list = list.filter((o) => o.orderState === selectedTabStatus);
  }

  // 회원/비회원 필터
  if (selectedMemberFilter === "member") {
    list = list.filter((o) => o.memberNumber);
  } else if (selectedMemberFilter === "guest") {
    list = list.filter((o) => !o.memberNumber);
  }

  // 검색
  if (searchKeyword) {
    list = list.filter((o) =>
      o?.orderName?.toLowerCase()?.includes(searchKeyword),
    );
  }

  // 정렬
  if (sortState.key) {
    list.sort((a, b) =>
      compareByKey(a, b, sortState.key, sortState.dir, sortState.type),
    );
  }

  const totalCount = list.length;
  const startIndex = pagination.getStartIndex();
  const endIndex = pagination.getEndIndex();
  const pageOrders = list.slice(startIndex, endIndex);

  // 빈 상태
  if (pageOrders.length === 0) {
        tbody.innerHTML = `
      <tr>
        <td colspan="8" class="table-cell">
          <div class="empty-state">
            <i data-lucide="package-x" class="empty-state-icon"></i>
            <div class="empty-state-title">주문 내역이 없습니다</div>
            <div class="empty-state-description">조건에 맞는 주문이 없습니다</div>
          </div>
        </td>
      </tr>
    `;
    pagination.update(totalCount);
    lucide.createIcons();
    return;
  }

  // 빈 행 채우기
  const blankCount = ITEMS_PER_PAGE - pageOrders.length;

  tbody.innerHTML = "";

  pageOrders.forEach((o) => {
    const statusInfo = getOrderStatusByKey(o.orderState);
    const badgeColor = STATUS_BADGE_COLORS[o.orderState] || "gray";

    const tr = document.createElement("tr");
    tr.className = "table-row";
    tr.dataset.orderId = o.orderNumber;

    tr.innerHTML = `
      <td class="table-cell">
        <div class="table-cell-wrapper">${o.orderNumber}</div>
      </td>
      <td class="table-cell">
        <div class="table-cell-wrapper orderer-cell">
          ${o.memberNumber
            ? `<span class="badge blue sm">회원</span> <span>${escapeHtml(o.memberId)} (${escapeHtml(o.ordererName)})</span>`
            : `<span class="badge gray sm">비회원</span> <span>${escapeHtml(o.ordererName)}</span>`
          }
        </div>
      </td>
      <td class="table-cell order-name-cell">
        <div class="table-cell-wrapper">
          <div class="order-name">${escapeHtml(o.orderName || "")}</div>
        </div>
      </td>
      <td class="table-cell">
        <div class="table-cell-wrapper">${o.orderDate || ""}</div>
      </td>
      <td class="table-cell">
        ${o.orderState
        ? `<span class="badge ${badgeColor}">${statusInfo ? statusInfo.label : o.orderState}</span>`
        : ""
      }
      </td>
      <td class="table-cell">
        <div class="table-cell-wrapper quantity-cell">${o.totalQuantity}</div>
      </td>
      <td class="table-cell">
        <div class="table-cell-wrapper price-cell">${formatPrice(o.totalAmount)}</div>
      </td>
      <td class="table-cell">
        <div class="btn ghost icon-only" data-popover-trigger="om-${o.orderNumber}">
          <i data-lucide="ellipsis" width="16"></i>
        </div>
        <div class="popover" data-popover-content="om-${o.orderNumber}"></div>
      </td>
    `;

    tbody.appendChild(tr);

    // 팝오버 생성
    const popover = new Popover(`om-${o.orderNumber}`);
    orderMorePopovers.push(popover);

    popover.addOpenEvent((e) => {
      e.trigger.classList.add("active");
      const content = e.content;

      content.innerHTML = `
        <a href="${window.pagePath}/detail?id=${o.orderNumber}">
          <button class="btn sm ghost">
            <i data-lucide="info"></i>
            <span>상세 보기</span>
          </button>
        </a>
      `;

      lucide.createIcons({ root: content });

      const btns = content.querySelectorAll("button");
      for (let btn of btns) {
        btn.addEventListener("click", () => {
          popover.close();
        });
      }
    });

    popover.addCloseEvent((e) => {
      e.trigger.classList.remove("active");
      e.content.innerHTML = "";
    });
  });

  // 부족한 행을 빈 행으로 채우기
  for (let i = 0; i < blankCount; i++) {
    const tr = document.createElement("tr");
    tr.className = "table-row";
    tr.innerHTML = `
      <td class="table-cell"><div class="table-cell-wrapper">&nbsp;</div></td>
      <td class="table-cell"><div class="table-cell-wrapper">&nbsp;</div></td>
      <td class="table-cell order-name-cell"><div class="table-cell-wrapper">&nbsp;</div></td>
      <td class="table-cell"><div class="table-cell-wrapper">&nbsp;</div></td>
      <td class="table-cell"></td>
      <td class="table-cell"><div class="table-cell-wrapper">&nbsp;</div></td>
      <td class="table-cell"><div class="table-cell-wrapper">&nbsp;</div></td>
      <td class="table-cell"></td>
    `;
    tbody.appendChild(tr);
  }

  pagination.update(totalCount);
  lucide.createIcons();
}

// ─── 유틸리티 함수 ────────────────────────────────────

function getOrderStatusByKey(key) {
  if (!key) return null;
  const statuses = Object.values(OrderStatus);
  return statuses.find((status) => status.key === key) || null;
}

function compareByKey(a, b, key, dir, type = "string") {
  let va = a[key];
  let vb = b[key];

  if (type === "number") {
    va = Number(va) || 0;
    vb = Number(vb) || 0;
  } else {
    va = String(va || "").toLowerCase();
    vb = String(vb || "").toLowerCase();
  }

  if (va < vb) return dir === "asc" ? -1 : 1;
  if (va > vb) return dir === "asc" ? 1 : -1;
  return 0;
}

function escapeHtml(str) {
  if (!str) return "";
  const div = document.createElement("div");
  div.textContent = str;
  return div.innerHTML;
}

function formatPrice(price) {
  if (!price && price !== 0) return "";
  return new Intl.NumberFormat("ko-KR", {
    style: "currency",
    currency: "KRW",
  }).format(price);
}

function debounce(fn, delay) {
  let timer;
  return function (...args) {
    clearTimeout(timer);
    timer = setTimeout(() => fn.apply(this, args), delay);
  };
}
