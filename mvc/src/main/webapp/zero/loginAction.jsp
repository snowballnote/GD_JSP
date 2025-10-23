<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="dao.*" %>
<!-- 로그인 하지 않은 session 분기 코드 : BeforeLoginFilter 필터 -->
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	Member paramM = new Member();
	paramM.setId(id);
	paramM.setPw(pw);
	
	MemberDao memberDao = new MemberDao();
	Member loginMember = memberDao.login(paramM);
	if(loginMember == null){
		System.out.println("로그인 실패");
		response.sendRedirect(request.getContextPath()+"/zero/loginForm.jsp");
		return;
	}
	
	// 로그인 성공이면
	session.setAttribute("loginMember", loginMember);
	response.sendRedirect(request.getContextPath()+"/one/memberHome.jsp");
	
%>