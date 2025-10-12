<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  // 이미 로그인 상태면 홈으로
  if(session.getAttribute("sessionMemberId") != null){
    response.sendRedirect(request.getContextPath()+"/home.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>로그인</title></head>
<body>
  <jsp:include page="/inc/menu.jsp"></jsp:include>

  <h1>로그인</h1>
  <form method="post" action="<%=request.getContextPath()%>/member/loginAction.jsp">
    <table border="1">
      <tr>
        <th>MEMBER ID</th>
        <td><input type="text" name="memberId" required></td>
      </tr>
      <tr>
        <th>MEMBER PW</th>
        <td><input type="password" name="memberPw" required></td>
      </tr>
    </table>
    <button type="submit">로그인</button>
    <a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">회원가입</a>
  </form>

  <% if(request.getParameter("error") != null){ %>
    <p style="color:red;">아이디 또는 비밀번호가 올바르지 않습니다.</p>
  <% } %>
</body>
</html>