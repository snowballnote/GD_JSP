<!-- modifyCategoryForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<%
	// 유효성 검사
	String categoryIdParam = request.getParameter("categoryId");
	if (categoryIdParam == null || !categoryIdParam.matches("\\d+")) {
	  response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
	  return;
	}
	int categoryId = Integer.parseInt(categoryIdParam);
	
    CategoryDao categoryDao = new CategoryDao();
    Category c = categoryDao.selectCategoryList(startRow, rowPerPage);
    if (c == null) {
        response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyCategoryForm</title>
</head>
<body>
    <h1>modifyCategoryForm</h1>

    <form action="<%= request.getContextPath() %>/category/modifyCategoryAction.jsp" method="post">
        <table border="1">
            <tr>
                <th>categoryId</th>
                <td>
                    <input type="text" value="<%= c.getCategoryId() %>" readonly>
                 
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