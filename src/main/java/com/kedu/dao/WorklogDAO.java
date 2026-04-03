package com.kedu.dao;

import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.WorklogDTO;

@Repository
public class WorklogDAO {
	
	@Autowired
	public JdbcTemplate jdbc;
	
	public int insertWorklog(WorklogDTO dto, String id) {
		String sql = "insert into worklog (seq, id, parent_seq, work_Date,"
				+ "start_time, end_time, breaktime, night_pay, overtime_pay,"
				+ "holiday_pay, total_pay, memo, worklog_date) values("
				+ "worklog_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
		return jdbc.update(sql, id, dto.getParent_seq(), dto.getWork_date(),
					dto.getStart_time(),dto.getEnd_time(), dto.getBreaktime(),
					dto.getNight_pay(), dto.getOvertime_pay(), dto.getHoliday_pay(),
					dto.getTotal_pay(), dto.getMemo());
		}

}
