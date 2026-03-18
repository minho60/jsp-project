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
<link rel="stylesheet" href="${ctx}/assets/css/service/qa_sub1.css">
<link rel="stylesheet"
	href="${ctx}/assets/css/service/service_common.css">
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
					<a href="#">HOME</a>>1:1 문의하기
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
				<div id="secret-main">
					<div class="qa-tit">
						<h2>1:1문의</h2>
					</div>
					<div class="secret-txt">
						<div class="secret-tit">
							[<span class="type">${qa.type}</span>] <span>${qa.title}</span>
						</div>
						<div class="secret-name">
							<div>
								<span> <c:choose>
										<c:when test="${not empty qa.guestName}">
                   				 ${qa.guestName}
                				</c:when>
										<c:otherwise>회원</c:otherwise>
									</c:choose>
								</span> ${qa.createdAt}
							</div>
							<div><p>답변상태: <span class="status">${qa.status}</span></p></div>
						</div>
						<div class="secret-body">
							<div class="secret-q">
								<p>${qa.content}</p>
							</div>
							<div class="secret-a">
								<p>
									<c:out value="${qa.answer}" default="답변 대기중" />
								</p>
							</div>
						</div>
						<div class="secret-btn">

							<button onclick="checkPassword(${qa.qaNum}, 'edit')">수정</button>
							
							<button onclick="checkPassword(${qa.qaNum}, 'delete')">삭제</button>
							<a href="${ctx}/qa/list"><button>목록</button></a>
						</div>
					</div>
				</div>
			</div>
			<!--//.service-container  -->
		</div>
	</main>
	<script src="${ctx}/assets/js/service/qa_view.js"></script>
	<script src="${ctx}/assets/js/service/qa_map.js"></script>
	<script type="text/javascript">
	var ctx = "${pageContext.request.contextPath}";
	</script>
	<%@ include file="/WEB-INF/includes/footer.jsp"%>
	<%@ include file="/WEB-INF/includes/sideMenu.jsp"%>
</body>

</html>