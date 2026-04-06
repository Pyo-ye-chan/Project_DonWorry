package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.ReportDTO;
@Repository
public class ReportDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int report(ReportDTO dto) {
		String sql = "insert into report values(report_seq.nextval,?,?,?,?,sysdate,'접수')";
		return jdbc.update(sql,dto.getBoards_seq(),dto.getReply_seq(),dto.getMember_id(),dto.getReason());
	}

}
