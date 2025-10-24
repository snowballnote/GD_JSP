<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listView.jsp</title>
</head>
<body>
	<a href="${pageContext.request.contextPath}/addController">글입력</a>
	<table border="1">
		<tr>
			<th>NO</th><th>TITLE</th><th>WRITER</th><th>CREATEDATE</th>
		</tr>

		<c:forEach var="gb" items="${list}">
			<tr>
				<td>${gb.no}</td>
				<td>${gb.title}</td>
				<td>${gb.writer}</td>
				<td>${gb.createdate}</td>
			</tr>
		</c:forEach>
	</table>
	<c:if test="${currentPage > 1}">
		<a href="${pageContext.request.contextPath}/listView?currentPage=${currentPage-1}">[이전]</a>
	</c:if>
	[${currentPage}]
	<c:if test="${currentPage < lastPage}">
		<a href="${pageContext.request.contextPath}/listView?currentPage=${currentPage+1}">[다음]</a>
	</c:if>
</body>
</html>