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
	
	public List<JobPostDTO> jobList(int start, int end){
		String sql = "SELECT * FROM ( "
	               + "    SELECT p.*, "
	               + "           c1.cat_name AS main_category_name, "
	               + "           c2.cat_name AS sub_category_name, "
	               + "           ROW_NUMBER() OVER(ORDER BY p.write_date DESC) AS rn "
	               + "    FROM job_post p "
	               + "    LEFT JOIN job_categories c1 ON p.main_category = c1.cat_id "
	               + "    LEFT JOIN job_categories c2 ON p.sub_category = c2.cat_id "
	               + ") WHERE rn BETWEEN ? AND ?";

   return jdbc.query(sql, new BeanPropertyRowMapper<JobPostDTO>(JobPostDTO.class),start, end);
}
	
	public int jobRecordTotalCount() {
	    String sql = "SELECT COUNT(*) FROM job_post";
	    return jdbc.queryForObject(sql, Integer.class);
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
	
	public List<JobPostDTO> selectByLocation(String keyword){
		String sql = "SELECT * FROM job_post WHERE "
	               + "REPLACE(NVL(sido,'') || NVL(gugun,'') || NVL(dong,''), ' ', '') "
	               + "LIKE ? "
	               + "ORDER BY write_date DESC";
	    
	    // 검색어에서도 모든 공백 제거 후 앞뒤에 % 붙이기
	    String cleanKeyword = keyword.replace(" ", "").trim();
	    String searchTag = "%" + cleanKeyword + "%";
	    
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
	        dto.setMain_category_name(rs.getString("main_category"));
	        return dto;
	    }, searchTag);
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
	
	public JobPostDTO getPostDetail(int seq) {
	    String sql = "SELECT * FROM job_post WHERE seq = ?";
	    
	    return jdbc.queryForObject(sql, (rs, rowNum) -> {
	        JobPostDTO dto = new JobPostDTO();
	        
	        dto.setSeq(rs.getInt("seq"));
	        dto.setMember_id(rs.getString("member_id"));
	        
	        /* 2. 기본 정보 섹션 */
	        dto.setCompany_name(rs.getString("company_name"));
	        dto.setPhone(rs.getString("phone"));
	        dto.setSido(rs.getString("sido"));
	        dto.setGugun(rs.getString("gugun"));
	        dto.setDong(rs.getString("dong"));
	        dto.setAddress_detail(rs.getString("address_detail"));
	        dto.setCount(rs.getInt("count"));
	        
	        /* 3. 상세 정보 섹션 */
	        dto.setTitle(rs.getString("title"));
	        dto.setPay(rs.getString("pay")); 
	        dto.setWork_days(rs.getString("work_days"));
	        dto.setWork_starttime(rs.getString("work_starttime"));
	        dto.setWork_endtime(rs.getString("work_endtime"));
	        
	        /* 4. 카테고리 및 내용 */
	        dto.setMain_category(rs.getString("main_category"));
	        dto.setSub_category(rs.getString("sub_category"));
	        dto.setContent(rs.getString("content")); 
	        dto.setBenefit(rs.getString("benefit")); 
	        
	        return dto;
	    }, seq);
	}
	
	public List<JobPostDTO> searchKeywordPaged(String keyword, int start, int end) {
	    // 1. 기존 SQL에 ROW_NUMBER() 추가
	    String sql = "SELECT * FROM ( "
	               + "    SELECT p.*, "
	               + "           c1.cat_name AS main_category_name, "
	               + "           c2.cat_name AS sub_category_name, "
	               + "           ROW_NUMBER() OVER(ORDER BY p.write_date DESC) AS rn " // 최신순 정렬 및 번호 매기기
	               + "    FROM job_post p "
	               + "    LEFT JOIN job_categories c1 ON p.main_category = c1.cat_id "
	               + "    LEFT JOIN job_categories c2 ON p.sub_category = c2.cat_id "
	               + "    WHERE p.sido LIKE ? OR p.gugun LIKE ? OR p.dong LIKE ? OR p.title LIKE ? OR p.company_name LIKE ? "
	               + ") WHERE rn BETWEEN ? AND ?"; // 페이징 범위 지정
	    
	    String searchTag = "%" + keyword + "%";
	    
	    // 물음표(?) 순서대로 파라미터 넣어주기
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
	        
	        dto.setMain_category(rs.getString("main_category"));
	        dto.setSub_category(rs.getString("sub_category"));
	        
	        // JOIN 결과값 세팅
	        dto.setMain_category_name(rs.getString("main_category_name"));
	        dto.setSub_category_name(rs.getString("sub_category_name"));
	        
	        return dto;
	    }, searchTag, searchTag, searchTag, searchTag, searchTag, start, end);
	}
	
	// 검색된 결과가 총 몇 건인지 숫자만 가져오는 메서드
	public int getSearchTotalCount(String keyword) {
	    // p.* 대신 COUNT(*)를 사용!
	    String sql = "SELECT COUNT(*) FROM job_post "
	               + "WHERE sido LIKE ? OR gugun LIKE ? OR dong LIKE ? OR title LIKE ? OR company_name LIKE ?";
	    
	    String searchTag = "%" + keyword + "%";
	    
	    // queryForObject를 써서 Integer(숫자) 하나만 리턴받음
	    return jdbc.queryForObject(sql, Integer.class, searchTag, searchTag, searchTag, searchTag, searchTag);
	}
	
	//메인에 구인구직글 최신 3개만 띄우기
	public List<JobPostDTO> mainJobList() {
	    // 최신순으로 1번부터 3번까지만 
		String sql = "SELECT * FROM ( "
		           + "    SELECT p.*, " // FROM의 별칭과 동일하게 p로 통일
		           + "           c1.cat_name AS main_category_name, "
		           + "           c2.cat_name AS sub_category_name, "
		           + "           ROW_NUMBER() OVER(ORDER BY p.write_date DESC) AS rn "
		           + "    FROM job_post p " // j 대신 p로 설정 (위와 맞춤)
		           + "    LEFT JOIN job_categories c1 ON p.main_category = c1.cat_id " // 이미지 속 오타 반영
		           + "    LEFT JOIN job_categories c2 ON p.sub_category = c2.cat_id "
		           + ") WHERE rn BETWEEN 1 AND 3";
		
	    return jdbc.query(sql, new BeanPropertyRowMapper<JobPostDTO>(JobPostDTO.class));
	}
	
}
