<!-- memberInfo.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//로그인 인가
	if(session.getAttribute("sessionMemberId") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String memberId = (String)session.getAttribute("sessionMemberId");
	String memberPw = request.getParameter("memberPw");

	Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");	
	/*
		select *
		from member
		where member_id = ?
		
		stmt.setString(1, (String)(session.getAttribute("sessionMEmberId")));
	*/
	String sql = "select member_id, member_pw from member where member_id = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, memberId);
	ResultSet rs = stmt.executeQuery();
	if(rs.next()){
		memberId = rs.getString("member_id");
		memberPw = rs.getString("member_pw");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberInfo.jsp</title>
</head>
<body>
	<jsp:include page="/menu.jsp"></jsp:include>
	<h1>회원정보</h1>
	<table border="1">
		<tr>
			<th>아이디</th>
			<td><%= memberId%></td>
		</tr>
	</table>
	<div>
		<a href="<%=request.getContextPath() %>/updateMemberPwForm.jsp">비밀번호수정</a>
		<!-- deleteMemberForm.jsp: 비밀번호입력 - deleteMemberAction.jsp: 비밀번호확인 후 탈퇴 -->
		<a href="<%=request.getContextPath() %>/deleteMemberForm.jsp">회원탈퇴</a>
	</div>
</body>
</html>