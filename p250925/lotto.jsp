<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//Model Layer -> 로또 번호 생성
	int[] balls = new int[45]; //정적배열 
	// 1 ~ 45 숫자로 마킹
	for(int i = 0; i < balls.length; i++){
		balls[i] = i+1; //1 ~ 45
	}
	
	//섞기
	for(int i = 0; i < 100000; i++){
		int rn = (int)(Math.random() * balls.length);
		int temp = balls[0]; //기본값을 탬프에 넣고
		balls[0] = balls[rn]; //랜덤값을 기본값에 넣고
		balls[rn] = temp; //탬프값을 랜덤값에 넣음
	}

	for(int i = 0; i < balls.length; i++){
		System.out.print(balls[i] + " ");
	}
	System.out.println();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOTTO</title>
</head>
<body>
	<%
		String[] color = {"red", "orange", "yellow", "green", "blue", "pink"};
		for(int i = 0; i < 6; i++){
	%>
		<span style="background-color: <%=color[i]%>"><%=balls[i] %></span>
	<%		
		}
	%>
</body>
</html>