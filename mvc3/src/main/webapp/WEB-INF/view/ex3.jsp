<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- JSTL 모듈에서 core부분만(import, 조건문, 반복문) 집중 -->

	<div>
		<c:import url="/WEB-INF/view/inc/menu.jsp"></c:import>
	</div>
	
	<h1>조건문</h1>
	<div>
		<h2>java : if</h2>
		<c:if test="${gender == '남'}">
			남자
		</c:if>
		<c:if test="${gender != '남'}">
			여자
		</c:if>
		
		<h2>java : if else, switch</h2>
		<c:choose>
			<c:when test="${score >= 90}">A</c:when>
			<c:when test="${score >= 80}">B</c:when>
			<c:when test="${score >= 70}">C</c:when>
			<c:otherwise>F</c:otherwise>
		</c:choose>		
	</div>
	
	<h1>반복문</h1>
	
	<h2>java : for문 처럼</h2>
	<c:forEach var="x" begin="1" end="10" step="1">
		${x}&nbsp;
	</c:forEach>
	
	<h2>java : forEach문 처럼</h2>
	<c:forEach var="n" items="${list}">
		${n}<br>
	</c:forEach>
	
	<hr>
	
	<c:forEach var="m" items="${memberList}">
		<!-- !empty m.pw : m.pw!=null && m.pw!=''   -->
		<c:if test="${!empty m.pw}">
			<div>${m.id}, ${m.pw}</div>
		</c:if>
	</c:forEach>
</body>
</html>