<!-- modifyCategoryForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<%
    String categoryIdParam = request.getParameter("categoryId");

    if (categoryIdParam == null || categoryIdParam.trim().isEmpty() || !categoryIdParam.matches("\\d+")) {
        response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
        return;
    }

    int categoryId = Integer.parseInt(categoryIdParam);

    CategoryDao categoryDao = new CategoryDao();
    Category c = categoryDao.selectCategoryOne(categoryId); // 단일 조회

    if (c == null) {
        response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyCategoryForm.jsp</title>
</head>
<body>
    <h1>modifyCategory</h1>

    <!-- [7] 수정 폼 시작 -->
    <form method="post" action="<%=request.getContextPath()%>/category/modifyCategoryAction.jsp">
        <table border="1">
            <tr>
                <th>categoryId</th>
                <!-- categoryId는 PK로 수정 불가 -->
                <td><input type="text" name="categoryId" value="<%=c.getCategoryId()%>" readonly></td>
            </tr>
            <tr>
                <th>examDate</th>
                <!-- examDate만 수정 가능 -->
                <td><input type="date" name="examDate" value="<%=c.getExamDate()%>" required></td>
            </tr>
            <tr>
                <th>createdate</th>
                <!-- 생성일은 읽기 전용 -->
                <td><%=c.getCreatedate()%></td>
            </tr>
            <tr>
                <td>
                    <!-- 저장 버튼 -->
                    <button type="submit">저장</button>
                    <!-- 취소(목록으로 이동) -->
                    <a href="<%=request.getContextPath()%>/category/categoryList.jsp">취소</a>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>