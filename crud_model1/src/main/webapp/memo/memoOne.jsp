<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemoDao, dto.MemoDto" %>
<%
	// URL에서 전달받은 memoNo 가져오기
	int memoNo = Integer.parseInt(request.getParameter("memoNo"));

	// DAO 생성 후 해당 메모 조회
	MemoDao memoDao = new MemoDao();
	MemoDto memo = memoDao.selectMemoOne(memoNo);
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>메모 상세보기</title></head>
<body>
<h1>🗒️ 메모 상세보기</h1>

<!-- 메모 내용 출력 -->
<table border="1" cellpadding="8">
	<tr><th>번호</th><td><%=memo.getMemoNo()%></td></tr>
	<tr><th>카테고리</th><td><%=memo.getMemoCategory()%></td></tr>
	<tr><th>제목</th><td><%=memo.getMemoTitle()%></td></tr>
	<tr><th>내용</th><td><pre><%=memo.getMemoContent()%></pre></td></tr>
</table>

<!-- 수정 / 삭제 / 목록 버튼 -->
<p>
	<a href="<%=request.getContextPath()%>/memo/updateMemoForm.jsp?memoNo=<%=memo.getMemoNo()%>">[수정]</a>
	<a href="<%=request.getContextPath()%>/memo/deleteMemoAction.jsp?memoNo=<%=memo.getMemoNo()%>">[삭제]</a>
	<a href="<%=request.getContextPath()%>/memo/memoList.jsp">[목록]</a>
</p>
</body>
</html>