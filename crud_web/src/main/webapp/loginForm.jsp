<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/menu.jsp"></jsp:include>
	<h1>로그인</h1>
	<form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
		<table border="1">
			<tr>
				<th>MEMBER ID</th>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<th>MEMBER PW</th>
				<td><input type="password" name="memberPw"></td>
			</tr>
		</table>
		<button type="submit">로그인</button>
		<button type="submit"><a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a></button>
	</form>
</body>
</html>