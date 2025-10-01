<!-- deleteMemberForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인 인가
	if(session.getAttribute("sessionMemberId") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteMemberForm.jsp</title>
</head>
<body>
	<jsp:include page="/menu.jsp"></jsp:include>
	<h1>회원탈퇴 : 비밀번호를 입력하세요</h1>
	<form method="post" action="<%=request.getContextPath() %>/deleteMEmberAction.jsp">
		<div>
			비밀번호 : 
			<input type="password" name="nenberPw">
		</div>
		<button type="submit">회원탈퇴</button>
	</form>
</body>
</html>