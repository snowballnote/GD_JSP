<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "dao.*" %>
<%
	final int ROW_PER_PAGE = 10;
	
	// Controller Layer
	// 매개값: boardDistrict, currentPage
	String boardDistrict = request.getParameter("boardDistrict");
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int startRow = 0;
	startRow = ROW_PER_PAGE * (currentPage - 1);

	// 모델(값): List<BoardDto>, lastPage : startRow와 ROW_PER_PAGE 입력 - List<BoardDto>반환하는 기능이 필요 - DAO 구현
	BoardDao boardDao = new BoardDao();
	List<BoardDto> boardList = boardDao.selectBoardListByPage(boardDistrict, startRow, ROW_PER_PAGE);
	System.out.println("boardList.jsp#boardList: "+boardList);
	// 모델(값) : lastPage, totalCount 먼저 구하고,  totalCount, ROW_PER_PAGE 입력 - lastPage 반환
	int lastPage = boardDao.getLastPage(boardDistrict, ROW_PER_PAGE);
	System.out.println("boardList.jsp#lastPage: "+lastPage);
%>

<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	<h1>boardList</h1>
	
		<!-- Navigation -->
	<div>
		<%
			String[] boardDistrictList = {"경기도","강원도","충청도","전라도","경상도","제주도"};
			for(String bd : boardDistrictList) {
		%>
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?boardDistrict=<%=bd%>">[<%=bd%>]</a>
		<%		
			}
		%>
	</div>
	
	<h1>BOARD LIST</h1>
	
	<div>
		<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp">글입력</a>
	</div>
	
	<div>
		현재 페이지: <%=currentPage%> / <%=lastPage%>
	</div>
	<table border="1">
		<tr>
			<th>board_no</th>
			<th>board_district</th>
			<th>board_title</th>
		</tr>
		<%
			for(BoardDto b : boardList) {
		%>
				<tr>
					<td><%=b.getBoardNo()%></td>
					<td><%=b.getBoardDistrict()%></td>
					<td>
						<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>">
							<%=b.getBoardTitle()%>
						</a>
					</td>
				</tr>
		<%		
			}
		%>
	</table>
	<!-- Paging Navigation -->
	<div>
		<!-- 이전 -->	
		<%
			if(currentPage > 1) {
				if(boardDistrict == null) {
		%>	
					<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>">[이전]</a>				
		<%			
				} else {
		%>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&boardDistrict=<%=boardDistrict%>">[이전]</a>			
		<%			
				}
			}	
		%>
				
		<!-- 다음 -->
		<%	
			if(currentPage < lastPage){
				if(boardDistrict == null) {
		%>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
		<%			
				} else {
		%>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&boardDistrict=<%=boardDistrict%>">[다음]</a>
		<%			
				}
			}
		%>
		
	</div>
	
</body>
</html>