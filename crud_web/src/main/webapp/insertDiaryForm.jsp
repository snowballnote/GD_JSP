<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String y = request.getParameter("y");
	String m = request.getParameter("m");
	String d = request.getParameter("d");
	// 2025-9-1 -> 2025-09-01
	m = Integer.parseInt(m)>9 ? m : "0"+m;
	d = Integer.parseInt(d)>9 ? d : "0"+d;
	String diaryDate = y+"-"+m+"-"+d;
	System.out.println("diaryDate:" + diaryDate); 
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
	
	<h1>INSERT DIARY</h1>
	<form method="post" action="<%=request.getContextPath()%>/insertDiaryAction.jsp">
		<table border="1">
			<tr>
				<th>DIARY DATE</th>
				<td><input type="date" name="diaryDate" value="<%=diaryDate%>" readonly="readonly"></td>
			</tr>
			<tr>
				<th>DIARY TITLE</th>
				<td><input type="text" name="diaryTitle"></td>
			</tr>
			<tr>
				<th>DIARY CONTENT</th>
				<td><textarea rows="3" cols="50" name="diaryContent"></textarea></td>
			</tr>
		</table>
		<button type="submit">다이어리 추가</button>
	</form>
</body>
</html>