package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CounterDao {
	
	public Integer selectToday() throws Exception {
		// SELECT counter_num FROM counter WHERE counter_date = CURDATE()
		Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Integer todayCount = null;
        
        String sql = "SELECT counter_num counterNum FROM counter WHERE counter_date = CURDATE()";
        
        conn = DBConnection.getConnection();
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        if(rs.next()) {
        	todayCount = rs.getInt("counterNum");
        }
        
        rs.close();
		stmt.close();
		conn.close();
		return todayCount;
	}
	
	public Integer selectTotal() throws Exception {
		// SELECT COUNT(counter_num) cnt FROM counter
		Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Integer cnt = null;
        
        String sql = "SELECT COUNT(counter_num) cnt FROM counter";
        
        conn = DBConnection.getConnection();
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        if(rs.next()) {
        	cnt = rs.getInt("cnt");
        }
        
        rs.close();
		stmt.close();
		conn.close();
		return cnt;
	}
	
	// 오늘 날짜의 데이터(카운드)가 없으면 인서트 되야함
	public Integer insertCounter() throws Exception { 
		// INSERT INTO counter(counter_date, counter_num) VALUES(CURDATE(), 1)
		Connection conn = null;
        PreparedStatement stmt = null;
        
        String sql = "INSERT INTO counter(counter_date, counter_num) VALUES(CURDATE(), 1)";
        
        conn = DBConnection.getConnection();
        stmt = conn.prepareStatement(sql);
        
        Integer row = stmt.executeUpdate();
        
		stmt.close();
		conn.close();
		return row;
	}
	
	// 오늘 날짜의 데이터(카운트)가 있으면
	public Integer updateCounter() throws Exception { 
		// UPDATE counter SET counter_num = counter_num + 1 WHERE counter_date = CURDATE()
		Connection conn = null;
        PreparedStatement stmt = null;
        
        String sql = "UPDATE counter SET counter_num = counter_num + 1 WHERE counter_date = CURDATE()";
        
        conn = DBConnection.getConnection();
        stmt = conn.prepareStatement(sql);
        
        Integer row = stmt.executeUpdate();
        
		stmt.close();
		conn.close();
		return row;

	}
}
