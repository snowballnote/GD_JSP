<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao, dto.MemberDto" %>
<%
  // 이미 로그인 상태면 홈으로
  if(session.getAttribute("sessionMemberId") != null){
    response.sendRedirect(request.getContextPath()+"/home.jsp");
    return;
  }
  request.setCharacterEncoding("UTF-8");

  String memberId = request.getParameter("memberId");
  String memberPw = request.getParameter("memberPw");

  // 입력값 기본 검증
  if(memberId == null || memberPw == null || memberId.trim().isEmpty() || memberPw.trim().isEmpty()){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp?error=1");
    return;
  }

  // DAO 호출 (성공 시 member_id, 실패 시 null)
  MemberDao memberDao = new MemberDao();
  MemberDto in = new MemberDto();
  in.setMemberId(memberId.trim());
  in.setMemberPw(memberPw);

  String loginId = memberDao.login(in);

  if(loginId != null){
    // 로그인 성공 → 세션 저장 후 홈
    session.setAttribute("sessionMemberId", loginId);
    response.sendRedirect(request.getContextPath()+"/home.jsp");
  } else {
    // 실패 → 폼으로
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp?error=1");
  }
%>