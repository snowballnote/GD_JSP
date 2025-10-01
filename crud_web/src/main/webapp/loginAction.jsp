<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	
	String sql = "select member_id from member where member_id=? and member_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, memberId);
	stmt.setString(2, memberPw);
	ResultSet rs = stmt.executeQuery();
	
	if(rs.next()) {
		// 로그인 성공시
		// 로그인 성공 정보를 자기 세션에 저장
		session.setAttribute("sessionMemberId", memberId);
		
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	// 로그인 실패시
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>