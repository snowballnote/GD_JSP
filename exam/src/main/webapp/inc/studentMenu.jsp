<!-- /exam/inc/studentMenu.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%
	// 인가
	Student loginStudent = (Student)(session.getAttribute("loginStudent"));
%>
<div>
	<a href="<%=request.getContextPath() %>/student/studentCategoryList.jsp">[시험관리]</a>
	<!-- 로그인 -->
	"<%=loginStudent.getStudentName() %>" 학생 반갑습니다.
	<a href="<%=request.getContextPath() %>/logout.jsp">[ 로그아웃 ]</a>
</div>