<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>request api</title>
</head>
<body>
	<h1>2) 요청 헤더 정보 출력</h1>
	<%
		//request.getHeader("host"); 
	
		Enumeration<String> names = request.getHeaderNames();
		while(names.hasMoreElements()){ 
			String hn = names.nextElement();
			out.println(hn + " : " + request.getHeader(hn) + "<br>");
		}
	%>
</body>
</html>