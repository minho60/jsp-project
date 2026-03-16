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
    <link rel="stylesheet" href="${ctx}/assets/css/mypage/delete_account.css">
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
         <h1 style="text-align: center">회원탈퇴</h1>
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
            </div><!--left-title  -->
            
            
            <div class="right-container">
                <h3>01.회원탈퇴 안내</h3>
                <div class="cancel-guide-content">
                    <p>도드람몰 탈퇴안내</p><br>
                    <p>회원님께서 회원 탈퇴를 원하신다니 저희 쇼핑몰의 서비스가 부족하고 미흡했나 봅니다.</p>
                    <p>불편하셨던 점이나 불만사항을 알려주시면 적극 반영해서 고객님의 불편함을 해결해 드리도록 노력하겠습니다.</p>
                    <br>
                    <p>■ 아울러 회원 탈퇴시의 아래 사항을 숙지하시기 바랍니다.</p>
                        <p>1.회원 탈퇴 시 회원님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서의 소비자 보호에 관한 법률에 의거한 고객정보 보호정책에따라 관리 됩니다.</p>
                        <p>탈퇴 시 회원님께서 보유하셨던 마일리지는 삭제 됩니다.</p>
                    </div><!--cancel-guide-content  -->
               
                <div class="right-middle-container">
                    <h3>02.회원탈퇴 하기</h3>
                    <div class="user-info">
                        <div class="user-psw">
                            <label for="password">비밀번호
                                <input type="password" id="password" name="password" required>
                            </label>
                        </div>
                        <form>
                              <div class="sub-title">탈퇴사유</div>
                        <div class="left-complain">
                            <label for="chk1">
                                <input type="checkbox" id="chk1" name="chkgroup" value="a">고객서비스(상담,포장등)불만
                            </label>
                            <label for="chk2">
                                <input type="checkbox" id="chk2" name="chkgroup" value="a">교환/환불/반품 불만
                            </label>
                            <label for="chk3">
                                <input type="checkbox" id="chk3" name="chkgroup" value="a">상품가격 불만
                            </label>
                            <label for="chk4">
                                <input type="checkbox" id="chk4" name="chkgroup" value="a">쇼핑몰의신뢰도 불만
                            </label>
                        </div>
                        <div class="right-complain">
                            <label for="chk5">
                                <input type="checkbox" id="chk5" name="chkgroup" value="a">배송 불만
                            </label>
                            <label for="chk6">
                                <input type="checkbox" id="chk6" name="chkgroup" value="a">방문 빈도가 낮음
                            </label>
                            <label for="chk7">
                                <input type="checkbox" id="chk7" name="chkgroup" value="a">개인 정보유출우려
                            </label>
                        </div>
                        </form>

                        <div class="last-comment">
                            <div>남기실 말씀</div>
                            <textarea name="message" rows="12" cols="116">
                            </textarea>
                        </div>
                        <div class="bottom-btn">
                            <a href="${ctx}/member/index">이전으로</a>
                            <a href="">탈퇴</a>
                        </div>
                    </div><!-- user-info -->
                </div> <!-- right-middle-title --> 
            </div><!-- right-container -->
        </div><!-- "main-container -->
    </main>
  <%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>
</html>
