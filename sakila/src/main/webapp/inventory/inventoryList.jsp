<!-- inventoryList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
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
<title>inventoryList.jsp</title>
</head>
<body>
	<!-- 공통 메뉴 include -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>

	<h1>inventoryList</h1>
<%
	final int rowPerPage = 10;
	int currentPage = 1;

	String cp = request.getParameter("currentPage");
	if (cp != null && cp.matches("\\d+")) {
		currentPage = Integer.parseInt(cp);
		if (currentPage < 1) currentPage = 1;
	}
	int startRow = (currentPage - 1) * rowPerPage;

	InventoryDao inventoryDao = new InventoryDao();

	int totalCnt = inventoryDao.selectInventoryTotalCount();
	int lastPage = (int) Math.ceil((double) totalCnt / rowPerPage);
	if (lastPage == 0) lastPage = 1;
	if (currentPage > lastPage) currentPage = lastPage;

	List<Map<String, Object>> inventoryList = inventoryDao.selectInventoryList(startRow, rowPerPage);
%>
	<table border="1">
		<tr>
			<th>inventoryId</th>
			<th>title</th>
			<th>대여</th>
			<th>rentalId</th>
		</tr>
			<%
				// 결과가 없을 경우
				if (inventoryList == null || inventoryList.isEmpty()) {
			%>
				<tr><td colspan="5" style="text-align:center;">대여 가능한 재고가 없습니다.</td></tr>
			<%
				// 결과가 있을 경우 반복 출력
				} else {
					for (Map i : inventoryList) {
			%>
				<tr>
					<td><%= i.get("inventoryId") %></td>
					<td>
					  <a href="<%=request.getContextPath()%>/film/filmOne.jsp?filmId=<%=i.get("filmId") %>">
					    <%= i.get("title") %>
					  </a>
					</td>
					<td>
						<%
							if(i.get("대여").equals("대여가능")){
						%>
								<a href='<%=request.getContextPath()%>/rental/addRental.jsp?inventoryId=<%=i.get("inventoryId") %>&title=<%=i.get("title") %>'>
									<%=i.get("대여") %>
								</a>
						<%		
							}else{
						%>
								<%=i.get("대여") %>				
						<%		
							}
						%>
					</td>
					<td>
						<%
							if((Integer)(i.get("rentalId")) > 0){
						%>
								<a href="<%=request.getContextPath()%>/rental/rentalOne.jsp?rentalId=<%=i.get("rentalId") %>">
									<%= i.get("rentalId") %>
								</a>
						<%		
							}
						%>
					</td>
				</tr>
			<%
					}
				}
			%>		
	</table>
	<!-- 페이지네이션 영역 -->
	<div>
		<%
			// 이전 / 다음 페이지 번호 계산
			int prevPage = Math.max(1, currentPage - 1);
			int nextPage = Math.min(lastPage, currentPage + 1);
		%>
		<a href="<%=request.getContextPath()%>/inventory/inventoryList.jsp?currentPage=1">처음</a>
		<a href="<%=request.getContextPath()%>/inventory/inventoryList.jsp?currentPage=<%= prevPage %>">이전</a>
		<strong><%= currentPage %></strong> / <%= lastPage %>
		<a href="<%=request.getContextPath()%>/inventory/inventoryList.jsp?currentPage=<%= nextPage %>">다음</a>
		<a href="<%=request.getContextPath()%>/inventory/inventoryList.jsp?currentPage=<%= lastPage %>">끝</a>
	</div>
</body>
</html>