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
    <link rel="stylesheet" href="${ctx}/assets/css/product/list.css" />
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
      <div id="product">
        <div class="list">
          <div class="top">
            <p><a href="${ctx}/">HOME > </a><span>신선정육</span></p>
          </div>
<hr>
          <div class="container">
            <h2>신선정육</h2>
              <ul class="tabs">
                <li class="tab-link current" data-tab="tab-1">한돈</li>
                <li class="tab-link" data-tab="tab-2">한우</li>
              </ul>
              <div id="tab-1" class="tab-content current">
                <div class="pork_container"></div>
              </div>
              <div id="tab-2" class="tab-content">
                <div class="beef_container"></div>
              </div>
            </div>
        </div>
      </div>
    </main>
      <script src="${ctx}/assets/js/product/listdata.js"></script>
    <script src="${ctx}/assets/js/product/list.js"></script>
    <script src="${ctx}/assets/js/product/tab.js"></script>
  <%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>
</html>
