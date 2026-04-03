package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.WorkPlaceListDTO;

@Repository
public class WorkPlaceListDAO {
	
	@Autowired
	public JdbcTemplate jdbc;
	
	public List<WorkPlaceListDTO> selectAllById(String memberId){
		  String sql = "select w.seq, w.name, nvl(sum(l.total_pay), 0) as total_pay,"
		  		+ "count(l.seq) as workDays,"
		  		+ "nvl(sum((l.end_time - l.start_time) * 24), 0) as totalHours " 
		  		+ "from workplace w left join worklog l on w.seq = l.parent_seq " 
		  		+ "where w.id = ? group by w.seq, w.name order by w.seq";

	        return jdbc.query(sql, new BeanPropertyRowMapper<WorkPlaceListDTO>(WorkPlaceListDTO.class),
	        		memberId);
	}
	
}
