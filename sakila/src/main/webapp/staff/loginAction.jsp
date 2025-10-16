<!-- loginAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.StaffDao" %>
<%@ page import="dto.Staff" %> 
<%
	// 1) 로그인 폼에서 전달받은 데이터 가져오기
	// form의 input name과 동일해야 함 (username, password)
	String username = request.getParameter("username"); // 아이디 입력값
	String password = request.getParameter("password"); // 비밀번호 입력값
	
	// 2) DTO 객체(Staff)에 입력값 저장
	Staff paramStaff = new Staff();
	paramStaff.setUsername(username);
	paramStaff.setPassword(password);
	
	// 3) DAO 객체 생성 후 로그인 메서드 호출
	StaffDao staffDao = new StaffDao();
	Staff loginStaff = staffDao.login(paramStaff); // DB에서 로그인 검증 실행
	
	// 4) 로그인 결과 확인 및 처리
	if(loginStaff == null){ // 로그인 실패 시
		// home.jsp로 이동하면서 쿼리 피라미터로 에러 전달
		response.sendRedirect(request.getContextPath() + "/home.jsp");
	}else{ // 로그인 성공 시
		// 세션(session)에 로그인한 직원 정보를 저장
		session.setAttribute("loginStaff", loginStaff);
	
		// 로그인 성공 후 filmList.jsp로 이동
		response.sendRedirect(request.getContextPath() + "/film/filmList/jsp");
	}
%>
