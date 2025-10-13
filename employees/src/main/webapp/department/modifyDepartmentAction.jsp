<!-- modifyDepartmentAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	//============ [Controller Layer] ============
	//인코딩
	request.setCharacterEncoding("UTF-8");

	// 전달받은 피라미터(게시들 수정 폼에서 보낸 데이터) 가져오기
	String deptNo = request.getParameter("deptNo");
	String deptName = request.getParameter("deptName"); //게시판 구분(카테고리)
	 if (deptName != null) deptName = deptName.trim();
	
	//원래 폼
	String formUrl = request.getContextPath()
                   + "/department/modifyDepartmentForm.jsp?deptNo="
                   + URLEncoder.encode(deptNo == null ? "" : deptNo, "UTF-8");
	
	// 기본 검증 (예외처리 없이 단순 분기)
	if (deptNo == null || deptNo.isBlank()) {
		response.sendRedirect(request.getContextPath()+"/department/departmentList.jsp?error=deptNo");
		return;
	}
	if (deptName == null || deptName.isEmpty()) {
		response.sendRedirect(formUrl + "&error=deptNameRequired");
		return;
	}
	    
	// 모델(값) 생성: DTO에 값 담기
	DepartmentDto paramDepartmentDto = new DepartmentDto();
	paramDepartmentDto.setDeptNo(deptNo); //문자열을 int로 변환 후 저장
	paramDepartmentDto.setDeptName(deptName);
	
	// DAO 호출: DB에서 게시글 수정 실행
	DepartmentDao departmentDao = new DepartmentDao();
	int row = departmentDao.updateDepartment(paramDepartmentDto); //수정된 행의개수를 반환받음
	
	// 수정 결과에 따라 페이지 이동
	if(row == 1){
		//수정 성공 -> 게시글 목록 페이지로 이동
		response.sendRedirect(request.getContextPath() + "/department/departmentList.jsp");
	}else{
		//수정 실패 -> 다시 작성 폼 페이지로 이동 + 에러 파라미터 전달
		response.sendRedirect(request.getContextPath() + "/department/modifyDepartmentForm.jsp?error=fail");
	}
	
%>