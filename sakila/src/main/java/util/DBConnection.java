package util;

import java.sql.*;

public class DBConnection {
	public static Connection getConnection() throws Exception{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila","root","java1234");
				
		return conn;	
	}
}