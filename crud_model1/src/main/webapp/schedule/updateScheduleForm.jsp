<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ScheduleDao, dto.ScheduleDto" %>
<%
  // 인가
  if(session.getAttribute("sessionMemberId")==null){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp"); return;
  }
  // 수정 대상 PK
  String scheduleNo = request.getParameter("scheduleNo");
  if(scheduleNo==null){ response.sendRedirect(request.getContextPath()+"/schedule/schedule.jsp"); return; }

  // DAO로 기존 데이터 로드
  ScheduleDao dao = new ScheduleDao();
  ScheduleDto schedule = dao.selectOne(Integer.parseInt(scheduleNo));
  if(schedule==null){ response.sendRedirect(request.getContextPath()+"/schedule/schedule.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>updateScheduleForm</title></head>
<body>
  <jsp:include page="/inc/menu.jsp"></jsp:include>

  <h1>UPDATE SCHEDULE</h1>
  <!-- 기존값을 value/textarea에 채워 넣는다 -->
  <form action="<%=request.getContextPath()%>/schedule/updateScheduleAction.jsp" method="post">
    <table border="1">
      <tr><th>schedule_no</th><td><input type="text" name="scheduleNo" value="<%=schedule.getScheduleNo()%>" readonly></td></tr>
      <tr><th>schedule_date</th><td><input type="date" name="scheduleDate" value="<%=schedule.getScheduleDate()%>"></td></tr>
      <tr><th>schedule_title</th><td><input type="text" name="scheduleTitle" value="<%=schedule.getScheduleTitle()%>" required></td></tr>
      <tr><th>schedule_content</th><td><textarea name="scheduleContent" rows="5" cols="50" required><%=schedule.getScheduleContent()%></textarea></td></tr>
    </table>
    <button type="submit">수정</button>
  </form>
</body>
</html>