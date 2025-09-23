<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//myName=xoro&myNum=2
	//request apis
	String myName = request.getParameter("myName");
	String myNum = request.getParameter("myNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>ex6Action.jsp</h1>
	<table border="1">
		<tr>
			<th>이름</th>
			<td><%=myName %></td>
		</tr>
		<tr>
			<th>번호</th>
			<td><%=myNum %></td>
		</tr>
	</table>
</body>
</html>