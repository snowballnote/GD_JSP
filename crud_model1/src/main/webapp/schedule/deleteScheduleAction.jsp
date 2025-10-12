<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ScheduleDao" %>
<%
  // 인가
  if(session.getAttribute("sessionMemberId")==null){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp"); return;
  }

  // 어떤 일정인지 PK 확인
  String scheduleNo = request.getParameter("scheduleNo");
  if(scheduleNo==null){ 
    response.sendRedirect(request.getContextPath()+"/schedule/schedule.jsp"); 
    return; 
  }

  // DAO 호출로 삭제
  ScheduleDao dao = new ScheduleDao();
  int row = dao.deleteSchedule(Integer.parseInt(scheduleNo));

  // 성공 → 달력, 실패 → 상세로
  if(row==1){
    response.sendRedirect(request.getContextPath()+"/schedule/schedule.jsp");
  } else {
    response.sendRedirect(request.getContextPath()+"/schedule/scheduleOne.jsp?scheduleNo="+scheduleNo+"&error=1");
  }
%>