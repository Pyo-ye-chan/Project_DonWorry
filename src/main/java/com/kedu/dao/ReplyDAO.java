package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.ReplyDTO;

@Repository
public class ReplyDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
//	public List<ReplyDTO> insert(ReplyDTO dto){
//		String sql = "select * from reply where parent_seq = ?";
//		return jdbc.query(sql,new BeanPropertyRowMapper<ReplyDTO>(ReplyDTO.class)dto.getParnet_seq());
//	}

}
