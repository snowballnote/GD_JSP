<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, dao.ScheduleDao, dto.ScheduleDto" %>
<%
  // 인가
  if(session.getAttribute("sessionMemberId")==null){
    response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp"); return;
  }

  // 달력 기준일(1일) 결정: 파라미터 없으면 현재월, 있으면 해당 연/월
  Calendar target = Calendar.getInstance();
  String targetYear = request.getParameter("targetYear");
  String targetMonth = request.getParameter("targetMonth"); // 0~11 기준을 사용 (기존 코드 스타일)
  if(targetYear!=null && targetMonth!=null){
    target.set(Calendar.YEAR, Integer.parseInt(targetYear));
    target.set(Calendar.MONTH, Integer.parseInt(targetMonth));
  }
  target.set(Calendar.DATE, 1);

  // DAO로 해당 월의 일정 목록 로드 (제목/날짜/번호)
  ScheduleDao dao = new ScheduleDao();
  List<ScheduleDto> monthList = dao.selectByMonth(target.get(Calendar.YEAR), target.get(Calendar.MONTH)+1);

  // 달력 렌더링 계산: 시작 공백/마지막 공백/총 칸수
  Calendar first = (Calendar)target.clone();
  first.set(Calendar.DATE, 1);
  int startBlank = first.get(Calendar.DAY_OF_WEEK)-1;

  Calendar last = (Calendar)target.clone();
  int lastDate = last.getActualMaximum(Calendar.DAY_OF_MONTH);
  last.set(Calendar.DATE, lastDate);
  int endBlank = 7 - last.get(Calendar.DAY_OF_WEEK);
  if(endBlank==7) endBlank=0;
  int totalTd = startBlank + lastDate + endBlank;

  // 날짜별 일정 빠르게 찾도록 Map<day, List<ScheduleDto>> 구성
  Map<Integer, List<ScheduleDto>> byDay = new HashMap<>();
  for(ScheduleDto s : monthList){
    int day = Integer.parseInt(s.getScheduleDate().substring(8,10));
    byDay.computeIfAbsent(day, k->new ArrayList<>()).add(s);
  }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"><title>달력</title>
<style>
  table { width:100%; border-collapse:collapse; table-layout:fixed; text-align:center;}
  td { border:1px solid #ccc; vertical-align:top; height:100px; padding:8px;}
</style>
</head>
<body>
  <jsp:include page="/inc/menu.jsp"></jsp:include>

  <h1><a href="<%=request.getContextPath()%>/schedule/schedule.jsp">SCHEDULE</a></h1>
  <!-- 이전/다음달 이동: MONTH는 0~11 기준이므로 ±1 -->
  <h2>
    <a href="<%=request.getContextPath()%>/schedule/schedule.jsp?targetYear=<%=target.get(Calendar.YEAR)%>&targetMonth=<%=target.get(Calendar.MONTH)-1%>">[이전달]</a>
    <%=target.get(Calendar.YEAR)%>년 <%=target.get(Calendar.MONTH)+1%>월
    <a href="<%=request.getContextPath()%>/schedule/schedule.jsp?targetYear=<%=target.get(Calendar.YEAR)%>&targetMonth=<%=target.get(Calendar.MONTH)+1%>">[다음달]</a>
  </h2>

  <table>
    <tr>
      <th style="color:#f00;">일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th style="color:#00f;">토</th>
    </tr>
    <tr>
    <%
      for(int i=1;i<=totalTd;i++){
        // 매 주 시작마다 줄바꿈
        if(i>1 && (i-1)%7==0){ %></tr><tr><% }

        int d = i - startBlank; // 실제 날짜
        if(d<=0 || d>lastDate){ %><td>&nbsp;</td><% continue; }

        // 링크에 넘길 y/m/d (월은 1~12 표기)
        String y = String.valueOf(target.get(Calendar.YEAR));
        String m = String.valueOf(target.get(Calendar.MONTH)+1);
    %>
      <td>
        <!-- 날짜 숫자 + [추가] 버튼 (해당 날짜를 가진 입력폼으로 이동) -->
        <div>
          <a href="<%=request.getContextPath()%>/schedule/insertScheduleForm.jsp?y=<%=y%>&m=<%=m%>&d=<%=d%>"><%=d%></a>
          <a href="<%=request.getContextPath()%>/schedule/insertScheduleForm.jsp?y=<%=y%>&m=<%=m%>&d=<%=d%>">[추가]</a>
        </div>
        <hr>
        <!-- 해당 날짜의 일정 제목들 출력 (10자 초과 시 ... 처리) -->
        <div>
          <%
            List<ScheduleDto> ds = byDay.getOrDefault(d, Collections.emptyList());
            for(ScheduleDto s : ds){
              String temp = s.getScheduleTitle();
              if(temp.length()>10) temp = temp.substring(0,10)+"...";
          %>
              <div><a href="<%=request.getContextPath()%>/schedule/scheduleOne.jsp?scheduleNo=<%=s.getScheduleNo()%>"><%=temp%></a></div>
          <% } %>
        </div>
      </td>
    <% } %>
    </tr>
  </table>
</body>
</html>