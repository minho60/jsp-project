<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>${pageTitle}</title>
</head>
<body>
	<h2>디버그</h2>

	<h3>설정 출처</h3>
	<table cellpadding="6" cellspacing="0">
		<tr>
			<th>키</th>
			<th>출처</th>
		</tr>
		<c:forEach var="entry" items="${configInfo}">
			<tr>
				<td>${entry.key}</td>
				<td>${entry.value != null ? entry.value : '미설정'}</td>
			</tr>
		</c:forEach>
	</table>

	<h3>접속 테스트</h3>
	<p>${connectionTest}</p>
</body>
</html>
