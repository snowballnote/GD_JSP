<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//Controller Layer
	String diaryDate = request.getParameter("diaryDate");
	String diaryTitle = request.getParameter("diaryTitle");
	String diaryContent = request.getParameter("diaryContent");
	
	//Model Layer
	//DB
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	String sql = "insert into diary(diary_date, diary_title, diary_content) values(?, ?, ?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, diaryDate);
	stmt.setString(2, diaryTitle);
	stmt.setString(3, diaryContent);
	int row = stmt.executeUpdate();
	//redirect 
	//diaryDate: yyyy-mm-yy
	String y = diaryDate.substring(0, 4);
	String m = diaryDate.substring(5, 7);
	String d = diaryDate.substring(8);
	response.sendRedirect(request.getContextPath() + "/diaryDateList.jsp?y=" + y + "&m=" + m + "&d=" + d);
	//이날짜의 리스트
	//diaryDateList로
%>