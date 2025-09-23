<!-- ex3.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int totalTD = 42;
		int startBlank = 5; //앞에 공백.
		int lastDay = 31; //9월날짜
	%>
	<h1>
		8월
		<a  href="/p250923/ex2.jsp">다음</a><!-- 9월달력 -->
	</h1>
	<table border="1">
		<tr>
			<th><span style="color:#FF0000;">일</span></th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th><span style="color:#0000FF;">토</span></th>
		</tr>
		<tr>
			<%	
				//i: td의 위치값(1~)	
				//day: 출력하고자 하는 날짜
				for(int i = 1; i <= totalTD; i=i+1){
					int day = i - startBlank;
			%>
				<td>
					<!-- 1보다 작거나 lastDay보다 크다면 공백을 출력. -->
					<%
						if(day < 1 || day > lastDay){
					%>
						&nbsp; <!-- 공백 -->
					<%		
						}else{
							if(i % 7 == 1){
					%>
								<span style="color:#FF0000;">
								<%=day %>
					<%
							}else if(i % 7 == 0){
					%>
								<span style="color:#0000FF;">
								<%=day %>
					<%
							}else{
					%>
								<%=day %>
					<%	
							}
						}
					%>
				</td>
			<%
					if(i % 7 == 0){ //7칸으로 나누기
			%>
		</tr>
		<tr>
			<%			
					}
				}
			%>
		</tr>
	</table>
</body>
</html>