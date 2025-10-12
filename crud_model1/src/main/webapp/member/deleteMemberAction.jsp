<!-- /member/deleteMemberAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao, dto.MemberDto" %>
<%
  // 인가
  if(session.getAttribute("sessionMemberId") == null){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
    return;
  }
  request.setCharacterEncoding("UTF-8");

  String memberId = (String)session.getAttribute("sessionMemberId");
  String memberPw = request.getParameter("memberPw");

  if(memberPw == null || memberPw.trim().isEmpty()){
    response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp");
    return;
  }

  MemberDao memberDao = new MemberDao();
  MemberDto memberDto = new MemberDto();
  memberDto.setMemberId(memberId);
  memberDto.setMemberPw(memberPw);

  // MemberDao의 delete 메서드 사용 (시그니처 유지)
  int row = memberDao.deleteMemberPw(memberDto, null); // 1=성공, 0=실패(비번 불일치 등)

  if(row == 1){
    session.invalidate(); // 세션 종료
    response.sendRedirect(request.getContextPath()+"/home.jsp");
  } else {
    response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp?error=1");
  }
%>