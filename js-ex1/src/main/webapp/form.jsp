<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="./action.jsp" id="testForm">
		<div>
			NO:
			<input type="text" name="no" id="no">
		</div>
		<div>
			NAME:
			<input type="text" name="name" id="name">
		</div>
		<button type="button" onclick="send()">입력</button>
	</form>
	
	<script>
		function send() {
			let no = document.getElementById('no').value;
			let name = document.getElementById('name').value;
			// 폼 유효성 검사에 사용되는 조건문
			if(isNaN(no) || no == ''){
				alert('no는 숫자를 입력하세요');
				return;
			}else if(name.length < 3){ // name == ''이 공백인지 검사
				alert('name은 3자이상 입력하세요');
				
			}else{
				let testForm = document.getElementById('testForm');
				testForm.submit();
			}
		}
	</script>
</body>
</html>