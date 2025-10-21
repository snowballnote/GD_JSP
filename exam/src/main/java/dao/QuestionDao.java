package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.Question;
import util.DBConnection;

public class QuestionDao {
	public List<Map<String, Object>> questionListByCategory(int categoryId) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
						SELECT 
							qe.question_id questionId
							, qe.category_id categoryId
							, qe.question_no questionNo
							, qe.question_title questionTitle
							, qe.question_answer questionAnswer
							, qe.createdate createdate
							, qe.teacher_id teacherId
							, t.items items
						FROM
						question qe INNER JOIN
						(SELECT q.question_id, GROUP_CONCAT(i.item_title) items
						FROM question q INNER JOIN item i
						ON q.question_id = i.question_id
						WHERE q.category_id=?
						GROUP BY q.question_id) t
						ON qe.question_id = t.question_id 
				""";
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryId);
		
		rs = stmt.executeQuery();
		List<Map<String, Object>> list = new ArrayList();
        while(rs.next()) {
        	Map<String, Object> m = new HashMap<>();
        	m.put("questionId", rs.getInt("questionId"));
        	m.put("categoryId", rs.getInt("categoryId"));
        	m.put("questionNo", rs.getInt("questionNo"));
        	m.put("questionTitle", rs.getString("questionTitle"));
        	m.put("questionAnswer", rs.getInt("questionAnswer"));
        	m.put("createdate", rs.getString("createdate"));
        	m.put("tacherId", rs.getInt("teacherId"));
        	m.put("items", rs.getInt("items"));
        	list.add(m);
        }
        
		return list;
	}
	
	// return : 실행된 행의 수, 생성된 키값(question_id)
	public Map<String, Integer> insertQuestion(Question q) throws Exception {
		int row = 0;
		int questionId = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null; //입력 후 자동으로 생성된 key값을 받을 결과셋(RETURN_GENERATED_KEYS)
		String sql = """
						INSERT INTO question(
							category_id, question_no, question_title, question_answer, teacher_id
						) VALUES (?, ?, ?, ?, ?)
				""";
		conn = DBConnection.getConnection();
		stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
		// ?,?,?,?,?
		stmt.setInt(1, q.getCategoryId());
		stmt.setInt(2, q.getQuestionNo());
		stmt.setString(3, q.getQuestionTitle());
		stmt.setInt(4, q.getQuestionAnswer());
		stmt.setInt(5, q.getTeacherId());
		
		row = stmt.executeUpdate();
		
		// insert 시 생성된 auto_increment key값을 반환받을 때 사용
		rs = stmt.getGeneratedKeys(); // PreparedStatement.RETURN_GENERATED_KEYS
		if(rs.next()) {
			questionId = rs.getInt(1);
			
		}
		Map<String, Integer> m = new HashMap<String, Integer>();
		m.put("row", row); // 실행된 행의 수
		m.put("questionId", questionId); // 생성된 키값(question_id)
		
		stmt.close();
		conn.close();
		return m;
	}
}
