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
<title>updateBoardFrom.jsp</title>
</head>
<body>
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	<h1>UPDATE BOARD</h1>
	
	<form action="<%=request.getContextPath() %>/board/updateBoardAction.jsp" method="post">
	<table border="1">
	<!-- board의 지역, 제목, 내용만 수정가능 -->
		<tr>
			<th>board_no</th>
			<td>
				<input type="text" name="boardNo" value="<%=board.getBoardNo() %>" readonly="readonly">	
			</td>
		</tr>
		<tr>
			<th>board_district</th>			
			<td>
				<select name="boardDistrict">
						<%
							String[] boardDistrictList = {"경기도", "강원도", "충청도", "전라도", "경상도", "제주도"};
							for(String s : boardDistrictList){
								if(s.equals(board.getBoardDistrict())){
						%>
									<option value="<%=s %>" selected="selected"><%=s %></option>
						<%
								}else{
						%>
							
									<option value="<%=s %>"><%=s %></option>
						<%
								}
						%>
								

						<%		
							}
						%>
					</select>
			</td>			
		</tr>
		<tr>
			<th>board_title</th>
			<td>
				<input type="text" name="boardTitle" value="<%=board.getBoardTitle() %>">
			</td>			
		</tr>
		<tr>
			<th>board_content</th>
			<td>
				<textarea name="boardContent" rows="5" cols="50"> <%=board.getBoardContent() %></textarea>
			</td>			
	</table>
	<button type="submit">수정하기</button>
	</form>	
</body>
</html>