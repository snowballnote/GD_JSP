<!-- scheduleDateList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%
   // Controller Layer
   String y = request.getParameter("y");
   String m = request.getParameter("m");
   String d = request.getParameter("d");
   // 2025-9-1 -> 2025-09-01
   int month = Integer.parseInt(m);
	int day = Integer.parseInt(d);

	String scheduleDate = String.format("%s-%02d-%02d", y, month, day);
   System.out.println("scheduleDate:" + scheduleDate); 
   
   // Model Layer
   Class.forName("com.mysql.cj.jdbc.Driver");
   Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
   String sql = "select schedule_no, schedule_title from schedule where schedule_date=? order by schedule_no desc";
   PreparedStatement stmt = conn.prepareStatement(sql);
   stmt.setString(1, scheduleDate);
   ResultSet rs = stmt.executeQuery();
   List<ScheduleDto> list = new ArrayList<>();
   while(rs.next()) { // ResultSet -> ArrayList<DiaryDto>
	   ScheduleDto dto = new ScheduleDto();
      dto.setScheduleNo(rs.getInt("schedule_no"));
      dto.setScheduleTitle(rs.getString("schedule_title"));
      list.add(dto);
   }
%>
<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scheduleDateList.jsp</title>
</head>
<body>
	<!-- menu.jsp 이 위치에 include -->
   <jsp:include page="/menu.jsp"></jsp:include>
   
	<h1>SCHEDULE DATE LIST</h1>
	<h2><%=scheduleDate %></h2>
   	<table border="1">
      <tr>
         <th>SCHEDULE TITLE</th>
      </tr>
      <%
         if(list.size() == 0) {
      %>
            <tr>
               <td>등록된 글이 없습니다</td>
            </tr>
      <%      
         } else {
            for(ScheduleDto dto : list) {
      %>
               <tr>
                  <td>
                     <a href="<%=request.getContextPath()%>/scheduleOne.jsp?scheduleNo=<%=dto.getScheduleNo()%>"><%=dto.getScheduleTitle()%></a>
                  </td>
               </tr>
      <%         
            }
         }
      %>
   </table>
</body>
</html>