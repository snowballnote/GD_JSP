<!-- /mvc/zero/loginForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 로그인 하지 않은 session 분기 코드 : BeforeLoginFilter 필터 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm.jsp</title>
</head>
<body>
	<h1>로그인</h1>
	<form method="post" action="<%=request.getContextPath() %>/zero/loginAction.jsp">
		<table border="1">
			<tr>
				<td>id</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td>pw</td>
				<td><input type="password" name="pw"></td>
			</tr>
		</table>
		<button>로그인</button>
	</form>
</body>
</html>