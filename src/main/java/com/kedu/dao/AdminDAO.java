package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.BoardsDTO;
import com.kedu.dto.ReplyDTO;

@Repository
public class AdminDAO {

	@Autowired
	private JdbcTemplate jdbc;
	
	//오늘 작성된 새 게시글
	public int getRecordCountToday() {
		String sql ="SELECT COUNT(*) FROM boards WHERE write_date >= TRUNC(SYSDATE)";
		return jdbc.queryForObject(sql, Integer.class);
	}
	//게시글 신고 카운트
	public int getRecordTotalCount(String category, String keyword) {
	    // 1. 기본 SQL (관리자 제외)
	    String sql = "SELECT COUNT(*) FROM ( "
	               + "    SELECT b.seq "
	               + "    FROM boards b "
	               + "    LEFT JOIN members m ON b.member_id = m.id "
	               + "    LEFT JOIN report rp ON b.seq = rp.boards_seq "
	               + "    WHERE b.member_id != 'admin' ";

	    // 2. 검색어 조건 추가
	    if (keyword != null && !keyword.trim().isEmpty()) {
	        sql += " AND m.nickname LIKE '%' || ? || '%' ";
	    }

	    sql += " GROUP BY b.seq ";

	    // 3. [핵심] 리스트 쿼리와 똑같은 HAVING 조건을 걸어줘야 개수가 맞습니다!
	    if ("report".equals(category)) {
	        sql += " HAVING COUNT(rp.seq) > 0 ";
	    } else if ("normal".equals(category)) {
	        sql += " HAVING COUNT(rp.seq) = 0 ";
	    }

	    sql += " )";

	    if (keyword != null && !keyword.trim().isEmpty()) {
	        return jdbc.queryForObject(sql, Integer.class, keyword);
	    } else {
	        return jdbc.queryForObject(sql, Integer.class);
	    }
	}
	//게시글 작성자로 검색
	public List<BoardsDTO> searchById(int start, int end, String keyword ,String category) {
		String sql = "SELECT * FROM ( "
	            + "    SELECT "
	            + "        b.seq, "
	            + "        m.nickname AS member_id, "
	            + "        b.category, "
	            + "        b.title, "
	            + "        b.content, "
	            + "        b.view_count, "
	            + "        b.write_date, "
	            + "        COUNT(DISTINCT r.seq) AS reply_count, "
	            + "        COUNT(DISTINCT rp.seq) AS report_count, "
	            + "    ROW_NUMBER() OVER("
	            + "        ORDER BY "
	            + "            CASE WHEN '" + category + "' = 'report' THEN COUNT(DISTINCT rp.seq) ELSE 0 END DESC, " 
	            + "            b.seq DESC"
	            + "    ) AS rn "
	            + "    FROM boards b "
	            + "    LEFT JOIN members m ON b.member_id = m.id "
	            + "    LEFT JOIN reply r ON b.seq = r.parent_seq "
	            + "    LEFT JOIN report rp ON b.seq = rp.boards_seq "
	            + "    WHERE m.nickname LIKE '%' || ? || '%' AND b.member_id != 'admin' "
	            + "    GROUP BY b.seq, m.nickname, b.category, b.title, b.content, b.view_count, b.write_date ";

		//신고 일반 카테고리 조건 추가
				if("report".equals(category)) {
					sql += " HAVING COUNT(distinct rp.seq)>0";
				}else if("normal".equals(category)) {
					sql += " HAVING COUNT(distinct rp.seq)=0";
				}
				sql +=") WHERE rn BETWEEN ? AND ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class),keyword,start,end);
	}
	
