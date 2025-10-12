package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.MemberDto;

/**
 * Member 테이블을 다루는 DAO
 * - 아이디 중복검사
 * - 회원가입
 * - 로그인
 * - 개인정보 조회
 * - 비밀번호 수정
 * - 회원탈퇴
 *
 * 사용 전제: MySQL Driver 로드, DB 연결 정보 일치
 */
public class MemberDao {

	/* ======================= [아이디 중복검사] ======================= */
	// param : String memberId
	// return: 존재하면 member_id(문자열), 없으면 null
	public String selectMemberId(String memberId) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");

		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT member_id FROM member WHERE member_id=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();

			String result = null;
			if (rs.next()) {
				result = rs.getString("member_id");
			}
			return result;
		} finally {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
	}

	/* ======================= [회원가입] ======================= */
	// param : MemberDto(memberId, memberPw)
	// return: int (1=성공, 0=실패)
	public int insertMember(MemberDto memberDto) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");

		PreparedStatement stmt = null;
		try {
			String sql = "INSERT INTO member(member_id, member_pw) VALUES(?, ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberDto.getMemberId());
			stmt.setString(2, memberDto.getMemberPw());
			return stmt.executeUpdate();
		} finally {
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
	}

	/* ======================= [로그인] ======================= */
	// param : MemberDto(memberId, memberPw)
	// return: 로그인 성공 시 member_id, 실패 시 null
	public String login(MemberDto memberDto) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");

		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT member_id FROM member WHERE member_id=? AND member_pw=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberDto.getMemberId());
			stmt.setString(2, memberDto.getMemberPw());
			rs = stmt.executeQuery();

			String result = null;
			if (rs.next()) {
				result = rs.getString("member_id");
			}
			return result;
		} finally {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
	}

	/* ======================= [개인정보 조회] ======================= */
	// param : String memberId
	// return: MemberDto(없으면 null)
	public MemberDto selectMemberOne(String memberId) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");

		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT member_id, member_pw, createdate FROM member WHERE member_id=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();

			MemberDto memberDto = null;
			if (rs.next()) {
				memberDto = new MemberDto();
				memberDto.setMemberId(rs.getString("member_id"));
				memberDto.setMemberPw(rs.getString("member_pw"));
				memberDto.setCreatedate(rs.getString("createdate"));
			}
			return memberDto;
		} finally {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
	}

	/* ======================= [비밀번호 수정] ======================= */
	// param : MemberDto(현재 로그인한 사용자 id, 현재 pw), String newPw(새 비밀번호)
	// return: int (1=성공, 0=실패)
	public int updateMemberPw(MemberDto memberDto, String newPw) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");

		PreparedStatement stmt = null;
		try {
			String sql = "UPDATE member SET member_pw=? WHERE member_id=? AND member_pw=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, newPw);                           // 바꿀 비밀번호
			stmt.setString(2, memberDto.getMemberId());         // 본인 확인 (아이디)
			stmt.setString(3, memberDto.getMemberPw());         // 본인 확인 (현재 비번)
			return stmt.executeUpdate();
		} finally {
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
	}

	/* ======================= [회원탈퇴] ======================= */
	// param : MemberDto(memberId, memberPw), String newPw(사용 안 함)
	// return: int (1=성공, 0=실패)
	public int deleteMemberPw(MemberDto memberDto, String newPw) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");

		PreparedStatement stmt = null;
		try {
			String sql = "DELETE FROM member WHERE member_id=? AND member_pw=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberDto.getMemberId());
			stmt.setString(2, memberDto.getMemberPw());
			return stmt.executeUpdate();
		} finally {
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
	}
}