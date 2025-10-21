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
	
	int currentPage = 1;
	int rowPerPage = 10;
	int startRow = (1-currentPage) * rowPerPage;
	
	CategoryDao categoryDao = new CategoryDao();
	List<Category> list = categoryDao.selectCategoryList(startRow, rowPerPage);
	
	// 날짜 준비 (반복문 밖)
    Calendar today = Calendar.getInstance();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String strToday = sdf.format(today.getTime());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>studentCategoryList</title>
</head>
<body>
	<jsp:include page="/inc/studentMenu.jsp"></jsp:include>
	<h1>studentList</h1>
	<table border="1">
		<tr>
			<th>회차(category_id)</th>
			<th>날짜</th>
			<th>완료 / 참여</th>
		</tr>
		<%
			for(Category c : list){
				String examDate = c.getExamDate(); // "yyyy-MM-dd"
                int cmp = strToday.compareTo(examDate);
		%>
				<tr>
					<td><%= c.getCategoryId() %></td>
                	<td><%= examDate %></td>
					<td>
						<%
                        	if (cmp > 0) { // 오늘보다 과거 → 완료(결과 보기)
                   		%>
							<a href="">[결과보기]</a>
						<%		
							}else if (cmp == 0) { // 오늘 → 응시 허용(예시)
						%>
								<a href="">[시험응시]</a>
						<%
							} else { // cmp < 0 : 시험 전 → 안내
						%>
							시험 예정
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