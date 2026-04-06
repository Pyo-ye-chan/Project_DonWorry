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
		String sql = "SELECT p.*, " +
                "c1.cat_name AS main_category_name, " +
                "c2.cat_name AS sub_category_name " +
                "FROM job_post p " +
                "LEFT JOIN job_categories c1 ON p.main_category = c1.cat_id " +
                "LEFT JOIN job_categories c2 ON p.sub_category = c2.cat_id " +
                "ORDER BY p.seq DESC";

   return jdbc.query(sql, new BeanPropertyRowMapper<JobPostDTO>(JobPostDTO.class));
}
	
	public List<JobPostDTO> searchKeyword(String keyword) {
	    String sql = "SELECT p.*, "
	               + "       c1.cat_name AS main_category_name, "
	               + "       c2.cat_name AS sub_category_name "
	               + "FROM job_post p "
	               + "LEFT JOIN job_categories c1 ON p.main_category = c1.cat_id "
	               + "LEFT JOIN job_categories c2 ON p.sub_category = c2.cat_id "
	               + "WHERE p.sido LIKE ? OR p.gugun LIKE ? OR p.dong LIKE ? "
	               + "ORDER BY p.write_date DESC";
	    
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
	        
	        // 원본 ID값(숫자) 세팅
	        dto.setMain_category(rs.getString("main_category"));
	        dto.setSub_category(rs.getString("sub_category"));
	        
	        // [추가] JOIN으로 가져온 실제 이름(문자열) 세팅
	        dto.setMain_category_name(rs.getString("main_category_name"));
	        dto.setSub_category_name(rs.getString("sub_category_name"));
	        
	        return dto;
	    }, searchTag, searchTag, searchTag);
	}
	
	public int insert(JobPostDTO dto) {
	    // 1. 컬럼 리스트 (총 18개)
	    String sql = "INSERT INTO job_post ("
	               + "seq, member_id, company_name, phone, "
	               + "sido, gugun, dong, address_detail, count, "
	               + "title, pay, work_days, work_starttime, work_endtime, "
	               + "main_category, sub_category, content, benefit, write_date) "
	               // 2. VALUES (seq + ? 16개 + sysdate = 총 18개)
	               + "VALUES (job_post_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";

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
	        dto.getMain_category(),        // 14
	        dto.getSub_category(),    // 15
	        dto.getContent(),         // 16
	        dto.getBenefit()          // 17
	    );
	}
	
}
