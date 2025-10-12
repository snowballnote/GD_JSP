<!-- /comment/insertCommentAction.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CommentDao, dto.CommentDto" %>
<%
    // 0) 인가: 로그인된 사용자만 댓글 작성 가능
    if(session.getAttribute("sessionMemberId") == null){
        response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");

    // 1) 파라미터 수집
    String boardNoStr = request.getParameter("boardNo");
    String commentContent = request.getParameter("commentContent");
    // 작성자는 세션에서 (폼 값은 신뢰하지 않는 것을 권장)
    String commentWriter = (String)session.getAttribute("sessionMemberId");

    // 2) 유효성 체크
    if(boardNoStr == null || boardNoStr.trim().isEmpty() ||
       commentContent == null || commentContent.trim().isEmpty()){
        response.sendRedirect(request.getContextPath()+"/boardOne.jsp?boardNo="+boardNoStr);
        return;
    }

    int boardNo = Integer.parseInt(boardNoStr);

    // 3) DAO 호출로 INSERT
    CommentDao dao = new CommentDao();
    CommentDto dto = new CommentDto();
    dto.setBoardNo(boardNo);
    dto.setCommentWriter(commentWriter);
    dto.setCommentContent(commentContent);

    int row = dao.insertComment(dto); // 1=성공

    // 4) 결과에 따른 리다이렉트 (실패해도 상세로 돌려보냄)
    response.sendRedirect(request.getContextPath()+"/boardOne.jsp?boardNo=" + boardNo);
%>