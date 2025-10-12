<%@ page import="dao.CommentDao, dto.CommentDto, java.util.*" %>
<%
   int bno = Integer.parseInt(request.getParameter("boardNo"));
   CommentDao cdao = new CommentDao();
   List<CommentDto> comments = cdao.selectCommentListByBoard(bno);
%>
<!-- 댓글 목록 출력 -->
<h3>댓글</h3>
<table border="1">
  <tr><th>작성자</th><th>내용</th><th>작성일</th><th>액션</th></tr>
  <%
    if(comments.isEmpty()){
  %>
    <tr><td colspan="4">댓글이 없습니다.</td></tr>
  <%
    } else {
      for(CommentDto c : comments){
  %>
    <tr>
      <td><%=c.getCommentWriter()%></td>
      <td><%=c.getCommentContent()%></td>
      <td><%=c.getCreatedate()%></td>
      <td>
        <a href="<%=request.getContextPath()%>/comment/deleteCommentAction.jsp?boardNo=<%=bno%>&commentNo=<%=c.getCommentNo()%>">삭제</a>
      </td>
    </tr>
  <%
      }
    }
  %>
</table>

<!-- 댓글 작성 폼 (로그인 시만 보이게) -->
<%
  if(session.getAttribute("sessionMemberId") != null){
%>
<form method="post" action="<%=request.getContextPath()%>/comment/insertCommentAction.jsp">
  <input type="hidden" name="boardNo" value="<%=bno%>">
  <textarea name="commentContent" rows="3" cols="60" required></textarea>
  <button type="submit">등록</button>
</form>
<% } %>