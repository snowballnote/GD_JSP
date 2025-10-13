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
			<!-- 번호 선택 -->
			<tr>
				<th>deptNo</th>
				<td>
					<!-- 텍스트 입력으로 변경 -->
					<input type="text" name="deptNo" maxlength="4">
				</td>
			</tr>
			<!-- 부서 선택 -->
			<tr>
			<th>deptName</th>
			<td>
				<select name="deptName">
					<%
						//선택 가능한 지역 목록 배열
						String[] deptNameList = {"Marketing", "Finance", "Human Resources", "Production", "Development", "Quality Management", "Sales", "Research", "Customer Service"};
						
						//현재 게시글의 지역과 동일한 값은 selected로 표시
						for(String s : deptNameList){
							if(s.equals(department)){
					%>
								<option value="<%=s %>" selected="selected"><%=s%></option>
					<%			
							}else{
					%>
								<option value="<%=s%>"><%=s %></option>
					<%			
							}
						}
					%>
				</select>
			</td>
		</tr>
		</table>
		<!-- 폼 전송 버튼 -->
		<button type="submit">입력</button>
	</form>
</body>
</html>