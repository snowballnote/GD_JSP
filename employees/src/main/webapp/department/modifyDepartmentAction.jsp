<!-- modifyDepartmentAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%
    String deptNo = request.getParameter("deptNo");
    String deptName = request.getParameter("deptName");

    if (deptNo == null || deptNo.trim().isEmpty() || deptName == null || deptName.trim().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/department/modifyDepartmentForm.jsp?deptNo=" + (deptNo==null?"":deptNo));
        return;
    }

    deptNo = deptNo.trim();
    deptName = deptName.trim();

    DepartmentDao deptDao = new DepartmentDao();
    DepartmentDto current = deptDao.selectDepartment(deptNo);
    if (current == null) {
        response.sendRedirect(request.getContextPath()+"/department/departmentList.jsp");
        return;
    }

    // 현재 값과 동일하면 변경 없이 폼으로 복귀
    if (deptName.equalsIgnoreCase(current.getDeptName()==null?"":current.getDeptName().trim())) {
        response.sendRedirect(request.getContextPath() + "/department/modifyDepartmentForm.jsp?deptNo=" + deptNo);
        return;
    }

    // 다른 행이 이미 같은 이름을 쓰는지 사전 확인 (UNIQUE 충돌 예방)
    Connection conn = DBConnection.getConnection();
    String sql = "SELECT 1 FROM departments WHERE dept_name = ? AND dept_no <> ? LIMIT 1";
    PreparedStatement chk = conn.prepareStatement(sql);
    chk.setString(1, deptName);
    chk.setString(2, deptNo);
    ResultSet rs = chk.executeQuery();

    if (rs.next()) {
        // 중복 이름 → 변경하지 않고 폼으로 되돌림
        rs.close(); chk.close(); conn.close();
        response.sendRedirect(request.getContextPath() + "/department/modifyDepartmentForm.jsp?deptNo=" + deptNo);
        return;
    }

    rs.close();
    chk.close();
    conn.close();

    // 실제 업데이트
    DepartmentDto dept = new DepartmentDto();
    dept.setDeptNo(deptNo);
    dept.setDeptName(deptName);

    int row = deptDao.updateDepartment(dept);

    if (row == 1) {
        response.sendRedirect(request.getContextPath() + "/department/departmentList.jsp");
    } else {
        response.sendRedirect(request.getContextPath() + "/department/modifyDepartmentForm.jsp?deptNo=" + deptNo);
    }
%>