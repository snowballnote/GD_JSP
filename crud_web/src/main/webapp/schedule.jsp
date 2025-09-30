<!-- schedule.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="dto.*"%>
<%	
	// ---------------------- Controller Layer
	//1) 출력할 달력의 년/월 값이 외부에서 전달되지 않은 경우, 기본값으로 오늘 날짜를 사용하기 위해 today 객체를 생성
	Calendar today = Calendar.getInstance(); // 현재 시스템의 날짜와 시간을 가지는 달력 객체
	// 실제로 화면에 출력할 달력을 담을 객체를 선언
	// 기본값은 today와 동일하게 '오늘 날짜'로 설정됨
	// 이후 set(), add() 메서드를 사용해 원하는 연/월로 변경할 수 있음
	Calendar targetDay = Calendar.getInstance(); 
	targetDay.set(Calendar.DATE, 1);
	
	// ----------------------Model Layer
	// 2) 만약 출력할 달력의 년/월 매개값으로 전달 받는다면
	String targetYear = request.getParameter("targetYear");
	String targetMonth = request.getParameter("targetMonth");
	System.out.println("targetYear: " + targetYear);
	System.out.println("targetMonth: " + targetMonth);
	
	//targetYear and targetMonth 전달받지 못하면 today==targetCalendar, 전달받으면 today!=targetCalendar
	if(targetYear != null && targetMonth != null){
		targetDay.set(Calendar.YEAR, Integer.parseInt(targetYear));
		targetDay.set(Calendar.MONTH, Integer.parseInt(targetMonth));
	}
	System.out.println("today: " + today.get(Calendar.YEAR) + " " +today.get(Calendar.MONTH)+ " " +today.get(Calendar.DATE));
	System.out.println("targetDay: " + targetDay.get(Calendar.YEAR) + " " +targetDay.get(Calendar.MONTH)+ " " +targetDay.get(Calendar.DATE));
	
	// 2-2) DB에서 targetDay 데이터를 가져온다.
	Class.forName("com.mysql.cj.jdbc.Driver"); //드라이브로딩
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
	System.out.println("conn: " + conn);
	/*
		select schedule_no, schedule_date, schedule_title 
		from schedule 
		where year(schedule_date) = ? and month(schedule_date) = ?"
	*/	
	String sql = "select schedule_no, schedule_date, schedule_title from schedule where year(schedule_date) = ? and month(schedule_date) = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, targetDay.get(Calendar.YEAR));
	stmt.setInt(2, targetDay.get(Calendar.MONTH)+1);	
	ResultSet rs = stmt.executeQuery();
	List<ScheduleDto> list = new ArrayList<>();
	while(rs.next()){
		ScheduleDto s = new ScheduleDto();
		s.setScheduleNo(rs.getInt("schedule_no"));
		s.setScheduleDate(rs.getString("schedule_date"));
		s.setScheduleTitle(rs.getString("schedule_title"));
		list.add(s);
	}
	System.out.println("list.size: "+list.size());
	System.out.println("list: " + list.toString());
	
	// 3) targetDay가 확정되고 나면, targetDay의 1일 -> 1일의 요일 -> startBlank
	Calendar firstDay = targetDay;
	int firstDate = 1; //첫번째날짜
	firstDay.set(Calendar.DATE, 1);// 날짜를 1일로 변경
	int firstYo = firstDay.get(Calendar.DAY_OF_WEEK); //첫번째날자의 요일
	int startBlank = firstYo - 1;
		
	// 4) targetDay의 마지막 날짜 데이터 -> 1일의 요일 -> endBlank
	Calendar lastDay = targetDay;
	int lastDate = lastDay.getActualMaximum(Calendar.DAY_OF_MONTH);
	lastDay.set(Calendar.DATE, lastDate); //마지막 날짜로 바꿔주고
	int lastYo = lastDay.get(Calendar.DAY_OF_WEEK); //마지막 날짜의 요일.
	int endBlank = 7 - lastYo;
		
	System.out.println("lastDate: " + lastDate);
	System.out.println("startBlank: " + startBlank);
	System.out.println("endBlank: " + endBlank);
		
	int totalTd = startBlank + lastDate + endBlank;
