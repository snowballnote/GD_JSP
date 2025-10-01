<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	// 인가 작업
	String sessionMemberId = (String)(session.getAttribute("sessionMemberId"));	
	// sessionMemberId == null -> 로그인 X
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/menu.jsp"></jsp:include>
	<h1>HOME</h1>
	
	<%
		if(sessionMemberId == null) {
			// 로그인X 출력
	%>
			<div><a href="<%=request.getContextPath()%>/loginForm.jsp">[로그인]</a></div>
			<div><a href="<%=request.getContextPath()%>/insertMemberForm.jsp">[회원가입]</a></div>
	<%		
		} else {
			// 로그인O 출력
	%>
			<div>
				<%=sessionMemberId%>님 반갑습니다
				<a href="<%=request.getContextPath()%>/logout.jsp">[로그아웃]</a>	
			</div>
	<%
		}
	%>
	
</body>
</html>