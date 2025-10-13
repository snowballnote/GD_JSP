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
	
	//전체 게시글 개수 조회
	public int selectDepartmentTotalCount(String deptName) throws Exception {
		Connection conn = DBConnection.getConnection();
		PreparedStatement stmt = null;
	    ResultSet rs = null;
	    int totalCount = 0;
		
		// 카테고리별 조회 or 전체 조회
	    String sql = "";
		if(deptName == null || deptName.equals("")) {
			sql = "SELECT count(*) FROM departments";
			stmt = conn.prepareStatement(sql);
		} else {
			sql = "SELECT count(*) FROM departments WHERE dept_name LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + deptName + "%");
		}
		
		rs = stmt.executeQuery();
		if(rs.next()) {
			totalCount = rs.getInt("count(*)"); // 전체 행 개수 가져오기
		}
		
		rs.close();
        stmt.close();
        conn.close();
        
		return totalCount;
	}

	/* ======================= [마지막 페이지 계산 메서드] ======================= */
	public int getLastPage(String deptName, int rowPerPage) throws Exception {
		// 전체글 수 구하기
		int totalCount = this.selectDepartmentTotalCount(deptName);
		
		// 페이지 계산
		int lastPage = totalCount / rowPerPage;
		if(totalCount % rowPerPage != 0) { // 나머지가 있으면 한 페이지 추가
			lastPage += 1;
		}
		
		return lastPage;
	}

}