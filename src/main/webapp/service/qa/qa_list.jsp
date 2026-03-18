<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet"
	href="${ctx}/assets/css/service/service_common.css">
<link rel="stylesheet" href="${ctx}/assets/css/service/qa_list.css">
<link rel="stylesheet" as="style" crossorigin
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
	<%@ include file="/WEB-INF/includes/header.jsp"%>
	<main>
		<div id="minho-qa">
			<div class="location-wrap">
				<div class="location-con">
					<a href="${ctx}/index.jsp">HOME</a>>1:1 문의하기
				</div>
			</div>
			<!--//. location-wrap  -->
			<div class="service-container">
				<div class="side-box">
					<div class="side-box-t">
						<h2>고객센터</h2>
						<div class="side-box-menu">
							<ul>
								<li><a href="${ctx}/service/notice/notice_jsp">공지사항</a></li>
								<li><a href="${ctx}/service/qa/qa.jsp" class="active">1:1문의</a></li>
								<li><a href="${ctx}/faq/list">FAQ</a></li>
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
				<div id="qa-board">
					<div class="qa-search">
						<div class="qa-search-tit">
							<h2>1:1문의</h2>
							<button class="qa-btn">
								<a href="${ctx}/qa/write">1:1문의하기</a>
							</button>
						</div>
						<form method="get" action="${ctx}/qa/list" id="searchForm">

							<div class="qa-search-box">

								<h3>조회기간</h3>

								<div class="date-box">
									<button type="button" class="date-btn" data-day="0">오늘</button>
									<button type="button" class="date-btn" data-day="7">7일</button>
									<button type="button" class="date-btn" data-day="15">15일</button>
									<button type="button" class="date-btn" data-day="30">1개월</button>
									<button type="button" class="date-btn" data-day="90">3개월</button>
									<button type="button" class="date-btn" data-day="365">1년</button>
								</div>

								<input class="calendar" type="text" name="startDate"
									id="startDate"> ~ <input class="calendar" type="text"
									name="endDate" id="endDate"> <input class="keyword" type="text"
									name="keyword" placeholder="제목 검색">

								<button type="submit" class="search-btn">
									<span>조회</span>
								</button>

							</div>
						</form>
					</div>
					<div class="qa-table">
						<table>
							<colgroup>
								<col style="width: 10%;">
								<col style="width: 15%;">
								<col style="width: auto;">
								<col style="width: 10%;">
								<col style="width: 10%;">
							</colgroup>
							<thead>
								<tr>
									<th>문의날짜</th>
									<th>카테고리</th>
									<th>제목</th>
									<th>작성자</th>
									<th>문의상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="qa" items="${qaList}">
									<tr>
										<td>${qa.createdAt}</td>
										<td class="type">${qa.type}</td>
										<td class="table-tit">
										<a href="javascript:void(0)"onclick="checkPassword(${qa.qaNum})"> 
											${qa.title} </a>
										</td>
										<td><c:choose>
												<c:when test="${not empty qa.guestName}">
                  									  ${qa.guestName}
               									</c:when>
												<c:otherwise>
                    								회원
                								</c:otherwise>
											</c:choose></td>
										<td class="status">${qa.status}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="service-pagination">
						<ul>

							<c:if test="${page > 1}">
								<li><a href="?page=${page-1}">이전</a></li>
							</c:if>

							<c:forEach begin="1" end="${totalPage}" var="i">
								<li class="${page == i ? 'service-active' : ''}"><a
									href="?page=${i}">${i}</a></li>
							</c:forEach>

							<c:if test="${page < totalPage}">
								<li><a href="?page=${page+1}">다음</a></li>
							</c:if>

						</ul>
					</div>
					<!-- //.service-pagenation -->
				</div>
				<!-- //.qa-board -->
			</div>
			<!--//.service-container  -->
		</div>
	</main>
	<script src="${ctx}/assets/js/service/qa_list.js"></script>
	<script src="${ctx}/assets/js/service/qa_map.js"></script>
	<script>const ctx = "${ctx}";</script>
	<%@ include file="/WEB-INF/includes/footer.jsp"%>
	<%@ include file="/WEB-INF/includes/sideMenu.jsp"%>
</body>

</html>