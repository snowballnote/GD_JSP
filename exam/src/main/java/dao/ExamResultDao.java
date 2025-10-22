package dao;

import java.sql.*;
import java.util.*;
import dto.*;
import util.DBConnection;

public class ExamResultDao {
	
	public Map<String, Integer> selectExamResultRank(int categoryId, int studentId) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
					SELECT category_id, student_id, score, r, cnt
					FROM 
						(SELECT category_id, student_id, score
							, RANK() OVER(PARTITION BY category_id ORDER BY score DESC) r
							, COUNT(*) OVER(PARTITION BY category_id) cnt
						FROM exam_result) t
					WHERE category_id=? AND student_id=?;
				""";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryId);
        stmt.setInt(2, studentId);
        
        rs = stmt.executeQuery();
        
		Map<String, Integer> m = null;
        while(rs.next()) {
        	m = new HashMap<String, Integer>();
        	m.put("score", rs.getInt("score"));
        	m.put("r", rs.getInt("r"));
        	m.put("cnt", rs.getInt("cnt"));
        }
        
        rs.close();
		stmt.close();
		conn.close();
		return m;	
	}
	public int insertExamResult(ExamResult er) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO examResult(category_id, student_id, score, reatedate)"
					+ " VALUES(?, ?, ?, NOW())";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, er.getCategoryId());
		stmt.setInt(2, er.getStudentId());
		stmt.setDouble(3, er.getScore());
		
		int row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return row;
	}
}
