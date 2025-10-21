<!-- categoryList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*" %>
<%	
	// 테스트할때 계속 로그인해야해서 잠시 주석처리
	if(session.getAttribute("loginTeacher") == null)
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>categoryList.jsp</title>
</head>
<body>
	<jsp:include page="/inc/teacherMenu.jsp"></jsp:include>
	<h1>categoryList</h1>
<%
	final int rowPerPage = 10;
	int currentPage = 1;
	String cp = request.getParameter("currentPage");
	if (cp != null && !cp.trim().isEmpty()) {
	    boolean isNumber = true;
	    for (int i = 0; i < cp.length(); i++) {
	        if (!Character.isDigit(cp.charAt(i))) { isNumber = false; break; }
	    }
	    if (isNumber) {
	        currentPage = Integer.parseInt(cp);
	        if (currentPage < 1) currentPage = 1;
	    }
	}
	int startRow = (currentPage - 1) * rowPerPage;

	CategoryDao categoryDao = new CategoryDao();

	int totalCnt = categoryDao.selectCategoryTotalCount();
	int lastPage = totalCnt / rowPerPage;  // 몫
	if (totalCnt % rowPerPage != 0) {      // 나머지가 있으면 한 페이지 더
		lastPage = lastPage + 1;
	}
	if (lastPage == 0) lastPage = 1;
	if (currentPage > lastPage) currentPage = lastPage;

	List<Category> categoryList = categoryDao.selectCategoryList(startRow, rowPerPage);
%>
	<!-- 글 작성 페이지로 이동하는 링크 -->
	<div>
		<a href="<%=request.getContextPath()%>/category/addCategoryForm.jsp">카테고리추가</a>
	</div>
	
	<table border="1">
		<tr>
			<th>categoryId</th>
			<th>examDate</th>
			<th>createdate</th>
			<th>수정</th>
			<th>삭제</th>
			<th>문제등록</th>
			<th>문제목록</th>
		</tr>
			<%
				// 결과가 없을 경우
				if (categoryList == null || categoryList.isEmpty()) {
			%>
				<tr><td colspan="5" style="text-align:center;">내용이 없습니다.</td></tr>
			<%
				// 결과가 있을 경우 반복 출력
				} else {
					for (Category c : categoryList) {
			%>
				<tr>
					<td><%= c.getCategoryId() %></td>
					<td><%= c.getExamDate() %></td>
					<td><%= c.getCreatedate() %></td>
					<td><a href="<%=request.getContextPath()%>/category/modifyCategoryForm.jsp?categoryId=<%=c.getCategoryId()%>">[수정]</a></td>
					<td><a href="<%=request.getContextPath()%>/category/removeCategory.jsp?categoryId=<%=c.getCategoryId()%>">[삭제]</a></td>
					<td>
						<%
							// 시험일자가 지났는지 분기
							Calendar today = Calendar.getInstance();
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
							String strToday = sdf.format(today.getTime());
							System.out.println(strToday);
							// 문자열 strToday와 c.getExamDate()크기를 비교 compareTo()
							System.out.println(strToday.compareTo(c.getExamDate())); // 양수이면 시험 완료, 음수이면 시험 전
							if(strToday.compareTo(c.getExamDate()) > 0){
						%>
								시험완료
						<%		
							}else{
						%>
								<a href="<%=request.getContextPath()%>/question/addQuestionForm.jsp?categoryId=<%=c.getCategoryId()%>">[문제등록]</a>
						<%
							}
						%>
					</td>
					<td>
						<a href="<%=request.getContextPath()%>/category/categoryList.jsp">[문제목록]</a>
					</td>
				</tr>
			<%
					}
				}
			%>		
	</table>
	<!-- 페이지 네비게이션 -->
	<div style="margin-top:12px;">
	    <a href="?currentPage=1">처음</a>
	    <%
	      	int prevPage = (currentPage > 1) ? currentPage - 1 : 1;
	      	int nextPage = (currentPage < lastPage) ? currentPage + 1 : lastPage;
	    %>
	    <a href="?currentPage=<%= prevPage %>">이전</a>
	    <strong> <%= currentPage %> / <%= lastPage %> </strong>
	    <a href="?currentPage=<%= nextPage %>">다음</a>
	    <a href="?currentPage=<%= lastPage %>">마지막</a>
	</div>
</body>
</html>