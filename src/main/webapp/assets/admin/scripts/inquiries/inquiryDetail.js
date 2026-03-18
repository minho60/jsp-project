import { Modal } from "./../components/modal.js";

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
    params.set("qaNum", inquiry.qaNum);
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

// 삭제 버튼
const deleteBtn = document.getElementById("delete-inquiry-btn");

if (deleteBtn) {
  deleteBtn.addEventListener("click", () => {
    const inquiry = window.inquiryDetail;
    if (!inquiry) return;

    if (!confirm("정말 이 문의를 삭제하시겠습니까?\n삭제 후 복구할 수 없습니다.")) {
      return;
    }

    const params = new URLSearchParams();
    params.set("action", "delete");
    params.set("qaNum", inquiry.qaNum);

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
        if (data.success) {
          location.href = window.ctx + "/admin/inquiries";
        }
      })
      .catch(() => alert("요청 중 오류가 발생했습니다."));
  });
}

// 초기화
document.addEventListener("DOMContentLoaded", () => {
  lucide.createIcons();
});
