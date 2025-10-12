package dao;

import java.sql.*;
import java.util.*;
import dto.CommentDto;

public class CommentDao {

    // 공통 커넥션 생성(드라이버 로딩 포함)
    private Connection getConn() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/ex1","root","java1234"
        );
    }

    /* ============ [CREATE] 댓글 작성 ============ */
    // return: 1(성공) / 0(실패)
    public int insertComment(CommentDto dto) throws Exception {
        String sql = "INSERT INTO comment(board_no, comment_writer, comment_content) VALUES(?,?,?)";
        try (Connection conn = getConn(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, dto.getBoardNo());
            ps.setString(2, dto.getCommentWriter());
            ps.setString(3, dto.getCommentContent());
            return ps.executeUpdate();
        }
    }

    /* ============ [DELETE] 댓글 삭제 ============ */
    // 기존 코드와 동일하게 comment_no + board_no 로 삭제
    // (작성자 제한을 걸려면 WHERE 절에 'AND comment_writer=?' 추가하면 됨)
    public int deleteComment(int commentNo, int boardNo) throws Exception {
        String sql = "DELETE FROM comment WHERE comment_no=? AND board_no=?";
        try (Connection conn = getConn(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, commentNo);
            ps.setInt(2, boardNo);
            return ps.executeUpdate();
        }
    }

    /* ============ [READ] 게시글별 댓글 목록 ============ */
    // boardOne.jsp에서 목록 출력 시 사용 (필요 시)
    public List<CommentDto> selectCommentListByBoard(int boardNo) throws Exception {
        String sql = "SELECT comment_no, board_no, comment_writer, comment_content, createdate " +
                     "FROM comment WHERE board_no=? ORDER BY comment_no DESC";
        try (Connection conn = getConn(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, boardNo);
            try (ResultSet rs = ps.executeQuery()) {
                List<CommentDto> list = new ArrayList<>();
                while (rs.next()) {
                    CommentDto c = new CommentDto();
                    c.setCommentNo(rs.getInt("comment_no"));
                    c.setBoardNo(rs.getInt("board_no"));
                    c.setCommentWriter(rs.getString("comment_writer"));
                    c.setCommentContent(rs.getString("comment_content"));
                    c.setCreatedate(rs.getString("createdate"));
                    list.add(c);
                }
                return list;
            }
        }
    }
}