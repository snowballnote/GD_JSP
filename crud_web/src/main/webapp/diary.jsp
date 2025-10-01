<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="dto.*" %>
<%	
	// 인가 작업 : 로그인 되어있다면
	if(session.getAttribute("sessionMemberId") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	}
	// ---------------- Controller Layer
	// 1) 만약 출력할 달력의 년/월 매개값으로 전달 받는다면

	String targetYear = request.getParameter("targetYear");
	String targetMonth = request.getParameter("targetMonth");

	
	System.out.println("targetYear: "+targetYear);
	System.out.println("targetMonth: "+targetMonth);
	
	// ---------------- Model Layer
	//2) 출력할 달력의 년/월 매개값으로 전달되지 않는다. 그래서 오늘 날짜를 출력
	Calendar today = Calendar.getInstance(); // 오늘의 정보를 가지는 달력
	Calendar targetDay = Calendar.getInstance();
	targetDay.set(Calendar.DATE, 1);

	// targetYear and targetMonth 전달받지 못하면 today==targetCalendar, 전달받으면 today!=targetCalendar
	if(targetYear != null && targetMonth != null) {
		targetDay.set(Calendar.YEAR, Integer.parseInt(targetYear));
		targetDay.set(Calendar.MONTH, Integer.parseInt(targetMonth));
	}
	// System.out.println("today: "+today.get(Calendar.YEAR)+" "+today.get(Calendar.MONTH));
	System.out.println(targetDay);
	System.out.println("targetDay: "+targetDay.get(Calendar.YEAR)+" "+targetDay.get(Calendar.MONTH));
	
	// 2-2) DB에서 targetDay 데이터를 가져온다
	Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");	
	/*
		select diary_no, diary_date, diary_title 
		from diary 
		where year(diary_date) = ? and month(diary_date) = ?"
	*/
	String sql = "select diary_no, diary_date, diary_title from diary where year(diary_date) = ? and month(diary_date) = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, targetDay.get(Calendar.YEAR));
	stmt.setInt(2, targetDay.get(Calendar.MONTH)+1);
	ResultSet rs = stmt.executeQuery();
	List<DiaryDto> list = new ArrayList<>();
	while(rs.next()) {
		DiaryDto d = new DiaryDto();
		d.setDiaryNo(rs.getInt("diary_no"));
		d.setDiaryDate(rs.getString("diary_date"));
		d.setDiaryTitle(rs.getString("diary_title"));
		list.add(d);
	}
	System.out.println("list.size: "+list.size());
	System.out.println("list: "+list.toString());
	
	// 3) targetDay가 확정되고 나면, targetDay의 1일-> 1일의 요일-> startBlank
	Calendar firstDay = targetDay;
	int firstDate = 1;
	firstDay.set(Calendar.DATE, 1);
	int firstYo = firstDay.get(Calendar.DAY_OF_WEEK);
	int startBlank = firstYo - 1;
	
	// 4) targetDay의 마지막날짜 -> 마지막날짜의 요일-> endBlank
	Calendar lastDay = targetDay;
	int lastDate = lastDay.getActualMaximum(Calendar.DAY_OF_MONTH);
	lastDay.set(Calendar.DATE, lastDate);
	int lastYo = lastDay.get(Calendar.DAY_OF_WEEK);
	int endBlank = 7 - lastYo;
	
	System.out.println("lastDate: "+lastDate);
	System.out.println("startBlank: "+startBlank);
	System.out.println("endBlank: "+endBlank);
	
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
	<!-- menu.jsp 이 위치에 include -->
	<jsp:include page="/menu.jsp"></jsp:include>
	
	<h1><a href="<%=request.getContextPath()%>/diary.jsp">DIARY</a></h1>
	
	<h2>
		<a href="<%=request.getContextPath()%>/diary.jsp?targetYear=<%=targetDay.get(Calendar.YEAR)%>&targetMonth=<%=targetDay.get(Calendar.MONTH)-1%>">[이전달]</a>
		<%=targetDay.get(Calendar.YEAR)%>년 <%=targetDay.get(Calendar.MONTH)+1%>월
		<a href="<%=request.getContextPath()%>/diary.jsp?targetYear=<%=targetDay.get(Calendar.YEAR)%>&targetMonth=<%=targetDay.get(Calendar.MONTH)+1%>">[다음달]</a>
	</h2>
	<table border="1" width="90%">
		<tr>
			<th>일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th>토</th>
		</tr>
		
		<tr>
		<%
			for(int i=1; i<=totalTd; i++) {
				if(i>1 && i%7 == 1) { // i==1 에도 </tr><tr>
		%>
					</tr><tr> <!-- 행바낌 -->
		<%		
				}
				
				int d = i-startBlank;
				if(d>0 && d<=lastDate) {
					// d 출력 + 일정 출력
					// 일정 날짜 포멧 , d포맷 일치
					String ymd = targetDay.get(Calendar.YEAR)+ "-";
					if(targetDay.get(Calendar.MONTH) < 10) {
						ymd = ymd + "0" +targetDay.get(Calendar.MONTH) + "-";
					} else {
						ymd = ymd + targetDay.get(Calendar.MONTH) + "-";
					}
					
					if(d<10) {
						ymd = ymd + "0" + d;
					} else {
						ymd = ymd + d;
					}
					

		%>
					<td>
						<!-- 
							1) 날짜를 클릭시 그 날짜의 diary 목록 출력 페이지 
							2) [추가] 클릭시 diary 입력 페이지
							3) diary title(일부만 출력)을 클릭시 diary 상세 출력 페이지
						-->
						<div>
							<a href="<%=request.getContextPath()%>/diaryDateList.jsp?y=<%=targetDay.get(Calendar.YEAR)%>&m=<%=targetDay.get(Calendar.MONTH)+1%>&d=<%=d%>"><%=d%></a>
							<!-- diary 추가시 날짜정보를 매개값으로 함께 전송 -->
							<a href="<%=request.getContextPath()%>/insertDiaryForm.jsp?y=<%=targetDay.get(Calendar.YEAR)%>&m=<%=targetDay.get(Calendar.MONTH)+1%>&d=<%=d%>">[추가]</a>
						</div>
						<hr>
						<div>
							<!-- getDiaryDate() 날짜 == d -->
							<%
								for(DiaryDto dto : list) {
									// "yyyy-mm-dd"
									if(d == Integer.parseInt(dto.getDiaryDate().substring(8))) {							
										// diaryTitle 문자열길이를 10자만 출력
										String tempTitle = dto.getDiaryTitle();
										if(dto.getDiaryTitle().length() > 10) {
											// 앞에서 10자만 자르고 뒤에 "..."문자열 추가
											tempTitle = dto.getDiaryTitle().substring(0, 10) + "...";
										}
							%>
										<div>
											<a href="<%=request.getContextPath()%>/diaryOne.jsp?diaryNo=<%=dto.getDiaryNo()%>"><%=tempTitle%></a>
										</div>			
							<%			
									}
								}
							%>
						</div>
					</td>
		<%			
				} else {
					// 공백 출력
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