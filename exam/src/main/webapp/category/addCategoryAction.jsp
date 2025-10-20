<!-- addCategoryAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<% 
	// addCategoryAction.jsp
	String examDate = request.getParameter("examDate");

	// (디버깅용)
	System.out.println("examDate ==> " + examDate);
	
	// 유효성 검사
	if(examDate == null || examDate.trim().equals("")){
		response.sendRedirect(request.getContextPath() + "/category/addCategoryForm.jsp");
		System.out.println("잘못된 파라미터 값");
		return;
	}
	
	CategoryDao categoryDao = new CategoryDao();
	int newId = categoryDao.selectMaxCategoryId() + 1; //서버에서 최종 계산
	
	Category c = new Category();
	c.setCategoryId(newId);
	c.setExamDate(examDate);
	
	int row = categoryDao.insertCategory(c);
	
	if(row == 1) { // insert 성공
		System.out.println("categoryId ==> " + newId + " 추가완료");
		response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp"); // 목록으로 이동
		return;
	}else { // insert 실패
		response.sendRedirect(request.getContextPath() + "/category/addCategoryForm.jsp"); // 폼으로 이동
	}
%>