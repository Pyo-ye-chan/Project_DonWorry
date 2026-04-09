package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.JobApplyDTO;
@Repository
public class JobApplyDAO {
	
	@Autowired
	private JdbcTemplate jdbc;

	public int insert(String id, int resume_num, int jobPostNum) {
	    String sql = "INSERT INTO job_apply (seq, member_id, resume_num, job_post_num) "
	               + "VALUES (job_apply_seq.nextval, ?, ?, ?)";
	    
	    return jdbc.update(sql, id, resume_num, jobPostNum);
	}
	
	public boolean existsApply(String id, int jobPostNum) {
	    String sql = "SELECT COUNT(*) FROM job_apply WHERE member_id = ? AND job_post_num = ?";
	    int count = jdbc.queryForObject(sql, Integer.class, id, jobPostNum);
	    return count > 0;
	}
}
