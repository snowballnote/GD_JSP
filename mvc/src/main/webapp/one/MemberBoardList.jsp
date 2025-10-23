<!-- /mvc/one/MemberBoardList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>
<%
	Member m = (Member)session.getAttribute("loginMember");
%>
<%
	final int rowPerPage = 10;
	int currentPage = 1;
	String cp = request.getParameter("currentPage");
	if (cp != null && !cp.trim().isEmpty()) {
	    boolean isNumber = true;
	    for (int i = 0; i < cp.length(); i++) {
	        if (!Character.isDigit(cp.charAt(i))) { isNumber = false; break; }
	    }
	    if (isNumber) {
	        currentPage = Integer.parseInt(cp);
	        if (currentPage < 1) currentPage = 1;
	    }
	}
	int startRow = (currentPage - 1) * rowPerPage;

	MemberBoardDao memberBoardDao = new MemberBoardDao();

	int totalCnt = memberBoardDao.selectMemberBoardTotalCount();
	int lastPage = totalCnt / rowPerPage;  // 몫
	if (totalCnt % rowPerPage != 0) {      // 나머지가 있으면 한 페이지 더
		lastPage = lastPage + 1;
	}
	if (lastPage == 0) lastPage = 1;
	if (currentPage > lastPage) currentPage = lastPage;

	List<MemberBoard> memberBoardList = memberBoardDao.selectMemberBoardList(startRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberBoardList.jsp</title>
</head>
<body>
	<h1>MemberBoardList</h1>
	<table border="1">
		<tr>
			<th>NO</th>
			<th>TITLE</th>
			<th>CONTENT</th>
			<th>ID</th>
			<th>CREATEDATE</th>
		</tr>
		<%
			for(MemberBoard mb : memberBoardList){
		%>
				<tr>
					<td><!-- 여기부터 --></td>
				</tr>
		<%		
			}
		%>
	</table>
</body>
</html>