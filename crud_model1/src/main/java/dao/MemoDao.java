package dao;
import java.util.*;
import java.sql.*;
import dto.MemoDto;

// Memo 테이블을 다루는 DAO 클래스
public class MemoDao {	
	
	/* ======================= [메모 작성] ======================= */
	// insertMemoAction.jsp 에서 사용
	public int insertMemo(MemoDto memoDto) throws ClassNotFoundException, SQLException {
		// 1. JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		// 2. DB 연결
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1", "root", "java1234");
		
		// 3. SQL문 작성
		String sql = "INSERT INTO memo(memo_category, memo_title, memo_content)"
				   + " VALUES(?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// 4. ? 값 세팅
		stmt.setString(1, memoDto.getMemoCategory());
		stmt.setString(2, memoDto.getMemoTitle());
		stmt.setString(3, memoDto.getMemoContent());
		
		// 5. SQL 실행
		int row = stmt.executeUpdate();
		System.out.println("MemoDao.insertMemo row: " + row);
		
		// 6. 성공 시 1 반환
		return row;
	}
	
	
	/* ======================= [메모 목록 조회] ======================= */
	// memoList.jsp 에서 사용 (카테고리 + 페이징)
	public List<MemoDto> selectMemoListByPage(String memoCategory, int startRow, int rowPerPage) 
			throws ClassNotFoundException, SQLException {
		
		// 1. 드라이버 로드 및 DB 연결
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1", "root", "java1234");
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";
		
		// 2. SQL문 작성 (카테고리 필터 적용 여부)
		if(memoCategory == null) {
			sql = "SELECT memo_no, memo_category, memo_title"
				+ " FROM memo"
				+ " ORDER BY memo_no DESC"
				+ " LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		} else {
			sql = "SELECT memo_no, memo_category, memo_title"
				+ " FROM memo"
				+ " WHERE memo_category = ?"
				+ " ORDER BY memo_no DESC"
				+ " LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memoCategory);
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
		}
		
		// 3. SQL 실행
		rs = stmt.executeQuery();
		
		// 4. 결과값 → MemoDto 리스트로 변환
		List<MemoDto> list = new ArrayList<MemoDto>();
		while(rs.next()) {
			MemoDto m = new MemoDto();
			m.setMemoNo(rs.getInt("memo_no"));
			m.setMemoCategory(rs.getString("memo_category"));
			m.setMemoTitle(rs.getString("memo_title"));
			list.add(m);
		}
		
		return list;
	}
	
	
	/* ======================= [메모 상세보기] ======================= */
	// memoOne.jsp, updateMemoForm.jsp 에서 사용
	public MemoDto selectMemoOne(int memoNo) throws ClassNotFoundException, SQLException {
		// 1. 드라이버 로드 및 DB 연결
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1", "root", "java1234");
		
		// 2. SQL 작성
		String sql = "SELECT memo_no, memo_category, memo_title, memo_content, createdate"
					+ " FROM memo WHERE memo_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memoNo);
		
		// 3. SQL 실행
		ResultSet rs = stmt.executeQuery();
		MemoDto memoDto = null;
		
		// 4. 결과값을 MemoDto에 담기
		if(rs.next()) {
			memoDto = new MemoDto();
			memoDto.setMemoNo(rs.getInt("memo_no"));
			memoDto.setMemoCategory(rs.getString("memo_category"));
			memoDto.setMemoTitle(rs.getString("memo_title"));
			memoDto.setMemoContent(rs.getString("memo_content"));
			memoDto.setCreatedate(rs.getString("createdate"));
		}
		
		System.out.println("MemoDao.selectMemoOne memoDto: " + memoDto);
		return memoDto;
	}
	
	
	/* ======================= [메모 수정] ======================= */
	// updateMemoAction.jsp 에서 사용
	public int updateMemo(MemoDto memoDto) throws ClassNotFoundException, SQLException {
		// 1. JDBC 드라이버 로드 및 DB 연결
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1", "root", "java1234");
		
		// 2. SQL 작성
		String sql = "UPDATE memo"
					+ " SET memo_category=?, memo_title=?, memo_content=?"
					+ " WHERE memo_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// 3. ? 값 세팅
		stmt.setString(1, memoDto.getMemoCategory());
		stmt.setString(2, memoDto.getMemoTitle());
		stmt.setString(3, memoDto.getMemoContent());
		stmt.setInt(4, memoDto.getMemoNo());
		
		// 4. SQL 실행
		int row = stmt.executeUpdate();
		System.out.println("MemoDao.updateMemo row: " + row);
		
		return row; // 수정된 행 수 반환
	}
	
	
	/* ======================= [메모 삭제] ======================= */
	// deleteMemoAction.jsp 에서 사용
	public int deleteMemo(int memoNo) throws ClassNotFoundException, SQLException {
		// 1. 드라이버 로드 및 DB 연결
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1", "root", "java1234");
		
		// 2. SQL 작성
		String sql = "DELETE FROM memo WHERE memo_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memoNo);
		
		// 3. SQL 실행
		int row = stmt.executeUpdate();
		System.out.println("MemoDao.deleteMemo row: " + row);
		
		return row; // 삭제된 행 수 반환
	}
	
	
	/* ======================= [전체 메모 개수 조회] ======================= */
	// 페이징 계산용
	public int selectMemoTotalCount(String memoCategory) throws ClassNotFoundException, SQLException {
		// 1. JDBC 드라이버 로드 및 DB 연결
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1", "root", "java1234");
		
		String sql = "";
		PreparedStatement stmt = null;
		
		// 2. SQL 작성 (카테고리 유무에 따라 분기)
		if(memoCategory == null) {
			sql = "SELECT count(*) FROM memo";
			stmt = conn.prepareStatement(sql);
		} else {
			sql = "SELECT count(*) FROM memo WHERE memo_category = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memoCategory);
		}
		
		// 3. SQL 실행
		ResultSet rs = stmt.executeQuery();
		int totalCount = 0;
		
		// 4. 결과값 저장
		if(rs.next()) {
			totalCount = rs.getInt("count(*)");
		}
		
		return totalCount;
	}
	
	
	/* ======================= [마지막 페이지 계산] ======================= */
	public int getLastPage(String memoCategory, int rowPerPage) throws ClassNotFoundException, SQLException {
		// 1. 전체 메모 개수 조회
		int totalCount = this.selectMemoTotalCount(memoCategory);
		
		// 2. 전체 페이지 수 계산
		int lastPage = totalCount / rowPerPage;
		
		// 3. 나머지가 있으면 한 페이지 추가
		if(totalCount % rowPerPage != 0) {
			lastPage += 1;
		}
		
		System.out.println("MemoDao.getLastPage lastPage: " + lastPage);
		return lastPage;
	}
}