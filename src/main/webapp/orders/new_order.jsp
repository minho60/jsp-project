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
    <link rel="stylesheet" href="${ctx}/assets/css/orders/cart.css" />
    <link rel="stylesheet" href="${ctx}/assets/css/orders/new_order.css" />
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
      <div class="main-wrapper">
        <div id="cart">
          <div class="inner">
            <p><a href="${ctx}/">HOME</a> > 주문서작성/결제</p>
            <hr />
            <div class="product">
              <p>주문서작성/결제</p>
              <p>
                01 장바구니<img
                  src="${ctx}/assets/img/cart/icon_join_step_off.png"
                  alt="화살표"
                /><span>02 주문서작성/결제</span
                ><img
                  src="${ctx}/assets/img/cart/icon_join_step_on.png"
                  alt="화살표"
                />03 주문완료
              </p>
            </div>
          </div>
        </div>
        <form class="order-wrapper">
          <aside>
            <div class="container">
              <h2>주문 상품 목록</h2>
              <div class="products">
                <div class="item">
                  <a class="img" href="#">
                    <img
                      src="${ctx}/assets/img/new_order/1000001853_list_072.png"
                      alt=""
                    />
                  </a>
                  <div class="info">
                    <a class="title" href="#">THE짙은 삼겹살 구이용 400g</a>
                    <div class="quantity">1개</div>
                    <div class="price">17,900원</div>
                  </div>
                </div>
                <div class="item">
                  <a class="img skeleton"></a>
                  <div class="info">
                    <a class="title skeleton"></a>
                    <div class="quantity skeleton"></div>
                    <div class="price skeleton"></div>
                  </div>
                </div>
                <div class="item">
                  <a class="img skeleton"></a>
                  <div class="info">
                    <a class="title skeleton"></a>
                    <div class="quantity skeleton"></div>
                    <div class="price skeleton"></div>
                  </div>
                </div>
              </div>
            </div>
            <div class="container">
              <h2>주문자 정보</h2>
              <div class="field-group">
                <span class="field-title">주문하시는 분</span>
                <input
                  class="form-input"
                  type="text"
                  name="sender_name"
                  id=""
                  value="조휘일"
                  required
                />
              </div>
              <div class="field-group">
                <span class="field-title">휴대폰 번호</span>
                <input
                  class="form-input"
                  type="tel"
                  name="sender_phone"
                  id=""
                  value="010-0000-0000"
                  required
                />
              </div>
              <div class="field-group">
                <span class="field-title">이메일</span>
                <input
                  class="form-input"
                  type="email"
                  name="sender_email"
                  id=""
                  value="whyeil@naver.com"
                />
              </div>
            </div>
            <div class="container">
              <h2>배송 정보</h2>
              <div class="field-group">
                <span class="field-title">배송지 확인</span>
                <ul class="field-group-col delivery_info_types">
                  <li class="field-group-col">
                    <input
                      class="form-radio"
                      type="radio"
                      name="delivery_info_type"
                      id="delivery_info_new"
                      value="0"
                    />
                    <label for="delivery_info_new">직접 입력</label>
                  </li>
                  <li class="field-group-col">
                    <input
                      class="form-radio"
                      type="radio"
                      name="delivery_info_type"
                      id="delivery_info_same"
                      value="1"
                      checked
                    />
                    <label for="delivery_info_same">주문자 정보와 동일</label>
                  </li>
                </ul>
              </div>
              <div class="field-group">
                <span class="field-title">받으실 분</span>
                <input
                  class="form-input"
                  type="text"
                  name="receiver_name"
                  id=""
                  required
                />
              </div>
              <div class="field-group">
                <span class="field-title">받으실 곳</span>
                <div class="field-group-col postcode">
                  <input
                    class="form-input"
                    type="text"
                    name="receiver_postcode"
                    placeholder="우편번호"
                    required
                  />
                  <button class="btn-postcode">우편번호 찾기</button>
                </div>
                <div class="field-group">
                  <input
                    class="form-input"
                    type="text"
                    name="receiver_address1"
                    placeholder="주소"
                    required
                  />
                  <input
                    class="form-input"
                    type="text"
                    name="receiver_address2"
                    placeholder="상세 주소"
                    required
                  />
                </div>
              </div>
              <div class="field-group">
                <span class="field-title">휴대폰 번호</span>
                <input
                  class="form-input"
                  type="tel"
                  name="receiver_phone"
                  id=""
                  required
                />
              </div>
            </div>
          </aside>
          <aside class="right">
            <div class="container total-container">
              <h2>결제정보</h2>
              <div class="info-field">
                <span>상품 합계 금액</span>
                <span>17,900원</span>
              </div>
              <div class="info-field">
                <span>배송비</span>
                <span>2,500원</span>
              </div>
              <hr />
              <div class="info-field">
                <span>총 결제 금액</span>
                <span>20,400원</span>
              </div>
            </div>
            <div class="container">
              <h2>결제 방법</h2>
              <ul class="field-group-col field-group-wrap pay-types">
                <li class="field-group-col">
                  <input
                    class="form-radio"
                    type="radio"
                    name="payment-type"
                    id="payment-type-card"
                    value="0"
                    disabled
                  />
                  <label for="payment-type-card">신용카드</label>
                </li>
                <li class="field-group-col">
                  <input
                    class="form-radio"
                    type="radio"
                    name="payment-type"
                    id="payment-type-vbank"
                    value="1"
                    disabled
                  />
                  <label for="payment-type-vbank">가상계좌</label>
                </li>
                <li class="field-group-col">
                  <input
                    class="form-radio"
                    type="radio"
                    name="payment-type"
                    id="payment-type-bank"
                    value="2"
                    checked
                  />
                  <label for="payment-type-bank">무통장 입금</label>
                </li>
              </ul>
            </div>
            <div class="container term">
              <div class="field-group-col">
                <input
                  type="checkbox"
                  name="term-agree"
                  id="term-agree"
                  class="form-checkbox"
                  required
                />
                <label for="term-agree"
                  ><strong>(필수)</strong> 구매하실 상품의 결제 정보를
                  확인하였으며, 구매 진행에 동의합니다.</label
                >
              </div>
              <button class="btn-order">결제</button>
            </div>
          </aside>
        </form>
      </div>
      <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
      <script src="${ctx}/assets/js/orders/new_order.js"></script>
    </main>
  <%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>
</html>
