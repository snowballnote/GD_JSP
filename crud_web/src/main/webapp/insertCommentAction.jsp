<!--  insertCommentAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//인가
	if(session.getAttribute("sessionMemberId") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//요청 파라미터
	String boardNo = request.getParameter("boardNo");
	String commentWriter = request.getParameter("commentWriter");
	String commentContent = request.getParameter("commentContent");
	
	//DB코드
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	String sql = "insert into comment(board_no, comment_writer, comment_content) values(?, ?, ?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, boardNo);
	stmt.setString(2, commentWriter);
	stmt.setString(3, commentContent);
	
	int row = stmt.executeUpdate();
	//..댓글입력
	response.sendRedirect(request.getContextPath()+"/boardOne.jsp?boardNo=" + boardNo);
%>
