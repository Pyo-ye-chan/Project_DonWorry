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
	/*회원 식별용 type 세션처리*/
	public String getType(String id) {
		String sql = "select type from members where id = ?";
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

	public void signup(MembersDTO dto) {
		if(dto.getType().equals("개인")) {
			String sql = "INSERT INTO members (id, pw, name, nickname, phone, email, type, rrn, join_date) "
		               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
		               
		    jdbc.update(sql, 
		        dto.getId(), 
		        dto.getPw(),
		        dto.getName(), 
		        dto.getNickname(),
		        dto.getPhone(), 
		        dto.getEmail(), 
		        dto.getType(),
		        dto.getRrn()
		    );
		}else {
			String sql = "INSERT INTO members (id, pw, name, nickname, phone, email, type, rrn, business_number, join_date) "
		               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?,?, sysdate)";
		               
		    jdbc.update(sql, 
		        dto.getId(), 
		        dto.getPw(),
		        dto.getName(), 
		        dto.getNickname(),
		        dto.getPhone(), 
		        dto.getEmail(), 
		        dto.getType(),
		        0,
		        dto.getBusiness_number()
		    );
		}
	    
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
	
	/*member 정보 업데이트*/
	public int updateMember(String id,MembersDTO dto){
		String sql = "update members set nickname=?, phone=?, email=? where id=?";
		return jdbc.update(sql,dto.getNickname(),dto.getPhone(),dto.getEmail(),id);
	}
	
}
