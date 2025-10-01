<!-- updateMemberPwAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%
	String memberPw = request.getParameter("memberPw");

	Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");	

	String sql = "update member set member_pw=? where member";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(2, boardTitle);
%>