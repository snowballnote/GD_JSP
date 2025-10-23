package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dto.Member;

public class MemberDao {
	// 로그인
	public Member login(Member paramMember) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT id, grade FROM member WHERE id=? AND pw=?";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/mvc", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getId());
		stmt.setString(2, paramMember.getPw());
		rs = stmt.executeQuery();
		
		Member loginMember = null;
		if(rs.next()) {
			loginMember = new Member();
			loginMember.setId(rs.getString("id"));
			loginMember.setGrade(rs.getInt("grade"));
		}
		
		return loginMember;
	}
}
