<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%
	//1) sn요청값을 get
	//2) sn의 인덱스 0, 1번째를 자른다.
	//3) sn의 인덱스 6번째를 자른다.
	//4) 3번의 문자열을 숫자로 변경한다. => 짝수면 여자, 홀수면 남자. -> 성별출력.
	//5) 3번의 값에 따라 2번의 결과값 앞에 "19" or "20"을 합친 후 숫자로 변경한다.
	//6) 2, 3번째->월. 4,5번째->일 숫자로 변경한다.

	//7) Calendar클래스를 이용하여 오늘 날짜를 구한후 년, 월, 일 분리한다.
	//8) 7번의 년도에서 5번의 결과를 뺀다. 
	//9) 6번의 결과값들과 7번의 월,일 값을 비교하여 8번의 결과값에서 1or2를 뺀다.

%>
<%
	String myName = request.getParameter("myName");
	String socialNum = request.getParameter("socialNum");
	System.out.println(socialNum + "<---socialNum");
	String s1 = socialNum.substring(0,2); //생년
	String s2 = socialNum.substring(6,7); //성별
	int gender = Integer.parseInt(s2); //성별의 문자를 숫자로 변경
	int birthYear = Integer.parseInt(s1); //년도를 숫자로
	int birthMonth = Integer.parseInt(socialNum.substring(2,4)); //태어난 달
	int birthDay = Integer.parseInt(socialNum.substring(4,6)); //태어난 날(일)
	
	Calendar today = Calendar.getInstance();
	//today.get(Calendar.DAY_OF_MONTH);
	int year = today.get(Calendar.YEAR);
	int month = today.get(Calendar.MONTH) + 1;
	int day = today.get(Calendar.DATE);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>인적사항</h1>
	<table border="1">
		<tr>
			<th>이름</th>
			<td><%=myName %></td>			
		</tr>
		<tr>
			<th>성별</th>
			<td>
				<%
					if(gender % 2 == 0) {
						out.println("여");
					} else{
						out.println("남");
					}
				%>
			</td>			
		</tr>
		<tr>
			<th>생년</th>
			<td>
				<%
					int totalBirthYear;
					if(gender == 3 || gender == 4){
						totalBirthYear = 2000 + birthYear;
						out.println(totalBirthYear);		
					}else{
						totalBirthYear = 1900 + birthYear;
						out.println(totalBirthYear);			
					}
				%>
			</td>			
		</tr>
		<th>나이</th>
			<td>
				<%
					int age = year - totalBirthYear;
					if(month < birthMonth) { // 아직 생일 안 지남
				    	out.println(age - 1);
					} else if(month == birthMonth && day < birthDay) { // 생일 달이지만 생일이 아직 안 지남
				    	out.println(age - 1);
					} else { // 생일 지났거나 오늘이 생일
				    	out.println(age);
					}
				%>
			</td>			
		</tr>
		<th>오늘날짜</th>
			<td>
				<%=year %>년<%=month %>월<%=day %>일
			</td>			
		</tr>
	</table>
</body>
</html>