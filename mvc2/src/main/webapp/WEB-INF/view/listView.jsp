<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	List<GuestBoard> list = (List<GuestBoard>)(request.getAttribute("list"));
	int currentPage = (Integer)(request.getAttribute("currentPage"));
	int lastPage = (Integer)(request.getAttribute("lastPage"));
%>
<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listView.jsp</title>
</head>
<body>
	<a href="<%=request.getContextPath() %>/addController">글입력</a>
	<table border="1">
		<tr>
			<th>no</th><th>title</th><th>WRITER</th><th>CREATEDATE</th>
		</tr>
		<%
			for(GuestBoard gb : list) {
		%>
				<tr>
					<td><%=gb.getNo()%></td>
					<td><%=gb.getTitle()%></td>
					<td><%=gb.getWriter() %>
					<td><%=gb.getCreatedate() %>
				</tr>
		<%		
			}
		%>
	</table>
	
	<% 
		if(currentPage > 1) {
	%>
			<a href="<%=request.getContextPath()%>/listView?currentPage=<%=currentPage-1%>">[이전]</a>
	<%		
		}
	%>
	
	[<%=currentPage%>]
	
	<%
		if(currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/listView?currentPage=<%=currentPage+1%>">[다음]</a>
	<%		
		}
	%>
	
</body>
</html>