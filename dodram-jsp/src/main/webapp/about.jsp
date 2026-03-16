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
    <link rel="stylesheet" href="${ctx}/assets/css/about.css">
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
        <div id="about">
            <div class="inner">
                <h1>브랜드 <span>소개</span></h1>
                <img class="img1" src="${ctx}/assets/img/about/egovtemp_202303240308273400.jpg" alt="">
                <h1>브랜드 <span>전략</span></h1>
                <p>기업브랜드, 패밀리브랜드, 개별브랜드, 브랜드 수식어의 서열관계를 가지는 계층구조로 되어 있으며, 브랜드 전략의 차별화(differentiation)를 가지고 있습니다.</p>
                <img class="img2" src="${ctx}/assets/img/about/20231218173125384_1HTGY7DA.png" alt="">
                <h1>브랜드 <span>레벨</span></h1>
                <img class="img3" src="${ctx}/assets/img/about/20241125091446432_BA7ECCQ3.png" alt="">
            </div>
        </div>
    </main>
  <%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>
</html>