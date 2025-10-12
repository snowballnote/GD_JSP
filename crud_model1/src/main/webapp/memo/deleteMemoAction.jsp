<!-- deleteMemoAction.jsp (기존 파일명이 deleteMemo.jsp여도 동작은 동일) -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
    // 0) 인가
    if(session.getAttribute("sessionMemberId") == null){
        response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
        return;
    }

    // 1) 파라미터 검증
    String memoNo = request.getParameter("memoNo");
    if(memoNo == null || memoNo.isEmpty()){
        response.sendRedirect(request.getContextPath()+"/memoList.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // 2) DB 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");

        // 3) DELETE
        String sql = "DELETE FROM memo WHERE memo_no=?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(memoNo));
        int row = stmt.executeUpdate(); // 1: 삭제성공, 0: 삭제대상없음

        // 4) 결과 분기 (기존 코드가 반대로 되어 있었음)
        if(row == 1){
            System.out.println("deleteMemo 삭제성공");
            response.sendRedirect(request.getContextPath()+"/memoList.jsp");
        }else if(row == 0){
            System.out.println("deleteMemo 삭제실패(대상없음)");
            response.sendRedirect(request.getContextPath()+"/memoOne.jsp?memoNo="+memoNo+"&error=notfound");
        }else{
            throw new Exception("2개 이상의 행 삭제 발생: " + row);
        }
    } finally {
        // 5) 자원 해제
        if(stmt != null) stmt.close();
        if(conn != null) conn.close();
    }
%>