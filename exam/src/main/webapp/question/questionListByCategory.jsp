<!-- /exam/question/questionListByCategory.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<%@ page import ="java.util.*" %>
<%
	// 인가
	Teacher loginTeacher = (Teacher) session.getAttribute("loginTeacher");
    String userRole = (String) session.getAttribute("userRole");

    if (loginTeacher == null || !"teacher".equals(userRole)) {
        response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
        return;
    }
    
	String categoryIdStr = request.getParameter("categoryId");
	if (categoryIdStr == null || categoryIdStr.isEmpty()) {
	    response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
	    return;
	}
	int categoryId = Integer.parseInt(categoryIdStr);
	
	QuestionDao questionDao = new QuestionDao();
	List<Map<String, Object>> list 
	= questionDao.questionListByCategory(categoryId);
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
	<div style="margin-bottom:10px;">
    	<a href="<%=request.getContextPath()%>/question/addQuestionForm.jsp?categoryId=<%=categoryId%>">[문제추가]</a>
   	 	<a href="<%=request.getContextPath()%>/category/categoryList.jsp">[카테고리목록]</a>
  	</div>
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