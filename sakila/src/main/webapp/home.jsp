<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인가
	if(session.getAttribute("loginStaff") != null){ //로그인이 되어있다면
		response.sendRedirect(request.getContextPath() + "/film/filmList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>staff login</h1>
	<form method="post" action="<%=request.getContextPath() %>/staff/loginAction.jsp">
		<table border="1">
			<tr>
				<th>username</th>
				<td><input type="text" name="username"></td>
			</tr>
			<tr>
				<th>password</th>
				<td><input type="password" name="password"></td>
			</tr>
		</table>
		<button type="submit">스탭 로그인</button>
	</form>
</body>
</html>