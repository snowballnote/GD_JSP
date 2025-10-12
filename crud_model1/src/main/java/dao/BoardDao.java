package dao;
import java.util.*;
import dto.*;
import java.sql.*;

// Board 테이블을 다루는 DAO 클래스
public class BoardDao {	

	/* ======================= [게시글 수정] ======================= */
	// updateBoardAction.jsp에서 호출
	// 전달받은 BoardDto 객체의 내용을 이용해 특정 게시글을 수정
	public int updateBoard(BoardDto boardDto) throws ClassNotFoundException, SQLException {
		// 1. JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		// 2. DB 연결
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		
		// 3. SQL문 작성
		String sql = "UPDATE board"
					+ " SET board_district=?, board_title=?, board_content=?"
					+ " WHERE board_no=?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// 4. ? 값 세팅
		stmt.setString(1, boardDto.getBoardDistrict());
		stmt.setString(2, boardDto.getBoardTitle());
		stmt.setString(3, boardDto.getBoardContent());
		stmt.setInt(4, boardDto.getBoardNo());
		
		// 5. SQL 실행
		int row = stmt.executeUpdate();
		System.out.println("BoardDao.updateBoard row:" + row);
		
		// 6. 수정된 행 수 반환 (1이면 성공)
		return row;
	}
	
	
	/* ======================= [게시글 상세보기] ======================= */
	// boardOne.jsp, updateBoardForm.jsp 에서 사용
	public BoardDto selectBoardOne(int boardNo) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		
		String sql = "SELECT board_no, board_district, board_title, board_content, board_writer, createdate "
					+ "FROM board WHERE board_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		
		System.out.println("stmt: " + stmt.toString());
		
		ResultSet rs = stmt.executeQuery();
		BoardDto boardDto = null;
		
		// 결과가 있을 경우 BoardDto 객체에 값 채워넣기
		if(rs.next()){
			boardDto = new BoardDto(); 
			boardDto.setBoardNo(rs.getInt("board_no"));
			boardDto.setBoardDistrict(rs.getString("board_district"));
			boardDto.setBoardTitle(rs.getString("board_title"));
			boardDto.setBoardContent(rs.getString("board_content"));
			boardDto.setBoardWriter(rs.getString("board_writer"));
			boardDto.setCreatedate(rs.getString("createdate"));		
		}	
		
		System.out.println(boardDto.toString());
		return boardDto;
	}
	
	
	/* ======================= [게시글 삭제] ======================= */
	// deleteBoardAction.jsp 에서 사용
	public int deleteBoard(BoardDto boardDto) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		
		String sql = "DELETE FROM board WHERE board_no=? AND board_writer=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, boardDto.getBoardNo());
		stmt.setString(2, boardDto.getBoardWriter());
		
		int row = stmt.executeUpdate();
		System.out.println("BoardDao.deleteBoard row:" + row);
		return row;  // 삭제된 행 수 반환
	}
	
	
	/* ======================= [게시글 작성] ======================= */
	public int insertBoard(BoardDto boardDto) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		
		String sql = "INSERT INTO board(board_district, board_title, board_content, board_writer)"
					+ " VALUES(?, ?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, boardDto.getBoardDistrict());
		stmt.setString(2, boardDto.getBoardTitle());
		stmt.setString(3, boardDto.getBoardContent());
		stmt.setString(4, boardDto.getBoardWriter());
		
		int row = stmt.executeUpdate();
		return row; // 성공 시 1 반환
	}
	
	
	/* ======================= [게시글 목록 페이징 조회] ======================= */
	public List<BoardDto> selectBoardListByPage(String boardDistrict, int startRow, int rowPerPage) 
			throws ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";
		
		// boardDistrict가 null이면 전체 게시글 조회
		if(boardDistrict == null) {
			sql = "SELECT board_no, board_district, board_title"
				+ " FROM board"
				+ " ORDER BY board_no DESC"
				+ " LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		} else { 
			// 특정 카테고리(boardDistrict)에 해당하는 게시글만 조회
			sql = "SELECT board_no, board_district, board_title"
				+ " FROM board"
				+ " WHERE board_district = ?"
				+ " ORDER BY board_no DESC"
				+ " LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, boardDistrict);
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
		}
		
		rs = stmt.executeQuery();
		List<BoardDto> list = new ArrayList<BoardDto>();
		
		// 결과값을 BoardDto 리스트로 변환
		while(rs.next()) {
			BoardDto b = new BoardDto();
			b.setBoardNo(rs.getInt("board_no"));
			b.setBoardDistrict(rs.getString("board_district"));
			b.setBoardTitle(rs.getString("board_title"));
			list.add(b);
		}
		
		return list;
	}
	
	
	/* ======================= [전체 게시글 개수 조회] ======================= */
	public int selectBoardTotalCount(String boardDistrict) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		
		String sql = "";
		PreparedStatement stmt = null;
		
		// 카테고리별 조회 or 전체 조회
		if(boardDistrict == null) {
			sql = "SELECT count(*) FROM board";
			stmt = conn.prepareStatement(sql);
		} else {
			sql = "SELECT count(*) FROM board WHERE board_district = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, boardDistrict);
		}
		
		ResultSet rs = stmt.executeQuery();
		int totalCount = 0;
		
		if(rs.next()) {
			totalCount = rs.getInt("count(*)"); // 전체 행 개수 가져오기
		}
		
		return totalCount;
	}
	
	
	/* ======================= [마지막 페이지 계산 메서드] ======================= */
	public int getLastPage(String boardDistrict, int rowPerPage) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		
		// 전체 게시글 수 구하기
		int totalCount = this.selectBoardTotalCount(boardDistrict);
		
		// 페이지 계산
		lastPage = totalCount / rowPerPage;
		if(totalCount % rowPerPage != 0) { // 나머지가 있으면 한 페이지 추가
			lastPage += 1;
		}
		
		return lastPage;
	}
}