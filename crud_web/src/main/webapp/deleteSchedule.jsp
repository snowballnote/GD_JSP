<!-- deleteSchedule.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String scheduleNo = request.getParameter("scheduleNo");
	System.out.println("scheduleNo: "+scheduleNo);
	if(scheduleNo == null) {
		response.sendRedirect(request.getContextPath()+"/schedule.jsp");
		return;
	}
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	String sql = "delete from schedule where schedule_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, Integer.parseInt(scheduleNo));
	int row = stmt.executeUpdate(); // 1 : 한행이 삭제, 0 : 하나의 행도 삭제되지 않았다
	if(row == 1) {
		System.out.println("deleteSchedule 삭제성공");
		response.sendRedirect(request.getContextPath()+"/schedule.jsp");
	} else if(row == 0) {
		System.out.println("deleteSchedule 삭제실패");
		response.sendRedirect(request.getContextPath()+"/scheduleOne.jsp?scheduleNo="+scheduleNo);
	} else { 
		throw new Exception("2개이상의 행이 삭제!");
	}
	// view가 없다
%>