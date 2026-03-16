import { Modal } from "./../components/modal.js";

// 날짜 포맷 함수
function formatDateTime(timestamp) {
  if (!timestamp) return "";
  const date = new Date(timestamp);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");
  return `${year}-${month}-${day} ${hours}:${minutes}`;
}

// 날짜 표시 엘리먼트 업데이트
function updateDateElements() {
  const dateElements = document.querySelectorAll("[data-timestamp]");
  dateElements.forEach((el) => {
    const timestamp = parseInt(el.getAttribute("data-timestamp"));
    if (timestamp) {
      el.textContent = formatDateTime(timestamp);
    }
  });
}

// Modal 컴포넌트 인스턴스 생성
const answerModal = new Modal("answer-modal");

// 모달 열릴 때 textarea에 포커스
answerModal.addOpenEvent(() => {
  const textarea = document.getElementById("answer-textarea");
  if (textarea) {
    textarea.focus();
  }
});

// 답변 제출 (서버 API 호출)
const submitAnswerBtn = document.getElementById("submit-answer-btn");
const answerTextarea = document.getElementById("answer-textarea");

if (submitAnswerBtn) {
  submitAnswerBtn.addEventListener("click", () => {
    const answer = answerTextarea?.value?.trim();

    if (!answer) {
      alert("답변 내용을 입력해주세요.");
      return;
    }

    const inquiry = window.inquiryDetail;
    if (!inquiry) return;

    const params = new URLSearchParams();
    params.set("action", "saveAnswer");
    params.set("inquiryNumber", inquiry.inquiryNumber);
    params.set("answer", answer);

    fetch(window.ctx + "/admin/inquiries/detail", {
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

// 초기화
document.addEventListener("DOMContentLoaded", () => {
  updateDateElements();
  lucide.createIcons();
});
