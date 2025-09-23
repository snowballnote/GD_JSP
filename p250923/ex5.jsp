<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%
	// 오늘 날짜
	Calendar today = Calendar.getInstance();
	//today.get(Calendar.DAY_OF_MONTH);
	int toDay = today.get(Calendar.DATE) + 1;
	System.out.println(toDay + " <---today");
	
	// 이번달 1일의 요일-> startBlank를 확인
	Calendar firstDay = Calendar.getInstance();
	//firstDay.set(Calendar.MONTH, 9); //디버깅용
	firstDay.set(Calendar.DATE, 1); //Calendar.DAY_OF_MONTH 도 가능.
	System.out.println(firstDay);
	int firstDayYo = firstDay.get(Calendar.DAY_OF_WEEK);
	System.out.println(firstDayYo + " <---firstDayYo"); //디버깅
	
	// 일요일 -> 1 -> startBlank 0
	// 월 -> 2 -> 1
	// startBlank = 1일의 Calendar.DAY_OF_WEEK - 1
	int startBlank = firstDayYo - 1;
	System.out.println(startBlank + " <---startBlank");
	
	// 이번달 마지막 날짜
	int lastDayNum = firstDay.getActualMaximum(Calendar.DAY_OF_MONTH);
	System.out.println(lastDayNum + " <---lastDayNum");
	Calendar lastDay = Calendar.getInstance();
	//lastDay.set(Calendar.MONTH, 9); //디버깅용
	lastDay.set(Calendar.DAY_OF_MONTH, lastDayNum);
	
	// 마지막 날 짜
	//endBlank = lastDay.DAY_OF_WEEK : 1-> 6, ..., 7-> 0
	//endBlank = 7 - 마지막 날짜의 요일값
	int endBlank = 7 - lastDay.get(Calendar.DAY_OF_WEEK);
	System.out.println(endBlank + " <---endBlank");
	
	//전체 TD의 갯수= startBlank + lastDayNum + endBlank //7로 나누어 떨어져야함.
	int totalTd = startBlank + lastDayNum + endBlank;
	System.out.println(totalTd + " <---totalTd");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=firstDay.get(Calendar.YEAR) %>년 <%=firstDay.get(Calendar.MONTH)+1 %>월</h1>
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
				for(int i = 1; i <= totalTd; i=i+1){
					int day = i - startBlank;
			%>
				<td>
					<!-- 1보다 작거나 lastDayNum보다 크다면 공백을 출력. -->
					<%
						if(day < 1 || day > lastDayNum){
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
							}else if(i == toDay){
					%>	
								<span style="color:#00FF00;">
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