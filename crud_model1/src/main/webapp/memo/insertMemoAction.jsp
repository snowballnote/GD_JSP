<!-- insertMemoAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto.*" %>
<%@ page import ="dao.*" %>
<%
	//Controller Layer
	String memoCategory = request.getParameter("memoCategory");
	String memoTitle = request.getParameter("memoTitle");
	String memoContent = request.getParameter("memoContent");
	
	MemoDto paramMemoDto = new MemoDto();
	paramMemoDto.setMemoCategory(memoCategory);
	paramMemoDto.setMemoTitle(memoTitle);
	paramMemoDto.setMemoContent(memoContent);
	
	MemoDao memoDao = new MemoDao();
	int row = memoDao.insertMemo(paramMemoDto);
	
	//글입력에 성공하면 보여줄 내용이 존재하지 않는다.
	//View Layer가 없다 -> 아무것도 보이지 않는 뷰를 보내고 클라이언트에게 /boardList.jsp 재요청
	response.sendRedirect(request.getContextPath() + "/memo/memoList.jsp");
%>