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
    <link rel="stylesheet" href="${ctx}/assets/css/mypage/mypage_change_info.css">
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

<div class="container">
    <div class="title">회원정보 변경</div>

    <div class="box">
        <div class="form-row">
            <span>아이디</span>
            <span class="user-id" id="userId">Dodram</span>

            <span>비밀번호</span>
            <input type="password" id="password" placeholder="1234">
        </div>
    </div>

    <div class="btn-area">
        <button onclick="cancel()">취소</button>
        <button class="btn-confirm" onclick="checkPassword()">인증하기</button>
    </div>
</div>

<script>
function checkPassword() {
    const password = document.getElementById("password").value;

    if(password === "") {
        alert("비밀번호를 입력하세요.");
        return;
    }

    // 예제용 비밀번호 (실제 서비스에서는 서버에서 검증)
    const correctPassword = "1234";

    if(password === correctPassword) {
        alert("인증 성공!");
         location.href = (contextPath || '') + '/member/mypage_change_info_sub'; // 다음 페이지 이동
    } else {
        alert("비밀번호가 틀렸습니다.");
    }
}

function cancel() {
    if(confirm("취소하시겠습니까?")) {
        history.back(); // 이전 페이지로
    }
}
</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>
</html>
