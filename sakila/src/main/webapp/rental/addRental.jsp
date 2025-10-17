<!-- addRental.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	if(session.getAttribute("loginStaff") == null) { // 로그인이 안 되었다면
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	String searchName = request.getParameter("searchName");
	
	// 현재페이지에서 이름검색버턴 조회가 되어 다시 .....
	String searchResult = "";
	if(searchName != null) {
		CustomerDao customerDao = new CustomerDao();
		List<Customer> list = customerDao.selectCustomerListByName(searchName);
		System.out.println(list.size());
		for(Customer c : list) {
			searchResult = searchResult + c.getFirstName() + " " + c.getLastName() +"(" + c.getCustomerId() + ")\n";
		}
	}
	System.out.println(searchResult);
	
	Staff loginStaff = (Staff)(session.getAttribute("loginStaff"));
	String inventoryId = request.getParameter("inventoryId");
	String title = request.getParameter("title");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=title%> 대여(addRental)</h1>
	
	<!-- 고객이름으로 ID 검색 -->
	<form method="post" action="<%=request.getContextPath()%>/rental/addRental.jsp">
		<input type="hidden" name="inventoryId" value="<%=inventoryId%>">
		<input type="hidden" name="title" value="<%=title%>">
		
		<input type="text" name="searchName">
		<button type="submit">고객이름검색</button> <!--  -->
	</form>
	
	<!-- 검색결과 출력 -->
	<textarea rows="5" cols="50" readonly><%=searchResult%></textarea>
	
	<hr>
	
	<form method="post" action="<%=request.getContextPath()%>/rental/addRentalAction.jsp">
		<table border="1">
			<tr>
				<th>inventoryId</th>
				<td><input type="text" name="inventoryId" value="<%=inventoryId%>" readonly></td>
			</tr>
			<tr>
				<th>rentalDate</th>
				<td><input type="date" name="rentalDate"></td>
			</tr>
			<tr>
				<th>staffId</th>
				<td><input type="text" name="staffId" value="<%=loginStaff.getStaffId()%>" readonly></td>
			</tr>
			<tr>
				<th>customerId</th>
				<td><input type="text" name="customerId"></td>
			</tr>
		</table>
		<button type="submit">대여</button>
	</form>
</body>
</html>