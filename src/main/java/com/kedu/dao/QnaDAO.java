package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.QnaDTO;

@Repository
public class QnaDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public void insert(QnaDTO dto) {
		String sql = "insert into qna values(qna_seq.nextval,?,?,?,'status-waiting',sysdate)";
		jdbc.update(sql,dto.getMember_id(),dto.getTitle(),dto.getContent());
	}
	public List<QnaDTO> list(String member_id){
		String sql = "select * from qna where member_id = ?";
		return jdbc.query(sql,new BeanPropertyRowMapper<QnaDTO>(QnaDTO.class),member_id);
	}
	public List<QnaDTO> listAll(){
		String sql = "select * from qna";
		return jdbc.query(sql,new BeanPropertyRowMapper<QnaDTO>(QnaDTO.class));
	} 
	public QnaDTO detail(int seq) {
		String sql = "select * from qna where seq = ?";
		return jdbc.queryForObject(sql,new BeanPropertyRowMapper<QnaDTO>(QnaDTO.class),seq);
	}
	public void statusUpdate(int seq) {
		String sql = "update qna set status where seq = ?";
		jdbc.update(sql,seq);
	}
	public void update(QnaDTO dto) {
		String sql = "update qna set title = ? , content = ? where seq = ?";
		jdbc.update(sql,dto.getTitle(),dto.getContent(),dto.getSeq());
	}
	public void delete(int seq) {
		String sql = "delete from qna where seq = ?";
		jdbc.update(sql,seq);
	}

}
