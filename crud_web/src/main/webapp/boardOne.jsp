<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "java.util.*" %>
<%
	String boardNo = request.getParameter("boardNo");
	System.out.println("boardNo: " + boardNo);
	if(boardNo == null){
		response.sendRedirect(request.getContextPath() + "/boardList.jsp"); //다른곳으로 돌려놓고
		return; //종료
	}
	
	// 1) 드라이브 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	// 2) Mysql(RDBMS)서버 접근
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	
	// 3) 쿼리 생성 후 실행-> 반환값
	String sql = "select board_no, board_district, board_title, board_content, board_writer, createdate from board where board_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, Integer.parseInt(boardNo));
	System.out.println("stmt: " + stmt.toString());
	ResultSet rs = stmt.executeQuery();
	BoardDto board = new BoardDto();
	if(rs.next()){
		board.setBoardNo(rs.getInt("board_no"));
		board.setBoardDistrict(rs.getString("board_district"));
		board.setBoardTitle(rs.getString("board_title"));
		board.setBoardContent(rs.getString("board_content"));
		board.setBoardWriter(rs.getString("board_writer"));
		board.setCreatedate(rs.getString("createdate"));		
	}	
	System.out.println(board.toString());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardOne.jsp</title>
</head>
<body>
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/menu.jsp"></jsp:include>
	
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
		<a href="<%=request.getContextPath()%>/updateBoardForm.jsp?boardNo=<%=board.getBoardNo()%>">[수정]</a>
		<a href="<%=request.getContextPath()%>/deleteBoard.jsp?boardNo=<%=board.getBoardNo()%>">[삭제]</a>
	</div>
	<!-- 댓글 -->
	<hr>
	<!-- 댓글리스트 -->
	<%
		String sql2 = "select comment_no, board_no, comment_content, comment_writer, createdate from comment where board_no =? order by comment_no desc";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, board.getBoardNo());
		ResultSet rs2 = stmt2.executeQuery();
		ArrayList<CommentDto> commentDtolist = new ArrayList<>();
		while(rs2.next()){
			CommentDto commentDto = new CommentDto();
			commentDto.setCommentNo(rs2.getInt("comment_no"));
			commentDto.setBoardNo(rs2.getInt("board_no")); 
			commentDto.setCommentContent(rs2.getString("comment_content"));
			commentDto.setCommentWriter(rs2.getString("comment_writer"));
			commentDto.setCreatedate(rs2.getString("createdate"));
			commentDtolist.add(commentDto);
		}	
	%>
	<table border="1">
		<%
			for(CommentDto commentDto : commentDtolist){
		%>		
				<tr>	
					<td><%=commentDto.getCommentContent() %></td>
					<td><%=commentDto.getCommentWriter() %></td>
					<td>
						<a href="<%=request.getContextPath()%>/deleteComment.jsp?commentNo=<%=commentDto.getCommentNo()%>&boardNo=<%=commentDto.getBoardNo()%>">
						[삭제]
						</a>
					</td>
				</tr>
		<%		
			}
		%>
		
	</table>
	<hr>
	<!-- 댓글 입력 폼 -->
	<form method="post" action="<%=request.getContextPath()%>/insertCommentAction.jsp">
		<table border="1">
			<tr>
				<th>board_no</th>
				<td>
					<input type="text" name="boardNo" value="<%=board.getBoardNo() %>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>comment_writer</th>
				<td>
					<input type="text" name="commentWriter" value="<%=(String)(session.getAttribute("sessionMemberId")) %>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>comment_content</th>
				<td>
					<textarea rows="3" cols="50" name="commentContent"></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">댓글입력</button>
	</form>
</body>
</html>