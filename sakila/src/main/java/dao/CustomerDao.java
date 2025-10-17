package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import dto.Customer;
import util.DBConnection;

public class CustomerDao {
	public List<Customer> selectCustomerListByName(String searchName) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT customer_id customerId, first_name firstName, last_name lastName"
				+ " FROM customer"
				+ " WHERE LOWER(first_name) LIKE ?"
				+ " OR LOWER(last_name) LIKE ?";
		
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchName+"%");
		stmt.setString(2, "%"+searchName+"%");
		rs = stmt.executeQuery();
		List<Customer> list = new ArrayList<Customer>();
		while(rs.next()) {
			Customer c = new Customer();
			c.setCustomerId(rs.getInt("customerId"));
			c.setFirstName(rs.getString("firstName"));
			c.setLastName(rs.getString("lastName"));
			list.add(c);
		}
		return list;
	}
}
