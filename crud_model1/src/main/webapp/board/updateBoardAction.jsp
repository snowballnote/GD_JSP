<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="dao.*" %>
<%	
	//Controller Layer
	String boardNo = request.getParameter("boardNo");
	String boardDistrict = request.getParameter("boardDistrict");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	
	//모델(값): 입력성공실패
	BoardDto paramBoardDto = new BoardDto();
	paramBoardDto.setBoardNo(Integer.parseInt(boardNo));
	paramBoardDto.setBoardDistrict(boardDistrict);
	paramBoardDto.setBoardTitle(boardTitle);
	paramBoardDto.setBoardContent(boardContent);
	
	BoardDao boardDao = new BoardDao();
	int row = boardDao.updateBoard(paramBoardDto);
	
	if(row == 1) {
        response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
    } else {
        response.sendRedirect(request.getContextPath()+"/board/insertBoardForm.jsp?error=fail");
    }
%>