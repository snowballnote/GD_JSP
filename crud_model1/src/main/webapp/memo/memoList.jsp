<!-- memoList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "dao.*" %>
<%
	final int ROW_PER_PAGE = 10;
	
	// Controller Layer
	// 매개값: memoCategory, currentPage
	String memoCategory = request.getParameter("memoCategory");
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int startRow = 0;
	startRow = ROW_PER_PAGE * (currentPage - 1);

	// 모델(값): List<MemoDto>, lastPage : startRow와 ROW_PER_PAGE 입력 - List<MemoDto>반환하는 기능이 필요 - DAO 구현
	MemoDao memoDao = new MemoDao();
	List<MemoDto> memoList = memoDao.selectMemoListByPage(memoCategory, startRow, ROW_PER_PAGE);
	System.out.println("memoList.jsp#memoList: "+memoList);
	// 모델(값) : lastPage, totalCount 먼저 구하고,  totalCount, ROW_PER_PAGE 입력 - lastPage 반환
	int lastPage = memoDao.getLastPage(memoCategory, ROW_PER_PAGE);
	System.out.println("memoList.jsp#lastPage: "+lastPage);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memoList.jsp</title>
</head>
<body>
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	<h1>memoList</h1>	
	<!-- Navigation -->
	<div>
		<%
			String[] memoCategoryList = {"회사일정", "부서일정", "개인일정"};
			for(String mc : memoCategoryList){
		%>
				<a href="<%=request.getContextPath() %>/memo/memoList.jsp?memoCategory=<%=mc %>">[<%=mc %>]</a>				
		<%		
			}
		%>
	</div>
	
	<h1><a href="/memo/memoList.jsp">MEMO LIST</a></h1>
	<div>
		<a href="<%=request.getContextPath() %>/memo/insertMemoForm.jsp">글입력</a>
	</div>
	<div>
		현재 페이지: <%=currentPage %> / <%=lastPage %>
	</div>
	<table border="1">
		<tr>
			
		</tr>
		<tr>
			<th>memo_no</th>
			<th>memo_category</th>
			<th>memo_title</th>
			<!-- <th>memo_content</th> -->
		</tr>	
		<%
			for(MemoDto m : memoList){
		%>
				<tr>
					<td><%=m.getMemoNo() %></td>
					<td><%=m.getMemoCategory() %></td>
					<td>
							<a href="<%=request.getContextPath() %>/memo/memoOne.jsp?memoNo=<%=m.getMemoNo() %>">
								<%=m.getMemoTitle() %>
							</a>
					</td>
					<!-- <td><%=m.getMemoContent() %></td> -->
				</tr>
		<%		
			}
		%>
	</table>
	<!-- Paging Navigation -->
	<div>
		<!-- 이전 -->
		<%
			if(currentPage > 1){
				if(memoCategory == null){
		%>
					<a href="<%=request.getContextPath() %>/memo/memoList.jsp?currentPage=<%=currentPage-1%>">[이전]</a>			
		<%			
				}else{
		%>
					<a href="<%=request.getContextPath() %>/memo/memoList.jsp?currentPage=<%=currentPage-1%>&memoCategory=<%=memoCategory%>">[이전]</a>
		<%			
				}	
			}
		%>
		<!-- 다음 -->
		<%
			if(currentPage < lastPage){
				if(memoCategory == null){
		%>
					<a href="<%=request.getContextPath() %>/memo/memoList.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
		<%			
				}else{
		%>
					<a href="<%=request.getContextPath() %>/memo/memoList.jsp?currentPage=<%=currentPage+1%>&memoCategory=<%=memoCategory%>">[다음]</a>
		<%			
				}
			}
		%>		
	</div>
	
</body>
</html>