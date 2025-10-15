<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h1>employeeList2</h1>
   <!-- 상단 메뉴 include -->
   <jsp:include page="/inc/menu.jsp"></jsp:include>
   
   <% 
      // rowPerPage & startRow 로직
      int rowPerPage = 10;
      int startRow = 0;
      int currentPage = 1;
      if(request.getParameter("currentPage") != null) {
         currentPage = Integer.parseInt(request.getParameter("currentPage"));
      }
      startRow = (currentPage-1) * rowPerPage;
      String[] deptNames = request.getParameterValues("deptNames");
      System.out.println("deptNames: " + deptNames);
      //
      
      //---------------------------------
      DepartmentDao departmentDao = new DepartmentDao();
      List<DepartmentDto> dList = departmentDao.selectDepartmentList();
      
      EmployeeDao employeeDao = new EmployeeDao();
      List<Map<String, Object>> eList = null;
      if(deptNames == null){
    	  eList = employeeDao.selectEmployeeListByPage(startRow, rowPerPage);
      }else{
    	  eList = employeeDao.selectEmployeeListByPageAndDepName(startRow, rowPerPage, deptNames);
      }
     
   %>
   
   	<!-- 결과 목록 구현-->
   	<form method="get" action="<%=request.getContextPath() %>/employee/employeeList2.jsp">
   		<%
   			for(DepartmentDto d : dList){
   				boolean flag = false; //deptNaes 안에 d.getDeptName() 있다 or 없다
   				if (deptNames != null) {   
   					for(String s : deptNames){
   						if (d.getDeptName().equals(s)) { flag = true; break; }
   					}
   				}
   		%>
   			<input type="checkbox" name="deptNames" value="<%=d.getDeptName()%>" <%= flag ? "checked" : "" %>><%=d.getDeptName()%>
		<%
    		}
		%>
   		<button type="submit">조회</button>
   	</form>
   	<table border="1">
      <tr>
         <th>empNo</th>
         <th>birthDate</th>
         <th>name</th>
         <th>gender</th>
         <th>hireDate</th>
         <th>deptNo</th>
         <th>deptName</th>
      </tr>
      <%
         for(Map e : eList) {
      %>
            <tr>
               <td><%=e.get("empNo")%></td>
               <td><%=e.get("birthDate")%></td>
               <td><%=e.get("name")%></td>
               <td><%=e.get("gender")%></td>
               <td><%=e.get("hireDate")%></td>
               <td><%=e.get("deptNo")%></td>
               <td><%=e.get("deptName")%></td>
            </tr>
      <%      
         }
      %>
   </table>
</body>
</html>