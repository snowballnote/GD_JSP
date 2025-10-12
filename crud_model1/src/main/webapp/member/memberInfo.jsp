<!-- /member/memberInfo.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao, dto.MemberDto" %>
<%
  // 인가
  if(session.getAttribute("sessionMemberId") == null){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
    return;
  }
  String memberId = (String)session.getAttribute("sessionMemberId");

  // DAO로 개인정보 조회
  MemberDao memberDao = new MemberDao();
  MemberDto me = memberDao.selectMemberOne(memberId); // 비번은 표시하지 않음
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>memberInfo.jsp</title></head>
<body>
  <jsp:include page="/inc/menu.jsp"></jsp:include>
  <h1>회원정보</h1>
  <table border="1">
    <tr><th>아이디</th><td><%= me != null ? me.getMemberId() : "" %></td></tr>
    <%-- 필요하다면 생성일도 표시 가능: me.getCreatedate() --%>
  </table>
  <div style="margin-top:10px;">
    <a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp">비밀번호 수정</a>
    <a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">회원탈퇴</a>
  </div>
</body>
</html>