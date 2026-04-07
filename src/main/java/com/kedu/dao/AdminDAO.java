package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.BoardsDTO;

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
	
}
