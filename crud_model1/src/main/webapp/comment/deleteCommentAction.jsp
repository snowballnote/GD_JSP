<!-- /comment/deleteCommentAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CommentDao" %>
<%
    // 0) 인가: 로그인 필요
    if(session.getAttribute("sessionMemberId") == null){
        response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
        return;
    }

    // 1) 파라미터 체크
    String commentNoStr = request.getParameter("commentNo");
    String boardNoStr   = request.getParameter("boardNo");
    if(commentNoStr == null || boardNoStr == null){
        response.sendRedirect(request.getContextPath()+"/boardList.jsp");
        return;
    }
    int commentNo = Integer.parseInt(commentNoStr);
    int boardNo   = Integer.parseInt(boardNoStr);

    // 2) DAO 호출로 DELETE
    CommentDao dao = new CommentDao();
    int row = dao.deleteComment(commentNo, boardNo); // 1=삭제성공, 0=대상없음
    System.out.println("deleteCommentAction row="+row);

    // 3) 상세로 리다이렉트
    response.sendRedirect(request.getContextPath()+"/boardOne.jsp?boardNo=" + boardNo);
%>