<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, dao.MemoDao, dto.MemoDto" %>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");

	// 검색 필터(카테고리)
	String memoCategory = request.getParameter("memoCategory");

	// 한 페이지에 보여줄 행 개수
	int rowPerPage = 10;

	// 현재 페이지 (기본값 1)
	int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));

	// 시작행 계산 (LIMIT 시작값)
	int startRow = (currentPage - 1) * rowPerPage;

	// DAO 객체 생성
	MemoDao memoDao = new MemoDao();

	// 메모 목록 조회 (카테고리 + 페이징)
	List<MemoDto> list = memoDao.selectMemoListByPage(memoCategory, startRow, rowPerPage);

	// 마지막 페이지 계산 (페이징용)
	int lastPage = memoDao.getLastPage(memoCategory, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>메모 목록</title></head>
<body>
<h1>📋 메모 목록</h1>

<!-- 검색창 -->
<form method="get" action="<%=request.getContextPath()%>/memo/memoList.jsp">
	카테고리:
	<input type="text" name="memoCategory" value="<%=memoCategory==null?"":memoCategory%>">
	<button type="submit">검색</button>
</form>

<!-- 새 글 작성 버튼 -->
<p><a href="<%=request.getContextPath()%>/memo/insertMemoForm.jsp">[새 메모 작성]</a></p>

<!-- 목록 테이블 -->
<table border="1" cellpadding="6">
	<tr><th>번호</th><th>카테고리</th><th>제목</th></tr>
	<% for(MemoDto m : list){ %>
	<tr>
		<td><%=m.getMemoNo()%></td>
		<td><%=m.getMemoCategory()%></td>
		<td>
			<!-- 상세보기 페이지로 이동 -->
			<a href="<%=request.getContextPath()%>/memo/memoOne.jsp?memoNo=<%=m.getMemoNo()%>">
				<%=m.getMemoTitle()%>
			</a>
		</td>
	</tr>
	<% } %>
</table>

<!-- 페이징 -->
<div style="margin-top:10px;">
	<% if(currentPage > 1){ %>
		<a href="?memoCategory=<%=memoCategory==null?"":memoCategory%>&currentPage=<%=currentPage-1%>">이전</a>
	<% } %>
	페이지 <%=currentPage%> / <%=lastPage%>
	<% if(currentPage < lastPage){ %>
		<a href="?memoCategory=<%=memoCategory==null?"":memoCategory%>&currentPage=<%=currentPage+1%>">다음</a>
	<% } %>
</div>
</body>
</html>