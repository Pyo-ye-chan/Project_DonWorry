package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
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
		String sql = "insert into resume values(resume_seq.nextval,?,?,?,?,?,?,?,'Y',sysdate)";
		return jdbc.update(sql,dto.getId(),dto.getTitle(),dto.getPreferred_job(),dto.getWorking_condition(),
				dto.getCareer(),dto.getCareer_write(),dto.getIntroduction());
	}
	
	public int getPrimaryResume(String id) {
		String sql = "select seq from resume where id=?";
		return jdbc.queryForObject(sql, Integer.class, id);
	}
	public List<ResumeDTO> myList(String id){
		String sql = "select * from resume where id = ? order by resume_date desc";
		return jdbc.query(sql,new BeanPropertyRowMapper<ResumeDTO>(ResumeDTO.class),id);
	}
	public int countById(String id) {
		String sql = "select count(*) from resume where id = ?";
		return jdbc.queryForObject(sql,Integer.class,id);
	}
	public ResumeDTO detail(int seq) {
		String sql = "SELECT r.*, m.phone, m.email " +
	             "FROM resume r " +
	             "JOIN members m ON r.id = m.id " +
	             "WHERE r.seq = ?";
		return jdbc.queryForObject(sql,new BeanPropertyRowMapper<ResumeDTO>(ResumeDTO.class),seq);
	}
	public void delete(int seq) {
		String sql = "delete from resume where seq = ?";
		jdbc.update(sql,seq);
	}
	public void update(ResumeDTO dto) {
		String sql = "update resume set title = ? , preferred_job = ? , working_condition = ?,"
				+ "career = ?, career_write =? ,introduction = ? where seq = ?";
		jdbc.update(sql,dto.getTitle(),dto.getPreferred_job(),dto.getWorking_condition(),
				dto.getCareer(),dto.getCareer_write(),dto.getIntroduction(),dto.getSeq());
	}
}