%>

<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달력</title>
<style>
	table {
		width: 100%;
		table-layout: fixed; /* 칸 너비를 고정 */
		border-collapse: collapse;
		text-align: center;
	}
	
	td {
		padding: 10px;
		border: 1px solid #ccc;
		vertical-align: top;
		height: 100px; /* 칸 높이 지정 */
	}
	
	.day-header {
		color: #FF0000;
	}
	
	.saturday-header {
		color: #0000FF;
	}
	
	.current-day {
		font-weight: bold;
		color: #00FF00;
	}
	
	.diary-title {
		font-size: 0.9em;
		color: #555;
		margin-top: 5px;
	}
</style>
</head>
<body>
	<jsp:include page="/menu.jsp"></jsp:include>

	<h1>SCHEDULE</h1>
	<h2>
		<a href="<%=request.getContextPath()%>/schedule.jsp?targetYear=<%=targetDay.get(Calendar.YEAR)%>&targetMonth=<%=targetDay.get(Calendar.MONTH)-1%>">[이전달]</a>
				<%=targetDay.get(Calendar.YEAR)%>년<%=targetDay.get(Calendar.MONTH)+1%>월
		<a href="<%=request.getContextPath()%>/schedule.jsp?targetYear=<%=targetDay.get(Calendar.YEAR)%>&targetMonth=<%=targetDay.get(Calendar.MONTH)+1%>">[다음달]</a>
	</h2>
	<table border="1">
		<tr>
			<th><span style="color: #FF0000;">일</span></th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th><span style="color: #0000FF">토</span></th>
		</tr>
		
		<tr>
		<%
			for(int i = 1; i <= totalTd; i++){
				if(i > 1 && i % 7 == 1){ //i==1에도 </tr><tr>
		%>
					</tr><tr><!-- 행바뀜 -->
		<%		
				}
				
				int d = i-startBlank;
				if(d > 0 && d <= lastDate){
					//d 출력 + 일정 출력
					//일정 날짜 포맷, d포맷 일치
					String ymd = targetDay.get(Calendar.YEAR) + "-";
					if(targetDay.get(Calendar.MONTH) < 10){
							ymd = ymd + "0" + targetDay.get(Calendar.MONTH) + "-";
					}else{
							ymd = ymd + targetDay.get(Calendar.MONTH) + "-";
					}
						
					if(d<10){
						ymd = ymd + "0" + d;
					}else{
						ymd = ymd + d;	
					}
		%>
			<td>
				<!-- 
					1) 날짜를 클릭시 그 날짜의 schedule 목록 출력 페이지
					2) [추가]클릭시 diary 입력 페이지
					3) diary title(일부만 출력)을 클릭시 diary상세 출력 페이지
				 -->
				<div>
					<a href="<%=request.getContextPath()%>/insertScheduleForm.jsp?y=<%=targetDay.get(Calendar.YEAR)%>&m=<%=targetDay.get(Calendar.MONTH)+1%>&d=<%=d%>"><%=d %></a>
					<!-- diary 추가시 날짜정보를 매개값으로 함께 전송 -->
					<a href="<%=request.getContextPath()%>/insertScheduleForm.jsp?y=<%=targetDay.get(Calendar.YEAR)%>&m=<%=targetDay.get(Calendar.MONTH)+1%>&d=<%=d%>">[추가]</a>
				</div>
				<hr>
				<div>
					<!-- getDiaryDate() 날짜 == d -->
					<%
						for(ScheduleDto dto : list){
							if(d == Integer.parseInt(dto.getScheduleDate().substring(8))){
								String tempTitle = dto.getScheduleTitle();
								if(tempTitle.length() > 10){
									tempTitle = tempTitle.substring(0, 10) + "...";
								}
					%>
								<div>
									<a href="<%=request.getContextPath()%>/scheduleOne.jsp?scheduleNo=<%=dto.getScheduleNo()%>"><%=tempTitle %></a>
								</div>
					<%
							}
						}
					%>
				</div>
			</td>
		<%			
				}else{
					//공백 출력
		%>
					<td>&nbsp;</td>
		<%
				}
			}
		%>
		</tr>
	</table>
</body>
</html>