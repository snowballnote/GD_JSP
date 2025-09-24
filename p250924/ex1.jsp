<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="/a.jsp?name=abc&pw=1234">submit</a><!-- 앵커타입은 사이에 있는 글자를 눌러서 이동가능. 
	무조건 주소지에 넣어야함. 노출되는 get방식임-->
	
	<form actio="/a.jsp?name=abc" target="_blank">
	<!-- form태그는 넘겨질때 post사용하여 넘어가는 내용 숨길수있음. -->
  		<input type="hidden" name="name" value="abc">
  		<input type="hidden" name="pw" value="1234">
  		
  		First name:<br>
  		<!-- 라벨지워도 괜찮은이유: 라벨태그이용해서 우리가 확인하려고.-->
  		<input type="text" id="fname" name="fname" value="John"><br>
  		<label for="lname">Last name:</label><br>
  		<input type="text" id="lname" name="lname" value="Doe"><br><br>
 		<input type="submit" value="Submit"><!-- html4문법 -->
 		<button type = "submit">submit</button> <!-- html5문법 : 권장 -->
	</form>
</body>
</html>