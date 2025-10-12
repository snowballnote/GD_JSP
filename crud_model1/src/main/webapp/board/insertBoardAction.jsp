<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto.*" %>  <!-- BoardDto 클래스 import -->
<%@ page import ="dao.*" %>  <!-- BoardDao 클래스 import -->

<%
	// ==================== [Controller Layer] ====================
	// 1️⃣ 로그인 확인
	// 세션에 로그인 정보가 없으면 로그인 페이지로 이동
	String boardWriter = (String) session.getAttribute("sessionMemberId");
	if(boardWriter == null) {
	    response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	    return; // 코드 실행 중단
	}

	
	// 2️⃣ 폼에서 전달받은 파라미터 값 가져오기
	String boardDistric = request.getParameter("boardDistrict"); // 지역
	String boardTitle = request.getParameter("boardTitle");     // 제목
	String boardContent = request.getParameter("boardContent"); // 내용
	// String boardWriter = request.getParameter("boardWriter"); // 작성자는 세션에서 가져옴 (주석 처리)

	
	// 3️⃣ 모델 생성 및 값 세팅 (BoardDto)
	// DAO에 전달할 데이터를 DTO 객체로 정리
	BoardDto paramBoardDto = new BoardDto();
	paramBoardDto.setBoardDistrict(boardDistric);
	paramBoardDto.setBoardTitle(boardTitle);
	paramBoardDto.setBoardContent(boardContent);
	paramBoardDto.setBoardWriter(boardWriter);

	
	// 4️⃣ DAO 호출
	// insertBoard() → DB에 새 게시글을 추가하는 메서드
	BoardDao boardDao = new BoardDao();
	int row = boardDao.insertBoard(paramBoardDto); // 성공 시 1 반환

	
	// 5️⃣ View로 이동
	// 등록 완료 후 게시판 목록으로 리다이렉트
	response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
%>