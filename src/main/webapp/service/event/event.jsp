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
<link rel="stylesheet" href="${ctx}/assets/css/service/event.css">
<link rel="stylesheet"
	href="${ctx}/assets/css/service/service_common.css">
<link rel="stylesheet" as="style" crossorigin
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
	<%@ include file="/WEB-INF/includes/header.jsp"%>
	<main>
		<div id="event">
			<div class="location-wrap">
				<div class="location-con">
					<a href="#">HOME</a>>event
				</div>
			</div>
			<!--//. location-wrap  -->
			<div class="service-container">
				<div class="side-box">
					<div class="side-box-t">
						<h2>고객센터</h2>
						<div class="side-box-menu">
							<ul>
								<li><a href="${ctx}/service/notice/notice_list.jsp">공지사항</a></li>
								<li><a href="${ctx}/service/qa/qa.jsp">1:1문의</a></li>
								<li><a href="${ctx}/qa/list">FAQ</a></li>
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
				<div class="event-box">
					<div class="event-tit">
						<h2>이벤트</h2>
						<div class="event-category">
							<ul>
								<li><button class="tab-btn active" data-tab="all">전체</button></li>
								<li><button class="tab-btn" data-tab="ongoing">진행중
										이벤트</button></li>
								<li><button class="tab-btn" data-tab="ended">종료된
										이벤트</button></li>
							</ul>
						</div>
					</div>

					<div class="event-cont">
						<ul id="eventList">
							<c:forEach var="e" items="${eventList}">
								<li>
									<div class="event-card" data-tab="${e.tab}">
										<div class="event-img">
											<a href="${ctx}/event/view?eventId=${e.id}"> <img
												src="${pageContext.request.contextPath}/assets/img/service/event/${e.img}"
												alt="${e.alt}" />
											</a>
										</div>
										<div class="event-info">
											<div class="event-tit">
												<a href="${ctx}/event/view?eventId=${e.id}"> <strong>${e.title}</strong>
												</a>
											</div>
											<div class="event-day">
												<strong>기간:</strong> ${e.date}
											</div>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
						<div class="service-pagination">
							<ul>
								<c:forEach var="i" begin="1" end="${totalPage}">
									<li class="${i == currentPage ? 'service-active' : ''}">
									<a href="?page=${i}">${i}</a></li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<script src="${ctx}/assets/js/service/event.js"></script>
	</main>
	<%@ include file="/WEB-INF/includes/footer.jsp"%>
	<%@ include file="/WEB-INF/includes/sideMenu.jsp"%>
</body>

</html>