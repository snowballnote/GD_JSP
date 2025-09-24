<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*"%>
<%@ page import = "java.util.*" %>
<%
	//1) Controller Layer

	//2) Model Layer
	List<Person> people = new ArrayList<>();

	// Gyeonggi-do
	people.add(new Person("Gyeonggi-do", "Suwon"));
	people.add(new Person("Gyeonggi-do", "Yongin"));
	people.add(new Person("Gyeonggi-do", "Seongnam"));
	people.add(new Person("Gyeonggi-do", "Goyang"));

	// Gangwon-do
	people.add(new Person("Gangwon-do", "Chuncheon"));
	people.add(new Person("Gangwon-do", "Gangneung"));
	people.add(new Person("Gangwon-do", "Wonju"));

	// Chungcheongbuk-do
	people.add(new Person("Chungcheongbuk-do", "Cheongju"));
	people.add(new Person("Chungcheongbuk-do", "Chungju"));

	// Chungcheongnam-do
	people.add(new Person("Chungcheongnam-do", "Cheonan"));
	people.add(new Person("Chungcheongnam-do", "Asan"));

	// Jeollabuk-do
	people.add(new Person("Jeollabuk-do", "Jeonju"));
	people.add(new Person("Jeollabuk-do", "Gunsan"));

	// Jeollanam-do
	people.add(new Person("Jeollanam-do", "Mokpo"));
	people.add(new Person("Jeollanam-do", "Yeosu"));
	people.add(new Person("Jeollanam-do", "Suncheon"));

	// Gyeongsangbuk-do
	people.add(new Person("Gyeongsangbuk-do", "Pohang"));
	people.add(new Person("Gyeongsangbuk-do", "Gyeongju"));
	people.add(new Person("Gyeongsangbuk-do", "Andong"));

	// Gyeongsangnam-do
	people.add(new Person("Gyeongsangnam-do", "Changwon"));
	people.add(new Person("Gyeongsangnam-do", "Jinju"));
	people.add(new Person("Gyeongsangnam-do", "Tongyeong"));

	// Jeju-do
	people.add(new Person("Jeju-do", "Jeju"));
	people.add(new Person("Jeju-do", "Seogwipo"));

	// --- 추가로 50개 채우기 (임의 반복/다양화) ---
	people.add(new Person("Gyeonggi-do", "Bucheon"));
	people.add(new Person("Gyeonggi-do", "Hwaseong"));
	people.add(new Person("Gyeonggi-do", "Pyeongtaek"));
	people.add(new Person("Gangwon-do", "Donghae"));
	people.add(new Person("Gangwon-do", "Samcheok"));
	people.add(new Person("Chungcheongbuk-do", "Jecheon"));
	people.add(new Person("Chungcheongnam-do", "Seosan"));
	people.add(new Person("Chungcheongnam-do", "Dangjin"));
	people.add(new Person("Jeollabuk-do", "Iksan"));
	people.add(new Person("Jeollabuk-do", "Namwon"));
	people.add(new Person("Jeollanam-do", "Naju"));
	people.add(new Person("Jeollanam-do", "Gangjin"));
	people.add(new Person("Gyeongsangbuk-do", "Yeongju"));
	people.add(new Person("Gyeongsangbuk-do", "Gimcheon"));
	people.add(new Person("Gyeongsangnam-do", "Geoje"));
	people.add(new Person("Gyeongsangnam-do", "Miryang"));

	System.out.println(people.size());
	
	String province = request.getParameter("");
	
%>
<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- navigation -->
	<div>
		<a href="/p250924/personlist.jsp?province=Gyeonggi-do">Gyeonggi-do</a>
		<a href="/p250924/personlist.jsp?province=Gangwon-do">Gangwon-do</a>
		<a href="/p250924/personlist.jsp?province=Chungcheongbuk-do">Chungcheongbuk-do</a>
		<a href="/p250924/personlist.jsp?province=Jeollabuk-do">Jeollabuk-do</a>
		<a href="/p250924/personlist.jsp?province=Jeollanam-do">Jeollanam-do</a>
		<a href="/p250924/personlist.jsp?province=Gyeongsangbuk-do">Gyeongsangbuk-do</a>
		<a href="/p250924/personlist.jsp?province=Gyeongsangnam-do">Gyeongsangnam-do</a>
		<a href="/p250924/personlist.jsp?province=Jeju-do">Jeju-do</a>
	</div>
	<h1>행정구역 : <%=province==null?"전체":province%></h1>
	<table border ="1">
		<tr>
			<th>행정구역</th>
			<th>도시</th>
		</tr>
		 <%
		 	if(province == null){
		 		for(Person person : people){ //people.size() --> 40
		 %>
		 			<tr>
		 				<td><%=person.getProvince() %></td>
		 				<td><%=person.getCity() %></td>
		 			</tr>		
		 <%	
		 		}
		 	}else{
		 		for(Person person : people){
		 			if(province.equals(person.getProvince())){ 
		 %>
		 				<tr>
		 					<td><%=person.getProvince() %></td>
		 					<td><%=person.getCity() %></td>
		 				</tr>
		 <%				
		 			}
		 		}	
		 	}
		 %>
	</table>
</body>
</html>