<!-- /exam/question/addQuestionAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*,dao.*,java.util.*" %>
<%
    // (권장) 인가: 선생님만
    String userRole = (String)session.getAttribute("userRole");
    if (userRole == null || !"teacher".equals(userRole)) {
        response.sendError(403, "선생님만 등록할 수 있습니다.");
        return;
    }
    
 	// 로그인 교사 ID 가져오기
 	int teacherId = ((Teacher)session.getAttribute("loginTeacher")).getTeacherId();
 	
 	// 문제등록
 	String categoryId = request.getParameter("categoryId");
 	String questionNo = request.getParameter("questionNo");
 	String questionTitle = request.getParameter("questionTitle");
 	String questionAnswer = request.getParameter("questionAnswer");
	
    
 	// Question 객체 세팅
 	Question q = new Question();
 	q.setCategoryId(Integer.parseInt(categoryId));
 	q.setQuestionNo(Integer.parseInt(questionNo));
 	q.setQuestionTitle(questionTitle);
 	q.setQuestionAnswer(Integer.parseInt(questionAnswer));
 	q.setTeacherId(teacherId);
 	
 	QuestionDao questionDao = new QuestionDao();
 	Map<String, Integer> m = questionDao.insertQuestion(q);
 	
 	if(m.get("row") == 1) {
		int questionId = m.get("questionId");
		
		// 보기등록
	 	String[] itemTitles = request.getParameterValues("itemTitle");
		ItemDao itemDao = new ItemDao();
		int itemRow = 0;
		
		for(int i=0; i<itemTitles.length; i++) {
			Item item = new Item();
			item.setQuestionId(questionId);
			item.setItemTitle(itemTitles[i]);
			item.setItemIdx(i+1);
			itemRow = itemRow + itemDao.insertItem(item);
		}
		
		if(itemRow == 4) {
			response.sendRedirect(
				    request.getContextPath()+"/question/questionListByCategory.jsp?categoryId="+categoryId);
		} else {
			response.sendRedirect(request.getContextPath()+"/question/addQuestionForm.jsp?categoryId="+categoryId);
		}
	} else {
		response.sendRedirect(request.getContextPath()+"/question/addQuestionForm.jsp?categoryId="+categoryId);
	}
%>
