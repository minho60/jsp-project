import { Popover } from "./../components/popover.js";
import { Tabs } from "./../components/tabs.js";
import { Pagination } from "./../components/pagination.js";

// 문의 상태 enum
const InquiryStatus = Object.freeze({
  ALL: {
    key: "ALL",
    label: "전체",
  },
  WAITING: {
    key: "WAITING",
    label: "답변대기",
  },
  ANSWERED: {
    key: "ANSWERED",
    label: "답변완료",
  },
});

// 문의 유형 enum
const InquiryType = Object.freeze({
  ALL: {
    key: "ALL",
    label: "전체 유형",
  },
  PRODUCT: {
    key: "PRODUCT",
    label: "상품문의",
  },
  DELIVERY: {
    key: "DELIVERY",
    label: "배송문의",
  },
  EXCHANGE: {
    key: "EXCHANGE",
    label: "교환/반품",
  },
  PAYMENT: {
    key: "PAYMENT",
    label: "결제문의",
  },
  ETC: {
    key: "ETC",
    label: "기타",
  },
});

function getInquiryStatusByKey(key) {
  if (!key) return null;
  const statuses = Object.values(InquiryStatus);
  return statuses.find((status) => status.key === key) || null;
}

function getInquiryTypeByKey(key) {
  if (!key) return null;
  const types = Object.values(InquiryType);
  return types.find((type) => type.key === key) || null;
}

// 유형별 색상 매핑
const typeColorMap = {
  PRODUCT: "blue",
  DELIVERY: "teal",
  EXCHANGE: "orange",
  PAYMENT: "violet",
  ETC: "gray",
};

// 상태별 색상 매핑
const statusColorMap = {
  WAITING: "amber",
  ANSWERED: "emerald",
};

// 탭 목록 생성
const tabList = document.querySelector(".tab-list");

for (let status of Object.values(InquiryStatus)) {
  tabList.insertAdjacentHTML(
    "beforeend",
    `
    <button class="tab" data-status="${status.key}">
      <span>${status.label}</span>
    </button>
    `,
  );
}

// 전체 탭 활성화
tabList.querySelector("[data-status=ALL]").classList.add("active");

// 대기 개수 표시
const inquiryData = window.inquiryData || [];
const waitingCount = inquiryData.filter((q) => q.status === "WAITING").length;
const answeredCount = inquiryData.filter((q) => q.status === "ANSWERED").length;

if (inquiryData.length > 0) {
  tabList
    .querySelector("[data-status=ALL]")
    .insertAdjacentHTML(
      "beforeend",
      `<div class="badge primary full">${inquiryData.length}</div>`,
    );
}

if (waitingCount > 0) {
  tabList
    .querySelector("[data-status=WAITING]")
    .insertAdjacentHTML(
      "beforeend",
      `<div class="badge primary full">${waitingCount}</div>`,
    );
}

if (answeredCount > 0) {
  tabList
    .querySelector("[data-status=ANSWERED]")
    .insertAdjacentHTML(
      "beforeend",
      `<div class="badge primary full">${answeredCount}</div>`,
    );
}

new Tabs(tabList);

function getSelectedStatus() {
  const activeTab = tabList.querySelector(".active");
  return activeTab ? activeTab.getAttribute("data-status") : "ALL";
}

tabList.addEventListener("tabchange", () => {
  pagination.reset();
  renderTable();
});

// 상태 관리
let searchState = {
  keyword: "",
};
let typeFilter = "ALL";
let sortState = { key: "inquiryNumber", dir: "desc", type: "number" };

// Pagination 컴포넌트
const pagination = new Pagination({
  infoSelector: "#pagination-info",
  controlsSelector: "#pagination-controls",
  limit: 10,
  onPageChange: () => renderTable(),
});

let inquiryMorePopovers = [];

const tbody = document.getElementById("inquiry-table-body");
const headerButtons = document.querySelectorAll(".header-sort-btn");
const typeFilterSelect = document.getElementById("type-filter");
const searchInput = document.getElementById("search-inquiry");

// type-filter 옵션 동적 생성
for (const type of Object.values(InquiryType)) {
  const option = document.createElement("option");
  option.value = type.key;
  option.textContent = type.label;
  typeFilterSelect.appendChild(option);
}

// 날짜 포맷 함수
function formatDate(timestamp) {
  if (!timestamp) return "";
  const date = new Date(timestamp);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");
  return `${year}-${month}-${day} ${hours}:${minutes}`;
}

