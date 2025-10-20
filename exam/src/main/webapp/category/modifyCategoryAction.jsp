<!-- modifyCategoryAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<%
    String categoryIdParam = request.getParameter("categoryId");
    String examDate = request.getParameter("examDate");
    
    if (examDate == null || examDate.trim().isEmpty()) {
    	response.sendRedirect(request.getContextPath() + "/category/addCategoryForm.jsp");
    	return;
    }

    int categoryId = Integer.parseInt(categoryIdParam);

    Category c = new Category();
    c.setCategoryId(categoryId);
    c.setExamDate(examDate);

    CategoryDao categoryDao = new CategoryDao();
    int row = categoryDao.updateCategory(c);

    if (row == 1) {
        // 수정 성공 시 → 목록으로 이동
        System.out.println("categoryId " + categoryId + " 수정 완료");
        response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp?");
        return;
    } else {
        // 수정 실패 시 → 목록으로 이동 (응시자 존재 등)
        System.out.println("categoryId " + categoryId + " 수정 실패 (응시자 존재 또는 조건 불만족)");
        response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp?");
        return;
    }
%>