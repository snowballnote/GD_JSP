<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto.*" %>
<%@ page import ="dao.*" %>
<% 
	//Controller 삭제할 게시글 번호
	String strBoardNo = request.getParameter("boardNo");
    int boardNo = Integer.parseInt(strBoardNo);
	
    //로그인한 사용자 ID 가져오기
     //String boardWriter = (String) session.getAttribute("sessionMemberId");
    
	//Model
	//DTO에 값 세팅
	BoardDto boardDto = new BoardDto();
    boardDto.setBoardNo(boardNo);
    //boardDto.setBoardWriter(boardWriter);
	
    //DAO호출(삭제)
	BoardDao boardDao = new BoardDao();
	int row = boardDao.deleteBoard(boardDto);
	
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
%>