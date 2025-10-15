<!-- addDepartmentAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String deptNo = request.getParameter("deptNo");
	String deptName = request.getParameter("deptName");
	
	// 콘솔에 입력값 출력 (디버깅용)
	System.out.println(deptNo + " " + deptName);
	
	// 유효성 검사
	// deptNo나 deptName이 비어있거나(null, 공백)한 경우
	if(deptNo == "" || deptName == "") {
		response.sendRedirect(request.getContextPath() + "/department/addDepartmentForm.jsp");
		System.out.println("잘못된 파라미터값");
		return;
	}
	
	// DAO 객체 생성 
	// 데이터베이스 처리 로직을 담당할 DAO와 DTO 객체 생성
	DepartmentDao deptDao = new DepartmentDao(); 
	DepartmentDto dept = new DepartmentDto();
		
	// DTO에 입력값 저장
	dept.setDeptNo(deptNo.trim());
	dept.setDeptName(deptName.trim());
	
	// DB에 insert 실행
	// insert 결과를 받아서 성공 여부 확인
	// (insertDepartment 메서드는 1=성공, 3=중복, 0=실패로 반환된다고 가정)
	int row = deptDao.insertDepartment(dept);  // insert는 한 번만 실행
	
	if(row == 1) {
		// insert 성공 시
		System.out.println("부서번호 " + deptNo + " => 추가 완료");
		response.sendRedirect(request.getContextPath() + "/department/departmentList.jsp"); // 목록 페이지로 이동
		return;
			
	} else if(row == 3) {
		// 부서번호가 이미 존재할 때 (중복키 오류)
		System.out.println("부서번호 " + deptNo + " => 이미 존재하는 부서번호입니다.");
		response.sendRedirect(request.getContextPath() + "/department/addDepartmentForm.jsp"); // 다시 입력 폼으로 이동
		return;
			
	} else {
		// 그 외 실패한 경우
		System.out.println("부서번호 " + deptNo + " => 추가 실패");
		response.sendRedirect(request.getContextPath() + "/department/addDepartmentForm.jsp"); // 다시 입력 폼으로 이동
		return;
	}
%>