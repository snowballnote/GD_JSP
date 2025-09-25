<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>request api</title>
</head>
<body>
	<h1>1) 요청 메타 정보 출력</h1>
	매개값: <%=request.getParameter("매개변수이름") %>
	<br>같은이름의 매개값: <%=request.getParameterValues("매개변수이름") %>
	<br>메서드: <%=request.getMethod()%> 
	<br> 프로토콜: <%=request.getProtocol()%> 
	<br> 요청 URI: <%=request.getRequestURI()%> 
	<br> 전체 URL: <%=request.getRequestURL()%> 
	<br> 쿼리스트링: <%=request.getQueryString()%> 
	<br> 컨텍스트패스: <%=request.getContextPath()%> 
	<br> 원격 IP: <%=request.getRemoteAddr()%> 
	<br> 서버: <%=request.getServerName()%>
	<br> 포트번호: <%=request.getServerPort()%> 
	<br> 로케일: <%=request.getLocale()%> 
	<hr>
	header-info: <%=request.getHeader("host") %>
</body>
</html>