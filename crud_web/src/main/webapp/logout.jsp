<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그아웃(본인에게 할당된 서버안에 세션영역을 초기화) 후 home.jsp redirect
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/home.jsp");
%>