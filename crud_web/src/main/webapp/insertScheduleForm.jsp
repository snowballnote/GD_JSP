<!-- insertScheduleForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String y = request.getParameter("y");
	String m = request.getParameter("m");
	String d = request.getParameter("d");
	
	m = Integer.parseInt(m) > 9 ? m : "0" + m;
	d = Integer.parseInt(d) > 9 ? d : "0" + d;
	String scheduleDate = y + "-" + m + "-" + d;
	System.out.println("scheduleDate" + scheduleDate);	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertScheduleForm.jsp</title>
</head>
<body>
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/menu.jsp"></jsp:include>
	
	<h1>INSERT SCHEDULE</h1>
	<form method="post" action="<%=request.getContextPath() %>/insertScheduleAction.jsp">
		<table border="1">
			<tr>
				<th>SCHEDULE DATE</th>
				<td><input type="date" name="scheduleDate" value="<%=scheduleDate %>" readonly ="readonly"></td>
			</tr>
			<tr>
				<th>SCHEDULE TITLE</th>
				<td><input type="text" name="scheduleTitle"></td>
			</tr>
			<tr>
				<th>SCHEDULE CONTENT</th>
				<td><textarea rows="3" cols="50" name="scheduleContent"></textarea></td>
			</tr>
		</table>
		<button type="submit">스케줄 추가</button>
	</form>
</body>
</html>