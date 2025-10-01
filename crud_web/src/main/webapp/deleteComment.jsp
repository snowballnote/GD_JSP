<!-- deleteCommentAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String commentNo = request.getParameter("commentNo");
    String boardNo = request.getParameter("boardNo");

    if(commentNo == null || boardNo == null){
        response.sendRedirect(request.getContextPath() + "/boardList.jsp");
        return;
    }

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/ex1","root","java1234"
    );

    String sql = "DELETE FROM comment WHERE comment_no=? AND board_no=?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setInt(1, Integer.parseInt(commentNo));
    stmt.setInt(2, Integer.parseInt(boardNo));

    int row = stmt.executeUpdate(); 
    System.out.println("삭제된 행 수: " + row);

    response.sendRedirect(request.getContextPath() + "/boardOne.jsp?boardNo=" + boardNo);
%>
