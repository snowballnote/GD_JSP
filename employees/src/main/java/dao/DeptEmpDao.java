package dao;

import java.sql.*;
import dto.*;
import util.DBConnection;

public class DeptEmpDao {
	public int insertDeptEmp(DeptEmpDto de) throws Exception {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "INSERT dept_emp(emp_no, dept_no, from_date, to_date)"
					+ " VALUES(?, ?, ?, ?)";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, de.getEmpNo());
		stmt.setString(2, de.getDeptNo());
		stmt.setString(3, de.getFromDate());
		stmt.setString(4, de.getToDate());
		
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	public int updateDeptEmp(DeptEmpDto de) throws Exception {
		Connection conn = DBConnection.getConnection();
		
		String sql = "UPDATE dept_emp SET to_date=? WHERE emp_no=? AND dept_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, de.getToDate());
		stmt.setInt(2, de.getEmpNo());
		stmt.setString(3, de.getDeptNo());
		
		int row = stmt.executeUpdate(); 
		
		stmt.close();
        conn.close();
        
		return row;
	}
}
