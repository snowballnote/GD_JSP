package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import dto.Item;
import util.DBConnection;

public class ItemDao {
	public  int insertItem(Item item) throws Exception{
		int row = 0;
        Connection conn = null;
        PreparedStatement stmt = null;

        String sql = """
        				INSERT INTO item (
        		        question_id, item_idx, item_title, createdate
        				) VALUES (?, ?, ?, NOW())
        		""";

        conn = DBConnection.getConnection();
        stmt = conn.prepareStatement(sql);

        stmt.setInt(1, item.getQuestionId());
		stmt.setInt(2, item.getItemIdx());
		stmt.setString(3, item.getItemTitle());
		
		row = stmt.executeUpdate();

        stmt.close();
        conn.close();
        return row; // 총 삽입 개수
	}
}
