package dao;
import java.util.*;
import dto.*;
import java.sql.*;

//table : board
public class BoardDao {	
	//수정: updateBoardAction.jsp
	public int updateBoard(BoardDto boardDto) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		PreparedStatement stmt = null;
		String sql = "UPDATE board"
					+ " SET board_district=?, board_title=?, board_content=?"
					+ " WHERE board_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, boardDto.getBoardDistrict());
		stmt.setString(2, boardDto.getBoardTitle());
		stmt.setString(3, boardDto.getBoardContent());
		stmt.setInt(4, boardDto.getBoardNo());
		
		int row = stmt.executeUpdate();
		System.out.println("BoardDao.updateBoard row:" + row);
		return row;
	}
	
	//상세보기: boardOne.jsp, updateBoardForm.jsp
	public BoardDto selectBoardOne(int boardNo) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT board_no, board_district, board_title, board_content, board_writer, createdate FROM board WHERE board_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		System.out.println("stmt: " + stmt.toString());
		
		rs = stmt.executeQuery();
		BoardDto boardDto = null;
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
	
	//삭제: deleteBoardAction.jsp
	public int deleteBoard(BoardDto boardDto) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		PreparedStatement stmt = null;
		String sql = "DELETE FROM board WHERE board_no=? "
					+ "and board_writer=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardDto.getBoardNo());
		stmt.setString(2, boardDto.getBoardWriter());
		int row = stmt.executeUpdate();
		System.out.println("BoardDao.deleteBoard row:" + row);
		return row;
		//return stmt.executeUpdate();
	}
	
	public int insertBoard(BoardDto boardDto) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		PreparedStatement stmt = null;
		String sql = "INSERT INTO board(board_district, board_title, board_content, board_writer)"
					+ " VALUES(?, ?, ?, ?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, boardDto.getBoardDistrict());
		stmt.setString(2, boardDto.getBoardTitle());
		stmt.setString(3, boardDto.getBoardContent());
		stmt.setString(4, boardDto.getBoardWriter());
		
		int row = stmt.executeUpdate();
		// row 디비깅
		
		return row;
	}

	public List<BoardDto> selectBoardListByPage(
			String boardDistrict, int startRow, int rowPerPage) 
					throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";
		
		if(boardDistrict == null) {
			sql = "SELECT board_no, board_district, board_title"
					+ " FROM board"
					+ " ORDER BY board_no DESC"
					+ " LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		} else {
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
		while(rs.next()) {
			BoardDto b = new BoardDto();
			b.setBoardNo(rs.getInt("board_no"));
			b.setBoardDistrict(rs.getString("board_district"));
			b.setBoardTitle(rs.getString("board_title"));
			list.add(b);
		}
		return list;
	}
	
	public int selectBoardTotalCount(String boardDistrict) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";
	
		if(boardDistrict == null) {
			sql = "SELECT count(*) FROM board";
			stmt = conn.prepareStatement(sql);
		} else {
			sql = "SELECT count(*) FROM board WHERE board_district = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, boardDistrict);
		}
		rs = stmt.executeQuery();
		
		int totalCount = 0;
		if(rs.next()) {
			totalCount = rs.getInt("count(*)");
		}
		
		return totalCount;
	}
	
	public int getLastPage(String boardDistruct, int rowPerPage) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		int totalCount = this.selectBoardTotalCount(boardDistruct);
		lastPage = totalCount / rowPerPage;
		if(totalCount % rowPerPage == 0) {
			lastPage = lastPage + 1;
		}
		return lastPage;
	}
}