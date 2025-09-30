<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "dto.*" %>
<%
	String diaryNo = request.getParameter("diaryNo");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	/*
		select *
		from diary
		where diary_no = ?
	*/
	String sql = "select diary_no,diary_date, diary_title,diary_content, createdate from diary where diary_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, Integer.parseInt(diaryNo));
	ResultSet rs = stmt.executeQuery();
	DiaryDto dto = null;
	if(rs.next()) {
		dto = new DiaryDto();
		dto.setDiaryNo(rs.getInt("diary_no"));
		dto.setDiaryDate(rs.getString("diary_date"));
		dto.setDiaryTitle(rs.getString("diary_title"));
		dto.setDiaryContent(rs.getString("diary_content"));
		dto.setCreatedate(rs.getString("createdate"));
	}
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
	
	<h1>DIARY ONE</h1>
	<table border="1">
		<tr>
			<th>diary_no</th>
			<td><%=dto.getDiaryNo()%></td>
		</tr>
		<tr>
			<th>diary_date</th>
			<td><%=dto.getDiaryDate()%></td>
		</tr>
		<tr>
			<th>diary_title</th>
			<td><%=dto.getDiaryTitle()%></td>
		</tr>
		<tr>
			<th>diary_content</th>
			<td><%=dto.getDiaryContent()%></td>
		</tr>
		<tr>
			<th>createdate</th>
			<td><%=dto.getCreatedate()%></td>
		</tr>
	</table>
	<!-- updateDiaryForm.jsp - updateDiaryAction.jsp -->
	<a href="<%=request.getContextPath() %>/updateDiaryForm.jsp?diaryNo=<%=dto.getDiaryNo()%>">수정</a>
	<!-- deleteDiary.jsp -->
	<a href="<%=request.getContextPath()  %>/deleteDiary.jsp?diaryNo=<%=dto.getDiaryNo()%>">삭제</a>
</body>
</html>