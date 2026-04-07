package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.Qna_replyDTO;

@Repository
public class Qna_replyDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public void insert(Qna_replyDTO dto) {
		String sql = "insert into qna_reply values(qna_reply_seq.nextval,?,?,?,sysdate)";
		jdbc.update(sql,dto.getQna_num(),dto.getMember_id(),dto.getContent());
	}
	public List<Qna_replyDTO>list(int qna_num){
		String sql = "select * from qna_reply where qna_num = ?";
		return jdbc.query(sql,new BeanPropertyRowMapper<Qna_replyDTO>(Qna_replyDTO.class),qna_num);
	}
	public int delete(int seq) {
		String sql = "delete from qna_reply where seq = ?";
		return jdbc.update(sql,seq);
	}
	public int update(int seq,String content) {
		String sql = "update qna_reply set content = ? , write_date = sysdate where seq = ?";
		return jdbc.update(sql,content,seq);
	}

}
