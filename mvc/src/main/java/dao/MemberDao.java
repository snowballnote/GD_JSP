package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.Member;

public class MemberDao {
	// 로그인
	public Member login(Member paramM) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT id, grade FROM member WHERE id=? AND pw=?";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramM.getId());
		stmt.setString(2, paramM.getPw());
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
