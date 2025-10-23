package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.MemberBoard;

public class MemberBoardDao {
	// 단건 조회
	public MemberBoard selectMemberBoardOne(int no) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = """
				SELECT no, title, content, id, creatdate
				FROM member_board
				WHERE no=?				
			""";

		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, no);

		rs = stmt.executeQuery();
		MemberBoard mb = null;
		if (rs.next()) {
			mb = new MemberBoard();
			mb.setNo(rs.getInt("no"));
        	mb.setTitle(rs.getString("title"));
        	mb.setContent(rs.getString("content"));
        	mb.setId(rs.getString("id"));
        	mb.setCreatedate(rs.getString("createdate"));
		}

		rs.close();
		stmt.close();
		conn.close();
		return mb;
	}
	
	// 목록 조회(페이징)
	public List<MemberBoard> selectMemberBoardList(int startRow, int rowPerPage) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<MemberBoard> list = new ArrayList<>();
		
		String sql = """
					SELECT no, title, content, id, creatdate
					FROM member_board
					ORDER BY no DESC
					LIMIT ?, ?					
				""";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
        stmt.setInt(2, rowPerPage);  
        rs = stmt.executeQuery();
        
        MemberBoard mb = null;
        while(rs.next()) {
        	mb = new MemberBoard();
        	mb.setNo(rs.getInt("no"));
        	mb.setTitle(rs.getString("title"));
        	mb.setContent(rs.getString("content"));
        	mb.setId(rs.getString("id"));
        	mb.setCreatedate(rs.getString("createdate"));
        	list.add(mb);
        }
        
        rs.close();
		stmt.close();
		conn.close();
		return list;		
	}
	
	//전체 개수 조회
	public int selectMemberBoardTotalCount() throws Exception {
		Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int totalCount = 0;
        
        String sql = "SELECT COUNT(*) cnt FROM memberBoard";
        
        conn = DBConnection.getConnection();
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        if(rs.next()) {
        	totalCount = rs.getInt("cnt");
        }
        
        rs.close();
		stmt.close();
		conn.close();
		return totalCount;
	}
}
