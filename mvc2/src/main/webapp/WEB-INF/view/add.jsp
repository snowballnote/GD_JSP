<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	Member loginMember = (Member) session.getAttribute("loginMember");
	if (loginMember == null) {
	    response.sendRedirect(request.getContextPath() + "/login");
	    return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>add.jsp</title>
</head>
<body>
	<h1>새 글 작성</h1>
	WRITER : <%=loginMember.getWriter() %>
	<form method="post" action="<%=request.getContextPath() %>/addController">
		<table border="1">
			<tr>
				<td>TITLE</td>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<td>CONTENT</td>
				<td><textarea name="content" rows="10" cols="60"></textarea>
			</tr>
		</table>
		<button type="submit">등록</button>
		<a href="<%=request.getContextPath()%>/listView">목록</a>
	</form>
</body>
</html>