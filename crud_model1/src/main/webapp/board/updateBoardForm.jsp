<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>   <!-- SQL 관련 클래스 사용 -->
<%@ page import = "dao.*" %>        <!-- BoardDao 클래스 사용 -->
<%@ page import = "dto.*" %>        <!-- BoardDto 클래스 사용 -->
<%@ page import = "java.util.*" %>  <!-- ArrayList 등 유틸 클래스 사용 -->
<%
	//============ [Controller Layer] ============
	//1. 전달받은 게시글 번호(boardNo) 피미터를 정수로 변환
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));

	//2.BoardNo 객체 생성 -> 해당 게시글 정보 조회
	BoardDao boardDao = new BoardDao();
	BoardDto board = boardDao.selectBoardOne(boardNo); //게시글 상세 데이터 반환
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 상단 메뉴 (공통UI) 포함 -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	
	<h1>UPDATE BOARD</h1>
	
	<!-- ============ [게시글 수정 폼 영역] ============ -->
	<!-- 수정 후 updateBoardAction.jsp로 데이터 전송 (POST방식) -->
	<form action="<%=request.getContextPath() %>/board/updateBoardAction.jsp" method="post">
	<table border="1">
	
	<!-- 수정할 수 있는 항목: 지역, 제목, 내용 -->
	
		<!-- 게시글 번호 (읽기 전용) -->
		<tr>
			<th>board_no</th>
			<td>
				<input type="text" name="boardNo" value="<%=board.getBoardNo()%>" readonly="readonly">
			</td>
		</tr>
		
		<!-- 게시글 지역(select 박스에서 현재 지역 선택 상태 유지 -->
		<tr>
			<th>board_district</th>
			<td>
				<select name="boardDistrict">
					<%
						//선택 가능한 지역 목록 배열
						String[] boardDistrictList = {"경기도", "강원도", "충청도", "전라도", "경상도", "제주도"};
						
						//현재 게시글의 지역과 동일한 값은 selected로 표시
						for(String s : boardDistrictList){
							if(s.equals(board.getBoardDistrict())){
					%>
								<option value="<%=s %>" selected="selected"><%=s%></option>
					<%			
							}else{
					%>
								<option value="<%=s%>"><%=s %></option>
					<%			
							}
						}
					%>
				</select>
			</td>
		</tr>
		
		<!-- 게시글 제목 -->
		<tr>
			<th>board_title</th>
			<td>
				<input type="text" name="boardTitle" value="<%=board.getBoardTitle()%>">
			</td>
		</tr>
		
		<!-- 게시글 내용 -->
		<tr>
			<th>board_content</th>
			<td>
				<textarea name="boardContent" rows="5" cols="50" ><%=board.getBoardContent() %></textarea>
			</td>
		</tr>
	</table>
	
	<!-- 수정 버튼 -->
	<button type="submit">수정하기</button>
	</form>
</body>
</html>