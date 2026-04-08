package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.BoardsDTO;
import com.kedu.dto.ReplyDTO;

@Repository
public class AdminDAO {

	@Autowired
	private JdbcTemplate jdbc;
	
	//게시글 가져옴
	public List<BoardsDTO> admin_boardList(int start, int end) {
		String sql = "SELECT * FROM ("
		        + "    SELECT "
		        + "        b.seq, "
		        + "        m.nickname AS member_id, "
		        + "        b.category, "
		        + "        b.title, "
		        + "        b.content, "
		        + "        b.view_count, "
		        + "        b.write_date, "
		        + "        COUNT(DISTINCT r.seq) AS reply_count, "
		        + "        COUNT(DISTINCT rp.seq) AS report_count, "
		        + "        ROW_NUMBER() OVER(ORDER BY b.seq DESC) AS rn "
		        + "    FROM boards b "
		        + "    LEFT JOIN members m ON b.member_id = m.id "
		        + "    LEFT JOIN reply r ON b.seq = r.parent_seq "
		        + "    LEFT JOIN report rp ON b.seq = rp.boards_seq "
		        + "	   WHERE b.member_id != 'admin' \r\n"
		        + "    GROUP BY "
		        + "        b.seq, m.nickname, b.category, b.title, "
		        + "        b.content, b.view_count, b.write_date "
		        + ") WHERE rn BETWEEN ? AND ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class), start, end);
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
				+ "WHERE b.member_id = 'admin' \r\n"
				+ "group by \r\n"
				+ "        b.seq, m.nickname, b.category, b.title, \r\n"
				+ "        b.content, b.view_count, b.write_date \r\n"
				+ "order by b.seq desc" ;
		
		return jdbc.query(sql,new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class));		
	}
	
	//댓글 가져옴
	public List<ReplyDTO> admin_replyList(int start, int end) {
		String sql="SELECT * FROM (\r\n"
				+ "    SELECT \r\n"
				+ "        ROW_NUMBER() OVER (ORDER BY r.seq DESC) AS rn,\r\n"
				+ "        r.seq,\r\n"
				+ "        r.parent_seq,\r\n"
				+ "        m.nickname AS member_id,\r\n"
				+ "        r.content,\r\n"
				+ "        r.write_date,\r\n"
				+ "        r.re_reply_seq,\r\n"
				+ "        r.member_id AS writer,\r\n"
				+ "        COUNT(rp.seq) AS report_count -- 신고 테이블의 seq 카운트\r\n"
				+ "    FROM reply r \r\n"
				+ "    JOIN members m ON r.member_id = m.id\r\n"
				+ "    LEFT JOIN report rp ON r.seq = rp.reply_seq -- 댓글 번호로 신고 테이블 조인\r\n"
				+ "    GROUP BY \r\n"
				+ "        r.seq, r.parent_seq, m.nickname, r.content, \r\n"
				+ "        r.write_date, r.re_reply_seq, r.member_id\r\n"
				+ ") \r\n"
				+ "WHERE rn BETWEEN ? AND ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<ReplyDTO>(ReplyDTO.class),start,end);
	}
	
	//신고된 댓글 가져옴
	public List<ReplyDTO> admin_report_replyList() {
		String sql="SELECT \r\n"
				+ "    r.seq, r.parent_seq, m.nickname AS member_id, \r\n"
				+ "    r.content, r.write_date, r.re_reply_seq, r.member_id AS writer,\r\n"
				+ "    COUNT(rp.seq) AS report_count\r\n"
				+ "FROM reply r \r\n"
				+ "JOIN members m ON r.member_id = m.id\r\n"
				+ "JOIN report rp ON r.seq = rp.reply_seq \r\n"
				+ "GROUP BY \r\n"
				+ "    r.seq, r.parent_seq, m.nickname, r.content, \r\n"
				+ "    r.write_date, r.re_reply_seq, r.member_id\r\n"
				+ "HAVING COUNT(rp.seq) > 0 -- 신고가 1개 이상인 것만\r\n"
				+ "ORDER BY r.seq DESC";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<ReplyDTO>(ReplyDTO.class));
	}
	
}
