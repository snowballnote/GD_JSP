<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>구구단</h1>
	<form action="/p250923/ex8Action.jsp">
		<select name="dan">
			<%
				for(int i = 2; i <= 9; i++){					
			%>
				<option value = "<%=i %>"><%=i %>단</option>
			<%			
				}
			%>
		</select>
		<button type="submit">전송</button>
	</form>
</body>
</html>