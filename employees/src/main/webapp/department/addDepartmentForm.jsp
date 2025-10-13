<!-- addDepartmentForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String department = request.getParameter("deptName"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addDepartmentForm</title>
</head>
<body>
	<!-- 공통 메뉴 영역 불러오기 -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	
	<h1>addDepartmentForm</h1>
	<!-- 게시글 입력 폼 -->
	<!-- 글 작성 후 addDepartmentAction.jsp로 데이터 전송 -->
	<form action="<%=request.getContextPath()%>/department/addDepartmentAction.jsp" method="post">
		<table border="1">
			<!-- 번호 입력 -->
			<tr>
				<th>deptNo</th>
				<td>
					<input type="text" name="deptNo" placeholder="예: d001">
				</td>
			</tr>
			<!-- 부서명 직접 입력 -->
			<tr>
			<th>deptName</th>
			<td>
				<input type="text" name="deptName" value="<%= (department != null ? department : "") %>" placeholder="예: Marketing">
			</td>
		</tr>
		</table>
		<!-- 폼 전송 버튼 -->
		<button type="submit">입력</button>
	</form>
</body>
</html>