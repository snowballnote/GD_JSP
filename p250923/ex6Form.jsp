<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/p250923/ex6Action.jsp" method="post"><!-- get: myName=루피&myNum=010 이렇게 넘어감-->
	<!-- method="post": 넘어가는 내용이 안보임. 보안강화 -->
		<div>
			이름 : <input type="text" name="myName" value="">
		</div>
		<div>
			번호 : <input type="number" name="myNum">
		</div>
		<div>
			<button type="submit">전송</button> <!-- submit: 폼안에있는 값(name의 value값)을 ex6Form으로 보낸다. -->
		</div>
	</form>
</body>
</html>