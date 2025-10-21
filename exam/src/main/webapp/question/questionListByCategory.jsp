<!-- /exam/question/questionListByCategory.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import ="java.util.*" %>
<%
	String categoryId = request.getParameter("categoryId");
	QuestionDao questionDao = new QuestionDao();
	List<Map<String, Object>> list 
		= questionDao.questionListByCategory(Integer.parseInt(categoryId));
	System.out.println(list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>questionListByCategory.jsp</title>
</head>
<body>
	<jsp:include page="/inc/teacherMenu.jsp"></jsp:include>
	<h1>questionList</h1>
	
	<table border ="1">
		<%
			for(Map m : list){
		%>
				<div><!-- 문제 -->
					<%=m.get("questionNo") %>
					<%=m.get("questionTitle") %>?
					정답 : <%=m.get("questionAnswer") %>
					<a href="">문제수정</a>
				</div>
				
				<div><!-- 보기 -->
					<%	// a, b, c
						String[] idx = {"①", "②", "③", "④"};
						String[] arr = ((String)m.get("items")).split(",");
						for(int i=0;i<arr.length;i++){
					%>
							<%=idx[i] %>&nbsp;<%=arr[i] %><br>
					<%		
						}
					%>
				</div>
				
				<hr>
		<%		
			}
		%>
	</table>
</body>
</html>