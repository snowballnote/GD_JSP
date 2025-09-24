<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar" %>
<%
	String name = request.getParameter("name");
	String[] user = new String[10];
	String[] answer = {"3", "2", "3", "1", "1", "2", "1", "2", "4", "2"};
	String[] result = new String[10];
	int score = 0;
	for(int i = 0; i < 10; i++){
		user[i] = request.getParameter("q" + (i+1));
		
		if(user[i] == null){
			user[i] = "";
		}
		
		
		if(user[i].equals(answer[i])){
			result[i] = "O";
			score++;
		}else{
			result[i] = "X";
		}
	}
	
	Calendar today = Calendar.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=today.get(Calendar.YEAR) %>년<%=today.get(Calendar.MONTH)+1 %>월<%=today.get(Calendar.DATE)%>일 시험결과</h1>
	<table border="1">
		<tr>
			<td colspan = "2">
				<%=name %>
			</td>
			<td colspan = "2">
				<%=score * 10 %> /100
			</td>
		</tr>
		<%
			for(int i = 0; i < 10; i+=2){
		%>
			<tr>
				<td><%=i + 1 %></td>
				<td><%=result[i] %></td>
				<%
					if(i+1 < 10){
				%>
					<td><%=i + 2 %></td>
					<td><%=result[i+1] %></td>
				<%		
					}else{
				%>
					<td></td>
				<%
					}
				%>
		<%			
			}
		%>
		
	</table>
</body>
</html>