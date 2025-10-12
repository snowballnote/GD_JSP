<!-- menu.jsp : 사이트 공통 메뉴 영역 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 메뉴 영역 -->
<div>
	<!-- 홈으로 이동 -->
	<a href="<%=request.getContextPath() %>/home.jsp">[홈]</a>
	
	<!-- 게시판 목록 페이지로 이동 -->
	<a href="<%=request.getContextPath() %>/board/boardList.jsp">[게시판 리스트]</a>
	
	<!-- 메모 기능 페이지로 이동 -->
	<a href="<%=request.getContextPath() %>/memo/memoList.jsp">[메모]</a>
	
	<!-- 다이어리 페이지로 이동 -->
	<a href="<%=request.getContextPath() %>/diary/diary.jsp">[다이어리]</a>
	
	<!-- 스케줄 관리 페이지로 이동 -->
	<a href="<%=request.getContextPath() %>/schedule/schedule.jsp">[스케줄]</a>	
	
	<%
		// 세션에 로그인 정보(sessionMemberId)가 있을 경우에만 '내정보' 메뉴 표시
		if(session.getAttribute("sessionMemberId") != null){
	%>
			<!-- 로그인한 사용자의 정보 페이지로 이동 -->
			<a href="<%=request.getContextPath() %>/member/memberInfo.jsp">[내정보]</a>		
	<%
		}
	%>
</div>