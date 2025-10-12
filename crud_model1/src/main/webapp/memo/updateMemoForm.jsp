<!-- updateMemoForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dto.*" %>
<%
    // 0) 인가
    if(session.getAttribute("sessionMemberId") == null){
        response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
        return;
    }

    // 1) 수정 대상 PK 체크
    String memoNo = request.getParameter("memoNo");
    if(memoNo == null || memoNo.isEmpty()){
        response.sendRedirect(request.getContextPath()+"/memoList.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    MemoDto memo = null;
    String[] memoCategoryList = {"회사일정", "부서일정", "개인일정"};

    try {
        // 2) DB 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");

        // 3) 단건 조회
        String sql = "SELECT memo_no, memo_category, memo_title, memo_content FROM memo WHERE memo_no=?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(memoNo));
        rs = stmt.executeQuery();

        if(rs.next()){
            memo = new MemoDto();
            memo.setMemoNo(rs.getInt("memo_no"));
            memo.setMemoCategory(rs.getString("memo_category"));
            memo.setMemoTitle(rs.getString("memo_title"));
            memo.setMemoContent(rs.getString("memo_content"));
        } else {
            // 대상 없음 → 목록으로
            response.sendRedirect(request.getContextPath()+"/memoList.jsp");
            return;
        }
    } finally {
        // 4) 자원 해제
        if(rs != null) rs.close();
        if(stmt != null) stmt.close();
        if(conn != null) conn.close();
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemoForm.jsp</title>
</head>
<body>
    <!-- menu.jsp include -->
    <jsp:include page="/inc/menu.jsp"></jsp:include>

    <h1>UPDATE MEMO</h1>
    <form action="<%=request.getContextPath() %>/updateMemoAction.jsp" method="post">
        <table border="1">
            <!-- PK는 읽기전용 -->
            <tr>
                <th>memo_no</th>
                <td><input type="text" name="memoNo" value="<%=memo.getMemoNo()%>" readonly></td>
            </tr>
            <tr>
                <th>memo_category</th>
                <td>
                    <select name="memoCategory">
                        <%
                            for(String s : memoCategoryList){
                                if(s.equals(memo.getMemoCategory())){
                        %>
                                    <option value="<%=s%>" selected><%=s%></option>
                        <%
                                } else {
                        %>
                                    <option value="<%=s%>"><%=s%></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <th>memo_title</th>
                <td><input type="text" name="memoTitle" value="<%=memo.getMemoTitle()%>" size="50"></td>
            </tr>
            <tr>
                <th>memo_content</th>
                <td>
                    <!-- rows 오타 수정 + 불필요한 선행 공백 제거 -->
                    <textarea name="memoContent" rows="5" cols="50"><%=memo.getMemoContent()%></textarea>
                </td>
            </tr>
        </table>
        <div style="margin-top:10px;">
            <button type="submit">수정 완료</button>
            <a href="<%=request.getContextPath()%>/memoOne.jsp?memoNo=<%=memo.getMemoNo()%>">[취소]</a>
        </div>
    </form>
</body>
</html>