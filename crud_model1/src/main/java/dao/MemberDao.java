package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.MemberDto;

public class MemberDao {
	//아이디 중복검사
	public String selectMemberId(String memberId) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT member_id FROM member WHERE member_id=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		rs = stmt.executeQuery();
		String result= null;
		if(rs.next()) {
			result = rs.getString("member_id");
		}
		return result;
	}
	//1)회원가입
	//param : MemberDto
	//return : int
	public int insertMember(MemberDto memberDto) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		PreparedStatement stmt = null;
		String sql1 = "INSERT INTO member(member_id, member_pw)"
						+ " VALUES(?, ?)";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt.setString(1, memberDto.getMemberId());
		stmt.setString(2, memberDto.getMemberPw());
		return 0;
	}
	//2)로그인
	//param : MemberDto
	//return : String
	 public String login(MemberDto memberDto) throws ClassNotFoundException, SQLException {
		 Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = "SELECT member_id FROM member WHERE member_id=? and member_pw=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberDto.getMemberId());
			stmt.setString(2, memberDto.getMemberPw());
			rs = stmt.executeQuery();
			String result= null;
			if(rs.next()) {
				result = rs.getString("member_id");
			}
			return result;
	 }
	//3)개인정보
	//param : Stirng(key: memberId)
	//return : MemberDto
	 public MemberDto selectMemberOne(String memberId) throws ClassNotFoundException, SQLException {
		 Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = "SELECT member_id, member_pw, createdate FROM member WHERE member_id=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			String result= null;
			MemberDto memberDto = null;
			if(rs.next()) {
				memberDto = new MemberDto();
				memberDto.setMemberId(rs.getString("member_id"));
				memberDto.setMemberPw(rs.getString("member_pw"));
				memberDto.setCreatedate(rs.getString("createdate"));
			}
			return memberDto;
	 }
	//4)비밀번호 수정
	//param : MemberDto, String(수정할 새로운 비밀번호)
	//return : int
	public int updateMemberPw(MemberDto memberDto, String newPw) throws ClassNotFoundException, SQLException {
		 Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		PreparedStatement stmt = null;
		String sql = "UPDATE member SET member_pw=?WHERE member_id=? and member_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, memberDto.getMemberId());
		stmt.setString(3, memberDto.getMemberPw());
		
		return stmt.executeUpdate();
	}
	//5)회원탈퇴
	//param: MemberDto
	//return: int
	public int deleteMemberPw(MemberDto memberDto, String newPw) throws ClassNotFoundException, SQLException {
		 Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		PreparedStatement stmt = null;
		String sql = "DELETE FROM membe WHERE member_id=? and member_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberDto.getMemberId());
		stmt.setString(2, memberDto.getMemberPw());
		return stmt.executeUpdate();
	}
}