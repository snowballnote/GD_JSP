<!-- /board/boardOne.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "java.util.*" %>
<%
    int boardNo = Integer.parseInt(request.getParameter("boardNo"));
    BoardDao boardDao = new BoardDao();
    BoardDto board = boardDao.selectBoardOne(boardNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/boardOne.jsp</title>
</head>
<body>
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	
	<h1>BOARD ONE</h1>
	<table border="1">
		<tr>
			<th>board_no</th>
			<td><%=board.getBoardNo() %></td>
		</tr>
		<tr>
			<th>board_district</th>
			<td><%=board.getBoardDistrict() %></td>			
		</tr>
		<tr>
			<th>board_title</th>
			<td><%=board.getBoardTitle() %></td>			
		</tr>
		<tr>
			<th>board_content</th>
			<td><%=board.getBoardContent() %></td>			
		</tr>
		<tr>
			<th>board_writer</th>
			<td><%=board.getBoardWriter() %></td>			
		</tr>
		<tr>
			<th>createdate</th>
			<td><%=board.getCreatedate() %></td>		
		</tr>
	</table>
	<div>
		<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=board.getBoardNo()%>">[수정]</a>
		<a href="<%=request.getContextPath()%>/board/deleteBoardAction.jsp?boardNo=<%=board.getBoardNo()%>">[삭제]</a>
	</div>
</body>
</html>