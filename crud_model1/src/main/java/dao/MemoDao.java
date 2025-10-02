package dao;
import java.util.*;
import dto.*;
import java.sql.*;

public class MemoDao {
	public int insertMemo(MemoDto memoDto) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		String sql = "INSERT INTO memo(memo_category, memo_title, memo_content) VALUES(?,?,?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memoDto.getMemoCategory());
		stmt.setString(2, memoDto.getMemoTitle());
		stmt.setString(3, memoDto.getMemoContent());
		int row = stmt.executeUpdate(); //1이면 입력성공 0이면 실패
		return row;
	}
	
	public List<MemoDto> selectMemoListByPage(String memoCategory, int startRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";
		
		if(memoCategory == null) {
			sql = "SELECT memo_no, memo_category, memo_title"
					+ " FROM memo"
					+ " ORDER BY memo_no DESC"
					+ " LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		} else {
			sql = "SELECT memo_no, memo_category, memo_title"
					+ " FROM memo"
					+ " WHERE memo_category = ?"
					+ " ORDER BY memo_no DESC"
					+ " LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memoCategory);
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
		}
		rs = stmt.executeQuery();

		List<MemoDto> list = new ArrayList<MemoDto>();
		while(rs.next()) {
			MemoDto m = new MemoDto();
			m.setMemoNo(rs.getInt("memo_no"));
			m.setMemoCategory(rs.getString("memo_category"));
			m.setMemoTitle(rs.getString("memo_title"));
			list.add(m);
		}
		return list;
	}
	
	public int selectMemoTotalCount(String memoCategory) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";
		
		if(memoCategory == null) {
			sql = "SELECT count(*) From memo";
			stmt = conn.prepareStatement(sql);
		}else {
			sql = "SELECT count(*) From memo WHERE memo_category = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memoCategory);
		}
		rs = stmt.executeQuery();
		int totalCount = 0;
		if(rs.next()) {
			totalCount = rs.getInt("count(*)");
		}
		
		return totalCount;
	}
	public int getLastPage(String memoCategory, int rowPerPage) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		int totalCount = this.selectMemoTotalCount(memoCategory);
		lastPage = totalCount / rowPerPage;
		if(totalCount % rowPerPage == 0) {
			lastPage = lastPage + 1;
		}
		return lastPage;
	}
}
