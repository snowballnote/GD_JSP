<!-- modifyDepartmentForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<%
    String deptNo = request.getParameter("deptNo");
    if (deptNo == null || deptNo.trim().isEmpty()) {
        response.sendRedirect(request.getContextPath()+"/department/departmentList.jsp");
        return;
    }

    DepartmentDao deptDao = new DepartmentDao();
    DepartmentDto dept = deptDao.selectDepartment(deptNo);
    if (dept == null) {
        response.sendRedirect(request.getContextPath()+"/department/departmentList.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify Department</title>
</head>
<body>
    <jsp:include page="/inc/menu.jsp"></jsp:include>
    <h1>modifyDepartment</h1>

    <form action="<%= request.getContextPath() %>/department/modifyDepartmentAction.jsp" method="post">
        <table>
            <tr>
                <th>deptNo</th>
                <td>
                    <input type="text" value="<%= dept.getDeptNo() %>" readonly>
                    <input type="hidden" name="deptNo" value="<%= dept.getDeptNo() %>">
                </td>
            </tr>
            <tr>
                <th>deptName</th>
                <td><input type="text" name="deptName" value="<%= dept.getDeptName() %>"></td>
            </tr>
        </table>
        <div>
            <button type="submit">수정</button>
        </div>
    </form>
</body>
</html>
