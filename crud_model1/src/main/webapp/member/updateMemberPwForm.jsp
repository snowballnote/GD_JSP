<!-- /member/updateMemberPwForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  // 인가: 로그인 안 되어 있으면 로그인 페이지로
  if(session.getAttribute("sessionMemberId") == null){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>비밀번호 수정</title></head>
<body>
  <jsp:include page="/inc/menu.jsp"></jsp:include>

  <h1>비밀번호 수정</h1>
  <!-- 현재 비밀번호 확인 + 새 비밀번호 2회 확인 -->
  <form method="post" action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp">
    <table border="1">
      <tr>
        <th>현재 비밀번호</th>
        <td><input type="password" name="currentPw" required></td>
      </tr>
      <tr>
        <th>새 비밀번호</th>
        <td><input type="password" name="newPw" required></td>
      </tr>
      <tr>
        <th>새 비밀번호 확인</th>
        <td><input type="password" name="newPw2" required></td>
      </tr>
    </table>
    <button type="submit">수정</button>
    <a href="<%=request.getContextPath()%>/member/memberInfo.jsp">취소</a>
  </form>

  <% if(request.getParameter("error") != null){ %>
    <p style="color:red;">비밀번호 변경에 실패했습니다. 입력값을 확인하세요.</p>
  <% } %>
</body>
</html>