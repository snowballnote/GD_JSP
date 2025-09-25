<!-- 지시자(Directive) -->
<%@ page language="java"%> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 
	선언문: 톰캣에 의해 자바 서블릿클래스 변경될때 메서드형태로 구현
	톰캣: ex1_jsp.java - ex1_jsp.class 
		new ex1_jsp().service(request, response);
-->
<%!
	public void test(){
		System.out.println("abc");
	}
%>

<!-- 스크립트릿 -->
<%
	for(int i = 0; i < 10; i++){
%>		
		<%=i %><%--표현식 --%>
<%
	}
%>

<!-- 표현식 -->
<%
	out.print(1); //out.write();
	out.print("abc");
	String s = "hello";
	out.print(s.subSequence(0,2));
	out.print(1+2);
	boolean f = true;
	out.print(f?"hi":"bye");
%>	
	<%=s.subSequence(0, 2) %>
	<%=2+3 %>

<%--JSP 주석 --%>
</body>
</html>