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
    <link rel="stylesheet" href="${ctx}/assets/css/orders/cart.css">
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
      <div id="cart">
            <div class="inner">
                  <p><a href="${ctx}/">HOME</a> > 장바구니</p>
                <hr>
                <div class="product">
                    <p>장바구니</p>
                    <p><span>01 장바구니</span><img src="${ctx}/assets/img/cart/icon_join_step_on.png" alt="화살표">02 주문서작성/결제<img src="${ctx}/assets/img/cart/icon_join_step_off.png" alt="화살표">03 주문완료</p>
                </div>
                <p class="box">장바구니에 담겨있는 상품이 없습니다.</p>
                <a class="continue" href="${ctx}/">< 쇼핑 계속하기</a>
                <div class="price">
                    <p>총 0개의 상품금액<br><span>0원</span></p>
                    <img src="${ctx}/assets/img/cart/order_price_plus.png" alt="더하기">
                    <p>배송비<br><span>0원</span></p>
                    <img src="${ctx}/assets/img/cart/order_price_total.png" alt="등호">
                    <p>합계<br><span>0원</span></p>
                </div>
                <div class="btn">
                  <div class="btn_left">
                    <a href="#">선택 상품 삭제</a>
                    <a href="#">선택 상품 찜</a>
                  </div>
                  <div class="btn_right">
                    <a href="${ctx}/orders/new_order">선택 상품 주문</a>
                    <a href="${ctx}/orders/new_order">전체 상품 주문</a>
                  </div>
                </div>
            </div>
        </div>
    </main>
  <%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>
</html>