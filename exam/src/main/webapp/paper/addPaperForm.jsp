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
	
	QuestionDao questionDao = new QuestionDao();
	List<Map<String, Object>> list 
	= questionDao.questionListByCategory(Integer.parseInt(categoryId));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=categoryId %>회차 시험 문제</h1>
	<h2>이름: <%=loginStudent.getStudentName() %></h2>
	<form method="post" action="<%=request.getContextPath() %>/paper/addPaperAction.jsp">
		<input type="hidden" name="categoryId" value="<%=categoryId %>">
		<%
			for(Map m : list){
		%>
				<div> <!-- 타이틀 -->
					<%=m.get("questionNo") %>.
					<%=m.get("questionTitle") %>
					<input type="hidden" name="questionId" value="<%=m.get("questionId") %>">
					<input type="text" name="answer">
				</div>
				<div> <!-- 보기 -->
		<%		
				String[] items = ((String)m.get("items")).split(",");
				for(int i=0; i<items.length; i++){
		%>
					<div>
						<input type="radio" name="<%=m.get("questionId") %>" value="<%=i+1 %>">
						<%=i+1 %>) <%=items[i] %>
					</div>
		<%			
				}
		%>
				</div>
				<hr>
		<%
			}
		%>
		<button type="submit">답안제출(시험완료)</button>
	</form>
		
</body>
</html>