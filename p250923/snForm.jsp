<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>주민번호</h1>
	<form action="/p250923/snAction.jsp">
		<div>
			이름 : <input type="text" name="myName" value="">
		</div>
		<div>
			주민번호 : <input type="text" name="socialNum"  method="post">
		</div>
		<div>
			<button type="submit">전송</button>
		</div>
	</form>
</body>
</html>