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
    <link rel="stylesheet" href="${ctx}/assets/css/notice/notice.css" />
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
      <div class="container">
      <!-- 제목 -->
      <h1 class="title">공지사항</h1>
  
      <!-- 검색창 -->
      <div class="search-box">
        <input type="text" placeholder="검색어를 입력해 주세요.">
        <button>검색</button>
      </div>
  
      <!-- 공지사항 테이블 -->
      <div id="notice-area"></div>
        <!-- 페이지네이션 -->
        <div class="pagination">
        </div>
      </div>

      <script src="${ctx}/assets/js/notice/notice_data.js"></script>
      <script src="${ctx}/assets/js/notice/notice_table.js"></script>
    </main>
  <%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>
</html>
