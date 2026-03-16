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
    <link rel="stylesheet" href="${ctx}/assets/css/mypage/mypage_change_info_sub.css">
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
      <!-- <h1 style="text-align: center">마이페이지</h1> -->
      <h1 style="text-align: center">회원정보 변경</h1>

      <div class="main-container">
          <div class="left-title">
                <a href="${ctx}/member/index">HOME>마이페이지>정보수정</a>
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
    <!-- <div class="title">회원정보 변경</div> -->

        <h3 class="section-title">기본정보</h3>

    <table class="info-table">
        <tr>
            <th>아이디</th>
            <td class="readonly">hong</td>
        </tr>

        <tr>
            <th>비밀번호</th>
            <td>
                <div class="password-box">
                    <div>
                        <label>새 비밀번호</label>
                        <input type="password">
                    </div>
                    <div>
                        <label>새 비밀번호 확인</label>
                        <input type="password">
                    </div>
                </div>
            </td>
        </tr>

        <tr>
            <th>이름</th>
            <td>
                <input type="text" value="홍길동">
            </td>
        </tr>

        <tr>
            <th>이메일</th>
            <td>
                <input type="email" value="hong@naver.com">
            </td>
        </tr>

        <tr>
            <th>휴대폰번호</th>
            <td>
                <input type="text" value="01012345678">
            </td>
        </tr>
    </table>
    <div class="btn-area">
        <button >취소</button>
        <button class="btn-confirm">정보수정</button>
    </div>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>
</html>