// 테이블 렌더링
function renderTable() {
  let list = [...inquiryData];

  // 상태 필터
  const selectedStatus = getSelectedStatus();
  if (selectedStatus && selectedStatus !== "ALL") {
    list = list.filter((q) => q.status === selectedStatus);
  }

  // 유형 필터
  if (typeFilter && typeFilter !== "ALL") {
    list = list.filter((q) => q.type === typeFilter);
  }

  // 검색 필터
  if (searchState.keyword) {
    list = list.filter(
      (q) =>
        q.title?.toLowerCase().includes(searchState.keyword) ||
        q.content?.toLowerCase().includes(searchState.keyword),
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
  const paginatedList = list.slice(startIndex, endIndex);

  // 빈 행 채우기
  const blankCount = pagination.getLimit() - paginatedList.length;
  for (let i = 0; i < blankCount; i++) {
    paginatedList.push({
      inquiryNumber: "",
      type: "",
      title: "",
      userName: "",
      createdAt: "",
      status: "",
    });
  }

  // 기존 Popover 정리
  inquiryMorePopovers.forEach((popover) => {
    popover.free();
  });
  inquiryMorePopovers = [];

  // tbody 채우기
  tbody.innerHTML = "";

  paginatedList.forEach((q) => {
    const tr = document.createElement("tr");
    tr.className = "table-row";
    tr.innerHTML = `
      <td class="table-cell">
        <div class="table-cell-wrapper">${q.inquiryNumber}</div>
      </td>
      <td class="table-cell">
        ${
          q.type
            ? `<span class="badge ${typeColorMap[q.type] || "gray"}">${getInquiryTypeByKey(q.type)?.label || q.type}</span>`
            : ""
        }
      </td>
      <td class="table-cell">
        <div class="table-cell-wrapper">${q.title || ""}</div>
      </td>
      <td class="table-cell">
        <div class="table-cell-wrapper">${q.userName || ""}</div>
      </td>
      <td class="table-cell">
        <div class="table-cell-wrapper">${formatDate(q.createdAt)}</div>
      </td>
      <td class="table-cell">
        ${
          q.status
            ? `
            <span class="badge ${statusColorMap[q.status] || "gray"}">
              ${q.status === "WAITING" ? '<i data-lucide="clock" width="12"></i>' : '<i data-lucide="check-circle" width="12"></i>'}
              <span>${getInquiryStatusByKey(q.status)?.label || q.status}</span>
            </span>
            `
            : ""
        }
      </td>
      <td class="table-cell">
        ${
          q.inquiryNumber
            ? `
            <div class="btn ghost icon-only" data-popover-trigger="im-${q.inquiryNumber}">
              <i data-lucide="ellipsis" width="16"></i>
            </div>
            <div class="popover" data-popover-content="im-${q.inquiryNumber}"></div>
            `
            : ""
        }
      </td>
    `;
    tbody.appendChild(tr);

    // Popover 생성
    if (q.inquiryNumber) {
      const popover = new Popover(`im-${q.inquiryNumber}`);
      inquiryMorePopovers.push(popover);

      popover.addOpenEvent((e) => {
        e.trigger.classList.add("active");

        const content = e.content;
        content.innerHTML = `
          <a href="${window.pagePath}/detail?id=${q.inquiryNumber}">
            <button class="btn sm ghost">
              <i data-lucide="info"></i>
              <span>상세 보기</span>
            </button>
          </a>
          ${
            q.status === "WAITING"
              ? `
            <a href="${window.pagePath}/detail?id=${q.inquiryNumber}">
              <button class="btn sm ghost">
                <i data-lucide="send"></i>
                <span>답변 작성</span>
              </button>
            </a>
            `
              : ""
          }
        `;

        lucide.createIcons({
          root: content,
        });

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
    }
  });

  pagination.update(totalCount);
  lucide.createIcons();
}

function compareByKey(a, b, key, dir, type = "string") {
  const va = (a[key] || "").toString().toLowerCase();
  const vb = (b[key] || "").toString().toLowerCase();
  if (type === "number") {
    return dir === "asc" ? va - vb : vb - va;
  }
  if (va < vb) return dir === "asc" ? -1 : 1;
  if (va > vb) return dir === "asc" ? 1 : -1;
  return 0;
}

function applySort(key, dir, type) {
  sortState = { key, dir, type };
  pagination.reset();
  renderTable();

  // 헤더 아이콘 업데이트
  headerButtons.forEach((btn) => {
    const icon = btn.querySelector(".header-icon");
    if (!icon) return;
    if (btn.getAttribute("data-sort-key") === key) {
      icon.setAttribute(
        "data-lucide",
        dir === "asc" ? "arrow-up" : "arrow-down",
      );
    } else {
      icon.setAttribute("data-lucide", "chevrons-up-down");
    }
  });
  lucide.createIcons();
  renderTable();
}

// 헤더 버튼 클릭 이벤트
headerButtons.forEach((btn) => {
  const key = btn.getAttribute("data-sort-key");
  const type = btn.getAttribute("data-sort-type") || "string";

  const popover = new Popover(key);

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

    lucide.createIcons({
      root: content,
    });

    const dirBtns = content.querySelectorAll("button[data-dir]");
    for (let dirBtn of dirBtns) {
      dirBtn.addEventListener("click", (ev) => {
        const btn = ev.target.closest("button");
        if (!btn) return;
        const dir = btn.getAttribute("data-dir");
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

// 유형 필터 이벤트
typeFilterSelect.addEventListener("change", (e) => {
  typeFilter = e.target.value;
  pagination.reset();
  renderTable();
});

// 검색 이벤트
searchInput.addEventListener("input", (e) => {
  searchState.keyword = e.target.value.trim().toLowerCase();
  pagination.reset();
  renderTable();
});

// 초기 렌더
document.addEventListener("DOMContentLoaded", () => {
  renderTable();
  lucide.createIcons();
});
