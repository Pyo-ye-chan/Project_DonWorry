package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.JobPostDTO;
@Repository
public class JobApplyDAO {
	
	@Autowired
	private JdbcTemplate jdbc;

	public int insert(String id, int resume_num, int jobPostNum) {
	    String sql = "INSERT INTO job_apply (seq, member_id, resume_num, job_post_num) "
	               + "VALUES (job_apply_seq.nextval, ?, ?, ?)";
	    
	    return jdbc.update(sql, id, resume_num, jobPostNum);
	}
	
	public int delete(int seq) {
	    String sql = "DELETE FROM job_apply WHERE seq = ?";
	    return jdbc.update(sql, seq);
	}
	
	public boolean existsApply(String id, int jobPostNum) {
	    String sql = "SELECT COUNT(*) FROM job_apply WHERE member_id = ? AND job_post_num = ?";
	    int count = jdbc.queryForObject(sql, Integer.class, id, jobPostNum);
	    return count > 0;
	}
	
	public List<JobPostDTO> selectApplyList(String id) {
		String sql = "SELECT a.seq AS apply_seq, b.*, a.status AS status, a.resume_num, " +
                "       c1.cat_name AS main_category_name, " + 
                "       c2.cat_name AS sub_category_name " + 
                "FROM job_apply a " +
                "JOIN job_post b ON a.job_post_num = b.seq " +
                "LEFT JOIN job_categories c1 ON b.main_category = c1.cat_id " +
                "LEFT JOIN job_categories c2 ON b.sub_category = c2.cat_id " +
                "WHERE a.member_id = ? " +
                "ORDER BY a.seq DESC";
	    
	    return jdbc.query(sql, new BeanPropertyRowMapper<JobPostDTO>(JobPostDTO.class), id);
	}
	
	public int countApplyById(String id) {
	    String sql = "SELECT COUNT(*) FROM job_apply WHERE member_id = ?";
	    return jdbc.queryForObject(sql, Integer.class, id);
	}
}
