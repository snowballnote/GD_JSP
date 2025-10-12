package dao;

import java.sql.*;
import java.util.*;
import dto.ScheduleDto;

public class ScheduleDao {

  // 공통 커넥션 획득 메서드 (드라이버 로딩 + 커넥션 생성)
  private Connection getConn() throws Exception {
    Class.forName("com.mysql.cj.jdbc.Driver");
    return DriverManager.getConnection("jdbc:mysql://localhost:3306/ex1","root","java1234");
  }

  /* ============ [CREATE] 스케줄 추가 ============ */
  // INSERT: schedule_date, schedule_title, schedule_content 를 받아 한 행 추가
  // return: 1(성공) / 0(실패)
  public int insertSchedule(ScheduleDto dto) throws Exception {
    String sql = "INSERT INTO schedule(schedule_date, schedule_title, schedule_content) VALUES(?,?,?)";
    // try-with-resources: 자원 자동 해제
    try (Connection conn = getConn(); PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setString(1, dto.getScheduleDate());
      ps.setString(2, dto.getScheduleTitle());
      ps.setString(3, dto.getScheduleContent());
      return ps.executeUpdate();
    }
  }

  /* ============ [READ] 특정 월 목록(달력용) ============ */
  // year, month(1~12)로 해당 월의 일정들(번호, 날짜, 제목) 목록 조회
  public List<ScheduleDto> selectByMonth(int year, int month1to12) throws Exception {
    String sql = "SELECT schedule_no, schedule_date, schedule_title " +
                 "FROM schedule WHERE YEAR(schedule_date)=? AND MONTH(schedule_date)=? ORDER BY schedule_no DESC";
    try (Connection conn = getConn(); PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, year);
      ps.setInt(2, month1to12);
      try (ResultSet rs = ps.executeQuery()) {
        List<ScheduleDto> list = new ArrayList<>();
        while (rs.next()) {
          ScheduleDto d = new ScheduleDto();
          d.setScheduleNo(rs.getInt("schedule_no"));
          d.setScheduleDate(rs.getString("schedule_date"));
          d.setScheduleTitle(rs.getString("schedule_title"));
          list.add(d);
        }
        return list;
      }
    }
  }

  /* ============ [READ] 특정 날짜 목록 ============ */
  // yyyy-MM-dd 날짜로 해당 일의 일정 목록(번호, 날짜, 제목) 조회
  public List<ScheduleDto> selectByDate(String yyyymmdd) throws Exception {
    String sql = "SELECT schedule_no, schedule_date, schedule_title " +
                 "FROM schedule WHERE schedule_date=? ORDER BY schedule_no DESC";
    try (Connection conn = getConn(); PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setString(1, yyyymmdd);
      try (ResultSet rs = ps.executeQuery()) {
        List<ScheduleDto> list = new ArrayList<>();
        while (rs.next()) {
          ScheduleDto d = new ScheduleDto();
          d.setScheduleNo(rs.getInt("schedule_no"));
          d.setScheduleDate(rs.getString("schedule_date"));
          d.setScheduleTitle(rs.getString("schedule_title"));
          list.add(d);
        }
        return list;
      }
    }
  }

  /* ============ [READ] 단건 상세 ============ */
  // PK(schedule_no)로 상세 조회 (내용/작성일 포함)
  public ScheduleDto selectOne(int scheduleNo) throws Exception {
    String sql = "SELECT schedule_no, schedule_date, schedule_title, schedule_content, createdate " +
                 "FROM schedule WHERE schedule_no=?";
    try (Connection conn = getConn(); PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, scheduleNo);
      try (ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
          ScheduleDto d = new ScheduleDto();
          d.setScheduleNo(rs.getInt("schedule_no"));
          d.setScheduleDate(rs.getString("schedule_date"));
          d.setScheduleTitle(rs.getString("schedule_title"));
          d.setScheduleContent(rs.getString("schedule_content"));
          d.setCreatedate(rs.getString("createdate"));
          return d;
        }
        return null; // 조회 결과 없음
      }
    }
  }

  /* ============ [UPDATE] 수정 ============ */
  // PK로 해당 일정의 날짜/제목/내용 업데이트
  public int updateSchedule(ScheduleDto dto) throws Exception {
    String sql = "UPDATE schedule SET schedule_date=?, schedule_title=?, schedule_content=? WHERE schedule_no=?";
    try (Connection conn = getConn(); PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setString(1, dto.getScheduleDate());
      ps.setString(2, dto.getScheduleTitle());
      ps.setString(3, dto.getScheduleContent());
      ps.setInt(4, dto.getScheduleNo());
      return ps.executeUpdate();
    }
  }

  /* ============ [DELETE] 삭제 ============ */
  // PK로 한 행 삭제
  public int deleteSchedule(int scheduleNo) throws Exception {
    String sql = "DELETE FROM schedule WHERE schedule_no=?";
    try (Connection conn = getConn(); PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setInt(1, scheduleNo);
      return ps.executeUpdate();
    }
  }
}