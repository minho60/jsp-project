<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/includes/init.jsp" %>
    <meta charset="UTF-8" />
    <meta name="viewport" content="wilih=device-wilih, initial-scale=1.0" />
    <title>신선한 식탁을 즐기다, 도드람몰입니다.</title>
    <link rel="icon" href="${ctx}/assets/img/main/favicon.png" type="image/x-icon" />
    <link rel="stylesheet" href="${ctx}/assets/css/layout.css" />
    <link rel="stylesheet" href="${ctx}/assets/css/orders/order_success.css" />
    <link rel="stylesheet" as="style" crossorigin
        href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/includes/header.jsp" %>
    <main>
        <div id="success">
            <div class="inner">
                <p><a href="${ctx}/">HOME</a> > 주문완료</p>
                <hr>
                <div class="product">
                    <p>주문완료</p>
                    <p>01 장바구니<img src="${ctx}/assets/img/cart/icon_join_step_off.png" alt="화살표">02 주문서작성/결제<img src="${ctx}/assets/img/cart/icon_join_step_on.png" alt="화살표"><span>03 주문완료</span></p>
                </div>
                <div class="clear">
                    <img src="${ctx}/assets/img/order_success/order_end_completion.png" alt="주문완료">
                    <p>주문이 정상적으로 접수 되었습니다.<br><span>감사합니다.</span></p>
                </div>

                    <div class="table">
                        <div class="order_info">
                            <p>주문요약정보</p>
                        </div>
                        <table class="info">
                            <tr>
                                <th><p>결제수단</p></th>
                                    <td>
                                        <p><span>무통장입금</span></p>
                                        <p>입금은행 : 농협</p>
                                        <p>입금계좌 : 351-1042-7399-13</p>
                                        <p>예금주명 : 도드람양돈협동조합</p>
                                        <p>입금금액 : <b>12,300원</b></p>
                                        <p>입금자명 : 홍길동</p>
                                </tr>
                            </tr>
                            <tr>
                                <th><p>주문번호</p></th>
                                    <td>
                                        <p>250000123456789</p>
                                    </td>
                            </tr>
                            <tr>
                                <th><p>주문일자</p></th>
                                    <td>
                                        <p>2025-12-26 18:00:00</p>
                                    </td>
                            </tr>
                            <tr>
                                <th><p>주문상품</p></th>
                                    <td>
                                        <p>도드람한돈 목심 에어프라이어용 500g</p>
                                    </td>
                            </tr>
                            <tr>
                                <th><p>주문자명</p></th>
                                    <td>
                                        <p>홍길동</p>
                                    </td>
                            </tr>
                            <tr>
                                <th><p>배송정보</p></th>
                                    <td>
                                        <p>홍길동</p>
                                        <p>[13618] 경기도 성남시 분당구 구미동 돌마로 73 우방코아 7층</p>
                                        <p>// 010-1234-1234</p>
                                        <p>남기실 말씀: </p>
                                    </td>
                            </tr>
                            <tr>
                                <th><p>상품 금액</p></th>
                                    <td>
                                        <p><span>9,800원</span></p>
                                    </td>
                            </tr>
                            <tr>
                                <th><p>배송비</p></th>
                                <td>
                                    <p>기본배송 2,500원</p>
                                </td>
                            </tr>
                            <tr>
                                <th><p>할인 및 적립</p></th>
                                <td>
                                    <p>할인: <b>(-) 0원</b> (상품 0원, 회원 0원, 배송비 0원, 상품쿠폰 0원, 주문쿠폰 0원, 배송비쿠폰 0원)</p>
                                    <p>적립 마일리지 : <b>(+) 213원</b></p>
                                </td>
                            </tr>
                            <tr>
                                <th><p>총 결제금액</p></th>
                                <td>
                                    <p>
                                        <span>12,300원</span>
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <th><p>현금영수증</p></th>
                                <td>
                                    <p>미발급</p>
                                </td>
                            </tr>
                            <tr>
                                <th><p>세금계산서</p></th>
                                <td>
                                    <p>미발급</p>
                                </td>
                            </tr>
                        </table>
                    </div>

                <div class="btn"><a href="${ctx}/">확인</a></div>
            </div>
        </div>
    </main>
<%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>

</html>