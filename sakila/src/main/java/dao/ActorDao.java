package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class ActorDao {
	// 배우 리스트 페이징 조회
	public List<Map<String, Object>> selectActorListByPage(int startRow, int rowPerPage){
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Map<String, Object>> list = new ArrayList<>();
		
		String sql = "SELECT"
					+ " a.actor_id actorId, a.first_name firstName"
					+ ", a.last_name lastName, a.last_update lastUpdate"
					+ " FROM actor e"
					+ " LEFT HOIN "
		
		return null;	
	}
}
