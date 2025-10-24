<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "mvc3.dto.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ex1.jsp</title>
</head>
<body>
	<h1>자바코드 X -> EL & JSTL</h1>
	
	<div>
		<h2>기존 표현식 방식</h2>
		기본연산 : <%=1+3 %>
		Request(Integer) 속성값 : <%=request.getAttribute("age") %><br>
		Session(String) 속성값 : <%=session.getAttribute("name") %><br>
		<%
			//(((Map<String, Object>)(request.getAttribute("myMap"))).get("mapName") 	
			Map<String, Object> myMap = (Map<String, Object>)request.getAttribute("myMap");
				
		%>
		Request(Map) 속성값 : <%=myMap.get("mapName") %><br>
		Request(Map) 속성값 : <%=myMap.get("mapAge") %><br>
		<%
			List<String> fruits = (List<String>)request.getAttribute("fruits");
		%>	
		Request(List) 속성값 : <%=fruits.get(0) %>, <%=fruits.get(1) %>, <%=fruits.get(2) %><br>
		Request(객체) 속성값 : <%=((Member)request.getAttribute("member")).getId() %>
								, <%=((Member)request.getAttribute("member")).getPw() %>
		
		파라미터 값 출력<br>
		p1 : <%=request.getParameter("p1") %>
		<%
			String[] p2 = request.getParameterValues("p2");
		%>						
		p2 : <%=p2[0] %>, <%=p2[1] %>
	</div>
	<div>
		<h2>EL 방식(import문 필요x)</h2>
		기본연산 : ${1+3 }<br>
		Request(Integer) 속성값 : ${requestScope.age } / ${age }<br><!-- scope생략가능 -->
		Session(String) 속성값 : ${sessionScope.name } / ${name }<br>
		Request(Map) 속성값 : ${myMap.mapName } / ${myMap["mapName"] } <!-- import문 필요X, ., []참조연산자를 이용하여 get()호출 --><br>
		Request(Map) 속성값 : ${myMap.mapAge } / ${myMap["mapAge"] }<br>
		Request(List) 속성값 : ${fruits[0] }, ${fruits[1] }, ${fruits[2] }<br>
		Request(객체) 속성값 : ${member.id }, ${member.pw } <!-- EL은 무조건 setter, getter을 호출 : 표준 getter가 존재하지 않으면 error! --><br>
		파라미터 값 출력<br>
		p1 : ${param.p1 }<br>
		p2 : ${paramValues.p2[0] }, ${paramValues.p2[1] }<br>
	</div>
</body>
</html>