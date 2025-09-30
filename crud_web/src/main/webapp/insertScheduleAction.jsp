<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//Controller Layer
	String scheduleDate = request.getParameter("scheduleDate");
	String scheduleTitle = request.getParameter("scheduleTitle");
	String scheduleContent = request.getParameter("scheduleContent");
	
	//Model Layer
	//DB
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	String sql = "insert into schedule(schedule_date, schedule_title, schedule_content) values(?, ?, ?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, scheduleDate);
	stmt.setString(2, scheduleTitle);
	stmt.setString(3, scheduleContent);
	int row = stmt.executeUpdate();
	//redirect
	
	//scheduleDate: yyyy-mm-dd
	String y = scheduleDate.substring(0, 4);
	String m = scheduleDate.substring(5, 7);
	String d = scheduleDate.substring(8);
	response.sendRedirect(request.getContextPath() + "/scheduleDateList.jsp?y=" + y + "&m=" + m + "&d=" + d);
	//이날짜의 리스트
	//diaryDateList로
%>