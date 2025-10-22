<!-- /exam/student/studentCategoryList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	// 인가: 학생만
	Student loginStudent = (Student) session.getAttribute("loginStudent");
	String userRole = (String) session.getAttribute("userRole");
	if (loginStudent == null || !"student".equals(userRole)) {
	    response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	    return;
	}
	
	CategoryDao categoryDao = new CategoryDao();
	List<Map<String, Object>> list = categoryDao.selectStudentCategoryList(loginStudent.getStudentId());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>studentCategoryList</title>
</head>
<body>
	<jsp:include page="/inc/studentMenu.jsp"></jsp:include>
	<h1>studentCategoryList</h1>
	<table border="1">
		<tr>
			<th>회차(category_id)</th>
			<th>날짜</th>
			<th>시험</th>
		</tr>
		<%
			for(Map m : list){
		%>
				<tr>
					<td><%= m.get("categoryId") %></td>
                	<td><%= m.get("examDate") %></td>
					<td>
						<%
                        	String exam = (String)m.get("exam");
							if(exam.equals("응시불가")){
						%>
								시험당일 응시가능
						<%		
							}else if(exam.equals("응시완료")){
						%>
								익일부터 확인가능
						<%		
							}else if(exam.equals("결과보기")){
						%>
								<a href="<%=request.getContextPath()%>/examResult/examResult.jsp?categoryId=<%=m.get("categoryId") %>">결과보기</a>
						<%		
							}else{
						%>		
								<a href="<%=request.getContextPath()%>/paper/addPaperForm.jsp?categoryId=<%=m.get("categoryId") %>">시험응시하기</a>
						<%		
							}
						%>
					</td>
				</tr>
		<%		
			}
		%>
	</table>
</body>
</html>