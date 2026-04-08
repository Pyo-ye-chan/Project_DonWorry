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
	
	
	public List<MembersDTO> getRecentMembers() {
	    String sql = "select * from members order by join_date desc";

	    return jdbc.query(sql, (rs, i) -> {
	        MembersDTO dto = new MembersDTO();
	        dto.setId(rs.getString("id"));
	        dto.setName(rs.getString("name"));
	        dto.setNickname(rs.getString("nickname"));
	        dto.setPhone(rs.getString("phone"));
	        dto.setEmail(rs.getString("email"));
	        dto.setType(rs.getString("type"));
	        dto.setState(rs.getString("state"));
	        dto.setRrn(rs.getString("rrn"));
	        dto.setBusiness_number(rs.getString("business_number"));
	        dto.setJoin_date(rs.getTimestamp("join_date"));
	        return dto;
	    });
	}
	
//	public List<MembersDTO> getMembers(int start, int end) {
//	    String sql = "SELECT * FROM ("
//	               + "    SELECT m.*, ROW_NUMBER() OVER(ORDER BY join_date DESC) AS rn "
//	               + "    FROM members m "
//	               + ") WHERE rn BETWEEN ? AND ?";
//	               
//	    return jdbc.query(sql, (rs, rowNum) -> {
//	        MembersDTO dto = new MembersDTO();
//	        dto.setId(rs.getString("id"));
//	        dto.setName(rs.getString("name"));
//	        dto.setNickname(rs.getString("nickname"));
//	        dto.setPhone(rs.getString("phone"));
//	        dto.setEmail(rs.getString("email"));
//	        dto.setType(rs.getString("type")); // 개인, 사업자, 관리자
//	        dto.setState(rs.getString("state")); // 탈퇴 여부 등
//	        dto.setRrn(rs.getString("rrn"));
//	        dto.setJoin_date(rs.getTimestamp("join_date"));
//	        return dto;
//	    }, start, end);
//	}
	
	public List<MembersDTO> getMembers(int start, int end) {
	    String sql = "SELECT * FROM ("
	               + "    SELECT m.*, ROW_NUMBER() OVER(ORDER BY join_date DESC) AS rn "
	               + "    FROM members m "
	               + ") WHERE rn BETWEEN ? AND ?";
	               
	    return jdbc.query(sql, (rs, rowNum) -> {
	        MembersDTO dto = new MembersDTO();
	        dto.setId(rs.getString("id"));
	        dto.setName(rs.getString("name"));
	        dto.setNickname(rs.getString("nickname"));
	        dto.setPhone(rs.getString("phone"));
	        dto.setEmail(rs.getString("email"));
	        dto.setType(rs.getString("type")); // 개인, 사업자, 관리자
	        dto.setState(rs.getString("state")); // 탈퇴 여부 등
	        dto.setRrn(rs.getString("rrn"));
	        dto.setJoin_date(rs.getTimestamp("join_date"));
	        
	        // 주민번호(rrn) 가져오기 (예: 950101-1)
	        String rrn = rs.getString("rrn");
	        if (rrn != null && rrn.contains("-")) {
	            String[] parts = rrn.split("-");
	            // 하이픈 뒤에 글자가 진짜 있는지(배열 크기가 2인지) 확인
	            if (parts.length >= 2 && !parts[1].isEmpty()) {
	                char genderCode = parts[1].charAt(0);
	                
	                if (genderCode == '1' || genderCode == '3') {
	                    dto.setGender("남성");
	                } else if (genderCode == '2' || genderCode == '4') {
	                    dto.setGender("여성");
	                } else {
	                    dto.setGender("기타");
	                }
	            } else {
	                dto.setGender("미입력");
	            }
	        } else {
	            dto.setGender("형식오류");
	        }
	        
	        return dto;
	    }, start, end);
	}
	
	public int membersTotalCount() {
		String sql = "select count(*) from members";
		return jdbc.queryForObject(sql,Integer.class);
	}
	
	public int getStateCount() {
		String sql = "select count(*) from members where state='Y'";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public int updateMemberState(String nickname, String state) {
	    String sql = "UPDATE members SET state = ? WHERE nickname = ?";
	    return jdbc.update(sql, state, nickname);
	}
}
