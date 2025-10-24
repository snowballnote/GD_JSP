<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ex2.jsp</title>
</head>
<body>
	<h1>EL 연산</h1>
	<h2>사칙연산</h2>
	+ : ${x + y}<br>
	- : ${x - y}<br>
	* : ${x * y}<br>
	/ : ${x / y}<br>
	% : ${x % y}<br>
	() : ${(x + y) * 2}<br>
	<hr>
	<h2>비교연산</h2>
	&lt; : ${x < y}<br>
	&gt; : ${x > y}<br>
	! : ${x==10}<br>
	!= : ${x!=10}<br>
	<hr>
	<h2>논리연산자</h2>
	&&(and) : ${x>0 && y>0}<br>
	||(or) : ${x<0 || y<0}<br>
	<hr>
	<h2>삼항연산자(조건연산자)</h2>
	${x<y ? "빨강" : "파랑"}
	<hr>
	<h2>null 연산자</h2>
	n1 : ${n1}<br><!-- null : 공백처리 -->
	n2 : ${n2}<br><!-- "" : 공백처리 -->
	n3 : ${n3}<br><!-- 존재하지 않음 : 공백처리 -->
	n1==null : ${n1==null}<br>
	n2==null : ${n2==null}<br><!-- false -->
	n3==null : ${n3==null}<br>
	
	empty n1 : ${empty n1}<br><!-- empty == "" || null -->
	empty n2 : ${empty n2}<br>
	empty n3 : ${empty n3}<br>
	empty Zero : ${empty 0}<br>
</body>
</html>