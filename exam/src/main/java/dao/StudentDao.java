package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dto.Student;
import util.DBConnection;

public class StudentDao {
	public Student studentLogin(Student paramS) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Student s = null;
		
		String sql = "SELECT student_id, student_name, createdate FROM student WHERE student_id=? AND student_name=?";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramS.getStudentId());
		stmt.setString(2, paramS.getStudentName());
		
		rs = stmt.executeQuery();
		if (rs.next()) {
			s = new Student();
			s.setStudentId(rs.getInt("student_id"));
			s.setStudentName(rs.getString("student_name"));
			s.setCreatedate(rs.getString("createdate"));
		}

		rs.close();
		stmt.close();
		conn.close();
		return s;	
	}
}
