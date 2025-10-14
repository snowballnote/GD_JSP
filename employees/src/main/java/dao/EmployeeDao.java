package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import util.DBConnection;

public class EmployeeDao {
	// 부서별 사원리스트
	public List<Map<String, Object>> selectEmployeeListByPageAndDepName(int startRow, int rowPerPage, String[] deptNames) throws Exception {
				// 변수 초기화(기본값)
				List<Map<String, Object>> list = new ArrayList<>();
				Connection conn = null;
				PreparedStatement stmt = null;
				ResultSet rs = null;
				String sql = "";
				
				// Where d.dept_name in (?, ?, ?, ?)
				String whereQuery = "?";
				for(int i = 0; i < deptNames.length-1; i++) {
					whereQuery = whereQuery + "?,"; //?,?
				}
				
				sql = "SELECT"
					+ " e.emp_no empNo, e.birth_date birthDate"
					+ ", e.first_name firstName, e.last_name lastName"
					+ ", e.gender, e.hire_date hireDate"
					+ ", d.dept_no deptNo, d.dept_name deptName"
					+ " FROM employees e "
					+ " INNER JOIN dept_emp de ON e.emp_no = de.emp_no"
					+ " INNER JOIN departments d ON de.dept_no = d.dept_no"
					+ " WHERE d.dept_name in("+whereQuery+")"
					+ " ORDER BY e.emp_no DESC"
					+ " LIMIT ?, ?";
					
				conn = DBConnection.getConnection();
				stmt = conn.prepareStatement(sql); // ?, ?
				stmt.setInt(1, startRow);
				stmt.setInt(2, rowPerPage);
				rs = stmt.executeQuery();
				
				while(rs.next()) {
					Map<String, Object> m = new HashMap<String, Object>();
					m.put("empNo", rs.getInt("empNo"));
					m.put("birthDate", rs.getString("birthDate"));
					m.put("name", rs.getString("firstName") + " " + rs.getString("lastName"));
					m.put("gender", rs.getString("gender"));
					m.put("hireDate", rs.getString("hireDate"));
					m.put("deptNo", rs.getString("deptNo"));
					m.put("deptName", rs.getString("deptName"));
					list.add(m);
				}
				
				rs.close();
				stmt.close();
				conn.close();
				return list;
			}	
	// 4)
	public List<Map<String, Object>> selectEmployeeListByPageAndSearchNameAndEmpNoRange(
			int startRow, int rowPerPage, String searchName, int fromEmpNo, int toEmpNo) throws Exception{
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";

		sql = "SELECT"
			+ " e.emp_no empNo, e.birth_date birthDate"
			+ ", e.first_name firstName, e.last_name lastName"
			+ ", e.gender, e.hire_date hireDate"
			+ ", d.dept_no deptNo, d.dept_name deptName"
			+ " FROM employees e"
			+ " INNER JOIN dept_emp de ON e.emp_no = de.emp_no"
			+ " INNER JOIN departments d ON de.dept_no = d.dept_no"
			+ " WHERE (e.first_name LIKE ? OR e.last_name LIKE ?)" //우선순위 바뀔 수 있으니 AND OR같이 쓸때는 우선순위 주고 싶은 코드에 괄호치기
			+ " AND e.emp_no BETWEEN ? AND ?"
			+ " ORDER BY e.emp_no DESC"
			+ " LIMIT ?, ?";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + searchName + "%");
		stmt.setString(2, "%" + searchName + "%");
		stmt.setInt(3, fromEmpNo);
		stmt.setInt(4, toEmpNo);
		stmt.setInt(5, startRow);
		stmt.setInt(6, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("empNo", rs.getInt("empNo"));
			m.put("birthDate", rs.getString("birthDate"));
			m.put("name", rs.getString("firstName") + " " + rs.getString("lastName"));
			m.put("gender", rs.getString("gender"));
			m.put("hireDate", rs.getString("hireDate"));
			m.put("deptNo", rs.getString("deptNo"));
			m.put("deptName", rs.getString("deptName"));
			list.add(m);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// 3) 사원 범위 범위 조건
	public List<Map<String, Object>> selectEmployeeListByPageAndEmpNoRange(int startRow, int rowPerPage, int fromEmpNo, int toEmpNo) throws Exception{
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";

		sql = "SELECT"
			+ " e.emp_no empNo, e.birth_date birthDate"
			+ ", e.first_name firstName, e.last_name lastName"
			+ ", e.gender, e.hire_date hireDate"
			+ ", d.dept_no deptNo, d.dept_name deptName"
			+ " FROM employees e"
			+ " INNER JOIN dept_emp de ON e.emp_no = de.emp_no"
			+ " INNER JOIN departments d ON de.dept_no = d.dept_no"
			+ " WHERE e.emp_no BETWEEN ? AND ?"
			+ " ORDER BY e.emp_no DESC"
			+ " LIMIT ?, ?";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, fromEmpNo);
		stmt.setInt(2, toEmpNo);
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("empNo", rs.getInt("empNo"));
			m.put("birthDate", rs.getString("birthDate"));
			m.put("name", rs.getString("firstName") + " " + rs.getString("lastName"));
			m.put("gender", rs.getString("gender"));
			m.put("hireDate", rs.getString("hireDate"));
			m.put("deptNo", rs.getString("deptNo"));
			m.put("deptName", rs.getString("deptName"));
			list.add(m);

		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}	
	// 2) 사원 이름(first_name + last_name) 검색 목록
	public List<Map<String, Object>> selectEmployeeListByPageAndSearchName(int startRow, int rowPerPage, String searchName) throws Exception{
		// 변수 초기화(기본값)
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";

		sql = "SELECT"
			+ " e.emp_no empNo, e.birth_date birthDate"
			+ ", e.first_name firstName, e.last_name lastName"
			+ ", e.gender, e.hire_date hireDate"
			+ ", d.dept_no deptNo, d.dept_name deptName"
			+ " FROM employees e"
			+ " INNER JOIN dept_emp de ON e.emp_no = de.emp_no"
			+ " INNER JOIN departments d ON de.dept_no = d.dept_no"
			+ " WHERE e.first_name LIKE ? OR e.last_name LIKE ?"
			+ " ORDER BY e.emp_no DESC"
			+ " LIMIT ?, ?";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + searchName + "%");
		stmt.setString(2, "%" + searchName + "%");
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("empNo", rs.getInt("empNo"));
			m.put("birthDate", rs.getString("birthDate"));
			m.put("name", rs.getString("firstName") + " " + rs.getString("lastName"));
			m.put("gender", rs.getString("gender"));
			m.put("hireDate", rs.getString("hireDate"));
			m.put("deptNo", rs.getString("deptNo"));
			m.put("deptName", rs.getString("deptName"));
			list.add(m);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// 1) 기본 사원 목록 - 조인쿼리는 일반적인 DTO(LIST)로 담을 수 없다. DTO대신 Map타입을 사용
		public List<Map<String, Object>> selectEmployeeListByPage(int startRow, int rowPerPage) throws Exception {
			// 변수 초기화(기본값)
			List<Map<String, Object>> list = new ArrayList<>();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = "";
			
			sql = "SELECT"
				+ " e.emp_no empNo, e.birth_date birthDate"
				+ ", e.first_name firstName, e.last_name lastName"
				+ ", e.gender, e.hire_date hireDate"
				+ ", d.dept_no deptNo, d.dept_name deptName"
				+ " FROM employees e "
				+ "INNER JOIN dept_emp de ON e.emp_no = de.emp_no"
				+ " INNER JOIN departments d ON de.dept_no = d.dept_no"
				+ " ORDER BY e.emp_no DESC"
				+ " LIMIT ?, ?"; 
				
			conn = DBConnection.getConnection();
			stmt = conn.prepareStatement(sql); // ?, ?
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("empNo", rs.getInt("empNo"));
				m.put("birthDate", rs.getString("birthDate"));
				m.put("name", rs.getString("firstName") + " " + rs.getString("lastName"));
				m.put("gender", rs.getString("gender"));
				m.put("hireDate", rs.getString("hireDate"));
				m.put("deptNo", rs.getString("deptNo"));
				m.put("deptName", rs.getString("deptName"));
				list.add(m);
			}
			
			rs.close();
			stmt.close();
			conn.close();
			return list;
		}
	
	// 전체 게시글 개수 조회
	public int selectEmployeeTotalCount(Integer empNo) throws Exception {
	    Connection conn = DBConnection.getConnection();
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    int totalCount = 0;

	    String sql;
	    if (empNo == null) {
	        sql = "SELECT COUNT(*) AS cnt FROM employees";
	        stmt = conn.prepareStatement(sql);
	    } else {
	        sql = "SELECT COUNT(*) AS cnt FROM employees WHERE emp_no LIKE ?";
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, "%" + empNo + "%");
	    }

	    rs = stmt.executeQuery();
	    if (rs.next()) {
	        totalCount = rs.getInt("cnt"); // 별칭으로 컬럼명 명확하게
	    }

	    rs.close();
	    stmt.close();
	    conn.close();

	    return totalCount;
	}

	// 마지막 페이지 계산 메서드
	public int getLastPage(Integer empNo, int rowPerPage) throws Exception {
	    
		int totalCount = this.selectEmployeeTotalCount(empNo);

	    int lastPage = totalCount / rowPerPage;
	    if (totalCount % rowPerPage != 0) {
	        lastPage += 1;
	    }

	    return lastPage;
	}
}
