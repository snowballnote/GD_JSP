<!-- departmentList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "java.util.*" %>
<%
	// ---------------- Controller Layer ----------------
	
	// 한 페이지당 보여줄 게시글 수 설정
	final int ROW_PER_PAGE = 10;
	
	// 1) 요청 파라미터 받기
	String deptName = request.getParameter("deptName");
	
	// 현재 페이지 값 (없으면 기본값 1)
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 2) 페이지 시작 행 계산
	// 예: 1페이지면 0행부터, 2페이지면 10행부터 출력
	int startRow = ROW_PER_PAGE * (currentPage - 1);

	// 3) DAO를 이용해 데이터 조회
	DepartmentDao departmentDao = new DepartmentDao();

	List<DepartmentDto> departmentList =
        departmentDao.selectDepartmentListByPage(deptName, startRow, ROW_PER_PAGE);
    System.out.println("departmentList.jsp#departmentList: " + departmentList);

	// 전체 페이지 수 계산 (DAO에서 totalCount 기반으로 계산)
	int lastPage = departmentDao.getLastPage(deptName, ROW_PER_PAGE);
	System.out.println("departmentList.jsp#lastPage: " + lastPage);
	
	String[] deptNameList = {
	        "Marketing", "Finance", "Human Resources", "Production",
	        "Development", "Quality Management", "Sales", "Research", "Customer Service"
	};
%>
<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>departmentList.jsp</title>
</head>
<body>
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	<h1>departmentList</h1>
	
	<!-- 부서 필터 네비게이션 -->
	<div>
		<%
			for(String dn : deptNameList){
		%>
				<a href="<%=request.getContextPath()%>/department/departmentList.jsp?deptName=<%=dn%>">[<%=dn%>]</a>
		<%
			}
		%>
	</div>
	<hr>
	<!-- 글 작성 페이지로 이동하는 링크 -->
	<div>
		<a href="<%=request.getContextPath()%>/department/addDepartmentForm.jsp">부서추가</a>
	</div>
	
	<!-- 현재 페이지 표시 -->
	<div>
		현재 페이지: <%=currentPage%> / <%=lastPage%>
	</div>
	
	<!-- 게시글 목록 테이블 -->
	<table border="1">
		<tr>
			<th>dept_no</th>
			<th>dept_name</th>
			<th>[modify][remove]</th>
		</tr>
		<%
			// boardList에 담긴 게시글을 순서대로 출력
			for(DepartmentDto d : departmentList) {
		%>
				<tr>
					<td><%=d.getDeptNo()%></td>
					<td><%=d.getDeptName()%></td>
					<td>
						<a href="<%=request.getContextPath()%>/department/modifyDepartmentForm.jsp?deptNo=<%=d.getDeptNo()%>">[수정]</a>
						<a href="<%=request.getContextPath()%>/department/removeDepartment.jsp?deptNo=<%=d.getDeptNo()%>">[삭제]</a>	
					</td>
				</tr>
		<%
			}
		%>
	</table>
	
	<!-- 페이징 네비게이션 -->
	<div>
		<!-- 이전 페이지 버튼 -->
		<%
			if(currentPage > 1) {
				if(deptName == null) {
		%>
					<a href="<%=request.getContextPath()%>/department/departmentList.jsp?currentPage=<%=currentPage-1%>">[이전]</a>
		<%
				} else {
		%>
					<a href="<%=request.getContextPath()%>/department/departmentList.jsp?currentPage=<%=currentPage-1%>&deptName=<%=deptName%>">[이전]</a>
		<%
				}
			}
		%>
		
		<!-- 다음 페이지 버튼 -->
		<%
			if(currentPage < lastPage) {
				if(deptName == null) {
		%>
					<a href="<%=request.getContextPath()%>/department/departmentList.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
		<%
				} else {
		%>
					<a href="<%=request.getContextPath()%>/department/departmentList.jsp?currentPage=<%=currentPage+1%>&deptName=<%=deptName%>">[다음]</a>
		<%
				}
			}
		%>
	</div>
</body>
</html>