<!-- insertMemberAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto.*" %>
<%@ page import ="dao.*" %>
<%
	//인가: 이미 로그인 했다면 회원가입 불가
	if(session.getAttribute("sessionMemberId") != null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

	//Controller Layer
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	//Model
	//DTO
	MemberDto paramMemberDto = new MemberDto();
	paramMemberDto.setMemberId(memberId);
	paramMemberDto.setMemberPw(memberPw);
	
	//DAO
	MemberDao memberDao = new MemberDao();
	int row = 
	

%>