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
	
	public List<WorkPlaceListDTO> selectAllByIdCard(String memberId, int year, int month){
		  String sql =  "select w.seq, w.name, nvl(sum(l.total_pay), 0) as total_pay, "
		          + "count(l.seq) as work_days, "
		          + "nvl(sum((l.end_time - l.start_time) * 24), 0) as total_hours "
		          + "from workplace w "
		          + "left join worklog l "
		          + "on w.seq = l.parent_seq "
		          + "and extract(year from l.start_time) = ? "
		          + "and extract(month from l.start_time) = ? "
		          + "where w.id = ? and w.status = 'Y' "
		          + "group by w.seq, w.name "
		          + "order by w.seq";

	        return jdbc.query(sql, new BeanPropertyRowMapper<WorkPlaceListDTO>(WorkPlaceListDTO.class), 
	        		year, month, memberId);
	}
	
	public List<WorkPlaceListDTO> selectAllByIdDetail(String memberId){
		  String sql = "select w.seq, w.name, l.work_date, l.seq as log_seq, nvl(sum(l.total_pay), 0) as total_pay,"
		  		+ "count(l.seq) as work_days,"
		  		+ "nvl(sum((l.end_time - l.start_time) * 24), 0) as total_hours,"
		  		+ "w.pay_per_hour, w.pay_type, w.tax_applied, w.insurance_applied, w.employment_insurance " 
		  		+ "from workplace w left join worklog l on w.seq = l.parent_seq " 
		  		+ "where w.id = ? group by w.seq, w.name, l.work_date, l.seq,"
		  		+ "w.pay_per_hour, w.pay_type, w.tax_applied, w.insurance_applied, w.employment_insurance "
		  		+ "order by w.seq";

	        return jdbc.query(sql, new BeanPropertyRowMapper<WorkPlaceListDTO>(WorkPlaceListDTO.class),
	        		memberId);
	}
	
	public List<WorkPlaceListDTO> selectAllByIdHome(String memberId){
		  String sql =  "select w.seq, w.name, nvl(sum(l.total_pay), 0) as total_pay, "
		          + "count(l.seq) as work_days, "
		          + "nvl(sum((l.end_time - l.start_time) * 24), 0) as total_hours "
		          + "from workplace w "
		          + "left join worklog l "
		          + "on w.seq = l.parent_seq "
		          + "where w.id = ? and w.status = 'Y' "
		          + "group by w.seq, w.name "
		          + "order by w.seq";

	        return jdbc.query(sql, new BeanPropertyRowMapper<WorkPlaceListDTO>(WorkPlaceListDTO.class), 
	        		memberId);
	}
	
}
