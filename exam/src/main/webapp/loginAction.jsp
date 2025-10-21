<!-- /exam/loginAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.TeacherDao,dao.StudentDao" %>
<%@ page import="dto.Teacher,dto.Student" %>
<%
	// 인가, 이미 로그인 되어있다면 바로 리다이렉트
	String userRole = (String) session.getAttribute("userRole");
  	if (userRole != null) {
    if ("teacher".equals(userRole)) {
    	response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
      	return;
    } else if ("student".equals(userRole)) {
      	response.sendRedirect(request.getContextPath() + "/student/studentCategoryList.jsp");
      	return;
    	}
  	}
  	
	String role = request.getParameter("role");
	String id = request.getParameter("id");
	String name = request.getParameter("name");

	if(role == null || id == null || name == null
			||role.isEmpty() ||id.isEmpty() ||name.isEmpty()){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	
	int loginId = Integer.parseInt(id);
	
	// 선생님 로그인
	if("teacher".equals(role)){
		Teacher paramT = new Teacher();
		paramT.setTeacherId(loginId);
		paramT.setTeacherName(name);

		TeacherDao teacherDao = new TeacherDao();
		Teacher t = teacherDao.teacherLogin(paramT);

		if(t == null){
			response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
			return;
		}else{
			session.setAttribute("loginTeacher", t);
			session.setAttribute("userRole", "teacher");
			response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
			return;
		}
	}else if("student".equals(role)){
		Student paramS = new Student();
		paramS.setStudentId(loginId);
		paramS.setStudentName(name);
		
		StudentDao studentDao = new StudentDao();
		Student s = studentDao.studentLogin(paramS);
		
		if(s == null){
			response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
			return;
		}else{
			session.setAttribute("loginStudent", s);
			session.setAttribute("userRole", "student");
			response.sendRedirect(request.getContextPath() + "/student/studentCategoryList.jsp");
			return;
		}		
	}
	
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
%>
