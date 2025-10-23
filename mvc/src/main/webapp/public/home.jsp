<!-- /mvc/public/home.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	CounterDao counterDao = new CounterDao();
	Integer todayCount = counterDao.selectToday();
	Integer totalCount = counterDao.selectTotal();	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home.jsp</title>
</head>
<body>
	<h1>home</h1>
	<div>
		<div>현재 접속자 수: <%=application.getAttribute("currentCount") %></div>
		<div>오늘 접속자 수: <%=todayCount %></div>
		<div>전체 접속자 수: <%=totalCount %></div>
	</div>
	<%
		if(session.getAttribute("loginMember") == null){
	%>
			<a href="<%=request.getContextPath() %>/zero/loginForm.jsp">로그인</a>
	<%		
		}else{
	%>
			<a href="<%=request.getContextPath() %>/public/logout.jsp">로그아웃</a>
	<%		
		}
	%>
</body>
</html>