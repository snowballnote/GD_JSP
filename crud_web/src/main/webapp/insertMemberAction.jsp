<!-- insertMemberAction.jsp -->
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.lang.module.ResolutionException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//인가: 이미 로그인 했다면 회원가입 불가
	if(session.getAttribute("sessionMemberId") != null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");

	String sql1 = "select member_id from member where member_id=?";
	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, memberId);
	ResultSet rs1 = stmt1.executeQuery();
	
	if(rs1.next()){
		//rs1 결과가 있다면 "이미 사용중인 아이디 입니다."
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
	}else{
		//회원가입
		String sql2 = "insert into member(member_id, member_pw) values(?, ?)";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, memberId);
		stmt2.setString(2, memberPw);
		
		int result = stmt2.executeUpdate();
		if(result == 1){
			//회원가입 성공
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		}else if(result == 0){
			//회원가입 실패
			response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		}else{
			throw new Exception("에러!");
		}
	}	
%>