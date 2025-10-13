<!-- removeDepartment.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="dto.*,dao.*" %>

<%
    // 파라미터 받기
    String deptNo = request.getParameter("deptNo");

    // 2값 검증 (비었을 때 목록으로 이동)
    if (deptNo == null || deptNo.trim().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/department/departmentList.jsp");
        return;
    }

    // DAO 실행
    DepartmentDao departmentDao = new DepartmentDao();
    DepartmentDto dto = new DepartmentDto();
    dto.setDeptNo(deptNo.trim());

    int row = departmentDao.deleteDepartment(dto);

    // 결과에 따라 페이지 이동 (조용히 처리)
    if (row == 1) {
        // 삭제 성공 → 목록으로 이동
        response.sendRedirect(request.getContextPath() + "/department/departmentList.jsp");
    } else {
        // 삭제 실패 → 목록으로 이동 (에러 메시지 없이)
        response.sendRedirect(request.getContextPath() + "/department/departmentList.jsp");
    }
%>
