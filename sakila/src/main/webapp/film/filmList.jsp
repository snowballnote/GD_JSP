<!-- filmList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>
<%
	// 인가
	if(session.getAttribute("loginStaff") == null){ //로그인이 안되어있다면 홈으로
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>filmList</title>
</head>
<body>
	<!-- 공통 메뉴 include -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>

	<h1>filmList</h1>
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

	List<Map<String, Object>> filmList = filmDao.selectFilmListByPage(startRow, rowPerPage);
%>
	<table border="1">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>설명</th>
			<th>개봉년도</th>
			<th>대여료</th>
			<th>상영시간(분)</th>
			<th>등급</th>
			<th>언어</th>
			<th>출연 배우</th>
			<th>마지막 수정일</th>
		</tr>
			<%
				// 결과가 없을 경우
				if (filmList == null || filmList.isEmpty()) {
			%>
				<tr><td colspan="5" style="text-align:center;">등록된 영화가 없습니다.</td></tr>
			<%
				// 결과가 있을 경우 반복 출력
				} else {
					for (Map f : filmList) {
			%>
				<tr>
					<td><%= f.get("filmId") %></td>
					<td>
					  <a href="<%=request.getContextPath()%>/film/filmOne.jsp?filmId=<%=f.get("filmId") %>">
					    <%= f.get("title") %>
					  </a>
					</td>
					<td><%= f.get("description") %></td>
					<td><%= f.get("releaseYear") %></td>
					<td style="text-align:right;">
						<%= f.get("rentalRate") == null ? "-" : String.format("%.2f", ((Number)f.get("rentalRate")).doubleValue()) %>
					</td>
					<td style="text-align:right;">
					  	<%= f.get("replacementCost") == null ? "-" : String.format("%.2f", ((Number)f.get("replacementCost")).doubleValue()) %>
					</td>
					<td><%= f.get("length") == null ? "-" : f.get("length") %></td>
					<td><%= f.get("rating") %></td>
					<td><%= f.get("actorNames") %></td>
					<td><%=f.get("lastUpdate") %></td>
				</tr>
			<%
					}
				}
			%>
		</tbody>
	</table>

	<!-- 페이지네이션 영역 -->
	<div>
		<%
			// 이전 / 다음 페이지 번호 계산
			int prevPage = Math.max(1, currentPage - 1);
			int nextPage = Math.min(lastPage, currentPage + 1);
		%>
		<a href="<%=request.getContextPath()%>/film/filmList.jsp?currentPage=1">처음</a>
		<a href="<%=request.getContextPath()%>/film/filmList.jsp?currentPage=<%= prevPage %>">이전</a>
		<strong><%= currentPage %></strong> / <%= lastPage %>
		<a href="<%=request.getContextPath()%>/film/filmList.jsp?currentPage=<%= nextPage %>">다음</a>
		<a href="<%=request.getContextPath()%>/film/filmList.jsp?currentPage=<%= lastPage %>">끝</a>
	</div>
</body>
</html>
