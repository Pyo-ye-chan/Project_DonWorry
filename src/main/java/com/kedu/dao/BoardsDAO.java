package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
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

}
