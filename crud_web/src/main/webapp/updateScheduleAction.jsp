<!-- updateScheduleAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String scheduleNo = request.getParameter("scheduleNo");
	String scheduleDate = request.getParameter("scheduleDate");
	String scheduleTitle = request.getParameter("scheduleTitle");
	String scheduleContent = request.getParameter("scheduleContent");

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	String sql = "update schedule set schedule_date=?, schedule_title=?, schedule_content=? where schedule_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, scheduleDate);
	stmt.setString(2, scheduleTitle);
	stmt.setString(3, scheduleContent);
	stmt.setInt(4, Integer.parseInt(scheduleNo));
	
	int row = stmt.executeUpdate(); // 
	// view가 없다.
	// 성공 -> boardOne 리다이렉트
	// 실패 -> updateBoardForm 리다이렉트
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/scheduleOne.jsp?scheduleNo="+scheduleNo);
	} else if(row == 0) {
		response.sendRedirect(request.getContextPath()+"/updateScheduleForm.jsp?scheduleNo="+scheduleNo);
	} else {
		// 예상치 못한 상황
		throw new Exception("심각한 에러 발생!");
	}
%>