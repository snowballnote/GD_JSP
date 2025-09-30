<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "dto.*" %>

<%
	String diaryNo = request.getParameter("diaryNo");
	System.out.println("diaryNo: "+diaryNo);
	if(diaryNo == null) {
		response.sendRedirect(request.getContextPath()+"/diary.jsp");
		return;
	}
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	String sql = "select diary_no, diary_date, diary_title, diary_content from diary where diary_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, Integer.parseInt(diaryNo));
	System.out.println("stmt: "+stmt.toString());
	ResultSet rs = stmt.executeQuery();
	// rs -> dto 타입변환
	DiaryDto diary = new DiaryDto();
	if(rs.next()) {
		diary.setDiaryNo(rs.getInt("diary_no"));
		diary.setDiaryDate(rs.getString("diary_date"));
		diary.setDiaryTitle(rs.getString("diary_title"));
		diary.setDiaryContent(rs.getString("diary_content"));
	}
	System.out.println(diary.toString());
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
	
	<h1>UPDATE DIARY</h1>
	
	<form action="<%=request.getContextPath()%>/updateDiaryAction.jsp" method="post">
		<table border="1">
			<tr>
				<th>diary_no</th>
				<td>
					<input type="text" name="diaryNo" value="<%=diary.getDiaryNo()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>diary_date</th>
				<td>
					<input type="date" name="diaryDate" value="<%=diary.getDiaryDate()%>"></td>
				</td>
			</tr>
			<tr>
				<th>diary_title</th>
				<td>
					<input type="text" name="diaryTitle" value="<%=diary.getDiaryTitle()%>">
				</td>
			</tr>
			<tr>
				<th>diary_content</th>
				<td><textarea name="diaryContent" rows="5" cols="50"><%=diary.getDiaryContent()%></textarea></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>