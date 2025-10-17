package dao;

import java.sql.*;
import java.util.*;

import util.DBConnection;

public class InventoryDao {
	public int selectInventoryTotalCount() throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalCount = 0;

		String sql = "SELECT COUNT(*) FROM inventory";

		conn = DBConnection.getConnection(); // DB 연결
		stmt = conn.prepareStatement(sql);   // SQL 실행 준비
		rs = stmt.executeQuery();            // 쿼리 실행 → 결과 저장

		if (rs.next()) {
			totalCount = rs.getInt(1); // 첫 번째 컬럼값
		}

		rs.close();
		stmt.close();
		conn.close();

		return totalCount;
	}
	
	public List<Map<String, Object>> selectInventoryList(int startRow, int rowPerPage) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Map<String, Object>> list = new ArrayList<>();
		
		String sql = "SELECT i.inventory_id inventoryId, f.title title"
					+ ", 	CASE WHEN t.return_date IS NULL AND t.rental_id IS NOT NULL THEN t.rental_id"
					+ " 	ELSE NULL END rentalId"
					+ ", 	CASE WHEN t.return_date IS NULL AND t.rental_id IS NOT NULL THEN '대여불가'"
					+ " 	ELSE '대여가능' END 대여"
					+ " FROM inventory i INNER JOIN film f"
					+ " ON i.film_id = f.film_id"
					+ " LEFT OUTER JOIN (SELECT rental_id, inventory_id, rental_date, return_date"
					+ "					FROM rental"
					+ "					WHERE (inventory_id, rental_date)"
					+ "						IN (SELECT inventory_id, MAX(rental_date)"
					+ "							FROM rental"
					+ "							GROUP BY inventory_id)) t"
					+ " ON i.inventory_id = t.inventory_id"
					+ " ORDER BY i.inventory_id ASC"
					+ " LIMIT ?, ?";
		conn = DBConnection.getConnection();

		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("inventoryId", rs.getInt("inventoryId"));
			m.put("title", rs.getString("title"));
			m.put("rentalId", rs.getInt("rentalId"));
			m.put("대여", rs.getString("대여"));
			list.add(m);
		}

		rs.close();
		stmt.close();
		conn.close();
		
		return list;	
	}
}
