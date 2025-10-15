<!-- addEmployeeAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "dto.*" %>
<%
	//addEmployeeAction
	//사원번호 현재 데이터의 가장큰 emp_no + 1 값으로 설정
	//사원 추가 후 바로 부서를 지정
	// 부서 지정시 to_date값은 '9999-01-01'
	
	String birthDate = request.getParameter("birthDate");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String gender = request.getParameter("gender");
	String hireDate = request.getParameter("hireDate");
	
	String deptNo = request.getParameter("deptNo");
	
	EmployeeDao emplyeeDao = new EmployeeDao();
	int maxEmpNo = emplyeeDao.selectMaxEmpNo();
	int empNo = maxEmpNo + 1;
	
	// 1) employees insert - EmployeeDao.insertEmplooyee(Employee)
	EmployeeDto e = new EmployeeDto();
	e.setEmpNo(empNo);
	e.setBirthDate(birthDate);
	e.setFirstName(firstName);
	e.setLastName(lastName);
	e.setGender(gender.equals("M") ? Gender.M : Gender.F);
	e.setHireDate(hireDate);
	
	int row = emplyeeDao.insertEmployee(e); //입력성공시 2번가능
	int row2 = 0;
	
	if(row == 1){
		// 2) dept_emp insert - DeptEmpDao.innsertDeptEmp(DeptEmp)
		DeptEmpDto de = new DeptEmpDto();
		de.setEmpNo(empNo);
		de.setDeptNo(deptNo);
		de.setFromDate(e.getHireDate());
		de.setToDate("9999-01-01");
		DeptEmpDao deptEmpDao = new DeptEmpDao();
		row2 = deptEmpDao.insertDeptEmp(de);
	}
	if ( row2 == 0 ) {	
		System.out.println("등록 오류");
		response.sendRedirect(request.getContextPath() + "/employee/addEmployeeForm.jsp");	
	} else {	
		response.sendRedirect(request.getContextPath() + "/employee/employeeList.jsp");
	}

%>