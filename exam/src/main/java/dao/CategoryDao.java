package dao;

import java.sql.*;
import java.util.*;
import dto.*;
import util.DBConnection;

public class CategoryDao {
	// 단건 조회
	public Category selectCategoryOne (int categorId) {
		
	}
	// 카테고리 목록 조회(페이징)
	public List<Category> selectCategoryList(int startRow, int rowPerPage) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Category> list = new ArrayList<>();
		
		String sql = "SELECT"
					+ " 	category_id categoryId"
					+ ", 	exam_date examDate"
					+ ", 	createdate createdate"
					+ " FROM category"
					+ " ORDER BY category_id ASC"
					+ " LIMIT ?, ?";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
        stmt.setInt(2, rowPerPage);
        
        rs = stmt.executeQuery();
        while(rs.next()) {
        	Category c = new Category();
        	c.setCategoryId(rs.getInt("categoryId"));
        	c.setExamDate(rs.getString("examDate"));
        	c.setCreatedate(rs.getString("createdate"));
        	list.add(c);
        }
        
        rs.close();
		stmt.close();
		conn.close();
		return list;		
	}
	
	//전체 카테고리 개수 조회
	public int selectCategoryTotalCount() throws Exception {
		Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int totalCount = 0;
        
        String sql = "SELECT COUNT(*) cnt FROM category";
        
        conn = DBConnection.getConnection();
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        if(rs.next()) {
        	totalCount = rs.getInt("cnt");
        }
        
        rs.close();
		stmt.close();
		conn.close();
		return totalCount;
	}
	
	// 입력, 가장 큰 ID 조회 후 +1
	public int selectMaxCategoryId() throws Exception {
		Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int maxId = 0;
        
        String sql = "SELECT IFNULL(MAX(category_id), 0) maxId FROM category";
        
        conn = DBConnection.getConnection();
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        if(rs.next()) {
        	maxId = rs.getInt("maxId");
        }
    	
        rs.close();
		stmt.close();
		conn.close();
		return maxId;
	}
	
	// 삽입
	public int insertCategory(Category c) throws Exception {
		Connection conn = null;
        PreparedStatement stmt = null;
        
        String sql = "INSERT INTO category(category_id, exam_date, createdate)"
        			+ " VALUES(?, ?, NOW())";
        
        conn = DBConnection.getConnection();
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, c.getCategoryId());
        stmt.setString(2, c.getExamDate());
        
        int row = stmt.executeUpdate();
        
        stmt.close();
        conn.close();
		return row;
	}
	
	// 수정
	// 응시자가 없을때
	public int updateCategory(Category c) throws Exception {
		Connection conn = DBConnection.getConnection();
		
		String sql = "UPDATE category c"
				+ " SET c.exam_date=?"
				+ " WHERE c.category_id=?"
				+ " AND NOT EXISTS (SELECT 1 FROM exam e WHERE e.category_id = c.category_id)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, c.getExamDate());
		stmt.setInt(2, c.getCategoryId());
		
		int row = stmt.executeUpdate();
		
		stmt.close();
        conn.close();
		return row;
	}
	
	// 삭제
	// 시험 날짜 이전 & 등록된 시험 문제가 없을때 & 응시자가 없을때
	public int deleteCategory(Category c) throws Exception {
		Connection conn = DBConnection.getConnection();
		
		String sql = "DELETE FROM category c"
					+ " WHERE c.category_id=?"
					+ " AND c.exam_date > NOW()"
					+ " AND NOT EXISTS (SELECT 1 FROM question q WHERE q.category_id = c.category_id)"
					+ " AND NOT EXISTS (SELECT 1 FROM exam e WHERE e.category_id = c.category_id)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, c.getCategoryId());
		
		int row = stmt.executeUpdate();
		
		stmt.close();
        conn.close();
		return row;
	}
}
