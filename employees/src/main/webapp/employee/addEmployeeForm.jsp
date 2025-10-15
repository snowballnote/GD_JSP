<!-- addEmployeeForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "java.util.*" %>

<%
	DepartmentDao departmentDao = new DepartmentDao();
	List<DepartmentDto> deptList = departmentDao.selectDepartmentList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addEmployeeForm</title>
</head>
<body>
	<h1>addEmployeeForm</h1>
	<!-- 
		사원번호 현재 데이터의 가장 큰 emp_no + 1 값으로 설정
		사원추가 후 바로 부서를 지정
		부서 지정시 to_date값은 '9999-01-01'
	 -->
	 <form method="post" action="<%=request.getContextPath()%>/employee/addEmployeeAction.jsp">
	 	<table border="1">
	 		<tr>
	 			<th>birthDate</th>
	 			<td><input type="date" name="birthDate"></td>
	 		</tr>
	 		<tr>
	 			<th>firstName</th>
	 			<td><input type="text" name="firstName"></td>
	 		</tr>
	 		<tr>
	 			<th>lastName</th>
	 			<td><input type="text" name="lastName"></td>
	 		</tr>
	 		<tr>
	 			<th>gender</th>
	 			<td>
	 				<input type="radio" name="gender" value='M'>남
	 				<input type="radio" name="gender" value='F'>여
	 			</td>
	 		</tr>
	 		<tr>
	 			<th>hireDate</th>
	 			<td><input type="date" name="hireDate"></td>
	 		</tr>
	 		<tr>
	 			<th>deptEmp</th>
	 			<td>
	 				<select name="deptNo">
	 					<%
	 						for(DepartmentDto d : deptList){
	 					%>
	 							<option value="<%=d.getDeptNo() %>"><%=d.getDeptName() %></option>
	 					<%
	 						}
	 					%>
	 				</select>
	 			</td>
	 		</tr>
	 	</table>
	 	<button type="submit">입력</button>
	 </form>
</body>
</html>