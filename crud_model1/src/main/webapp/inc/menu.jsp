<!-- menu.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
	<a href="<%=request.getContextPath() %>/home.jsp">[홈]</a>
	<a href="<%=request.getContextPath() %>/board/boardList.jsp">[게시판 리스트]</a>
	<a href="<%=request.getContextPath() %>/memo/memoList.jsp">[메모]</a>
	<a href="<%=request.getContextPath() %>/diary/diary.jsp">[다이어리]</a>
	<a href="<%=request.getContextPath() %>/schedule/schedule.jsp">[스케줄]</a>	
	<%
		if(session.getAttribute("sessionMemberId") != null){
	%>
			<a href="<%=request.getContextPath() %>/member/memberInfo.jsp">[내정보]</a>		
	<%
		}
	%>
</div>