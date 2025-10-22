<!-- /exam/inc/teacherMenu.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%
	// 인가
	Teacher loginTeacher = (Teacher)(session.getAttribute("loginTeacher"));
%>
<div>
	<a href="<%=request.getContextPath() %>/category/categoryList.jsp">[카테고리관리]</a>
	<a href="<%=request.getContextPath() %>/question/questionListByCategory.jsp">[시험관리]</a>
	<!-- 로그인 -->
	"<%=loginTeacher.getTeacherName() %>" 선생님 반갑습니다.
	<a href="<%=request.getContextPath() %>/logout.jsp">[ 로그아웃 ]</a>
</div>