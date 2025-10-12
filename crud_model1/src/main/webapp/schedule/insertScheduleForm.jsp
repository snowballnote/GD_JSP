<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  // 인가: 로그인 여부 체크
  if(session.getAttribute("sessionMemberId")==null){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp"); return;
  }
  // y/m/d 파라미터를 받아 날짜 문자열을 yyyy-MM-dd 형식으로 만든다.
  String y = request.getParameter("y");
  String m = request.getParameter("m");
  String d = request.getParameter("d");
  m = Integer.parseInt(m) > 9 ? m : "0"+m;
  d = Integer.parseInt(d) > 9 ? d : "0"+d;
  String scheduleDate = y + "-" + m + "-" + d;
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>insertScheduleForm</title></head>
<body>
  <jsp:include page="/inc/menu.jsp"></jsp:include>

  <h1>INSERT SCHEDULE</h1>
  <!-- 날짜는 클릭한 칸 기준으로 고정(읽기전용) -->
  <form method="post" action="<%=request.getContextPath()%>/schedule/insertScheduleAction.jsp">
    <table border="1">
      <tr><th>SCHEDULE DATE</th><td><input type="date" name="scheduleDate" value="<%=scheduleDate%>" readonly></td></tr>
      <tr><th>SCHEDULE TITLE</th><td><input type="text" name="scheduleTitle" required></td></tr>
      <tr><th>SCHEDULE CONTENT</th><td><textarea rows="3" cols="50" name="scheduleContent" required></textarea></td></tr>
    </table>
    <button type="submit">스케줄 추가</button>
  </form>
</body>
</html>