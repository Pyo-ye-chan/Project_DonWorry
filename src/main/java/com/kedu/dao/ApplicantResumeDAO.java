package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.ApplicantResumeDTO;

@Repository
public class ApplicantResumeDAO {

	@Autowired
	private JdbcTemplate jdbc;

	public List<ApplicantResumeDTO> selectApplicantResumeList(int jobPostNum) {
		String sql =
				"SELECT " +
						"    ja.seq AS apply_seq, " +
						"    ja.status AS apply_status, " +
						"    ja.job_post_num, " +
						"    ja.member_id, " +
						"    ja.resume_num, " +
						"    jp.title AS job_title, " +
						"    jp.company_name, " +
						"    r.title AS resume_title, " +
						"    r.preferred_job, " +
						"    r.working_condition, " +
						"    r.career, " +
						"    r.career_write, " +
						"    r.introduction, " +
						"    r.resume_date " +
						"FROM job_apply ja " +
						"JOIN job_post jp ON ja.job_post_num = jp.seq " +
						"JOIN resume r ON ja.resume_num = r.seq AND ja.member_id = r.id " +
						"WHERE ja.job_post_num = ? " +
						"ORDER BY ja.seq DESC";

		return jdbc.query(sql, new BeanPropertyRowMapper<>(ApplicantResumeDTO.class), jobPostNum);
	}

	public List<ApplicantResumeDTO> selectApplicantsByPost(int jobPostNum) {

	    String sql = "SELECT "
	            + "ja.seq AS apply_seq, "
	            + "ja.job_post_num AS job_post_num, "
	            + "ja.member_id AS member_id, "
	            + "ja.resume_num AS resume_num, "
	            + "ja.status AS apply_status, "
	            + "m.name AS name, "
	            + "m.phone AS phone, "
	            + "r.title AS resume_title "
	            + "FROM job_apply ja "
	            + "JOIN members m ON ja.member_id = m.id "
	            + "LEFT JOIN resume r ON ja.resume_num = r.seq AND ja.member_id = r.id "
	            + "WHERE ja.job_post_num = ? "
	            + "ORDER BY ja.seq DESC";
	

		return jdbc.query(sql, new BeanPropertyRowMapper<>(ApplicantResumeDTO.class), jobPostNum);
	}

}
