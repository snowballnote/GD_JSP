<!-- /exam/paper/addPaperAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//인가: 학생만
	Student loginStudent = (Student) session.getAttribute("loginStudent");
	String userRole = (String) session.getAttribute("userRole");
	if (loginStudent == null || !"student".equals(userRole)) {
	    response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	    return;
	}

	String categoryId = request.getParameter("categoryId");
	String[] questionId = request.getParameterValues("questionId");
	String[] paperAnswer = request.getParameterValues("paperAnswer");
	
	for(int i = 0; i < questionId.length; i++){
		System.out.println("문제ID: " + questionId[i] + " , 제출답안: " + paperAnswer[i]);
	}
	
	int scorePerQuestion = 100 / questionId.length; // 나머지 X
	int totalScore = 0;
	
	QuestionDao questionDao = new QuestionDao();
	// 1) paper 답안 입력 + 점수계산
	for(int i=0; i<questionId.length; i++){
		// paper 답안 입력
		Paper p = new Paper();
		// loginStudnet.getStudentId(), question[i], answer[i]
		// insert into paper() values(loginStudent.getStudentId(), question[i], answer[i])
		p.setStudentId(loginStudent.getStudentId());
		p.setQuestionId(Integer.parseInt(questionId[i]));
		p.setPaperAnswer(Integer.parseInt(paperAnswer[i]));
		
		
		PaperDao paperDao = new PaperDao();
		int row = paperDao.insertPaper(p);
		/*
			if(row != 1){ // 실패시
				// rollback 후
				throw new Exception();	
			}
		*/
		// DB에 저장된 정답
		int questionAnswer = questionDao.selectQuestionAnswer(Integer.parseInt(questionId[0]));
		// 학생이 입력한 답 answer[i]
		int studentAnswer = Integer.parseInt(paperAnswer[i]);
		if(questionAnswer == studentAnswer){
			totalScore = totalScore + scorePerQuestion;
		}
	}
	
	// 2) totalScore를 exam_result테이블에 입력
	ExamResult er = new ExamResult(); // categoryId, loginStudnet.getStudentId(), totalScore
	ExamResultDao examResultDao = new ExamResultDao();
	examResultDao.insertExamResult(er);
%>