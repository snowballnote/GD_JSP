<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String dan = request.getParameter("dan");
	System.out.println(dan + "<---dan");
	
	//dan문자열 숫자로 변경
	int numDan = Integer.parseInt(dan); //dan안에있는 문자를 숫자로 변경
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		for(int i = 1; i < 10; i++){
	%>
			<div><%=numDan %> * <%=i %> = <%=numDan*i %></div>
	<%		
		}
	%>
</body>
</html>