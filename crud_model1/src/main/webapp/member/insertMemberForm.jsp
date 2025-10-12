<!-- /member/insertMemberForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  // 로그인 상태면 회원가입 차단
  if(session.getAttribute("sessionMemberId") != null){
    response.sendRedirect(request.getContextPath()+"/home.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>회원가입</title></head>
<body>
  <jsp:include page="/inc/menu.jsp"></jsp:include>

  <h1>회원가입</h1>
  <form method="post" action="<%=request.getContextPath()%>/member/insertMemberAction.jsp">
    <table border="1">
      <tr><th>MEMBER ID</th><td><input type="text" name="memberId" required></td></tr>
      <tr><th>MEMBER PW</th><td><input type="password" name="memberPw" required></td></tr>
    </table>
    <button type="submit">회원가입</button>
  </form>

  <% if(request.getParameter("error") != null){ %>
    <p style="color:red;">이미 사용 중인 아이디입니다.</p>
  <% } %>
</body>
</html>