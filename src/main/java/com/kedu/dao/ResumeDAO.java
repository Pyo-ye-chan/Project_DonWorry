package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.ResumeDTO;

@Repository
public class ResumeDAO {
	@Autowired
	private JdbcTemplate jdbc;
////int seq, String id, String title, String prferred_job, String working_condition, String career,
	//String career_write, String introduction, Timestamp resume_date	
	public int insert_resume(ResumeDTO dto) {
		String sql = "insert into resume values(resume_seq.nextval,?,?,?,?,?,?,?,sysdate)";
		return jdbc.update(sql,dto.getId(),dto.getTitle(),dto.getPrferred_job(),dto.getWorking_condition(),
				dto.getCareer(),dto.getCareer_write(),dto.getIntroduction());
	}
	
	public int getPrimaryResume(String id) {
		String sql = "select seq from resume where id=?";
		return jdbc.queryForObject(sql, Integer.class, id);
	}
}
