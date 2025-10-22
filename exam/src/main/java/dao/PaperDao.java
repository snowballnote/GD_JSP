package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import dto.Paper;
import util.DBConnection;

public class PaperDao {
	public int insertPaper(Paper p) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO paper(student_id, question_id, paper_answer, createdate)"
					+ " VALUES(?, ?, ?, NOW())";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);

		stmt.setInt(1, p.getStudentId());
		stmt.setInt(2, p.getQuestionId());
		stmt.setInt(3, p.getPaperAnswer());
		
		int row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return row;
	}
}
