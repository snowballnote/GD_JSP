<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
	body {
		font-family: 'Noto Sans KR', sans-serif;
		background-color: #f5f6fa;
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
		margin: 0;
	}
	.login-box {
		background: #fff;
		padding: 40px 50px;
		border-radius: 10px;
		box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
		text-align: center;
		width: 360px;
	}
	h1 {
		margin-bottom: 30px;
		color: #333;
	}
	table {
		margin: 0 auto;
		border-collapse: collapse;
	}
	td {
		padding: 10px;
	}
	input[type="text"],
	input[type="password"] {
		width: 200px;
		padding: 8px;
		border: 1px solid #ccc;
		border-radius: 5px;
	}
	button {
		margin-top: 20px;
		background-color: #4a90e2;
		color: white;
		border: none;
		padding: 10px 20px;
		border-radius: 5px;
		cursor: pointer;
		font-size: 15px;
	}
	button:hover {
		background-color: #357ABD;
	}
	.sub-text {
		margin-top: 15px;
		font-size: 13px;
		color: #777;
	}
</style>
</head>
<body>
	<div class="login-box">
		<h1>로그인</h1>
		<form method="post" action="<%=request.getContextPath() %>/login">
			<table>
				<tr>
					<td>ID</td>
					<td><input type="text" name="id" placeholder="아이디 입력" required></td>
				</tr>
				<tr>
					<td>PW</td>
					<td><input type="password" name="pw" placeholder="비밀번호 입력" required></td>
				</tr>
			</table>
			<button type="submit">로그인</button>
		</form>
		<div class="sub-text">
			<a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a>
		</div>
	</div>
</body>
</html>
