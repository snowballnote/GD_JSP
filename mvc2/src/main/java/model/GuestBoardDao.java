package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.GuestBoard;

public class GuestBoardDao {
	// 글 추가
	public int insertGuestBoard(GuestBoard gb) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
        int row = 0;
        String sql = "INSERT INTO guest_board (title, content, writer, createdate)"
                   + " VALUES (?, ?, ?, NOW())";
        
        Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/mvc", "root", "java1234");
        stmt = conn.prepareStatement(sql);
       	stmt.setString(1, gb.getTitle());
        stmt.setString(2, gb.getContent());
        stmt.setString(3, gb.getWriter());
        row = stmt.executeUpdate();
        
		stmt.close();
		conn.close();
        return row;
    }
	public int selectCount() throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM guest_board";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/mvc", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		int count = 0;
		if(rs.next()) {
			count = rs.getInt(1);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return count;
	}
	
	// list Model역활
	public List<GuestBoard> selectList(int startRow, int rowPerPage) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT no, title, writer, createdate FROM guest_board ORDER BY no DESC LIMIT ?,?";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/mvc", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		List<GuestBoard> list = new ArrayList<>();
		while(rs.next()) {
			GuestBoard gb = new GuestBoard();
			gb.setNo(rs.getInt("no"));
			gb.setTitle(rs.getString("title"));
			gb.setWriter(rs.getString("writer"));
			gb.setCreatedate(rs.getString("createdate"));
			list.add(gb);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
}