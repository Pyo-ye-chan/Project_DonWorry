package com.kedu.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.BoardsDTO;
import com.kedu.dto.JobPostDTO;

@Repository
public class JobPostDAO {
	@Autowired
	private JdbcTemplate jdbc;
	
	public List<JobPostDTO> getList(){
		String sql = "select * from job_post order by seq desc";

		return jdbc.query(sql, new BeanPropertyRowMapper<JobPostDTO>(JobPostDTO.class));
	}
	
	public List<JobPostDTO> searchKeyword(String keyword) {
	    // 주소 컬럼들에서 키워드가 포함된 행을 찾음
	    String sql = "SELECT * FROM job_post WHERE "
	               + "sido LIKE ? OR gugun LIKE ? OR dong LIKE ? "
	               + "ORDER BY write_date DESC";
	    
	    String searchTag = "%" + keyword + "%";
	    
	    return jdbc.query(sql, (rs, rowNum) -> {
	        JobPostDTO dto = new JobPostDTO();
	        dto.setSeq(rs.getInt("seq"));
	        dto.setCompany_name(rs.getString("company_name"));
	        dto.setTitle(rs.getString("title"));
	        dto.setPay(rs.getString("pay"));
	        dto.setWork_days(rs.getString("work_days"));
	        dto.setWork_starttime(rs.getString("work_starttime"));
	        dto.setWork_endtime(rs.getString("work_endtime"));
	        dto.setSido(rs.getString("sido"));
	        dto.setGugun(rs.getString("gugun"));
	        dto.setDong(rs.getString("dong"));
	        dto.setContent(rs.getString("content"));
	        dto.setCategory(rs.getString("category"));
	        return dto;
	    }, searchTag, searchTag, searchTag);
	}
	
	public int insert(JobPostDTO dto) {
	    // 1. 컬럼 리스트 (총 18개)
	    String sql = "INSERT INTO job_post ("
	               + "seq, member_id, company_name, phone, "
	               + "sido, gugun, dong, address_detail, count, "
	               + "title, pay, work_days, work_starttime, work_endtime, "
	               + "category, content, benefit, write_date) "
	               // 2. VALUES (seq + ? 16개 + sysdate = 총 18개)
	               + "VALUES (job_post_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";

	    // 3. 인자 전달 (총 16개)
	    return jdbc.update(sql,
	        dto.getMember_id(),      // 1
	        dto.getCompany_name(),    // 2
	        dto.getPhone(),           // 3
	        dto.getSido(),            // 4
	        dto.getGugun(),           // 5
	        dto.getDong(),            // 6
	        dto.getAddress_detail(),  // 7
	        dto.getCount(),           // 8 (DB 컬럼명이 recruitment_count라면 맞춰줄 것)
	        dto.getTitle(),           // 9
	        dto.getPay(),             // 10
	        dto.getWork_days(),       // 11
	        dto.getWork_starttime(),      // 12
	        dto.getWork_endtime(),        // 13
	        dto.getCategory(),        // 14
	        dto.getContent(),         // 15
	        dto.getBenefit()          // 16
	    );
	}
	
}
