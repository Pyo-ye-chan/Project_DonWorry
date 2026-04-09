package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.JobPostDTO;

@Repository
public class MypageDAO {

		@Autowired
		private JdbcTemplate jdbc;
		
		public boolean passwordCheck(String id, String pw) {
			String sql = "select pw from members where id = ?";
			String searchPw = jdbc.queryForObject(sql, String.class, id);
			if(searchPw.equals(pw)) {
				return true;
			}else {
				return false;
			}		
		}
		
		public int withdraw(String id, String pw) {
			String sql = "delete from members where id = ? and pw = ?";
			return jdbc.update(sql, id, pw);
		}
		
		//  이력서용 대분류 카테고리 목록 불러오기
		public List<JobPostDTO> getJobCategory() {
		    // DB의 cat_id를 main_category 필드에, cat_name을 main_category_name 필드에 매핑
		    String sql = "SELECT cat_id AS main_category, cat_name AS main_category_name "
		               + "FROM job_categories WHERE parent_id IS NULL ORDER BY cat_id ASC";
		    
		    return jdbc.query(sql, new BeanPropertyRowMapper<JobPostDTO>(JobPostDTO.class));
		}

		// 대분류 클릭 시 해당되는 소분류 목록 불러오기 (선택사항)
		public List<JobPostDTO> getSubCategory(int parentId) {
		    // 소분류 데이터는 sub_ 필드들에 매핑
		    String sql = "SELECT cat_id AS sub_category, cat_name AS sub_category_name "
		               + "FROM job_categories WHERE parent_id = ? ORDER BY cat_id ASC";
		    
		    return jdbc.query(sql, new BeanPropertyRowMapper<JobPostDTO>(JobPostDTO.class), parentId);
		}
		
//		//이력서 저장
//		public void insert_resume() {
//			String sql = "insert into resume values()";
//		}
}
