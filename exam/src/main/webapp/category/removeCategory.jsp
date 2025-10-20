<!-- removeCategory.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "dao.*" %>
<%@ page import = "dto.*" %>
<%
	//유효성 검사
	if(request.getParameter("categoryId") == null || request.getParameter("categoryId").equals("")) {
		System.out.println("removeCategory.jsp ===> 빈칸 발생(잘못된 파라미터값 입력)");
		response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
		return;
	}

	// 시험날짜이전 & 등록된 시험 문제가 없을 때 & 응시자가 없을때
	String categoryId = request.getParameter("categoryId");
	Category c = new Category();
	c.setCategoryId(Integer.parseInt(categoryId));
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.deleteCategory(c);
	if(row == 1) {
		System.out.println("removeCategory.jsp ===> 카테고리 삭제 성공");
		response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
	} else {
		System.out.println("removeCategory.jsp ===> 카테고리 삭제 실패 row: " + row);
		response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
	}
%>