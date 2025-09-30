<!-- scheduleOne.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dto.*" %>
<%
	String scheduleNo = request.getParameter("scheduleNo");

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");

	/*
		select *
		from schedule
		where schedule_no = ?
	*/
	String sql = "select schedule_no, schedule_date, schedule_title, schedule_content, createdate from schedule where schedule_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, Integer.parseInt(scheduleNo));
	ResultSet rs = stmt.executeQuery();
	ScheduleDto dto = null;
	if(rs.next()){
		dto = new ScheduleDto();
		dto.setScheduleNo(rs.getInt("schedule_no"));
		dto.setScheduleDate(rs.getString("schedule_date"));
		dto.setScheduleTitle(rs.getString("schedule_title"));
		dto.setScheduleContent(rs.getString("schedule_content"));
		dto.setCreatedate(rs.getString("createdate"));
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scheduleOne.jsp</title>
</head>
<body>
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/menu.jsp"></jsp:include>
	
	<h1>SCHEDULE ONE</h1>
	<table border="1">
		<tr>
			<th>schedule_no</th>
			<td><%=dto.getScheduleNo() %></td>
		</tr>
		<tr>
			<th>schedule_date</th>
			<td><%=dto.getScheduleDate() %></td>
		</tr>
		<tr>
			<th>schedule_title</th>
			<td><%=dto.getScheduleTitle() %></td>
		</tr>
		<tr>
			<th>schedule_content</th>
			<td><%=dto.getScheduleContent() %></td>
		</tr>
		<tr>
			<th>createdate</th>
			<td><%=dto.getCreatedate() %></td>
		</tr>
	</table>
	<!-- updateScheduleForm.jsp - updateSchduleAction.jsp -->
	<a href="<%=request.getContextPath() %>/updateScheduleForm.jsp?scheduleNo=<%=dto.getScheduleNo()%>">수정</a>
	<!-- deleteSchedule.jsp -->
	<a href="<%=request.getContextPath()  %>/deleteSchedule.jsp?scheduleNo=<%=dto.getScheduleNo()%>">삭제</a>
</body>
</html>