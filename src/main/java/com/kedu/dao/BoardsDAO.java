package com.kedu.dao;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dto.BoardsDTO;

@Repository
public class BoardsDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int seqNextval() {
		String sql = "select boards_seq.nextval from dual";
		return jdbc.queryForObject(sql,Integer.class);
	}
	public void insert(int next,BoardsDTO dto) {
		String sql = "insert into boards values(?,?,?,?,?,0,sysdate)";
		jdbc.update(sql,next,dto.getMember_id(),dto.getCategory(),dto.getTitle(),dto.getContent());
	}
	public List<BoardsDTO> mainList(int start, int end){
		String sql = "SELECT * FROM (\r\n"
				+ "    SELECT \r\n"
				+ "        b.seq, \r\n"
				+ "        m.nickname AS member_id, \r\n"
				+ "        b.category, \r\n"
				+ "        b.title, \r\n"
				+ "        b.content, \r\n"
				+ "        b.view_count, \r\n"
				+ "        b.write_date,\r\n"
				+ "        COUNT(r.seq) AS reply_count, \r\n"
				+ "        ROW_NUMBER() OVER(ORDER BY b.seq DESC) AS rn \r\n"
				+ "    FROM boards b \r\n"
				+ "    LEFT JOIN members m ON b.member_id = m.id \r\n"
				+ "    LEFT JOIN reply r ON b.seq = r.parent_seq \r\n"
				+ "    GROUP BY \r\n"
				+ "        b.seq, m.nickname, b.category, b.title, \r\n"
				+ "        b.content, b.view_count, b.write_date \r\n"
				+ ") WHERE rn BETWEEN ? AND ?";
		return jdbc.query(sql,new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class),start,end);
		
	}
	
	//공지글만 가져옴
	public List<BoardsDTO> adminNoticeList(){
		String sql = "select \r\n"
				+ "        b.seq, \r\n"
				+ "        m.nickname as member_id, \r\n"
				+ "        b.category, \r\n"
				+ "        b.title, \r\n"
				+ "        b.content, \r\n"
				+ "        b.view_count, \r\n"
				+ "        b.write_date,\r\n"
				+ "        count(r.seq) as reply_count \r\n"
				+ "from boards b \r\n"
				+ "left join members m on b.member_id = m.id \r\n"
				+ "left join reply r on b.seq = r.parent_seq \r\n"
				+ "where b.member_id = 'admin' \r\n"
				+ "group by \r\n"
				+ "        b.seq, m.nickname, b.category, b.title, \r\n"
				+ "        b.content, b.view_count, b.write_date \r\n"
				+ "order by b.seq desc" ;
		
		return jdbc.query(sql,new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class));		
	}
	
	public int mainRecordTotalCount() {
		String sql = "select count(*) from boards";
		return jdbc.queryForObject(sql,Integer.class);
	}
	public BoardsDTO detail(int seq) {
		String sql = "select b.seq,m.nickname AS member_id,b.category,b.title,b.content,b.view_count,b.write_date"
				+ " from boards b join members m on b.member_id = m.id where seq = ?";
		return jdbc.queryForObject(sql,new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class),seq);
	}
	public String writer(int seq) {
		String sql = "select member_id from boards where seq=?";
		return jdbc.queryForObject(sql, String.class,seq);
	}
	public void update(BoardsDTO dto) {
		String sql = "update boards set title = ? , content = ? where seq = ?";
		jdbc.update(sql,dto.getTitle(),dto.getContent(),dto.getSeq());
	}
	public void delete(int seq) {
		String sql = "delete from boards where seq = ?";
		jdbc.update(sql,seq);
	}
	public void view_count(int seq,int view_count) {
		String sql = "update boards set view_count = ? where seq = ?";
		jdbc.update(sql,view_count+1,seq);
	}
	
	public int freeRecordTotalCount() {
		String sql = "select count(*) from boards where category = 'free'";
		return jdbc.queryForObject(sql,Integer.class);
	}
	
	public List<BoardsDTO> freeList(int start, int end){
		String sql = "SELECT * FROM (\r\n"
				+ "    SELECT \r\n"
				+ "        b.seq, \r\n"
				+ "        m.nickname AS member_id, \r\n"
				+ "        b.category, \r\n"
				+ "        b.title, \r\n"
				+ "        b.content, \r\n"
				+ "        b.view_count, \r\n"
				+ "        b.write_date,\r\n"
				+ "        (SELECT COUNT(*) FROM reply r WHERE r.parent_seq = b.seq) AS reply_count, \r\n"
				+ "        ROW_NUMBER() OVER(ORDER BY b.seq DESC) AS rn \r\n"
				+ "    FROM boards b \r\n"
				+ "    LEFT JOIN members m ON b.member_id = m.id \r\n"
				+ "    WHERE b.category = 'free' \r\n"
				+ ") \r\n"
				+ "WHERE rn BETWEEN ? AND ?";
		return jdbc.query(sql,new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class),start,end);
		
	}
	public int qnaRecordTotalCount() {
		String sql = "select count(*) from boards where category = 'qna'";
		return jdbc.queryForObject(sql,Integer.class);
	}
	
	public List<BoardsDTO> qnaList(int start, int end){
		String sql = "SELECT * FROM (\r\n"
				+ "    SELECT \r\n"
				+ "        b.seq, \r\n"
				+ "        m.nickname AS member_id, \r\n"
				+ "        b.category, \r\n"
				+ "        b.title, \r\n"
				+ "        b.content, \r\n"
				+ "        b.view_count, \r\n"
				+ "        b.write_date,\r\n"
				+ "        (SELECT COUNT(*) FROM reply r WHERE r.parent_seq = b.seq) AS reply_count, \r\n"
				+ "        ROW_NUMBER() OVER(ORDER BY b.seq DESC) AS rn \r\n"
				+ "    FROM boards b \r\n"
				+ "    LEFT JOIN members m ON b.member_id = m.id \r\n"
				+ "    WHERE b.category = 'qna' \r\n"
				+ ") \r\n"
				+ "WHERE rn BETWEEN ? AND ?";
		return jdbc.query(sql,new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class),start,end);
		
	}
	public int reviewRecordTotalCount() {
		String sql = "select count(*) from boards where category = 'review'";
		return jdbc.queryForObject(sql,Integer.class);
	}
	public List<BoardsDTO> reviewList(int start, int end){
		String sql = "SELECT * FROM (\r\n"
				+ "    SELECT \r\n"
				+ "        b.seq, \r\n"
				+ "        m.nickname AS member_id, \r\n"
				+ "        b.category, \r\n"
				+ "        b.title, \r\n"
				+ "        b.content, \r\n"
				+ "        b.view_count, \r\n"
				+ "        b.write_date,\r\n"
				+ "        (SELECT COUNT(*) FROM reply r WHERE r.parent_seq = b.seq) AS reply_count, \r\n"
				+ "        ROW_NUMBER() OVER(ORDER BY b.seq DESC) AS rn \r\n"
				+ "    FROM boards b \r\n"
				+ "    LEFT JOIN members m ON b.member_id = m.id \r\n"
				+ "    WHERE b.category = 'review' \r\n"
				+ ") \r\n"
				+ "WHERE rn BETWEEN ? AND ?";
		return jdbc.query(sql,new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class),start,end);
		
	}
	
	//메인화면 인기 게시글
	public List<BoardsDTO> mainHotList(){
		String sql = "SELECT * FROM ("
	            + "    SELECT "
	            + "        b.seq, "
	            + "        m.nickname AS member_id, "
	            + "        b.category, "
	            + "        b.title, "
	            + "        b.content, "
	            + "        b.view_count, "
	            + "        b.write_date,"
	            + "        COUNT(r.seq) AS reply_count, "
	            // 핵심: 조회수(view_count) 내림차순 정렬 후 번호 매기기
	            + "        ROW_NUMBER() OVER(ORDER BY b.view_count DESC, b.seq DESC) AS rn " 
	            + "    FROM boards b "
	            + "    LEFT JOIN members m ON b.member_id = m.id "
	            + "    LEFT JOIN reply r ON b.seq = r.parent_seq "
	            + "    GROUP BY "
	            + "        b.seq, m.nickname, b.category, b.title, "
	            + "        b.content, b.view_count, b.write_date "
	            + ") WHERE rn BETWEEN 1 AND 3"; // 상위 3개 고정
		
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class));
	}
	

}
