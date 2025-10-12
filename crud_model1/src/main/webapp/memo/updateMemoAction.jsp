<!-- updateMemoAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 0) 인가 + 인코딩
    if(session.getAttribute("sessionMemberId") == null){
        response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");

    // 1) 파라미터 수집
    String memoNo = request.getParameter("memoNo");
    String memoCategory = request.getParameter("memoCategory");
    String memoTitle = request.getParameter("memoTitle");
    String memoContent = request.getParameter("memoContent");

    // 방어: 필수값 체크 (없으면 목록으로)
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

        // 3) UPDATE SQL
        String sql = "UPDATE memo SET memo_category=?, memo_title=?, memo_content=? WHERE memo_no=?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, memoCategory);
        stmt.setString(2, memoTitle);
        stmt.setString(3, memoContent);
        stmt.setInt(4, Integer.parseInt(memoNo));

        // 4) 실행
        int row = stmt.executeUpdate();

        // 5) 결과 분기
        if(row == 1){
            // ✅ 오타 수정: memone.jsp → memoOne.jsp
            response.sendRedirect(request.getContextPath()+"/memoOne.jsp?memoNo="+memoNo);
        }else if(row == 0){
            response.sendRedirect(request.getContextPath()+"/updateMemoForm.jsp?memoNo="+memoNo);
        }else{
            throw new Exception("예상치 못한 수정 건수: " + row);
        }
    } finally {
        // 6) 자원 해제
        if(stmt != null) stmt.close();
        if(conn != null) conn.close();
    }
%>