<!-- /member/deleteMemberForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  // 인가
  if(session.getAttribute("sessionMemberId") == null){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>회원탈퇴</title></head>
<body>
  <jsp:include page="/inc/menu.jsp"></jsp:include>

  <h1>회원탈퇴</h1>
  <form method="post" action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp">
    <div>
      비밀번호: <input type="password" name="memberPw" required>
    </div>
    <button type="submit">탈퇴</button>
    <a href="<%=request.getContextPath()%>/member/memberInfo.jsp">취소</a>
  </form>
</body>
</html>