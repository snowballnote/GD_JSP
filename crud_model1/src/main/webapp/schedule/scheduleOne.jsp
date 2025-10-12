<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ScheduleDao, dto.ScheduleDto" %>
<%
  // 인가
  if(session.getAttribute("sessionMemberId")==null){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp"); return;
  }
  // 대상 PK
  String scheduleNo = request.getParameter("scheduleNo");
  if(scheduleNo==null){ response.sendRedirect(request.getContextPath()+"/schedule/schedule.jsp"); return; }

  // DAO로 단건 조회
  ScheduleDao dao = new ScheduleDao();
  ScheduleDto dto = dao.selectOne(Integer.parseInt(scheduleNo));
  if(dto==null){ response.sendRedirect(request.getContextPath()+"/schedule/schedule.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>scheduleOne</title></head>
<body>
  <jsp:include page="/inc/menu.jsp"></jsp:include>

  <h1>SCHEDULE ONE</h1>
  <table border="1">
    <tr><th>schedule_no</th><td><%=dto.getScheduleNo()%></td></tr>
    <tr><th>schedule_date</th><td><%=dto.getScheduleDate()%></td></tr>
    <tr><th>schedule_title</th><td><%=dto.getScheduleTitle()%></td></tr>
    <!-- 긴 내용을 보기 좋게 줄바꿈/공백 보존 -->
    <tr><th>schedule_content</th><td><pre style="white-space:pre-wrap;"><%=dto.getScheduleContent()%></pre></td></tr>
    <tr><th>createdate</th><td><%=dto.getCreatedate()%></td></tr>
  </table>

  <!-- 수정/삭제 이동 -->
  <a href="<%=request.getContextPath()%>/schedule/updateScheduleForm.jsp?scheduleNo=<%=dto.getScheduleNo()%>">수정</a>
  <a href="<%=request.getContextPath()%>/schedule/deleteScheduleAction.jsp?scheduleNo=<%=dto.getScheduleNo()%>">삭제</a>
</body>
</html>