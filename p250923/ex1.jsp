<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calendar 예제</title>
</head>
<body>
<%
    Calendar today = Calendar.getInstance();

    String yo = ""; // 요일 문자열 변수 선언

    switch(today.get(Calendar.DAY_OF_WEEK)) {
        case 1: yo = "일"; break;
        case 2: yo = "월"; break;
        case 3: yo = "화"; break;
        case 4: yo = "수"; break;
        case 5: yo = "목"; break;
        case 6: yo = "금"; break;
        case 7: yo = "토"; break;
    }
%>
    <table border="1">
        <tr>
            <td>년도</td>
            <td><%=today.get(Calendar.YEAR)%></td>
        </tr>
        <tr>
            <td>월</td>
            <td><%=today.get(Calendar.MONTH) + 1 %></td>
        </tr>
        <tr>
            <td>일</td>
            <td><%=today.get(Calendar.DATE) %></td>
        </tr>
        <tr>
            <td>시</td>
            <td><%=today.get(Calendar.HOUR) %></td>
        </tr>
        <tr>
            <td>분</td>
            <td><%=today.get(Calendar.MINUTE) %></td>
        </tr>
        <tr>
            <td>초</td>
            <td><%=today.get(Calendar.SECOND) %></td>
        </tr>
        <tr>
            <td>요일</td>
            <td><%=yo%></td>
        </tr>
    </table>
</body>
</html>
