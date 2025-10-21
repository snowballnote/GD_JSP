<!-- /exam/loginForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title></head>
<body>
	<h1>로그인</h1>
		<form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
	    	<table border="1">
	    		<tr>
	        		<th>구분</th>
	        		<td>
						<label><input type="radio" name="role" value="teacher" required> 선생님</label>
						<label><input type="radio" name="role" value="student"> 학생</label>
					</td>
	      		</tr>
	      		<tr>
			        <th>아이디</th>
			        <td><input type="number" name="id" required></td>
	      		</tr>
			    <tr>
			        <th>이름</th>
			        <td><input type="text" name="name" required></td>
			   </tr>
	    	</table>
	    	<button type="submit">로그인</button>
	  </form>
</body>
</html>