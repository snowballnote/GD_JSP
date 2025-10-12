<!-- /board/boardOne.jsp : 게시글 상세보기 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>   <!-- JDBC를 사용하기 위한 SQL 관련 클래스 -->
<%@ page import = "dao.*" %>        <!-- 데이터 접근 객체(DAO) 클래스 -->
<%@ page import = "dto.*" %>        <!-- 데이터 전송 객체(DTO) 클래스 -->
<%@ page import = "java.util.*" %>  <!-- 유틸리티 클래스 (List 등) -->

<%
    // ===================== [Controller 역할 부분] =====================
    // 1️⃣ 요청 파라미터로 전달된 게시글 번호(boardNo)를 정수로 변환
    int boardNo = Integer.parseInt(request.getParameter("boardNo"));
    
    // 2️⃣ BoardDao 객체 생성 후 해당 번호의 게시글 정보 조회
    BoardDao boardDao = new BoardDao();
    BoardDto board = boardDao.selectBoardOne(boardNo); 
    // → DB에서 boardNo에 해당하는 한 개의 게시글 정보(행)를 가져옴
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/boardOne.jsp</title>
</head>
<body>
	<!-- ===================== [공통 메뉴 영역] ===================== -->
	<!-- menu.jsp 파일을 불러와 상단 메뉴를 표시 -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	
	<h1>BOARD ONE</h1>
	
	<!-- ===================== [게시글 상세 정보 표시 테이블] ===================== -->
	<table border="1">
		<tr>
			<th>board_no</th>
			<!-- 게시글 고유 번호 -->
			<td><%=board.getBoardNo() %></td>
		</tr>
		<tr>
			<th>board_district</th>
			<!-- 게시글 지역 -->
			<td><%=board.getBoardDistrict() %></td>			
		</tr>
		<tr>
			<th>board_title</th>
			<!-- 게시글 제목 -->
			<td><%=board.getBoardTitle() %></td>			
		</tr>
		<tr>
			<th>board_content</th>
			<!-- 게시글 내용 -->
			<td><%=board.getBoardContent() %></td>			
		</tr>
		<tr>
			<th>board_writer</th>
			<!-- 작성자 ID -->
			<td><%=board.getBoardWriter() %></td>			
		</tr>
		<tr>
			<th>createdate</th>
			<!-- 작성일 -->
			<td><%=board.getCreatedate() %></td>		
		</tr>
	</table>
	
	<!-- ===================== [게시글 수정 / 삭제 기능] ===================== -->
	<div>
		<!-- 수정 버튼: 수정 폼 페이지로 이동 -->
		<!-- 수정 페이지는 boardNo를 쿼리스트링으로 전달받아 해당 글을 불러옴 -->
		<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=board.getBoardNo()%>">[수정]</a>
		
		<!-- 삭제 버튼: deleteBoardAction.jsp 호출 -->
		<!-- deleteBoardAction.jsp에서 boardNo를 이용해 DB에서 글 삭제 -->
		<a href="<%=request.getContextPath()%>/board/deleteBoardAction.jsp?boardNo=<%=board.getBoardNo()%>">[삭제]</a>
	</div>
</body>
</html>