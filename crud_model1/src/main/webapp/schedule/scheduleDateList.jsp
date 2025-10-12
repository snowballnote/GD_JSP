<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ScheduleDao, dto.ScheduleDto, java.util.*" %>
<%
  // 인가
  if(session.getAttribute("sessionMemberId")==null){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp"); return;
  }
  // y/m/d → yyyy-MM-dd 변환
  String y = request.getParameter("y");
  String m = request.getParameter("m");
  String d = request.getParameter("d");
  String scheduleDate = String.format("%s-%02d-%02d", y, Integer.parseInt(m), Integer.parseInt(d));

  // DAO로 해당 날짜 목록 조회
  ScheduleDao dao = new ScheduleDao();
  List<ScheduleDto> list = dao.selectByDate(scheduleDate);
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>scheduleDateList</title></head>
<body>
  <jsp:include page="/inc/menu.jsp"></jsp:include>

  <h1>SCHEDULE DATE LIST</h1>
  <h2><%=scheduleDate%></h2>
  <table border="1">
    <tr><th>SCHEDULE TITLE</th></tr>
    <%
      if(list.isEmpty()){
    %>
        <tr><td>등록된 글이 없습니다</td></tr>
    <%
      } else {
        for(ScheduleDto s : list){
    %>
          <tr>
            <td><a href="<%=request.getContextPath()%>/schedule/scheduleOne.jsp?scheduleNo=<%=s.getScheduleNo()%>"><%=s.getScheduleTitle()%></a></td>
          </tr>
    <%
        }
      }
    %>
  </table>
</body>
</html>