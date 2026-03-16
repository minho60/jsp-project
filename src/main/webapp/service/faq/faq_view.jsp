<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/includes/init.jsp"%>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>신선한 식탁을 즐기다, 도드람몰입니다.</title>
<link rel="icon" href="${ctx}/assets/img/main/favicon.png"
	type="image/x-icon" />
<link rel="stylesheet" href="${ctx}/assets/css/layout.css" />
<link rel="stylesheet" href="${ctx}/assets/css/service/faq_answer.css">
<link rel="stylesheet"
	href="${ctx}/assets/css/service/service_common.css">
<link rel="stylesheet" as="style" crossorigin
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/assets/js/layout.js"></script>
</head>

<body>
	<%@ include file="/WEB-INF/includes/header.jsp"%>
	<main>
		<div id="minho-faq">
			<div class="location-wrap">
				<div class="location-con">
					<a href="#">HOME</a>>FAQ
				</div>
			</div>
			<!--//. location-wrap  -->
			<div class="service-container">
				<div class="side-box">
					<div class="side-box-t">
						<h2>고객센터</h2>
						<div class="side-box-menu">
							<ul>
								<li><a href="${ctx}/service/notice_list.jsp">공지사항</a></li>
								<li><a href="${ctx}/service/qa/qa.jsp">1:1문의</a></li>
								<li><a href="${ctx}/faq/list" class="active">FAQ</a></li>
							</ul>
						</div>
					</div>
					<div class="side-box-b">
						<div>
							<h3>고객상담센터</h3>
							<div class="side-info">
								<strong>1551-3349</strong> <a href="#">mall@dodram.co.kr</a>
								<p>
									운영 10:00~17:00<br> 점심 12:00~13:00
								</p>
							</div>
						</div>

						<div>
							<h3>은행계좌 안내</h3>
							<div class="side-info">
								<strong>351-1042-7399-13</strong>
								<p>
									농협<br> [예금주: 도드람양돈협동조합]
								</p>
							</div>
						</div>
					</div>
				</div>
				<!-- //.side-box -->

				<!-- 수정 가능 페이지 컨텐츠 -->
				<div class="answer-box">
					<div class="q-box">
						<span><img src="${ctx}/assets/img/service/icon_qna_q.png"
							alt="q"></span>
						<div id="question">
							<p>질문내용</p>
							<p>${faq.question}</p>
						</div>
					</div>
					<div class="a-box">
						<span><img src="${ctx}/assets/img/service/icon_qna_a.png"
							alt="a"></span>
						<div id="answer">
							<p>답변내용</p>
							<p>${faq.answer}</p>
						</div>
					</div>
					<div class="faq-btn-area">
						<a href="${pageContext.request.contextPath}/faq/list"
							class="faq-list-btn">
							<button>목록</button>
						</a>
					</div>
				</div>

			</div>
			<!--//.service-container  -->
		</div>
	</main>
	<%@ include file="/WEB-INF/includes/footer.jsp"%>
	<%@ include file="/WEB-INF/includes/sideMenu.jsp"%>
</body>

</html>