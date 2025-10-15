<!-- addDeptEmpAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "dto.*" %>
<%
	//addDeptEmpAction
	String empNoParam = request.getParameter("empNo");
	String deptNo = request.getParameter("deptNo"); //종료할(현재) 부서번호
	String fromDate = request.getParameter("fromDate"); //새 소속 시작일
	String toDate = request.getParameter("toDate"); // 현재 소속 종료일(=바꿀 to_date)
	int empNo = Integer.parseInt(empNoParam);
	
	DeptEmpDao deptEmpDao = new DeptEmpDao();
	
	// 1) 현재 레코드의 to_date를 사용자가 입력한 toDate로 종료 처리
	// 1) to_date를 변경 '9999-01-01' -> 입력받은 날짜 
	// DeptEmpDao.updateDeptEmp(DeptEmp); 구현해ㅐ야댐
	// update dept_emp set to_date=? where emp_no=? and dept_no=?
	DeptEmpDto closeDto = new DeptEmpDto();
	closeDto.setEmpNo(empNo);
	closeDto.setDeptNo(deptNo);
	closeDto.setToDate(toDate);
	int row1 = deptEmpDao.updateDeptEmp(closeDto);

	// 2) 새 소속 추가 (to_date는 항상 '9999-01-01')
	// 2) 1)의 결과가 if(row==1)...
	// DeptEmpDao.insertDeptEmp(DeptEmp); 이건있음
	// insert dept_emp(emp_no, dept_no, from_date, to_date) values(?, ?, ?, ?)
	//4번째 물음표 값은 '9999-01-01'로 넣으면됨.
	DeptEmpDto newDto = new DeptEmpDto();
	newDto.setEmpNo(empNo);
	newDto.setDeptNo(deptNo);
	newDto.setFromDate(fromDate);
	newDto.setToDate(toDate);
	int row2 = deptEmpDao.insertDeptEmp(newDto);
	
	if(row1 == 1 && row2 == 2){
		response.sendRedirect(request.getContextPath()+"/employee/employeeList.jsp");
	}else{
		response.sendRedirect(request.getContextPath()+"/department/addDeptEmpForm.jsp");
	}
			

%>
