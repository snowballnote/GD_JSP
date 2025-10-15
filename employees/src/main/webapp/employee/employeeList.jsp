<!-- employeeList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "java.util.*" %>
<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>employeeList.jsp</title>
</head>
<body>
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	<h1>employeeList</h1>
	<%
		// ---------------- Controller Layer ----------------
		// 한 페이지당 보여줄 게시글 수 설정
		int rowPerPage = 10;
	  	int startRow = 0;
	  	int currentPage = 1;
	  	int totalCnt = 0;
	  	if(request.getParameter("currentPage") != null){
	  		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	  	}
		startRow = (currentPage-1) * rowPerPage;
		
		//쿼리에 필요한 매개값
		String searchName = request.getParameter("searchName");
		if(searchName == null){
			searchName = "";
		}
		
		String fromEmpNo = request.getParameter("fromEmpNo");
		if(fromEmpNo == null){
			fromEmpNo = "";
		}
		
		String toEmpNo = request.getParameter("toEmpNo");
		if(toEmpNo == null){
			toEmpNo = "";
		}
		
		//매개값에 따라 쿼리(메서드) 분기 -> 동적쿼리
		EmployeeDao employeeDao = new EmployeeDao();
		List<Map<String, Object>> list = null;
		if(searchName.equals("")){ //검색어가 없다
			// empNo 범위 없다
			System.out.println("if 1"); //1
			if(fromEmpNo.equals("") || toEmpNo.equals("")){
				list = employeeDao.selectEmployeeListByPage(startRow, rowPerPage);
			}else{ //empNo 범위 있다
				System.out.println("if 2"); //2
				list = employeeDao.selectEmployeeListByPageAndEmpNoRange(startRow, rowPerPage, Integer.parseInt(fromEmpNo), Integer.parseInt(toEmpNo));
			}
		}else{ //검색어가 있다
			//empNo 범위 없다
			if(fromEmpNo.equals("") || toEmpNo.equals("")){
				System.out.println("if 3"); //3
				list = employeeDao.selectEmployeeListByPageAndSearchName(startRow, rowPerPage, searchName);
			}else{ //empNo 범위 있다
				System.out.println("if 4"); //4
				list = employeeDao.selectEmployeeListByPageAndSearchNameAndEmpNoRange(startRow, rowPerPage, searchName, Integer.parseInt(fromEmpNo), Integer.parseInt(toEmpNo));
			}
		}
	%>
	<%
		//페이지
		int prevPage = (currentPage > 1) ? currentPage - 1 : 1;
	 	int nextPage = currentPage + 1;
	  	int lastPage = employeeDao.getLastPage(null, rowPerPage);
	  	if(list == null || list.size() < rowPerPage){
	  		lastPage = currentPage;
	  	}
	%>
	<form method="get" action="<%=request.getContextPath() %>/employee/employeeList.jsp">
		<div>이름 검색: <input type="text" name="searchName" value="<%=searchName %>"></div>
		<div>
			번호 범위: 
			<input type="number" name="fromEmpNo"> ~ <input type="number" name="toEmpNo">
		</div>
		<button type="submit">조회</button>
	</form>
	<!-- 직원 목록 테이블 -->
	<table border="1">
		<tr>
			<th>empNo</th>
			<th>birthDate</th>
			<th>name</th>
			<th>gender</th>
			<th>hireDate</th>
			<th>deptNo</th>
			<th>deptName</th>
			<th>부서이동</th> <!-- insert dept_emp -->
			<th>title</th>
			<th>직책변경</th><!-- insert titles -->
			<th>salary</th>
			<th>연봉변경</th><!-- insert salary -->

		</tr>
		<%
			for(Map e : list){
		%>
				<tr>
					<td><%=e.get("empNo")%></td>
					<td><%=e.get("birthDate") %></td>
					<td><%=e.get("name") %></td>
					<td><%=e.get("gender") %></td>
					<td><%=e.get("hireDate") %></td>
					<td><%=e.get("deptNo") %></td>
					<td><%=e.get("deptName") %></td>
					<td>
						<a href="<%=request.getContextPath()%>/deptEmp/addDeptEmpForm.jsp?empNo=<%=e.get("empNo")%>">
							부서이동
						</a>
					</td>
					<td><%=e.get("title") %></td>
					<td>
						<a href="<%=request.getContextPath()%>/title/addTitleForm.jsp?empNo=<%=e.get("empNo")%>">
							직책변경
						</a>
					</td>
					<td><%=e.get("salary") %></td>
					<td>
						<a href="<%=request.getContextPath()%>/salary/addSalaryForm.jsp?empNo=<%=e.get("empNo")%>">
							연봉변경
						</a>
					</td>
				</tr>
		<%
			}
		%>
	</table>
	<!-- 페이징 -->
	<div>
		<%
			if(currentPage > 1){
		%>
				<a href="<%=request.getContextPath() %>/employee/employeeList.jsp?currentPage=<%=prevPage%>&searchName=<%=searchName %>&fromEmpNo=<%=fromEmpNo %>&toEmpNo=<%=toEmpNo %>">[이전]</a>
		<%		
			}
		%>
		<%=currentPage %> / <%=lastPage %>
		<%
			if(lastPage > 0 && currentPage < lastPage){
		%>
				<a href="<%=request.getContextPath() %>/employee/employeeList.jsp?currentPage=<%=nextPage%>&searchName=<%=searchName %>&fromEmpNo=<%=fromEmpNo %>&toEmpNo=<%=toEmpNo %>">[다음]</a>
		<%		
			}
		%>		
	</div>
</body>
</html>