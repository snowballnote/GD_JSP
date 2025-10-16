package dao;

import java.sql.*;
import dto.*;
import util.DBConnection;

public class StaffDao {
	// 로그인 시도: 일치하는 계정이 있으면 Staff DTO를 반환, 없으면 null 반환.
	// 비밀번호는 평문 비교 또는 해시 저장 중 상황에 맞게 사용
	public Staff login(Staff s) throws Exception {
		// 1) 반환할 객체 미리 선언 (로그인 성공 시 이 객체에 정보 담아 반환)
		Staff loginStaff = null;
		
		// 2) SQL 준비 (로그인 시 아이디와 비밀번호가 일치하는 직원 조회)
		String sql = "SELECT"
					+ "	staff_id, first_name, last_name, address_id, picture, email"
					+ ", store_id, active, username, last_update"
					+ " FROM staff"
					+ " WHERE username=? AND password=?";
		
		// 3) DB 연결 및 쿼리 실행
		Connection conn = DBConnection.getConnection(); // DBConnection 유틸 클래스 통해 DB 연결
		PreparedStatement stmt = conn.prepareStatement(sql); // SQL문 실행 준비
		stmt.setString(1, s.getUsername()); // 첫 번째 ?에 사용자 아이디(username) 바인딩
		stmt.setString(2,  s.getPassword()); // 두 번째 ?에 비밀번호(password) 바인딩
		
		ResultSet rs = stmt.executeQuery(); // SQL 실행 후 결과를 ResultSet 객체에 저장
		
		// 4) 결과 처리 (조회 결과가 있을 경우 - 로그인 성공)
		if(rs.next()) {
			loginStaff = new Staff(); // Staff 객체 생성 후 DB값 채워 넣기
			loginStaff.setStaffId(rs.getInt("staff_id"));
			loginStaff.setFirstName(rs.getString("first_name"));
			loginStaff.setLastName(rs.getString("last_name"));
			loginStaff.setAddressId(rs.getInt("address_id"));
			loginStaff.setPicture(rs.getString("picture"));
			loginStaff.setEmail(rs.getString("email"));
			loginStaff.setStoreId(rs.getInt("store_id"));
			loginStaff.setActive(rs.getInt("active"));
			loginStaff.setUsername(rs.getString("username"));
			loginStaff.setLastUpdate(rs.getString("last_update"));
		}
		
		rs.close();
	    stmt.close();
	    conn.close();
	    
	    // 5) 반환 (로그인 성공 시 Staff 객체, 실패 시 null)
		return loginStaff;
		
	}
}
