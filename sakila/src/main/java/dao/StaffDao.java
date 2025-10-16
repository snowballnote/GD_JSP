package dao;

import java.sql.*;
import dto.*;
import util.DBConnection;

public class StaffDao {
	// 로그인 시도: 일치하는 계정이 있으면 Staff DTO를 반환, 없으면  null 반환. 비밀번호는 평문 비교/해시 중 택1
	public Staff login(Staff s) throws Exception {
		Staff loginStaff = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";
		
		sql = "SELECT"
				+ " staff_id, first_name, last_name, address_id, picture, email" 
				+ ", store_id, active, username, last_update"
				+ " FROM staff"
				+ " WHERE username=? AND password=?";
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, s.getUsername());
		stmt.setString(2, s.getPassword());
		
		rs = stmt.executeQuery();
		if(rs.next()) {
			loginStaff = new Staff();
			loginStaff.setStaffId(rs.getInt("staff_id"));
            loginStaff.setFirstName(rs.getString("first_name"));
            loginStaff.setLastName(rs.getString("last_name"));
            loginStaff.setAddressId(rs.getInt("address_id"));
            loginStaff.setPicture(rs.getString("picture"));
            loginStaff.setEmail(rs.getString("email"));
            loginStaff.setStoreId(rs.getInt("store_id"));
            loginStaff.setActive(rs.getInt("active"));
            loginStaff.setUsername(rs.getString("username"));
		}

		return loginStaff;	
	}
}
