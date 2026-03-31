package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.MembersDTO;

@Repository
public class MembersDAO {

	@Autowired
	private JdbcTemplate jdbc;

	public boolean login(String id,String pw) {
		String sql = "select count(*) from members where id =? and pw = ?";
		int result = jdbc.queryForObject(sql,Integer.class,id,pw);
		if(result > 0) {
			return true;
		}else {
			return false;
		}
	}
	public String getNickname(String id) {
		String sql = "select nickname from members where id = ?";
		return jdbc.queryForObject(sql,String.class,id);
	}

	public void signup(MembersDTO dto) {
	    // 1. 괄호 안에 데이터를 넣을 컬럼 이름을 정확히 적어줘.
	    String sql = "INSERT INTO members (id, pw, name, nickname, phone, email, rrn, business_number, join_date) "
	               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, sysdate)";

	    // 2. 위에서 적은 컬럼 순서대로 데이터를 매칭해줘. (총 8개)
	    jdbc.update(sql, 
	        dto.getId(), 
	        dto.getPw(), 
	        dto.getName(), 
	        dto.getNickname(),
	        dto.getPhone(), 
	        dto.getEmail(), 
	        dto.getRrn(), 
	        dto.getBusiness_number()
	    );
	}

}
