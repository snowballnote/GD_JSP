<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String diaryNo = request.getParameter("diaryNo");
	String diaryDate = request.getParameter("diaryDate");
	String diaryTitle = request.getParameter("diaryTitle");
	String diaryContent = request.getParameter("diaryContent");

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	String sql = "update diary set diary_date=?, diary_title=?, diary_content=? where diary_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, diaryDate);
	stmt.setString(2, diaryTitle);
	stmt.setString(3, diaryContent);
	stmt.setInt(4, Integer.parseInt(diaryNo));
	
	int row = stmt.executeUpdate(); // 
	// view가 없다.
	// 성공 -> boardOne 리다이렉트
	// 실패 -> updateBoardForm 리다이렉트
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/diaryOne.jsp?diaryNo="+diaryNo);
	} else if(row == 0) {
		response.sendRedirect(request.getContextPath()+"/updateDiaryForm.jsp?diaryNo="+diaryNo);
	} else {
		// 예상치 못한 상황
		throw new Exception("심각한 에러 발생!");
	}
%>