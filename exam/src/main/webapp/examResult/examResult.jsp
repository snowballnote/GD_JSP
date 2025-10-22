<!-- /exam/examResult/examResult.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//인가: 학생만
	Student loginStudent = (Student) session.getAttribute("loginStudent");
	String userRole = (String) session.getAttribute("userRole");
	String categoryId = request.getParameter("categoryId");
	
	if (loginStudent == null || !"student".equals(userRole)) {
	    response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	    return;
	}
	
	ExamResultDao examResultDao = new ExamResultDao();
	Map<String, Integer> m = examResultDao.selectExamResultRank(Integer.parseInt(categoryId), loginStudent.getStudentId());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>examResult.jsp</title>
</head>
<body>
	<h1><%=categoryId %>회차 시험 결과</h1>
	<table border="1">
		<tr>
			<th>점수</th>
			<td><%=m.get("score") %></td>
		</tr>
		<tr>
			<th>등수</th>
			<td><%=m.get("r") %> / <%=m.get("cnt") %></td>
		</tr>
	</table>
</body>
</html>