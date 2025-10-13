package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import dto.*;
import util.DBConnection;

public class EmployeeDao {
	public List<Employee> selectEmployeeListByPage(int startRow, int rowPerPage) throws Exception{
		List<Employee> list = new ArrayList<>();
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";

		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date direDate"
				+ " FROM employee"
				+ " ORDER BY emp_no DESC"
				+ " LIMIT ?, ?";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Employee e = new Employee();
			e.setEmpNo(rs.getInt("empNo"));
			e.setBirthDate(rs.getString("birthDate"));
			e.setFirstName(rs.getString("firstName"));
			e.setLastName(rs.getString("lastName"));
			e.setGender(rs.getString("gender").equals("M") ? Gender.M : Gender.F);
//위에 한 줄과 같은 코드			
//			Gender g = Gender.F;
//			if(rs.getString("gender").equals("M")) {
//				g = Gender.M;
//			}
//			e.setGender(g);
			e.setHireDate(rs.getString("hireDate"));

		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
		
	}
}
