<!-- updateScheduleForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "dto.*" %>

<%
	String scheduleNo = request.getParameter("scheduleNo");
	System.out.println("scheduleNo: "+scheduleNo);
	if(scheduleNo == null) {
		response.sendRedirect(request.getContextPath()+"/schedule.jsp");
		return;
	}
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	String sql = "select schedule_no, schedule_date, schedule_title, schedule_content from schedule where schedule_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, Integer.parseInt(scheduleNo));
	System.out.println("stmt: "+stmt.toString());
	ResultSet rs = stmt.executeQuery();
	// rs -> dto 타입변환
	ScheduleDto schedule = new ScheduleDto();
	if(rs.next()) {
		schedule.setScheduleNo(rs.getInt("schedule_no"));
		schedule.setScheduleDate(rs.getString("schedule_date"));
		schedule.setScheduleTitle(rs.getString("schedule_title"));
		schedule.setScheduleContent(rs.getString("schedule_content"));
	}
	System.out.println(schedule.toString());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/menu.jsp"></jsp:include>
	
	<h1>UPDATE SCHEDULE</h1>
	
	<form action="<%=request.getContextPath()%>/updateScheduleAction.jsp" method="post">
		<table border="1">
			<tr>
				<th>schedule_no</th>
				<td>
					<input type="text" name="scheduleNo" value="<%=schedule.getScheduleNo()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>schedule_date</th>
				<td>
					<input type="date" name="scheduleDate" value="<%=schedule.getScheduleDate()%>"></td>
				</td>
			</tr>
			<tr>
				<th>schedule_title</th>
				<td>
					<input type="text" name="scheduleTitle" value="<%=schedule.getScheduleTitle()%>">
				</td>
			</tr>
			<tr>
				<th>schedule_content</th>
				<td><textarea name="scheduleContent" rows="5" cols="50"><%=schedule.getScheduleContent()%></textarea></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>