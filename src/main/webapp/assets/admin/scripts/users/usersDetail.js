// 유저 상세 페이지 스크립트

const userDetail = window.userDetail || null;

/**
 * 날짜를 YYYY-MM-DD HH:mm 형식으로 변환
 * DB DATETIME 문자열 또는 UTC timestamp 모두 지원
 * @param {string|number} value - DB DATETIME 문자열 또는 UTC 타임스탬프
 * @returns {string} 포맷된 날짜 문자열
 */
function formatDateTime(value) {
  if (!value) return "";
  // DB DATETIME 문자열인 경우 (예: "2025-01-01 00:00:00")
  if (typeof value === "string") {
    // "YYYY-MM-DD HH:mm:ss" → "YYYY-MM-DD HH:mm"
    return value.substring(0, 16);
  }
  // timestamp(number)인 경우 (레거시 호환)
  const date = new Date(value);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  const hour = String(date.getHours()).padStart(2, "0");
  const minute = String(date.getMinutes()).padStart(2, "0");
  return `${year}-${month}-${day} ${hour}:${minute}`;
}

/** 편집 모드 여부 */
let isEditing = false;

/**
 * 페이지 초기화
 */
function initPage() {
  // 타임스탬프 요소들 포맷팅
  const timestampElements = document.querySelectorAll("[data-timestamp]");
  timestampElements.forEach((el) => {
    const raw = el.getAttribute("data-timestamp");
    if (raw) {
      // 숫자형이면 parseInt, 아니면 문자열 그대로
      const value = /^\d+$/.test(raw) ? parseInt(raw) : raw;
      el.textContent = formatDateTime(value);
    }
  });

  // 버튼 이벤트 바인딩
  initUserActions();

  // Lucide 아이콘 초기화
  if (typeof lucide !== "undefined") {
    lucide.createIcons();
  }
}

/**
 * 사용자 관리 버튼 이벤트 바인딩
 */
function initUserActions() {
  if (!userDetail) return;

  const btnEdit = document.getElementById("btn-edit");
  const btnSave = document.getElementById("btn-save");
  const btnCancel = document.getElementById("btn-cancel");
  const btnResetPw = document.getElementById("btn-reset-pw");
  const btnDelete = document.getElementById("btn-delete");

  if (btnEdit) btnEdit.addEventListener("click", enterEditMode);
  if (btnSave) btnSave.addEventListener("click", saveUser);
  if (btnCancel) btnCancel.addEventListener("click", cancelEditMode);

  if (btnResetPw) {
    btnResetPw.addEventListener("click", () => {
      alert("비밀번호 재설정 기능은 준비 중입니다.");
    });
  }

  if (btnDelete) btnDelete.addEventListener("click", deleteUser);

  // ESC 키로 편집 취소
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape" && isEditing) {
      cancelEditMode();
    }
  });
}

/**
 * 편집 모드 진입 — data-field가 있는 span을 input으로 교체
 */
function enterEditMode() {
  if (isEditing) return;
  isEditing = true;

  const fields = document.querySelectorAll("[data-field]");
  fields.forEach((span) => {
    const field = span.getAttribute("data-field");
    const value = span.textContent.trim();

    // 기존 텍스트를 숨기고 input 삽입
    span.setAttribute("data-original", value);
    span.style.display = "none";

    const input = document.createElement("input");
    input.type = field === "email" ? "email" : "text";
    input.className = "inline-edit-input";
    input.value = value;
    input.setAttribute("data-edit-field", field);
    input.placeholder = span.previousElementSibling
      ? span.previousElementSibling.textContent
      : "";

    span.parentNode.insertBefore(input, span.nextSibling);
  });

  // 첫 번째 input에 포커스
  const firstInput = document.querySelector(".inline-edit-input");
  if (firstInput) firstInput.focus();

  toggleEditUI(true);
}

/**
 * 편집 모드 취소 — input을 제거하고 원래 span 복원
 */
function cancelEditMode() {
  if (!isEditing) return;
  isEditing = false;

  // input 제거
  document.querySelectorAll(".inline-edit-input").forEach((input) => input.remove());

  // span 복원
  document.querySelectorAll("[data-field]").forEach((span) => {
    span.style.display = "";
  });

  toggleEditUI(false);
}

/**
 * 편집 UI 토글 (저장/취소 버튼 표시, 기존 버튼 숨김)
 */
function toggleEditUI(editing) {
  const editActions = document.querySelector(".edit-actions");
  const btnEdit = document.getElementById("btn-edit");
  const btnResetPw = document.getElementById("btn-reset-pw");
  const groupDanger = document.getElementById("group-danger");

  if (editActions) editActions.style.display = editing ? "flex" : "none";
  if (btnEdit) btnEdit.style.display = editing ? "none" : "";
  if (btnResetPw) btnResetPw.style.display = editing ? "none" : "";
  if (groupDanger) groupDanger.style.display = editing ? "none" : "";

  // 편집 모드일 때 info-item에 시각적 표시
  document.querySelectorAll("[data-field]").forEach((span) => {
    const item = span.closest(".info-item");
    if (item) {
      item.classList.toggle("editing", editing);
    }
  });
}

/**
 * 사용자 정보 저장
 */
function saveUser() {
  const inputs = document.querySelectorAll(".inline-edit-input");
  const data = {};
  inputs.forEach((input) => {
    data[input.getAttribute("data-edit-field")] = input.value.trim();
  });

  // 간단한 유효성 검증
  if (!data.name) {
    alert("이름을 입력해 주세요.");
    document.querySelector('[data-edit-field="name"]')?.focus();
    return;
  }
  if (!data.email) {
    alert("이메일을 입력해 주세요.");
    document.querySelector('[data-edit-field="email"]')?.focus();
    return;
  }

  const params = new URLSearchParams();
  params.set("action", "update");
  params.set("userNumber", userDetail.userNumber);
  params.set("name", data.name);
  params.set("email", data.email);
  params.set("phoneNumber", data.phoneNumber || "");

  fetch(window.ctx + "/admin/users/detail", {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
    },
    body: params.toString(),
  })
    .then((res) => res.json())
    .then((result) => {
      alert(result.message);
      if (result.success) location.reload();
    })
    .catch(() => alert("요청 중 오류가 발생했습니다."));
}

/**
 * 사용자 삭제
 */
function deleteUser() {
  if (
    !confirm(
      `사용자 "${userDetail.name || userDetail.userName}"을(를) 삭제하시겠습니까?`,
    )
  )
    return;

  const params = new URLSearchParams();
  params.set("action", "delete");
  params.set("userNumber", userDetail.userNumber);

  fetch(window.ctx + "/admin/users/detail", {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
    },
    body: params.toString(),
  })
    .then((res) => res.json())
    .then((result) => {
      alert(result.message);
      if (result.success) location.href = window.ctx + "/admin/users";
    })
    .catch(() => alert("요청 중 오류가 발생했습니다."));
}

// DOM 로드 시 초기화
document.addEventListener("DOMContentLoaded", initPage);
