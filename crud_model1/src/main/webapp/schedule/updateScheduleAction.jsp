<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ScheduleDao, dto.ScheduleDto" %>
<%
  // 인가 + 인코딩
  if(session.getAttribute("sessionMemberId")==null){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp"); return;
  }
  request.setCharacterEncoding("UTF-8");

  // 폼 파라미터 수집
  int    scheduleNo    = Integer.parseInt(request.getParameter("scheduleNo"));
  String scheduleDate  = request.getParameter("scheduleDate");
  String scheduleTitle = request.getParameter("scheduleTitle");
  String scheduleContent = request.getParameter("scheduleContent");

  // DAO 호출로 UPDATE
  ScheduleDao dao = new ScheduleDao();
  ScheduleDto dto = new ScheduleDto();
  dto.setScheduleNo(scheduleNo);
  dto.setScheduleDate(scheduleDate);
  dto.setScheduleTitle(scheduleTitle);
  dto.setScheduleContent(scheduleContent);

  int row = dao.updateSchedule(dto);

  // 성공 → 상세로, 실패 → 수정폼
  if(row==1){
    response.sendRedirect(request.getContextPath()+"/schedule/scheduleOne.jsp?scheduleNo="+scheduleNo);
  }else{
    response.sendRedirect(request.getContextPath()+"/schedule/updateScheduleForm.jsp?scheduleNo="+scheduleNo+"&error=1");
  }
%>