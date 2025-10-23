<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 하지 않은 session 분기 코드 : BeforeLoginFilter 필터 -->
<%
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/zero/loginForm.jsp");
%>