<!-- addCategoryForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addCategoryForm.jsp</title>
</head>
<body>
	<h1>addCategory</h1>
	<!-- 
		회차값은 자동으로 입력
		SELECT MAX(category_id) FROM category + 1
	-->
	<%
		CategoryDao categoryDao = new CategoryDao();
		int nextCategoryId = categoryDao.selectMaxCategoryId() + 1;
	%>
	<form action="<%=request.getContextPath() %>/category/addCategoryAction.jsp" method="post">
		<table border="1">
			<tr>
				<th>categoryId</th><!-- 자동 -->
				<td><%=nextCategoryId %></td>
			</tr>
			<tr>
				<th>examDate</th>
				<td><input type="date" name="examDate" required></td>
			</tr>
		</table>
		<button type="submit">저장</button>
		<a href="<%=request.getContextPath() %>/category/categoryList.jsp">취소</a>
	</form>
</body>
</html>