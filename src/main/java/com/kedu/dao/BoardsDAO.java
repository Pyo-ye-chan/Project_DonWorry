package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

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
		String sql = "insert into boards valuse(?,?,?,?,?,0,sysdate)";
		jdbc.update(sql,next,dto.getMember_id(),dto.getCategory(),dto.getTitle(),dto.getContent());
	}
	public List<BoardsDTO> mainList(int start, int end){
		String sql = "select * from(select boards.*,row_number() over(order by seq desc)rn from boards) rn where rn between ? and ?";
		return jdbc.query(sql,new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class),start,end);
		
	}
	public int recordTotalCount() {
		String sql = "select count(*) from boards";
		return jdbc.queryForObject(sql,Integer.class);
	}
	public BoardsDTO detail(int seq) {
		String sql = "select * from boards where seq = ?";
		return jdbc.queryForObject(sql,new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class),seq);
	}

}
