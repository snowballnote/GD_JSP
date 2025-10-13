<!-- addDepartmentAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="dao.*" %>
<%
	String deptNo = request.getParameter("deptNo");
	String deptName = request.getParameter("deptName");
	System.out.println(deptNo + " " + deptName);
	if(deptNo == "" || deptName == "") {
		response.sendRedirect(request.getContextPath() + "/department/addDepartmentForm.jsp");
		System.out.println("잘못된 파라미터값");
		return;
	}
	
	DepartmentDao deptDao = new DepartmentDao();
	Department dept = new Department();
	
	dept.setDeptNo(deptNo);
	dept.setDeptName(deptName);
	
	if(deptDao.insertDepartment(dept) == 1) {
		response.sendRedirect(request.getContextPath() + "/department/daepartmentList.jsp");
		System.out.println("부서번호 " + deptNo + " => 추가 완료");
	} else if (deptDao.insertDepartment(dept) == 3){
		response.sendRedirect(request.getContextPath() + "/department/addDepartmentForm.jsp");
		System.out.println("부서번호 " + deptNo + " => 이미 존재하는 부서번호입니다.");
	} else {
		response.sendRedirect(request.getContextPath() + "/department/addDepartmentForm.jsp");
		System.out.println("부서번호 " + deptNo + " => 추가 실패");
	}
%>
[출처] 1013 Department List (자바 교실) | 작성자 GDJ 95 김서희