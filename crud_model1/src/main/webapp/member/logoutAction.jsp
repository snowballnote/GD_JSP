<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  // 본인 세션 전체 무효화
  session.invalidate();
  response.sendRedirect(request.getContextPath()+"/home.jsp");
%>