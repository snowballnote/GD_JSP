<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.DiaryDto" %>
<%@ page import="java.util.ArrayList" %>
<%
	// DiaryDto 더미 데이터 100개를 생성
	// 2025 - 07,08,09 - 1~30 100개
	ArrayList<DiaryDto> list = new ArrayList<>();
	for(int i = 0; i < 100; i++){
		String[] tempYM = {"2025-07-", "2025-08-", "2025-09-"};
		int rn1 = (int)(Math.random()*tempYM.length); 
		String diaryDate = tempYM[rn1];
		
		String[] tempD = {
				"01", "02", "03", "04", "05", "06", "07", "08", "09", "10",
				"11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
				"21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
		};
		int rn2 = (int)(Math.random()*tempD.length); 
		diaryDate = diaryDate + tempD[rn2];
		
		String diaryMemo = "sample memo " + i;
		list.add(new DiaryDto(diaryDate, diaryMemo));
	}
%>