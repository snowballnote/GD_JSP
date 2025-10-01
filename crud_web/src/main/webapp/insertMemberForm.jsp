<!-- insertMemberForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//인가: 로그인X (로그인했다면 회원가입 불가)
	if(session.getAttribute("sessionMemberId") != null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertMemberForm.jsp</title>
</head>
<body>
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/menu.jsp"></jsp:include>
	
	<h1>회원가입</h1>
	<form method="post" action="<%=request.getContextPath()%>/insertMemberAction.jsp">
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
		<button type="submit">회원가입</button>
	</form>
</body>
</html>