// dao/FilmDao.java
package dao;

import java.sql.*;
import java.util.*;
import util.DBConnection;

public class FilmDao {
	// 1) 전체 영화 개수 조회
	//  - film 테이블 전체 행 수를 구함
	//  - COUNT(*) 결과를 int로 반환
	public int selectFilmTotalCount() throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalCount = 0;

		String sql = "SELECT COUNT(*) FROM film";

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


	// 2) 영화 리스트 페이징 조회
	//  - LIMIT ?, ?로 구간 지정
	//  - FilmDto 리스트 형태로 반환
	public List<Map<String, Object>> selectFilmListByPage(int startRow, int rowPerPage) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Map<String, Object>> list = new ArrayList<>();

		String sql = "SELECT"
					+ " ff.film_id filmId, ff.title title"
					+ ", ff.description description, ff.release_year releaseYear"
					+ ", ff.rental_duration rentalDuration, ff.rental_rate rentalRate"
					+ ", ff.length length, ff.replacement_cost replacementCost"
					+ ", ff.rating rating, ff.last_update lastUpdate"
					+ ", l.name languageName"
					+ ", ifnull(t2.cnt, 0) actorCount, ifnull(t2.names, '출연배우 없음') actorNames"
					+ " FROM film ff"
					+ " 	LEFT OUTER JOIN"
					+ " 	(SELECT f.film_id, COUNT(*) cnt, GROUP_CONCAT(t.name) names"
					+ " 	FROM film f INNER JOIN"
					+ "			(SELECT fa.film_id , fa.actor_id, CONCAT(a.first_name,' ', a.last_name) name"
					+ "			FROM actor a INNER JOIN film_actor fa"
					+ "			ON a.actor_id = fa.actor_id) t"
					+ " 	ON f.film_id = t.film_id"
					+ " 	GROUP BY f.film_id) t2"
					+ " 	ON ff.film_id = t2.film_id"
					+ "		INNER JOIN language l"
					+ "		ON ff.language_id = l.language_id"
					+ " ORDER BY ff.film_id ASC"
					+ " LIMIT ?, ?";

		conn = DBConnection.getConnection();

		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);   // 시작 행
		stmt.setInt(2, rowPerPage); // 출력 행 수

		rs = stmt.executeQuery();

		while (rs.next()) {
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("filmId", rs.getInt("filmId"));
			m.put("title", rs.getString("title"));
			m.put("description", rs.getString("description"));
			m.put("releaseYear", rs.getString("releaseYear"));
			//m.put("rentalDuration", rs.getInt("rentalDuration"));
			m.put("rentalRate", rs.getBigDecimal("rentalRate"));
			m.put("replacementCost", rs.getInt("replacementCost"));
			m.put("length", rs.getBigDecimal("length"));
			m.put("rating", rs.getString("rating"));
			m.put("actorNames", rs.getString("actorNames"));
			m.put("lastUpdate", rs.getString("lastUpdate"));
			list.add(m);
		}

		rs.close();
		stmt.close();
		conn.close();

		return list;
	}
}
