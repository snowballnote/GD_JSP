<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- ex2.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	<form action="/p250924/ex2Action.jsp">
		<table border="1">
			<tr> <!-- 1행 -->
				<th>아이디</th>
				<td>
					<input type="text" name="id" value="test">
				</td>
			</tr>
			<tr>
				<th>
					<div>비밀번호</div>
					<div>비밀번호확인</div>
				</th>
				<td>
					<div><input type="password" name="pw1" value="1234"></div>
					<div><input type="password" name="pw2" value="1234"></div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="name" value="guest">
				</td>
			</tr>
			<tr>
				<th>생일</th>
				<td>
					<input type="date" name="birth" value="1996-03-06">
				</td>
			</tr>
			<tr>
				<th>기수</th> <!-- 95기 -->
				<td>
					<input type="number" name="num" value="95">
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="radio" name="gender" value="M">남
					<input type="radio" name="gender" value="F" checked="checked">여
				</td>
			</tr>
			<tr>
				<th>취미</th>
				<td>
					<input type="checkbox" name="hobby" value="여행" checked="checked">여행
					<input type="checkbox" name="hobby" value="게임" checked="checked">게임
					<input type="checkbox" name="hobby" value="등산">등산
				</td>
			</tr>
			<tr>
				<th>메일</th>
				<td>
					<input type="text" name="mail1" value="guest">@
					<select name="mail2">
						<option value="">선택</option><!-- 빈칸이 넘어오면 선택을 안했다고 생각하면됨. -->
						<option value="@naver.com" selected="selected">네이버</option>
						<option value="@gmail.com">구글</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>메모</th>
				<td>
					<textarea name="memo" rows="5" cols="60">안녕하쇼</textarea>
				</td>
			</tr>
		</table>
			<tr>
				<!-- 2열짜리 컬럼 -->
				<td colspan = "2">
					<button type="submit">회원가입</button>
				</td>
			</tr>
	</form>
</body>
</html>