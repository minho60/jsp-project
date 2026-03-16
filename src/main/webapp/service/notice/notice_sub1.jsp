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
        <div class="sub-container">
            <h1 class="sub-title">공지사항</h1>
            <div id="sub-notice-area"></div>
            <table class="notice-sub-table">
                <thead>
                  <tr>
                      <th colspan = "2">[공지] 2025년 8월 광복절 배송 안내</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                      <td>관리자 2025-08-10</td>
                      <td>조회수 175 </td>
                  </tr>
    
                  <tr class="notice-image">
                      <td colspan="2">
                            <img src="${ctx}/assets/img/notice/sub1_up.jpg" alt="공지 상단이미지">
                      </td>
                  </tr>
    
                  <tr class="notice-image">
                      <td colspan="2">
                      <img src="${ctx}/assets/img/notice/sub1_down.png" alt="공지 하단이미지">
                      </td>
                   </tr>
                </tbody>
            </table>
        </div>
        <p>
          <a href="${ctx}/service/notice/notice_list">목록으로</a>
        </p>
    </main>
  <%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>
</html>
