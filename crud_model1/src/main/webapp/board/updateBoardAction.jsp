<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="dao.*" %>
<%
	//============ [Controller Layer] ============
	//클라이언트(폼)에서 전달받은 데이터를 처리하는 영역
	
	//1. 전달받은 피라미터(게시들 수정 폼에서 보낸 데이터) 가져오기
	String boardNo = request.getParameter("boardNo");
	//게시글 번호(PK)
	String boardDistrict = request.getParameter("boardDistrict"); //게시판 구분(카테고리)
	//게시글 제목
	String boardTitle = request.getParameter("boardTitle");
	//게시글 내용
	String boardContent = request.getParameter("boardContent");
	
	//2. 모델(값) 생성: DTO에 값 담기
	BoardDto paramBoardDto = new BoardDto();
	paramBoardDto.setBoardNo(Integer.parseInt(boardNo)); //문자열을 int로 변환 후 저장
	paramBoardDto.setBoardDistrict(boardDistrict);
	paramBoardDto.setBoardTitle(boardTitle);
	paramBoardDto.setBoardContent(boardContent);
	
	//3. DAO 호출: DB에서 게시글 수정 실행
	BoardDao boardDao = new BoardDao();
	int row = boardDao.updateBoard(paramBoardDto); //수정된 행의개수를 반환받음
	
	//4. 수정 결과에 따라 페이지 이동
	if(row == 1){
		//수정 성공 -> 게시글 목록 페이지로 이동
		response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
	}else{
		//수정 실패 -> 다시 작성 폼 페이지로 이동 + 에러 파라미터 전달
		response.sendRedirect(request.getContextPath() + "/board/insertBoardForm.jsp?error=fail");
	}
	
%>