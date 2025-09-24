<!-- ex2Action.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>
<%
	/*
		1. 요청 데이터 확인+검증(Controller)
		2. 데이터 정제 후 논리적 단위로 저장(Model)
		3. 데이터 출력(View)
	*/
	//1)Begin Controller --------------------------------
	//id
	String id = request.getParameter("id"); //변수명(소문자로시작)(or클래스명(대문자로시작)).메소드
	//request선언 안해줬는데 사용할 수 있는 이유. jsp에서 만드는 거 가져다 사용하는 것.
	System.out.println(id + "<---id");
	
	//pw
	String pw1 = request.getParameter("pw1");
	String pw2 = request.getParameter("pw2");
	if(pw1.equals(pw2) == false){ //pw1 != pw2이거는 두개의 주소가 같냐는 뜻임.'.equals'은 두개의 값이 같은지 물어보는 거임.
		//System.out.println("pw error");
		throw new Exception("pw error");
	}
	
	//name
	String name = request.getParameter("name");
	System.out.println(name + "<---name");
	
	//birthday
	String birth = request.getParameter("birth");
	System.out.println(birth + "<---birth");
	
	//num기수
	String num = request.getParameter("num");
	System.out.println(num + "<---num");
		
	//gender
	String gender = request.getParameter("gender");
	System.out.println(gender + "<---gender");
	
	//String hobby = request.getParameter("hobby"); //값을 하나 밖에 못받음
	String[] hobby = request.getParameterValues("hobby"); //값을 여러개 받을 수 있음
	System.out.println(hobby);
	if(hobby != null){
		for(String h : hobby){
			System.out.println(h);
		}
	}
	
	//mail
	String mail1 = request.getParameter("mail1");
	System.out.println(mail1 + "<--mail1");
	String mail2 = request.getParameter("mail2");
	System.out.println(mail2 + "<--mail2");
	
	//memo
	String memo = request.getParameter("memo");
	System.out.println(memo + "<--memo");	
	//End Controller -------------------------------------

	//2)Begin Model --------------------------------------
	Member member = new Member();
	member.setId(id);
	member.setPw(pw1);
	member.setName(name);
	member.setBirth(birth);
	member.setNum(Integer.parseInt(num));
	Gender g = null;
	if(gender.equals("M")){//member.setGender(gender.equals("M")?Gender.MALE : Gender.FEMALE);
		g = Gender.MALE;
	}else{
		g = Gender.FEMALE;
	}
	member.setGender(g);
	
	member.setHobby(new ArrayList<String>()); //하비와 관계없이 빈칸
	if(hobby != null){ //hobby가 null이면 member.hobby도 null
		for(String h : hobby){
			member.getHobby().add(h);
		}
	}
	member.setMail(mail1 + mail2);
	member.setMemo(memo);
	
	System.out.println(member.toString());
	
	//쌤코드
	int age = 0;
	Calendar c = Calendar.getInstance();
	int todayYear = c.get(Calendar.YEAR);
	int todayMonth = c.get(Calendar.MONTH);
	int todayDate = c.get(Calendar.DATE);
	
	//2000-12-10
	String[] arr = birth.split("-");
	System.out.println(arr[0]);
	System.out.println(arr[1]);
	System.out.println(arr[2]);
	
	int birthYear = Integer.parseInt(arr[0]);
	int birthMonth = Integer.parseInt(arr[1]);
	int birthDate = Integer.parseInt(arr[2]);
	
	age = todayYear - birthYear;
	//생일이 안 지났다면 -1 -> 생일의 월이 오늘날짜의 월보다 크다, 같고 오늘이 생일일보다 작다
	if(todayMonth < birthMonth){
		age = age - 1;
	}else if(todayMonth == birthMonth && (todayDate < birthDate)){
		age = age - 1;
	}		
	//End Model ------------------------------------
%>
<%	
/* 내코드
	//오늘년도
	Calendar today = Calendar.getInstance();
	int year = today.get(Calendar.YEAR);
	int month = today.get(Calendar.MONTH) + 1;
	int day = today.get(Calendar.DATE);
	//생년월일
	int birthYear = Integer.parseInt(birth.substring(0,4));
	int bMonth = Integer.parseInt(birth.substring(5,7));
	int bDay = Integer.parseInt(birth.substring(8,10));
	// 나이 구하기 (기본 나이)
	int age = year - birthYear;

	// 만나이 계산
	if (month < bMonth || (month == bMonth && day < bDay)) {
	    age--;
	}
*/
%>
<!-- 3)view -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	<table border="1">
			<tr> <!-- 1행 -->
				<th>아이디</th>
				<td><%=member.getId() %></td>
			</tr>
			<tr>
				<th>
					<div>비밀번호</div>
				</th>
				<td><%=member.getPw().substring(0,2) %>*****</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><%=member.getName() %></td>
			</tr>
			<tr>
				<th>생일</th>
				<td><%=member.getBirth() %>(<%=age %>)</td>
			</tr>
			<tr>
				<th>기수</th>
				<td><%=member.getNum() %></td>
			</tr>
			<tr>
				<th>성별</th>
				<td><%=member.getGender()==Gender.MALE ? "남자" : "여자" %></td>
			</tr>
			<tr>
				<th>취미</th>
				<td>
					<%
						for(String h : member.getHobby()){
					%>
							<%=h %> &nbsp;		
					<%		
						}
					%>
				</td>
			</tr>
			<tr>
				<th>메일</th>
				<td><%=member.getMail() %></td>
			</tr>
			<tr>
				<th>메모</th>
				<td><%=member.getMemo() %></td>
			</tr>
		</table>
</body>
</html>