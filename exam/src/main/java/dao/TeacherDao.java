package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dto.Teacher;
import util.DBConnection;

public class TeacherDao {
	public Teacher teacherLogin(Teacher paramT) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Teacher t = null;
		
		String sql = "SELECT teacher_id, teacher_name, createdate FROM teacher WHERE teacher_id=? AND teacher_name=?";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramT.getTeacherId());
		stmt.setString(2, paramT.getTeacherName());
		
		rs = stmt.executeQuery();
		if (rs.next()) {
			t = new Teacher();
			t.setTeacherId(rs.getInt("teacher_id"));
			t.setTeacherName(rs.getString("teacher_name"));
			t.setCreatedate(rs.getString("createdate"));
		}

		rs.close();
		stmt.close();
		conn.close();
		return t;	
	}
}
