package com.kedu.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.QnaDTO;

@Repository
public class QnaDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public void insert(QnaDTO dto) {
		String sql = "insert into qna values(qna_seq.nextval,?,?,?,'status-waiting',sysdate)";
		jdbc.update(sql,dto.getMember_id(),dto.getTitle(),dto.getContent());
	}
	public List<QnaDTO> list(String member_id,int start,int end){
		String sql = "SELECT * FROM ("
	               + "    SELECT qna.*, ROW_NUMBER() OVER (ORDER BY seq DESC) AS rnum "
	               + "    FROM qna "
	               + "    WHERE member_id = ?"
	               + ") WHERE rnum BETWEEN ? AND ?";
		return jdbc.query(sql,new BeanPropertyRowMapper<QnaDTO>(QnaDTO.class),member_id,start,end);
	}
	public List<QnaDTO> listAll(){
		String sql = "select * from qna";
		return jdbc.query(sql,new BeanPropertyRowMapper<QnaDTO>(QnaDTO.class));
	} 
	public QnaDTO detail(int seq) {
		String sql = "select * from qna where seq = ?";
		return jdbc.queryForObject(sql,new BeanPropertyRowMapper<QnaDTO>(QnaDTO.class),seq);
	}
	public void statusUpdate(int seq) {
		String sql = "update qna set status = 'status-complete' where seq = ?";
		jdbc.update(sql,seq);
	}
	public void update(QnaDTO dto) {
		String sql = "update qna set title = ? , content = ? where seq = ?";
		jdbc.update(sql,dto.getTitle(),dto.getContent(),dto.getSeq());
	}
	public void delete(int seq) {
		String sql = "delete from qna where seq = ?";
		jdbc.update(sql,seq);
	}
	public int selectAllCount() {
		String sql = "select count(*) from qna";
		return jdbc.queryForObject(sql,Integer.class);
	}
	public int selectWaitCount() {
		String sql = "select count(*) from qna where status = 'status-waiting'";
		return jdbc.queryForObject(sql,Integer.class);
	}
	public int selectCompleteCount() {
		String sql = "select count(*) from qna where status = 'status-complete'";
		return jdbc.queryForObject(sql,Integer.class);
	}
	// 1. 이번 주 신규 문의 건수 (최근 7일)
	public int selectWeekNewCount() {
	    String sql = "SELECT COUNT(*) FROM qna WHERE write_date >= SYSDATE - 7";
	    return jdbc.queryForObject(sql, Integer.class);
	}

	// 2. 24시간 이상 경과된 미처리 문의 (접수중 상태이면서 1일 경과)
	public int selectOverdueWaitCount() {
	    // status 값은 DB에 저장된 실제 값('status-waiting' 또는 '접수중')에 맞춰 수정하세요.
	    String sql = "SELECT COUNT(*) FROM qna WHERE status = 'status-waiting' AND write_date <= SYSDATE - 1";
	    return jdbc.queryForObject(sql, Integer.class);
	}

	public Double selectAvgReplyTime() {
	    // NVL을 사용하여 데이터가 없을 때 0을 반환하도록 설정
	    String sql = "SELECT NVL(AVG(CAST(r.write_date AS DATE) - CAST(q.write_date AS DATE)), 0) " +
	                 "FROM qna q " +
	                 "JOIN qna_reply r ON q.seq = r.qna_num " +
	                 "WHERE r.seq IN (SELECT MIN(seq) FROM qna_reply GROUP BY qna_num)";
	    
	    try {
	        return jdbc.queryForObject(sql, Double.class);
	    } catch (Exception e) {
	        return 0.0;
	    }
	}
	public List<QnaDTO> selectSearchList(int page, String status, String keyword, int countPerPage) {
	    StringBuilder sql = new StringBuilder("SELECT * FROM (SELECT q.*, ROW_NUMBER() OVER(ORDER BY seq DESC) rn FROM qna q WHERE 1=1 ");
	    List<Object> params = new ArrayList<>();

	    if (!status.equals("all")) {
	        sql.append("AND status = ? ");
	        params.add(status);
	    }
	    if (!keyword.trim().isEmpty()) {
	        sql.append("AND (title LIKE ? OR member_id LIKE ?) ");
	        params.add("%" + keyword + "%");
	        params.add("%" + keyword + "%");
	    }
	    sql.append(") WHERE rn BETWEEN ? AND ?");

	    int start = (page - 1) * countPerPage + 1;
	    int end = page * countPerPage;
	    params.add(start);
	    params.add(end);

	    return jdbc.query(sql.toString(), new BeanPropertyRowMapper<>(QnaDTO.class), params.toArray());
	}

	public int selectSearchCount(String status, String keyword) {
	    StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM qna WHERE 1=1 ");
	    List<Object> params = new ArrayList<>();

	    if (!status.equals("all")) {
	        sql.append("AND status = ? ");
	        params.add(status);
	    }
	    if (!keyword.trim().isEmpty()) {
	        sql.append("AND (title LIKE ? OR member_id LIKE ?) ");
	        params.add("%" + keyword + "%");
	        params.add("%" + keyword + "%");
	    }
	    return jdbc.queryForObject(sql.toString(), Integer.class, params.toArray());
	}
	public void statusReset(int seq) {
	    String sql = "update qna set status = 'status-waiting' where seq = ?";
	    jdbc.update(sql, seq);
	}
	public int recordTotalCount(String member_id) {
		String sql = "select count(*) from qna where member_id = ?";
		return jdbc.queryForObject(sql,Integer.class,member_id);
	}

}
