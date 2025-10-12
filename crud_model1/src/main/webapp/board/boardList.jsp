<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "dao.*" %>

<%
	// ---------------- Controller Layer ----------------
	
	// 한 페이지당 보여줄 게시글 수 설정
	final int ROW_PER_PAGE = 10;
	
	// 1) 요청 파라미터 받기
	// 지역(도) 필터링 값
	String boardDistrict = request.getParameter("boardDistrict");
	
	// 현재 페이지 값 (없으면 기본값 1)
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 2) 페이지 시작 행 계산
	// 예: 1페이지면 0행부터, 2페이지면 10행부터 출력
	int startRow = ROW_PER_PAGE * (currentPage - 1);

	// 3) DAO를 이용해 데이터 조회
	BoardDao boardDao = new BoardDao();

	// 선택된 지역(boardDistrict)과 페이징 정보로 게시글 목록 가져오기
	List<BoardDto> boardList = boardDao.selectBoardListByPage(boardDistrict, startRow, ROW_PER_PAGE);
	System.out.println("boardList.jsp#boardList: " + boardList);

	// 전체 페이지 수 계산 (DAO에서 totalCount 기반으로 계산)
	int lastPage = boardDao.getLastPage(boardDistrict, ROW_PER_PAGE);
	System.out.println("boardList.jsp#lastPage: " + lastPage);
%>

<!-- ---------------- View Layer ---------------- -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList.jsp</title>
</head>
<body>
	<!-- 상단 메뉴 포함 -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	
	<h1>BOARD LIST</h1>
	
	<!-- 지역 필터 네비게이션 -->
	<div>
		<%
			String[] boardDistrictList = {"경기도","강원도","충청도","전라도","경상도","제주도"};
			for(String bd : boardDistrictList) {
		%>
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?boardDistrict=<%=bd%>">[<%=bd%>]</a>
		<%
			}
		%>
	</div>

	<!-- 글 작성 페이지로 이동하는 링크 -->
	<div>
		<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp">글입력</a>
	</div>
	
	<!-- 현재 페이지 표시 -->
	<div>
		현재 페이지: <%=currentPage%> / <%=lastPage%>
	</div>
	
	<!-- 게시글 목록 테이블 -->
	<table border="1">
		<tr>
			<th>board_no</th>
			<th>board_district</th>
			<th>board_title</th>
		</tr>
		<%
			// boardList에 담긴 게시글을 순서대로 출력
			for(BoardDto b : boardList) {
		%>
				<tr>
					<td><%=b.getBoardNo()%></td>
					<td><%=b.getBoardDistrict()%></td>
					<td>
						<!-- 제목 클릭 시 게시글 상세보기 페이지로 이동 -->
						<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>">
							<%=b.getBoardTitle()%>
						</a>
					</td>
				</tr>
		<%
			}
		%>
	</table>
	
	<!-- 페이징 네비게이션 -->
	<div>
		<!-- 이전 페이지 버튼 -->
		<%
			if(currentPage > 1) {
				if(boardDistrict == null) {
		%>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>">[이전]</a>
		<%
				} else {
		%>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&boardDistrict=<%=boardDistrict%>">[이전]</a>
		<%
				}
			}
		%>
		
		<!-- 다음 페이지 버튼 -->
		<%
			if(currentPage < lastPage) {
				if(boardDistrict == null) {
		%>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
		<%
				} else {
		%>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&boardDistrict=<%=boardDistrict%>">[다음]</a>
		<%
				}
			}
		%>
	</div>
</body>
</html>