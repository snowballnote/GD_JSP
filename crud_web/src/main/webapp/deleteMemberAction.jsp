<!-- deleteMemberAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//로그인 인가
	if(session.getAttribute("sessionMemberId") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	String memberId = (String)(session.getAttribute("sessionMemberId"));
	String memberPw = request.getParameter("memberPw");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");	
	String sql = "delete from member where member_id=? and member_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);	
	stmt.setString(1, memberId);
	stmt.setString(2, memberPw);
	
	int row = stmt.executeUpdate();
	if(row == 1){
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	}else{
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp");
	}
%>