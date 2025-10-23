<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberHome.jsp</title>
</head>
<body>
	<h1>memberHome</h1>
	<div>
		<%
			Member m = (Member)session.getAttribute("loginMember");
		%>
		<%=m.getId() %>(grade: <%=m.getGrade() %>)
		<a href="<%=request.getContextPath() %>/public/logout.jsp">로그아웃</a>
	</div>
	
	<div>
		<a href="">[/two/* test]</a>
	</div>
</body>
</html>