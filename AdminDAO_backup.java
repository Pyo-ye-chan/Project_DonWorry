package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.BoardsDTO;

@Repository
public class adminDAO {
	@Autowired
	private JdbcTemplate jdbc;
	

	public List<BoardsDTO> admin_boardList(int start, int end) {
		String sql="SELECT * FROM ("
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
	            + "    GROUP BY "
	            + "        b.seq, m.nickname, b.category, b.title, "
	            + "        b.content, b.view_count, b.write_date "
	            + ") WHERE rn BETWEEN ? AND ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class), start, end);
	}

}
