import { Popover } from "./../components/popover.js";
import { Pagination } from "./../components/pagination.js";

// 서버에서 내려준 데이터 사용
const users = window.users || [];

// 날짜를 YYYY-MM-DD로 변환 (DB DATETIME 문자열 또는 timestamp 모두 지원)
function formatDate(value) {
  if (!value) return "";
  // DB DATETIME 문자열인 경우 (예: "2025-01-01 00:00:00")
  if (typeof value === "string") {
    return value.substring(0, 10);
  }
  // timestamp(number)인 경우 (레거시 호환)
  const date = new Date(value);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  return `${year}-${month}-${day}`;
}

let searchState = {
  keyword: "",
};
let sortState = { key: null, dir: null, type: "string" };

// Pagination 컴포넌트
const pagination = new Pagination({
  infoSelector: "#pagination-info",
  controlsSelector: "#pagination-controls",
  limit: 10,
  onPageChange: () => renderTable(),
});

let userMorePopovers = [];

const tbody = document.getElementById("users-table-body");
const headerButtons = document.querySelectorAll(".header-sort-btn");

function renderTable() {
  // 정렬 적용된 배열
  let list = [...users];
  if (searchState.keyword) {
    list = list.filter((u) =>
      u?.userName?.toLowerCase()?.includes(searchState.keyword),
    );
  }
  if (sortState.key) {
    list.sort((a, b) =>
      compareByKey(a, b, sortState.key, sortState.dir, sortState.type),
    );
  }
  const totalCount = list.length;
  const startIndex = pagination.getStartIndex();
  const endIndex = pagination.getEndIndex();
  const paginatedList = list.slice(startIndex, endIndex);

  const blankCount = pagination.getLimit() - paginatedList.length;
  for (let i = 0; i < blankCount; i++) {
    paginatedList.push({
      userNumber: "",
      userName: "",
      name: "",
      email: "",
    });
  }

  userMorePopovers.forEach((popover) => {
    popover.free();
  });
  userMorePopovers = [];

  // tbody 채우기
  tbody.innerHTML = "";

  paginatedList.forEach((u) => {
    const tr = document.createElement("tr");
    tr.className = "table-row";
    tr.innerHTML = `
      <td class="table-cell">
        <div class="table-cell-wrapper">${u.userNumber}</div>
      </td>
      <td class="table-cell">
        <div class="table-cell-wrapper">${u.userName}</div>
      </td>
      <td class="table-cell">
        <div class="table-cell-wrapper">${u.email}</div>
      </td>
      <td class="table-cell">
        <div class="table-cell-wrapper">${formatDate(u.createdAt)}</div>
      </td>
      <td class="table-cell">
      ${u.userNumber
        ? `
            <div class="btn ghost icon-only" data-popover-trigger="um-${u.userNumber}">
              <i data-lucide="ellipsis" width="16"></i>
            </div>
            <div class="popover" data-popover-content="um-${u.userNumber}"></div>
          `
        : ""
      }</td>
    `;
    tbody.appendChild(tr);

    if (u.userNumber) {
      const popover = new Popover(`um-${u.userNumber}`);
      userMorePopovers.push(popover);

      popover.addOpenEvent((e) => {
        e.trigger.classList.add("active");

        const content = e.content;

        content.innerHTML = `
          <a href="${window.pagePath}/detail?id=${u.userNumber}">
            <button class="btn sm ghost">
              <i data-lucide="eye"></i>
              <span>상세보기</span>
            </button>
          </a>
          <button class="btn sm ghost btn-delete-user" style="color: var(--color-destructive-foreground);">
            <i data-lucide="user-x"></i>
            <span>계정 삭제</span>
          </button>
        `;

        lucide.createIcons({
          root: content,
        });

        // 삭제 버튼 이벤트
        const deleteBtn = content.querySelector(".btn-delete-user");
        if (deleteBtn) {
          deleteBtn.addEventListener("click", () => {
            popover.close();
            if (!confirm(`사용자 "${u.userName}"을(를) 삭제하시겠습니까?`)) return;

            const params = new URLSearchParams();
            params.set("action", "delete");
            params.set("userNumber", u.userNumber);

            fetch(window.ctx + "/admin/users/detail", {
              method: "POST",
              headers: {
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
              },
              body: params.toString(),
            })
              .then((res) => res.json())
              .then((data) => {
                alert(data.message);
                if (data.success) location.reload();
              })
              .catch(() => alert("요청 중 오류가 발생했습니다."));
          });
        }

        // 상세보기 클릭 시 팝오버 닫기
        const viewLink = content.querySelector("a");
        if (viewLink) {
          viewLink.addEventListener("click", () => popover.close());
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

    const dirBtns = content.querySelectorAll(`button[data-dir]`);

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

const searchInput = document.getElementById("search-user");

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
