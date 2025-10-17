<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%
	// 인가
	Staff loginStaff = (Staff)(session.getAttribute("loginStaff"));
%>
<div>
	<a href="<%=request.getContextPath() %>/film/filmList.jsp">필름 관리</a>
	<a href="<%=request.getContextPath() %>/actor/actorList.jsp">액터 관리</a>
	<a href="<%=request.getContextPath() %>/inventory/inventoryList.jsp">인벤토리 관리</a>
	
	<!-- 로그인 스탭 -->
	<%=loginStaff.getUsername() %>님 반갑습니다.
	<a href="<%=request.getContextPath() %>/home.jsp">[ 로그아웃 ]</a>
</div>