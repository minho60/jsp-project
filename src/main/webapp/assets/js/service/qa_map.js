const InquiryType = Object.freeze({
  MEMBER: "회원/정보관리",
  ORDER: "주문/결제",
  DELIVERY: "배송",
  REFUND: "반품/환불/교환/AS",
  RECEIPT: "영수증/증빙서류",
  EVENT: "상품/이벤트",
  ETC: "기타"
});

const StatusType = {
  WAITING: "답변대기",
  ANSWERED: "답변완료",

};

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".type").forEach(el => {
    const key = el.innerText.trim(); // 공백 제거
    el.innerText = InquiryType[key] || key; // 변환
  });
});

document.querySelectorAll(".status").forEach(el => {
  const key = el.textContent.trim();
  el.textContent = StatusType[key] || key;
});
