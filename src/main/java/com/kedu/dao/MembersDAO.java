package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
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
		System.out.println(result);
		if(result > 0) {
			System.out.println("gd");
			return true;
		}else {
			return false;
		}
	}
	public String getNickname(String id) {
		String sql = "select nickname from members where id = ?";
		return jdbc.queryForObject(sql,String.class,id);
	}
	public String idSearch(String name,String email) {
		String test = "select count(*) from members where name = ? and email = ?";
		int result = jdbc.queryForObject(test,Integer.class,name,email);
		if(result > 0) {
			String sql = "select substr(id, 1, length(id) - 4) || '****' from members where name = ? and email =?";
			return jdbc.queryForObject(sql,String.class,name,email);
		}else {
			return null;
		}
				
	}

	public void signup(MembersDTO dto, String pw) {
	    // 1. 괄호 안에 데이터를 넣을 컬럼 이름을 정확히 적어줘.
	    String sql = "INSERT INTO members (id, pw, name, nickname, phone, email, rrn, join_date) "
	               + "VALUES (?, ?, ?, ?, ?, ?, ?, sysdate)";

	    // 2. 위에서 적은 컬럼 순서대로 데이터를 매칭해줘. (총 8개)
	    jdbc.update(sql, 
	        dto.getId(), 
	        pw, 
	        dto.getName(), 
	        dto.getNickname(),
	        dto.getPhone(), 
	        dto.getEmail(), 
	        dto.getRrn()
	    );
	}
	
	public int checkMemberForPw(String id, String email) {
		String sql = "select count(*) from members where id=? and email=?";
		
		return jdbc.queryForObject(sql,Integer.class,id,email);
	}
	
	public int updatePw(String id, String pw) {
	    String sql = "update members set pw = ? where id = ?";
	    
	    try {
	        return jdbc.update(sql, pw, id);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return 0;
	    }
	}
	
	/*member 정보 list*/
	public List<MembersDTO> selectAll(String id){
		String sql = "select * from members where id=?";
		return jdbc.query(sql, new BeanPropertyRowMapper<MembersDTO>(MembersDTO.class),id);
	}
	
	/*member 정보 update*/
	public void updateMember() {
		
	}
}