	//게시글 가져옴
	public List<BoardsDTO> admin_boardList(int start, int end,String category) {
		String sql = "SELECT * FROM ( "
	            + "    SELECT "
	            + "        b.seq, "
	            + "        m.nickname AS member_id, "
	            + "        b.category, "
	            + "        b.title, "
	            + "        b.content, "
	            + "        b.view_count, "
	            + "        b.write_date, "
	            + "        COUNT(DISTINCT r.seq) AS reply_count, "
	            + "        COUNT(DISTINCT rp.seq) AS report_count, "
	            + "        ROW_NUMBER() OVER("
	            + "            ORDER BY "
	            + "                CASE WHEN '" + category + "' = 'report' THEN COUNT(DISTINCT rp.seq) ELSE 0 END DESC, "
	            + "                b.seq DESC"
	            + "        ) AS rn "
	            + "    FROM boards b "
	            + "    LEFT JOIN members m ON b.member_id = m.id "
	            + "    LEFT JOIN reply r ON b.seq = r.parent_seq "
	            + "    LEFT JOIN report rp ON b.seq = rp.boards_seq "
	            + "    WHERE b.member_id != 'admin' "
	            + "    GROUP BY b.seq, m.nickname, b.category, b.title, b.content, b.view_count, b.write_date ";

	    // 만약 category 조건이 들어오면 HAVING 절을 추가
	    if ("report".equals(category)) {
	        sql += " HAVING COUNT(DISTINCT rp.seq) > 0 ";
	    } else if ("normal".equals(category)) {
	        sql += " HAVING COUNT(DISTINCT rp.seq) = 0 ";
	    }

	    // [중요] 여기서 괄호를 '하나'만 닫아야 합니다!
	    sql += " ) WHERE rn BETWEEN ? AND ? ";
	    
	    return jdbc.query(sql, new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class), start, end);
	}
	

	//공지글만 가져옴
	public List<BoardsDTO> adminNoticeList(){
		String sql = "select \r\n"
				+ "        b.seq, \r\n"
				+ "        m.nickname as member_id, \r\n"
				+ "        b.category, \r\n"
				+ "        b.title, \r\n"
				+ "        b.content, \r\n"
				+ "        b.view_count, \r\n"
				+ "        b.write_date,\r\n"
				+ "        count(r.seq) as reply_count \r\n"
				+ "from boards b \r\n"
				+ "left join members m on b.member_id = m.id \r\n"
				+ "left join reply r on b.seq = r.parent_seq \r\n"
				+ "WHERE b.member_id = 'admin' \r\n"
				+ "group by \r\n"
				+ "        b.seq, m.nickname, b.category, b.title, \r\n"
				+ "        b.content, b.view_count, b.write_date \r\n"
				+ "order by b.seq desc" ;
		
		return jdbc.query(sql,new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class));		
	}
	
	//닉넴 키워드 검색 결과 카운트
	public int getReplySearchCount(String keyword) {
	    String sql = "SELECT COUNT(*) "
	               + "FROM reply r "
	               + "JOIN members m ON r.member_id = m.id "
	               + "WHERE m.nickname LIKE '%' || ? || '%'";
	    
	    return jdbc.queryForObject(sql, Integer.class, keyword);
	}
	
	//댓글 작성자 검색
	public List<ReplyDTO> searchReplyById(int start, int end, String keyword) {
		String sql="SELECT * FROM (\r\n"
				+ "    SELECT \r\n"
				+ "        ROW_NUMBER() OVER (ORDER BY r.seq DESC) AS rn,\r\n"
				+ "        r.seq,r.parent_seq,\r\n"
				+ "        m.nickname AS member_id,\r\n"
				+ "        r.content,r.write_date,r.re_reply_seq,r.member_id AS writer,\r\n"
				+ "        COUNT(rp.seq) AS report_count -- 신고 테이블의 seq 카운트\r\n"
				+ "    FROM reply r \r\n"
				+ "    JOIN members m ON r.member_id = m.id\r\n"
				+ "    LEFT JOIN report rp ON r.seq = rp.reply_seq \r\n"
				+ "    WHERE m.nickname LIKE '%' || ? || '%' "
				+ "    GROUP BY \r\n"
				+ "        r.seq, r.parent_seq, m.nickname, r.content, \r\n"
				+ "        r.write_date, r.re_reply_seq, r.member_id\r\n"
				+ ") \r\n"
				+ "WHERE rn BETWEEN ? AND ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<ReplyDTO>(ReplyDTO.class),keyword,start,end);
	}
	//댓글 가져옴
	public List<ReplyDTO> admin_replyList(int start, int end) {
		String sql="SELECT * FROM (\r\n"
				+ "    SELECT \r\n"
				+ "        ROW_NUMBER() OVER (ORDER BY r.seq DESC) AS rn,\r\n"
				+ "        r.seq,\r\n"
				+ "        r.parent_seq,\r\n"
				+ "        m.nickname AS member_id,\r\n"
				+ "        r.content,\r\n"
				+ "        r.write_date,\r\n"
				+ "        r.re_reply_seq,\r\n"
				+ "        r.member_id AS writer,\r\n"
				+ "        COUNT(rp.seq) AS report_count -- 신고 테이블의 seq 카운트\r\n"
				+ "    FROM reply r \r\n"
				+ "    JOIN members m ON r.member_id = m.id\r\n"
				+ "    LEFT JOIN report rp ON r.seq = rp.reply_seq -- 댓글 번호로 신고 테이블 조인\r\n"
				+ "    GROUP BY \r\n"
				+ "        r.seq, r.parent_seq, m.nickname, r.content, \r\n"
				+ "        r.write_date, r.re_reply_seq, r.member_id\r\n"
				+ ") \r\n"
				+ "WHERE rn BETWEEN ? AND ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<ReplyDTO>(ReplyDTO.class),start,end);
	}
	
	//신고된 댓글 가져옴
	public List<ReplyDTO> admin_report_replyList() {
		String sql="SELECT \r\n"
				+ "    r.seq, r.parent_seq, m.nickname AS member_id, \r\n"
				+ "    r.content, r.write_date, r.re_reply_seq, r.member_id AS writer,\r\n"
				+ "    COUNT(rp.seq) AS report_count\r\n"
				+ "FROM reply r \r\n"
				+ "JOIN members m ON r.member_id = m.id\r\n"
				+ "JOIN report rp ON r.seq = rp.reply_seq \r\n"
				+ "GROUP BY \r\n"
				+ "    r.seq, r.parent_seq, m.nickname, r.content, \r\n"
				+ "    r.write_date, r.re_reply_seq, r.member_id\r\n"
				+ "HAVING COUNT(rp.seq) > 0 -- 신고가 1개 이상인 것만\r\n"
				+ "ORDER BY r.seq DESC";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<ReplyDTO>(ReplyDTO.class));
	}
	
}
