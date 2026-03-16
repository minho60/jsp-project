<%@ page language="java" contentType="text/html; charset=UTF-8"%>


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
<link rel="stylesheet" href="${ctx}/assets/css/service/event_in.css">
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
		<div id="minho-event">
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
								<li><a href="#">공지사항</a></li>
								<li><a href="/service/qa/qa_new.html">1:1문의</a></li>
								<li><a href="/service/faq/faq_list.html">FAQ</a></li>
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
				<div id="event">
					<div class="main-tit">
						<h2>이벤트</h2>
					</div>
					<div class="event-txt">
						<div class="event-tit">
							<span>${event.title}</span>
						</div>
						<div class="event-name">
							<div>
								<span>관리자(ip)</span>
								<span>
								작성시간: ${event.createTime}</span>
							</div>
							<div>조회수: ${event.viewCount}</div>
						</div>
						<div class="event-body">
							<div class="event-img">
								<img src="${ctx}/assets/img/service/event/${event.img}" alt="${event.alt}">
									
							</div>
							<div class="event-content">${event.content}</div>
						</div>
						<div class="event-btn">
							<a href="${ctx}/service/event/event_list.jsp"><button>목록</button></a>
						</div>
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