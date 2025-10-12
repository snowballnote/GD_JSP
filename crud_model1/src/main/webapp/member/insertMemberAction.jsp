<!-- /member/insertMemberAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao, dto.MemberDto" %>
<%
  // 로그인 상태면 가입 불가
  if(session.getAttribute("sessionMemberId") != null){
    response.sendRedirect(request.getContextPath()+"/home.jsp");
    return;
  }
  request.setCharacterEncoding("UTF-8");

  String memberId = request.getParameter("memberId");
  String memberPw = request.getParameter("memberPw");

  if(memberId == null || memberPw == null || memberId.trim().isEmpty() || memberPw.trim().isEmpty()){
    response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp?error=1");
    return;
  }

  MemberDao memberDao = new MemberDao();

  // 1) 중복검사
  String exists = memberDao.selectMemberId(memberId.trim());
  if(exists != null){
    // 이미 존재 → 폼으로
    response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp?error=1");
    return;
  }

  // 2) 가입 진행
  MemberDto memberDto = new MemberDto();
  memberDto.setMemberId(memberId.trim());
  memberDto.setMemberPw(memberPw); // (실서비스는 해시 저장 권장)

  int row = memberDao.insertMember(memberDto); // 1=성공
  if(row == 1){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
  } else {
    response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp?error=1");
  }
%>