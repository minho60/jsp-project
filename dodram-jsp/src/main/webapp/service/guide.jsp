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
    <link rel="stylesheet" href="${ctx}/assets/css/service/service2.css">
    <link rel="stylesheet" as="style" crossorigin
        href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/includes/header.jsp" %>
    <main>
        <div id="guide">
            <div class="inner">
                <p><a href="${ctx}/">HOME</a> > 서비스 이용안내</p>
<hr>
                <h2>이용안내</h2>
                <div class="service_guide">
                    도드람몰 이용안내<br>
                    <br>
                    ■ 회원가입안내<br>
                    ① 저희 도드람몰은 기본적으로는 회원제로 운영하고 있습니다. <br>
                    ② 회원가입비나 월회비, 연회비등 어떠한 비용도 청구하지 않는 100% 무료 입니다. <br>
                    ③ 구매시 상품별로 적용된 마일리지는 100원 이상이면 사용하실 수가 있습니다. <br>
                    <br>
                    ■ 마일리지 제도<br>
                    ① 저희도드람몰은 마일리지를 사용할 수 있습니다. <br>
                    ② 마일리지 100점은 현금 100원과 같습니다.<br>
                    ③ 유효기간은 발급일로부터 12개월입니다.<br>
                    ④ 마일리지는 자동으로 유효기간이 적게 남은 금액부터 사용됩니다.<br>
                    ⑤ 마일리지의 유효기간은 마이페이지 내의 [마이페이지]페이지에서 상시로 확인하실 수 있습니다.<br>
                    <br>
                    <br>
                    ■ 상품주문방법<br>
                    저희도드람몰에서 상품을 주문하는 방법은 크게 6단계입니다. <br>
                    ① 상품검색 <br>
                    ② 쇼핑백에 담기 <br>
                    ③ 회원ID 로그인 또는 비회원 주문 <br>
                    ④ 주문서 작성 <br>
                    ⑤ 결제방법 선택 및 결제 <br>
                    ⑥ 주문 성공 화면 (주문번호) <br>
                    ⑦ 비회원 주문인 경우 6단계에서 주문번호와 승인번호(카드결제시)를 꼭 메모해 두시기 바랍니다. <br>
                    ※ 단, 회원인 경우 자동 저장되므로 따로 관리하실 필요가 없습니다.<br>
                    <br>
                    ■ 주문확인 및 실시간 배송조회시스템<br>
                    도드람몰에서 주문을 하셨을 경우 주문/배송 확인을 통해서 실제 주문이 어떻게 처리되고 있는지 확인 하실 수 있습니다. 회원페이지에서 주문/배송 확인을 클릭해 보세요.
                    <br>
                    회원일 경우 ID와 비밀번호를 입력하시면 되고 비회원으로 주문하셨을 경우, 주문하셨을때 입력했던 메일을 입력하시면 됩니다. (주문시 입력했던 이름을 정확하게
                    입력하셔야 합니다. 주문자의 이름을 입력하는 것은 본인 확인을 위해서 입니다.) <br>
                    주문시 받으시는 주소가 동일주소일 경우 주문이 여러개여도 합포장되어 발송됩니다.<br>
                    현재 배송은 농협택배(한진택배) 서비스를 이용하고 있습니다. 본 서비스는 상품 추적을 통해 상품이 어디쯤 도착해 있는지 실시간으로 추적하실 수 있습니다. <br>
                    <br>
                    ■ 안전한 대금 결제 시스템<br>
                    저희 도드람몰은 무통장 입금과 신용카드, 핸드폰 결제 세 가지 결제방법을 제공하여 드립니다. <br>
                    무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 되고, 신용카드 결제는 LG U+ PG사의 전자결제를 이용하므로
                    보안문제는 걱정하지 않으셔도 됩니다. <br>
                    이용 가능한 국내 발행 신용카드 <br>
                    - 국내발행 모든 신용카드 <br>
                    이용 가능한 해외 발생 신용카드 <br>
                    - VISA Card, MASTER Card, AMEX Card <br>
                    무통장 입금 가능 은행 <br>
                    - 농협<br>
                    무통장 입금시의 송금자 이름은 주문시 입력하신 주문자의 실명이어야 합니다.<br>
                    <br>
                    ■ 배송기간 및 배송방법<br>
                    고객님이 무통장 입금으로 주문하신 경우에는 입금하신 날로부터, 신용카드로 구매하신 경우에는 구매하신 날로부터 2-3일 이내에 입력하신 배송처로 주문상품이 도착하게
                    됩니다. <br>
                    자사 기준 07시 입금 확인 건까지 당일 출고되어 익일 받아보실 수 있습니다.<br>
                    주문하실 때 희망 배송일자를 넉넉히 잡아주시면(3일이상) 원하시는 날짜에 배송할 수 있도록 최선을 다하겠습니다. <br>
                    저희 도드람몰에서는 구입하신 상품의 배송 방법을 농협택배 서비스를 원칙으로 하고 있습니다. (배송방법은 상품 종류에 따라 상이할 수 있습니다.)<br>
                    <br>
                    ■ 주문취소, 교환 및 환불<br>
                    도드람몰은 소비자의보호를 위해서 규정한 제반 법규를 준수합니다. <br>
                    주문 취소는 저희 고객센터로 문의해 주시기 바랍니다. <br>
                    무통장 입금의 경우 일정기간동안 송금을 하지 않으면 자동 주문 취소가 되고, 송금을 하신 경우에는 환불조치 해드립니다. <br>
                    카드로 결제하신 경우, 승인 취소가 가능하면 취소을 해드리지만 승인 취소가 불가능한 경우 해당 금액을 모두 송금해 드립니다. <br>
                    반송을 하실 때에는 주문번호, 회원번호를 메모하여 보내주시면 보다 신속한 처리에 도움이 됩니다.
                </div> <!-- .service_guide -->
            </div> <!-- //.inner -->
        </div> <!-- //#guide -->
    </main>
<%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>

</html>