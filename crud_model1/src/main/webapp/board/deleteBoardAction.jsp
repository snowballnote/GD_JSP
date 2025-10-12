<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto.*" %>   <!-- BoardDto 클래스 import -->
<%@ page import ="dao.*" %>   <!-- BoardDao 클래스 import -->

<%
	// ==================== [Controller Layer] ====================
	// 클라이언트에서 전달받은 데이터를 처리하고, DAO를 호출하여 DB 작업 수행

	// 1️⃣ 삭제할 게시글 번호(boardNo) 파라미터 가져오기
	String strBoardNo = request.getParameter("boardNo"); // URL에서 전달된 boardNo 파라미터 값
	int boardNo = Integer.parseInt(strBoardNo); // 문자열 → int 변환

	
	// 2️⃣ (선택) 로그인한 사용자 ID 가져오기
	//    ※ 로그인 인증 후, 본인 게시글만 삭제하도록 처리할 때 사용 가능
    // String boardWriter = (String) session.getAttribute("sessionMemberId");

	
	// 3️⃣ 모델(값) 생성: DTO에 데이터 세팅
	BoardDto boardDto = new BoardDto();
	boardDto.setBoardNo(boardNo); // 삭제할 게시글 번호 설정
	// boardDto.setBoardWriter(boardWriter); // (필요 시) 작성자 정보도 설정
	
	
	// 4️⃣ DAO 호출: DB에서 해당 게시글 삭제
	BoardDao boardDao = new BoardDao();
	int row = boardDao.deleteBoard(boardDto); // 삭제된 행 수 반환 (성공 시 1)
	
	
	// 5️⃣ View 이동: 삭제 후 게시글 목록 페이지로 리다이렉트
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
%>