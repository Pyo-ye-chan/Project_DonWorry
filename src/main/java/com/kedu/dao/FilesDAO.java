package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.FilesDTO;

@Repository
public class FilesDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public void upload(FilesDTO dto) {
		String sql = "insert into files values(files_seq.nextval,?,?,?)";
		jdbc.update(sql,dto.getOriName(),dto.getSysName(),dto.getParent_seq());
	}
	public List<FilesDTO> selectByParent_seq(int seq){
		String sql = "select * from files where parent_seq = ?";
		return jdbc.query(sql,new BeanPropertyRowMapper<FilesDTO>(FilesDTO.class),seq);
		
	}
	public void deleteByParent_seq(int seq) {
		String sql = "delete from files where parent_seq = ?";
		jdbc.update(sql,seq);
	}
	
	
}
