<!-- modifyDepartmentForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>   <!-- SQL 관련 클래스 사용 -->
<%@ page import = "dao.*" %>        <!-- Dao 클래스 사용 -->
<%@ page import = "dto.*" %>        <!-- Dto 클래스 사용 -->
<%@ page import = "java.util.*" %>  <!-- ArrayList 등 유틸 클래스 사용 -->
<%
	//============ [Controller Layer] ============
	//1. 전달받은 게시글 번호(boardNo) 피미터를 정수로 변환
	String deptNo = request.getParameter("deptNo");

	//2.BoardNo 객체 생성 -> 해당 게시글 정보 조회
	DepartmentDao departmentDao = new DepartmentDao();
	DepartmentDto departmentDto = departmentDao.selectDepartment(String.valueOf(deptNo)); //게시글 상세 데이터 반환

	//선택 가능한 지역 목록 배열
	String[] deptNameList = {"Marketing", "Finance", "Human Resources", "Production", "Development", "Quality Management", "Sales", "Research", "Customer Service"};
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyDepartmentForm</title>
</head>
<body>
	<!-- 상단 메뉴 (공통UI) 포함 -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	
	<h1>MODIFY DEPARTMENT</h1>
	
	<!-- ============ [수정 폼 영역] ============ -->
	<!-- 수정 후 modifyDepartmentAction.jsp로 데이터 전송 (POST방식) -->
	<form action="<%=request.getContextPath() %>/department/modifyDepartmentAction.jsp" method="post">
	<table border="1">
	
	<!-- 수정할 수 있는 항목: 부서 이름 -->
	
		<!-- 게시글 번호 (읽기 전용) -->
		<tr>
			<th>dept_no</th>
			<td>
				<input type="text" name="deptNo" value="<%=departmentDto.getDeptNo()%>" readonly="readonly">
			</td>
		</tr>
		
		<!-- 부서(select 박스에서 현재 부서 선택 상태 유지 -->
		<tr>
			<th>dept_name</th>
			<td>
				<select name="deptName">
					<%						
						//현재 게시글의 지역과 동일한 값은 selected로 표시
						for(String s : deptNameList){
							if(s.equals(departmentDto.getDeptName())){
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
	
	<!-- 수정 버튼 -->
	<button type="submit">수정하기</button>
	</form>
</body>
</html>