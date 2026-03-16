<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
<%@ include file="/WEB-INF/includes/init.jsp" %>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>신선한 식탁을 즐기다, 도드람몰입니다.</title>
    <link rel="icon" href="${ctx}/assets/img/main/favicon.png" type="image/x-icon" />
    <link rel="stylesheet" href="${ctx}/assets/css/layout.css" />
    <link rel="stylesheet" href="${ctx}/assets/css/mypage/mypage_claim.css">
    <link
      rel="stylesheet"
      as="style"
      crossorigin
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css"
    />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>

  <body>
<%@ include file="/WEB-INF/includes/header.jsp" %>
    <main>
      <h1 style="text-align: center">마이페이지</h1>

      <div class="main-container">
          <div class="left-title">
                <a href="${ctx}/member/index">HOME></a>
                <h3>쇼핑정보</h3>
                <a href="${ctx}/member/mypage_orderlist_diliversearch"><p>- 주문목록/배송조회</p></a>
                <a href="${ctx}/member/mypage_claim_list"><p>- 취소/반품/교환내역</p></a>
                <a href="${ctx}/member/mypage_refund_list"><p>- 환불/입금 내역</p></a>
                <a href="${ctx}/member/mypage_wishlist"><p>- 찜리스트</p></a>
                <h3>혜택관리</h3>
                <a href="${ctx}/member/mypage_coupon_list"><p>- 쿠폰</p></a>
                <a href="${ctx}/member/mypage_deposit"><p>- 예치금</p></a>
                <a href="${ctx}/member/mypage_mileage"><p>- 마일리지</p></a>
                <h3>고객센터</h3>
                <a href="${ctx}/member/mypage1_1faq"><p>- 1:1문의</p></a>
                <h3>회원정보</h3>
                <a href="${ctx}/member/mypage_change_info"><p>- 회원정보 변경</p></a>
                <a href="${ctx}/member/delete_account"><p>- 회원탈퇴</p></a>
                <a href="${ctx}/member/mypage_dilivery_addr"><p>- 배송지 관리</p></a>
                <h3>나의 상품문의</h3>
                <a href="${ctx}/member/mypage_product_faq"><p>- 나의 상품문의</p></a>
                <h3>나의 상품후기</h3>
                <a href="${ctx}/member/mypage_product_review"><p>- 나의 상품후기</p></a>
            </div>
            <div class="right-container">
                
               
                <h3 class="title">나의 상품문의</h3>

                <div class="order-search">
  <div class="search-box">
    <span class="label">조회기간</span>

    <div class="btn-group">
      <button>오늘</button>
      <button class="active">7일</button>
      <button>15일</button>
      <button>1개월</button>
      <button>3개월</button>
      <button>1년</button>
    </div>

    <input type="date" value="2025-12-22">
    <span class="tilde">~</span>
    <input type="date" value="2025-12-29">

    <button class="search-btn">
      조회 <i class="fa-solid fa-magnifying-glass"></i>
    </button>
  </div><!-- //search-box -->
</div><!--// order-search -->
                  
                <p class="date-range-text" id="dateRangeText"></p>
                
                 
                    <table class="middle-content">
                        <tr>
                            <th>문의날짜</th>
                            <th>카테고리</th>
                            <th>제목</th>
                            <th>문의상태</th>
                            
                        </tr>
                        
                        <tr>
                            <td colspan="6">게시글이 존재하지않습니다.</td>
                        </tr>
                        
                    </table>
                
            </div>
      </div><!-- main-container -->
    </main>
    <script>
// 1. 요소 선택
// =========================
const periodButtons = document.querySelectorAll(".btn-group button");
const startDateInput = document.querySelectorAll('input[type="date"]')[0];
const endDateInput = document.querySelectorAll('input[type="date"]')[1];

// 오늘 날짜
const today = new Date();

// yyyy-mm-dd 형태로 변환 함수
function formatDate(date) {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  return `${year}-${month}-${day}`;
}

// =========================
// 2. 버튼 클릭 이벤트
// =========================
periodButtons.forEach(btn => {
  btn.addEventListener("click", () => {

    // ① active 처리
    periodButtons.forEach(b => b.classList.remove("active"));
    btn.classList.add("active");

    // ② 날짜 계산
    const text = btn.innerText;
    const startDate = new Date(today);

    if (text === "오늘") {
      // 그대로
    } else if (text === "7일") {
      // periodText.textContent = "최근 7일간의 쿠폰내역";
      startDate.setDate(today.getDate() - 7);
    } else if (text === "15일") {
      startDate.setDate(today.getDate() - 15);
    } else if (text === "1개월") {
      startDate.setMonth(today.getMonth() - 1);
    } else if (text === "3개월") {
      startDate.setMonth(today.getMonth() - 3);
    } else if (text === "1년") {
      startDate.setFullYear(today.getFullYear() - 1);
    }

    // input에 반영
    startDateInput.value = formatDate(startDate);
    endDateInput.value = formatDate(today);
    dateRangeText.innerText = `${startDateInput.value} ~ ${endDateInput.value} 까지의 문의내역`;
  });
});
        //주문조회 끝
        // 초기 표시 (페이지 로드시)
// 7일 전 날짜 계산
const defaultStartDate = new Date(today);
defaultStartDate.setDate(today.getDate() - 7);

// input 값 설정
startDateInput.value = formatDate(defaultStartDate);
endDateInput.value = formatDate(today);

dateRangeText.innerText =
  `${startDateInput.value} ~ ${endDateInput.value} 까지의 1:1문의내역`;
</script>
  <%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>
</html>
