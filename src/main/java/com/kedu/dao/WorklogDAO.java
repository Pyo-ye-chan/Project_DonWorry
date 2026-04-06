package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.WorklogDTO;

@Repository
public class WorklogDAO {
	
	@Autowired
	public JdbcTemplate jdbc;
	
	public int insertWorklog(WorklogDTO dto, String memberId) {
		String sql = "insert into worklog (seq, id, parent_seq, work_Date,"
				+ "start_time, end_time, breaktime, night_pay, overtime_pay,"
				+ "holiday_pay, total_pay, memo, worklog_date) values("
				+ "worklog_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
		return jdbc.update(sql, memberId, dto.getParent_seq(), dto.getWork_date(),
					dto.getStart_time(),dto.getEnd_time(), dto.getBreaktime(),
					dto.getNight_pay(), dto.getOvertime_pay(), dto.getHoliday_pay(),
					dto.getTotal_pay(), dto.getMemo());
		}

	public List<WorklogDTO> selectAllById(String memberId) {
		String sql = "select * from worklog where id = ?";
		List<WorklogDTO> list = jdbc.query(sql, new BeanPropertyRowMapper<WorklogDTO>(WorklogDTO.class), memberId);
		return list;
	}
	
	public WorklogDTO selectBySeq(int seq) {
		String sql = "select * from worklog where seq = ?";
		List<WorklogDTO> list = jdbc.query(sql, new BeanPropertyRowMapper<>(WorklogDTO.class), seq);
	    if(list.isEmpty()) {
	        return null; // 없으면 null 반환
	    }
		System.out.println(list.size());
		return list.get(0);
	}	
}
