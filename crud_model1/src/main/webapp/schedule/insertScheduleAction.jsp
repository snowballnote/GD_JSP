<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ScheduleDao, dto.ScheduleDto" %>
<%
  // 인가 + 인코딩
  if(session.getAttribute("sessionMemberId")==null){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp"); return;
  }
  request.setCharacterEncoding("UTF-8");

  // 폼 입력값 수집
  String scheduleDate = request.getParameter("scheduleDate");   // yyyy-MM-dd
  String scheduleTitle = request.getParameter("scheduleTitle");
  String scheduleContent = request.getParameter("scheduleContent");

  // DAO 호출로 INSERT
  ScheduleDao dao = new ScheduleDao();
  ScheduleDto dto = new ScheduleDto();
  dto.setScheduleDate(scheduleDate);
  dto.setScheduleTitle(scheduleTitle);
  dto.setScheduleContent(scheduleContent);
  int row = dao.insertSchedule(dto);

  // 등록 후, 해당 날짜의 리스트 화면으로 리다이렉트
  String y = scheduleDate.substring(0,4);
  String m = scheduleDate.substring(5,7);
  String d = scheduleDate.substring(8);
  response.sendRedirect(request.getContextPath()+"/schedule/scheduleDateList.jsp?y="+y+"&m="+Integer.parseInt(m)+"&d="+Integer.parseInt(d));
%>