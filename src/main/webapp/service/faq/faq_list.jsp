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
<link rel="icon" href="/assets/img/main/favicon.png" type="image/x-icon" />
<link rel="stylesheet" href="${ctx}/assets/css/layout.css" />
<link rel="stylesheet" href="${ctx}/assets/css/service/faq_list.css">
<link rel="stylesheet"
	href="${ctx}/assets/css/service/service_common.css">
<link rel="stylesheet" as="style" crossorigin
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
								<li><a href="${ctx}/service/notice/notice_list.jsp">공지사항</a></li>
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
				<div class="board-box">
					<div class="search-box">
						<div class="search-left">
							<h2>자주묻는 질문 검색</h2>
							<form action="${pageContext.request.contextPath}/faq/list"
								method="get">
								<input type="text" name="keyword" value="${param.keyword}"
									placeholder="검색어를 입력하세요"> <input type="hidden"
									name="category" value="${category}">
								<button type="submit">검색</button>
							</form>
						</div>
						<div class="search-right">
							<strong>찾으시는 질문이 없다면?</strong> <a href="/service/qa/qa_new.html"><span>1:1
									문의하기</span></a>
						</div>
					</div>
					<div class="faq-tit">
						<h3>FAQ</h3>
					</div>
					<div class="faq-content">
						<div class="faq-content-list">
							<ul>
								<c:set var="cat" value="${category}" />

									<li><a
										href="${pageContext.request.contextPath}/faq/list?page=1"
										class="${cat == null ? 'active' : ''}">전체</a></li>
									<li><a
										href="${pageContext.request.contextPath}/faq/list?category=회원가입/정보&page=1"
										class="${cat == '회원가입/정보' ? 'active' : ''}">회원가입/정보</a></li>
									<li><a
										href="${pageContext.request.contextPath}/faq/list?category=결제/배송&page=1"
										class="${cat == '결제/배송' ? 'active' : ''}">결제/배송</a></li>
									<li><a
										href="${pageContext.request.contextPath}/faq/list?category=교환/반품/환불&page=1"
										class="${cat == '교환/반품/환불' ? 'active' : ''}">교환/반품/환불</a></li>
									<li><a
										href="${pageContext.request.contextPath}/faq/list?category=마일리지 적립&page=1"
										class="${cat == '마일리지 적립' ? 'active' : ''}">마일리지 적립</a></li>
									<li><a
										href="${pageContext.request.contextPath}/faq/list?category=기타&page=1"
										class="${cat == '기타' ? 'active' : ''}">기타</a></li>
							
							</ul>
						</div>
						<div class="faq-table">
							<table>
								<thead>
									<tr>
										<th>번호</th>
										<th>분류</th>
										<th class="faq-cell">내용</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="faq" items="${faqList}">
										<tr>
											<td>${faq.qaNum}</td>
											<td>${faq.type}</td>
											<td class="faq-cell">
											<a href="${pageContext.request.contextPath}/faq/view?qaNum=${faq.qaNum}">
											${faq.question}</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- //.faq-table -->
						<div class="service-pagination">
							<ul>
								<c:forEach var="i" begin="1" end="${totalPage}">
									<li class="${i == currentPage ? 'service-active' : ''}">
									<a href="${pageContext.request.contextPath}/faq/list?category=${category}&keyword=${keyword}&page=${i}">
									${i}
									</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<!-- //.faq-content -->
				</div>
				<!-- //.board-box (수정 가능)-->

			</div>
			<!--//.faq-container  -->
		</div>
		<!-- //#minho-faq -->
	</main>
	<%@ include file="/WEB-INF/includes/footer.jsp"%>
	<%@ include file="/WEB-INF/includes/sideMenu.jsp"%>
</body>

</html>