<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto.*" %>
<%@ page import ="dao.*" %>
<%
	// 로그인한 사용자 ID 가져오기
	String boardWriter = (String) session.getAttribute("sessionMemberId");
	if(boardWriter == null) {
	    response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	    return;
	}

	// Controller Layer
	String boardDistric = request.getParameter("boardDistrict");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	//String boardWriter = request.getParameter("boardWriter");
	
	// 모델(값) : 입력성공실패
	// 반환값 int, 입력값 BoardDto
	BoardDto paramBoardDto = new BoardDto();
	paramBoardDto.setBoardDistrict(boardDistric);
	paramBoardDto.setBoardTitle(boardTitle);
	paramBoardDto.setBoardContent(boardContent);
	paramBoardDto.setBoardWriter(boardWriter);
	
	BoardDao boardDao = new BoardDao();
	int row = boardDao.insertBoard(paramBoardDto);
	
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
%>