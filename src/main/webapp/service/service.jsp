<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/includes/init.jsp" %>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>신선한 식탁을 즐기다, 도드람몰입니다.</title>
  <link rel="icon" href="${ctx}/assets/img/main/favicon.png" type="image/x-icon" />
  <link rel="stylesheet" href="${ctx}/assets/css/layout.css" />
  <link rel="stylesheet" href="${ctx}/assets/css/service/service.css" />
  <link rel="stylesheet" as="style" crossorigin
    href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="/assets/js/layout.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/includes/header.jsp" %>
  <main>
    <div id="service">
      <div class="service-t">
        <a href="${ctx}/service/notice/notice_list.jsp">
          <div class="service-box">
            <h2>공지사항</h2>
            <p>도드람몰의 업데이트 소식!</p>
          </div>
        </a>
        <a href="${ctx}/faq/list">
          <div class="service-box">
            <h2>FAQ</h2>
            <p>도드람몰을 활용하는 법!</p>
          </div>
        </a>
        <a href="${ctx}/service/qa/qa.jsp">
          <div class="service-box">
            <h2>1:1 문의하기</h2>
            <p>도드람몰에 대한 궁긍한건 무엇이든!</p>
          </div>
        </a>
      </div>
      <a href="${ctx}/event/list">
        <div class="event-link">
          <h2>이벤트</h2>
          <p>도드람몰 이벤트들을 한 눈에!</p>
        </div>
      </a>
      <div class="side-box-b">
        <div>
          <h3>고객상담센터</h3>
          <div class="side-info">
            <strong>1551-3349</strong>
            <a href="#">mall@dodram.co.kr</a>
            <p>운영 10:00~17:00<br>
              점심 12:00~13:00</p>
          </div>
        </div>

        <div>
          <h3>은행계좌 안내</h3>
          <div class="side-info">
            <strong>351-1042-7399-13</strong>
            <p>농협<br>
              [예금주: 도드람양돈협동조합]</p>
          </div>
        </div>
      </div>
    </div>
  </main>
<%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>

</html>