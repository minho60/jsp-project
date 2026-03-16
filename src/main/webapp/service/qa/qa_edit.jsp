<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="service.dto.QaDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/includes/init.jsp"%>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>문의 수정</title>
<link rel="icon" href="${ctx}/assets/img/main/favicon.png"
	type="image/x-icon" />
<link rel="stylesheet" href="${ctx}/assets/css/layout.css" />
<link rel="stylesheet" href="${ctx}/assets/css/service/qa_edit.css">
<link rel="stylesheet"
	href="${ctx}/assets/css/service/service_common.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/assets/js/layout.js"></script>
</head>

<body>
	<%@ include file="/WEB-INF/includes/header.jsp"%>

	<main>
		<div id="minho-qa">
			<!-- 위치 표시 -->
			<div class="location-wrap">
				<div class="location-con">
					<a href="#">HOME</a> > 1:1 문의하기 > 문의 수정
				</div>
			</div>
			<!--//. location-wrap  -->

			<div class="service-container">
				<div class="side-box">
					<div class="side-box-t">
						<h2>고객센터</h2>
						<div class="side-box-menu">
							<ul>
								<li><a href="${ctx}/service/service/notice/notice_jsp">공지사항</a></li>
								<li><a href="${ctx}/service/qa/qa.jsp">1:1문의</a></li>
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

				<!-- 수정 가능한 페이지 컨텐츠 -->
				<div id="secret-edit">
					<div class="edit-tit">
						<h2>문의 수정</h2>
					</div>
					<div class="edit-txt">
						<!-- 폼 시작 -->
						<form action="${pageContext.request.contextPath}/qa/edit"
							method="post" onsubmit="return validateForm()">
							<input type="hidden" name="qaNum" value="${qa.qaNum}">

							<div class="edit-form">
								<label for="type">유형</label> <select name="type" id="type"
									required>
									<option value="" disabled ${emptyqa.type ? 'selected' : ''}>문의내용
										선택</option>
									<option value="회원/정보관리"
										${qa.type == '회원/정보관리' ? 'selected' : ''}>회원/정보관리</option>
									<option value="주문/결제" ${qa.type == '주문/결제' ? 'selected' : ''}>주문/결제</option>
									<option value="배송" ${qa.type == '배송' ? 'selected' : ''}>배송</option>
									<option value="반품/환불/교환/AS"
										${qa.type == '반품/환불/교환/AS' ? 'selected' : ''}>반품/환불/교환/AS</option>
									<option value="영수증/증빙서류"
										${qa.type == '영수증/증빙서류' ? 'selected' : ''}>영수증/증빙서류</option>
									<option value="상품/이벤트" ${qa.type == '상품/이벤트' ? 'selected' : ''}>상품/이벤트</option>
									<option value="기타" ${qa.type == '기타' ? 'selected' : ''}>기타</option>
								</select><br> <label for="title">제목</label> <input type="text"
									id="title" name="title" value="${qa.title}" required><br>

								<label for="content">내용</label>
								<textarea id="content" name="content" required>${qa.content}</textarea>
								<br>

								<button type="submit" class="edit-btn">수정 완료</button>
							</div>
						</form>
						<!-- //폼 끝 -->
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