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

	String diaryDate = String.format("%s-%02d-%02d", y, month, day);
   System.out.println("diartDate:" + diaryDate); 
   
   // Model Layer
   Class.forName("com.mysql.cj.jdbc.Driver");
   Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
   String sql = "select diary_no, diary_title from diary where diary_date=? order by diary_no desc";
   PreparedStatement stmt = conn.prepareStatement(sql);
   stmt.setString(1, diaryDate);
   ResultSet rs = stmt.executeQuery();
   List<DiaryDto> list = new ArrayList<>();
   while(rs.next()) { // ResultSet -> ArrayList<DiaryDto>
      DiaryDto dto = new DiaryDto();
      dto.setDiaryNo(rs.getInt("diary_no"));
      dto.setDiaryTitle(rs.getString("diary_title"));
      list.add(dto);
   }
%>
<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <!-- menu.jsp 이 위치에 include -->
   <jsp:include page="/menu.jsp"></jsp:include>

   <h1>DIARY DATE LIST</h1>
   <h2><%=diaryDate%></h2>
   <table border="1">
      <tr>
         <th>DIARY TITLE</th>
      </tr>
      <%
         if(list.size() == 0) {
      %>
            <tr>
               <td>등록된 글이 없습니다</td>
            </tr>
      <%      
         } else {
            for(DiaryDto dto : list) {
      %>
               <tr>
                  <td>
                     <a href="<%=request.getContextPath()%>/diaryOne.jsp?diaryNo=<%=dto.getDiaryNo() %>"><%=dto.getDiaryTitle() %></a>
                  </td>
               </tr>
      <%         
            }
         }
      %>
   </table>
</body>
</html>













