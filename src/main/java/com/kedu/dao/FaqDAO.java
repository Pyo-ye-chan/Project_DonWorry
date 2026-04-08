package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.FaqDTO;

@Repository
public class FaqDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(FaqDTO dto) {
		String sql = "insert into faq values(faq_seq.nextval,?,?,sysdate,'Y',(SELECT NVL(MAX(SORT_ORDER), 0) + 1 FROM FAQ))";
		return jdbc.update(sql,dto.getTitle(),dto.getContent());
	}
	public List<FaqDTO> adminList(int start,int end){
		String sql = "SELECT * FROM (\r\n"
				+ "    SELECT \r\n"
				+ "        ROW_NUMBER() OVER(ORDER BY SORT_ORDER ASC, WRITE_DATE DESC) AS RN,\r\n"
				+ "        SEQ, \r\n"
				+ "        TITLE, \r\n"
				+ "        CONTENT, \r\n"
				+ "        IS_SHOW, \r\n"
				+ "        SORT_ORDER,\r\n"
				+ "        TO_CHAR(WRITE_DATE, 'YYYY-MM-DD') AS REG_DATE_STR\r\n"
				+ "    FROM FAQ\r\n"
				+ ")where rn between ? and ?";
		return jdbc.query(sql,new BeanPropertyRowMapper<FaqDTO>(FaqDTO.class),start,end);
	}
	public int getTotalCount() {
	    String sql = "SELECT COUNT(*) FROM FAQ";
	    return jdbc.queryForObject(sql, Integer.class);
	}
	public int updateIs_show(int seq, String is_show) {
		String sql = "update faq set is_show = ? where seq = ?";
		return jdbc.update(sql,is_show,seq);
	}
	public int updateSort(int seq, int sort_order) {
		String sql = "update faq set sort_order = ? where seq = ?";
		return jdbc.update(sql,sort_order,seq);
	}
	public void pushBackOrder(int sort_order) {
		String sql = "UPDATE FAQ SET SORT_ORDER = SORT_ORDER + 1 WHERE SORT_ORDER >= ?";
		jdbc.update(sql,sort_order);
	}
	public void pullBackOrder(int seq) {
	    // 수정할 FAQ의 현재 번호를 가져와서 그 뒤의 데이터들을 -1 합니다.
	    String sql = "UPDATE FAQ SET SORT_ORDER = SORT_ORDER - 1 " +
	                 "WHERE SORT_ORDER > (SELECT SORT_ORDER FROM FAQ WHERE SEQ = ?)";
	    jdbc.update(sql, seq);
	}
	public int delete(int seq) {
		String sql = "delete from faq where seq = ?";
		return jdbc.update(sql,seq);
	}
	

}
