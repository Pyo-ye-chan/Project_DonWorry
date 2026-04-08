package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BookmarkDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public boolean isBookmarkExist(int board_seq,String loginId) {
		String sql = "select count(*) from bookmark where board_seq = ? and member_id = ?";
		int result = jdbc.queryForObject(sql,Integer.class,board_seq,loginId);
		return result > 0;
	}
	public void deleteBookmark(int board_seq,String loginId) {
		String sql = "delete from bookmark where board_seq = ? and member_id = ?";
		jdbc.update(sql,board_seq,loginId);
	}
	public void insertBookmark(int board_seq,String loginId) {
		String sql = "insert into bookmark values(sysdate,?,?)";
		jdbc.update(sql,board_seq,loginId);
	}
	public int countBookmark(String id) {
		String sql = "select count(*) from bookmark where member_id = ?";
		return jdbc.queryForObject(sql,Integer.class,id);
				
	}

}
