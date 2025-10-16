<!-- loginAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.StaffDao" %>
<%@ page import="dto.Staff" %>

<%
    // 폼에서 전달받은 값 가져오기
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Staff 객체 생성
    Staff paramStaff = new Staff();
    paramStaff.setUsername(username);
    paramStaff.setPassword(password);

    // DAO 호출
    StaffDao staffDao = new StaffDao();
    Staff loginStaff = staffDao.login(paramStaff);


    // 로그인 성공 여부 확인
    if (loginStaff == null) { // 로그인 실패시
    	response.sendRedirect(request.getContextPath() + "/home.jsp?error=fail");
        
    } else { // 로그인 성공 시
        session.setAttribute("loginStaff", loginStaff);
        response.sendRedirect(request.getContextPath() + "/film/filmList.jsp");     
    }
%>
