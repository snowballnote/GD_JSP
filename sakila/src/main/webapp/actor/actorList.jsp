<!-- actorList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>
<%
	// 인가
	if(session.getAttribute("loginStaff") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>actorList.jsp</title>
</head>
<body>
	<!-- 공통 메뉴 include -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	
	<h1>actorList</h1>	
<%
	final int rowPerPage = 10;
	int currentPage = 1;
	
	String cp = request.getParameter("currentPage");
	if (cp != null && cp.matches("\\d+")) {
		currentPage = Integer.parseInt(cp);
		if (currentPage < 1) currentPage = 1;
	}
	int startRow = (currentPage - 1) * rowPerPage;
	
	FilmDao filmDao = new FilmDao();
	
	int totalCnt = filmDao.selectFilmTotalCount();
	int lastPage = (int) Math.ceil((double) totalCnt / rowPerPage);
	if (lastPage == 0) lastPage = 1;
	if (currentPage > lastPage) currentPage = lastPage;
	
	List<Map<String, Object>> actorList = actorDao.selectActorListByPage(startRow, rowPerPage);
%>
</body>
</html>