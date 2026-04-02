package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MypageDAO {

		@Autowired
		private JdbcTemplate jdbc;
		
		public boolean passwordCheck(String id, String pw) {
			String sql = "select pw from members where id = ?";
			String searchPw = jdbc.queryForObject(sql, String.class, id);
			if(searchPw.equals(pw)) {
				return true;
			}else {
				return false;
			}		
		}
		
		public int withdraw(String id, String pw) {
			String sql = "delete from members where id = ? and pw = ?";
			return jdbc.update(sql, id, pw);
		}
}
