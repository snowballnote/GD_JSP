<!-- /member/updateMemberPwAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao, dto.MemberDto" %>
<%
  // 인가 + 인코딩
  if(session.getAttribute("sessionMemberId") == null){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
    return;
  }
  request.setCharacterEncoding("UTF-8");

  // 파라미터 수집
  String currentPw = request.getParameter("currentPw");
  String newPw     = request.getParameter("newPw");
  String newPw2    = request.getParameter("newPw2");

  // 1차 검증
  if(currentPw == null || newPw == null || newPw2 == null || !newPw.equals(newPw2)){
    response.sendRedirect(request.getContextPath()+"/member/updateMemberPwForm.jsp?error=1");
    return;
  }

  // DAO 호출
  MemberDao memberDao = new MemberDao();
  MemberDto memberDto = new MemberDto();
  memberDto.setMemberId((String)session.getAttribute("sessionMemberId"));
  memberDto.setMemberPw(currentPw); // 현재 비번으로 본인 인증

  int row = memberDao.updateMemberPw(memberDto, newPw); // 1=성공, 0=실패

  if(row == 1){
    response.sendRedirect(request.getContextPath()+"/member/memberInfo.jsp");
  } else {
    response.sendRedirect(request.getContextPath()+"/member/updateMemberPwForm.jsp?error=1");
  }
%>