package dao;

import java.sql.*;
import java.util.*;
import dto.*;
import util.DBConnection;

public class DepartmentDao {
	public int insertDepartment(DepartmentDto departmentDto) throws Exception {
		Connection conn = DBConnection.getConnection();
		
		String sql = "INSERT INTO departments(dept_no, dept_name)"
				+ " VALUES(?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, departmentDto.getDeptNo());
		stmt.setString(2, departmentDto.getDeptName());
		
		int row = stmt.executeUpdate();
		
		stmt.close();
        conn.close();
        
		return row;
	}
	
	public int deleteDepartment(DepartmentDto departmentDto) throws Exception {
		Connection conn = DBConnection.getConnection();
		
		String sql = "DELETE FROM departments WHERE dept_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, departmentDto.getDeptNo());
		
		int row = stmt.executeUpdate();
		
		stmt.close();
        conn.close();
        
		return row;
	}
	
	public int updateDepartment(DepartmentDto departmentDto) throws Exception {
		Connection conn = DBConnection.getConnection();
		
		String sql = "UPDATE departments SET dept_name=? WHERE dept_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, departmentDto.getDeptName());
		stmt.setString(2, departmentDto.getDeptNo());
		
		int row = stmt.executeUpdate();
		
		stmt.close();
        conn.close();
        
		return row;
	}
	
	public List<Map<String, Object>> selectDepartmentAndManagerList(int startRow, int rowPerPage, String deptName) throws Exception {
		//년수 초기화(기본값)
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";
		String whereDept = (deptName != null && !deptName.trim().isEmpty())
	            ? " AND d.dept_name = ?"
	            : "";
		
		
		sql = "SELECT d.dept_no deptNo, d.dept_name deptName, dm.emp_no empNo"
				+ ", e.first_name firstName, e.last_name lastName"
				+ " FROM departments d"
				+ " LEFT JOIN dept_manager dm ON d.dept_no = dm.dept_no AND dm.to_date = ?"
				+ " LEFT JOIN employees e ON dm.emp_no = e.emp_no"
		        + whereDept
				+ " ORDER BY d.dept_no ASC"
				+ " LIMIT ?, ?";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		
		int idx = 1;
	    stmt.setString(idx++, "9999-01-01");
	    if (!whereDept.isEmpty()) stmt.setString(idx++, deptName.trim());
	    stmt.setInt(idx++, startRow);
	    stmt.setInt(idx, rowPerPage);

		rs = stmt.executeQuery();
		while(rs.next()) {
			Map<String, Object> m = new HashMap<>();
			m.put("deptNo", rs.getString("deptNo"));
			m.put("deptName", rs.getString("deptName"));
			m.put("empNo", rs.getString("empNo"));
			m.put("name", rs.getString("firstName") + " " + rs.getString("lastName"));
			list.add(m);
		}
		
		rs.close();
        stmt.close();
        conn.close();
		
        return list;
	}
	
	//정보 하나 조회
	public DepartmentDto selectDepartment(String key) throws Exception {
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT dept_no, dept_name FROM departments WHERE dept_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);	
		stmt.setString(1, key);
		ResultSet rs = stmt.executeQuery();
		
		DepartmentDto dto = null;
		if (rs.next()) {
			dto = new DepartmentDto();
			dto.setDeptNo(rs.getString("dept_no")); 
			dto.setDeptName(rs.getString("dept_name"));
		}
		
		rs.close();
        stmt.close();
        conn.close();
        
		return dto;
	}
	public List<DepartmentDto> selectDepartmentList() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employees", "root", "java1234");
		String sql = "select dept_no, dept_name from departments order by dept_no asc";
		PreparedStatement stmt = conn.prepareStatement(sql);
				
		ResultSet rs = stmt.executeQuery();
		List<DepartmentDto> list = new ArrayList<DepartmentDto>();
		while(rs.next()) {
			DepartmentDto d = new DepartmentDto();
			d.setDeptNo(rs.getString("dept_no"));
			d.setDeptName(rs.getString("dept_name"));
			list.add(d);
		}
		return list;
	}
	
	//정보 전체 조회
	public List<DepartmentDto> selectDepartmentListByPage(String deptName, int startRow, int rowPerPage) throws Exception{
		Connection conn = DBConnection.getConnection();	
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<DepartmentDto> list = new ArrayList<>();
		
		String sql = "";
		if(deptName == null || deptName.equals("")) {
			sql = "SELECT dept_no, dept_name"
					+ " FROM departments"
					+ " ORDER BY dept_no DESC"
					+ " LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		} else { 
			sql = "SELECT dept_no, dept_name"
					+ " FROM departments"
					+ " WHERE dept_name LIKE ?"
					+ " ORDER BY dept_no DESC"
					+ " LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + deptName + "%");
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
		}
		
		rs = stmt.executeQuery();
		while(rs.next()) {
			DepartmentDto d = new DepartmentDto();
			d.setDeptNo(rs.getString("dept_no"));
			d.setDeptName(rs.getString("dept_name"));
			list.add(d);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	//총 개수(카운트) 메서드
	public int selectDepartmentAndManagerTotalCount(String deptName) throws Exception {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    int total = 0;

	    String whereDept = (deptName != null && !deptName.trim().isEmpty())
	            ? " AND d.dept_name = ?"
	            : "";

	    String sql =
	        "SELECT COUNT(*) AS cnt " +
	        "FROM departments d " +
	        "INNER JOIN dept_manager dm ON d.dept_no = dm.dept_no " +
	        "INNER JOIN employees e ON dm.emp_no = e.emp_no " +
	        "WHERE dm.to_date = ? " +
	        whereDept;

	    conn = DBConnection.getConnection();
	    stmt = conn.prepareStatement(sql);

	    int idx = 1;
	    stmt.setString(idx++, "9999-01-01");
	    if (!whereDept.isEmpty()) stmt.setString(idx++, deptName.trim());

	    rs = stmt.executeQuery();
	    if (rs.next()) total = rs.getInt("cnt");

	    rs.close();
	    stmt.close();
	    conn.close();
	    
	    return total;
	}

	// 마지막 페이지 계산 메서드
	public int getLastPage(String deptName, int rowPerPage) throws Exception {
	    int totalCount = this.selectDepartmentAndManagerTotalCount(deptName); // ★ 여기 바꿈
	    int lastPage = totalCount / rowPerPage;
	    if (totalCount % rowPerPage != 0) lastPage += 1;
	    return lastPage == 0 ? 1 : lastPage; // 데이터 0건일 때 1페이지로 표시하려면
	}

}