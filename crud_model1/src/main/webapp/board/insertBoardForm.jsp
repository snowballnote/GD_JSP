<!-- insertBoardForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertBoardForm.jsp</title>
</head>
<body>
	<!-- 공통 메뉴 영역 불러오기 -->
	<!-- 메뉴에는 홈, 게시판, 메모, 다이어리, 스케줄 등이 포함됨 -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>

	<%
		// 게시판 지역 선택용 리스트 선언
		// 사용자가 선택할 수 있도록 셀렉트 박스에 넣을 예정
		String[] boardDistrictList = {"경기도", "강원도", "충청도", "전라도", "경상도", "제주도"};
	%>

	<h1>ADD BOARD</h1>

	<!-- 게시글 입력 폼 -->
	<!-- 글 작성 후 insertBoardAction.jsp로 데이터 전송 -->
	<form action="<%=request.getContextPath()%>/board/insertBoardAction.jsp" method="post">
		<table border="1">
			<!-- 게시글 지역 선택 -->
			<tr>
				<th>BOARD DISTRICT</th>
				<td>
					<select name="boardDistrict">
						<%
							// 위에서 정의한 지역 리스트를 반복문으로 출력
							for(String s : boardDistrictList){
						%>
								<option value="<%=s %>"><%=s %></option>
						<%
							}
						%>
					</select>
				</td>
			</tr>

			<!-- 게시글 제목 입력 -->
			<tr>
				<th>BOARD TITLE</th>
				<td><input type="text" name="boardTitle" required></td>
			</tr>

			<!-- 게시글 내용 입력 -->
			<tr>
				<th>BOARD CONTENT</th>
				<td><textarea rows="5" cols="80" name="boardContent" required></textarea></td>
			</tr>

			<!-- 게시글 작성자 입력 -->
			<!-- 실제로는 로그인 세션에서 가져오는 게 일반적 -->
			<tr>
				<th>BOARD WRITER</th>
				<td><input type="text" name="boardWriter" ></td>
			</tr>
		</table>

		<!-- 폼 전송 버튼 -->
		<button type="submit">글입력</button>
	</form>
</body>
</html>