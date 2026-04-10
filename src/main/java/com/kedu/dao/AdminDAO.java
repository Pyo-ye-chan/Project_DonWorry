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
	
	// 신고된 게시글 총 개수 조회 (신고가 1건이라도 있는 게시글 수)
	public int getReportTotalCount() {
	    String sql = "SELECT COUNT(DISTINCT boards_seq) FROM report";
	    return jdbc.queryForObject(sql, Integer.class);
	}

	// 신고된 게시글 목록 조회 (페이징 + LISTAGG 포함)
	public List<BoardsDTO> admin_report_boardList_paging(int start, int end) {
	    String sql = "SELECT * FROM ( "
	               + "    SELECT "
	               + "        b.seq, b.title, m.nickname AS member_id, "
	               + "        b.write_date, b.category, "
	               + "        COUNT(rp.seq) AS report_count, "
	               + "        LISTAGG(rp.reason, ', ') WITHIN GROUP (ORDER BY rp.seq) AS reason, "
	               + "        ROW_NUMBER() OVER(ORDER BY b.seq DESC) AS rn "
	               + "    FROM boards b "
	               + "    JOIN members m ON b.member_id = m.id "
	               + "    JOIN report rp ON b.seq = rp.boards_seq "
	               + "    GROUP BY b.seq, b.title, m.nickname, b.write_date, b.category "
	               + ") WHERE rn BETWEEN ? AND ?";
	    
	    return jdbc.query(sql, new BeanPropertyRowMapper<>(BoardsDTO.class), start, end);
	}
	
	//신고 게시글 가져와야함
	public List<BoardsDTO> admin_report_boardList() {
	    String sql = "SELECT "
	               + "    b.seq, b.title, m.nickname AS member_id, "
	               + "    b.write_date, "
	               + "    COUNT(rp.seq) AS report_count, "
	               + "    LISTAGG(rp.reason, ', ') WITHIN GROUP (ORDER BY rp.seq) AS reason "
	               + "FROM boards b "
	               + "JOIN members m ON b.member_id = m.id " // 게시글 작성자 ID로 닉네임 조인
	               + "JOIN report rp ON b.seq = rp.boards_seq " // 게시글 신고는 보통 board_seq 컬럼 사용
	               + "GROUP BY b.seq, b.title, m.nickname, b.write_date "
	               + "HAVING COUNT(rp.seq) > 0 "
	               + "ORDER BY b.seq DESC";
	    
	    return jdbc.query(sql, new BeanPropertyRowMapper<>(BoardsDTO.class));
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
	
	//닉넴 키워드 검색 결과, 댓글 신고 카운트
		public int getReplyTotalCount(String category, String keyword) {
		    // 1. 기본 SQL (관리자 제외)
		    String sql = "SELECT COUNT(*) FROM ( "
		               + "    SELECT r.seq "
		               + "    FROM reply r "
		               + "    LEFT JOIN members m ON r.member_id = m.id "
		               + "    LEFT JOIN report rp ON r.seq = rp.reply_seq ";

		    // 2. 검색어 조건 추가
		    if (keyword != null && !keyword.trim().isEmpty()) {
		        sql += " WHERE m.nickname LIKE '%' || ? || '%' ";
		    }

		    sql += " GROUP BY r.seq ";

		    //  리스트 쿼리와 똑같은 HAVING 조건을 걸어줘야 개수가 같
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
	
	//댓글 작성자 검색 및 신고 일반 카테고리별 분류 리스트
	public List<ReplyDTO> searchReplyById(int start, int end, String keyword, String category) {
		String sql="SELECT * FROM (\r\n"
				+ "    SELECT \r\n"
				+ "        ROW_NUMBER() OVER (ORDER BY r.seq DESC) AS rn,\r\n"
				+ "        r.seq,r.parent_seq,\r\n"
				+ "        m.nickname AS member_id,\r\n"
				+ "        r.content,r.write_date,r.re_reply_seq,r.member_id AS writer,\r\n"
				+ "        COUNT(rp.seq) AS report_count -- 신고 테이블의 seq 카운트\r\n"
				+ "    FROM reply r \r\n"
				+ "    JOIN members m ON r.member_id = m.id\r\n"
				+ "    LEFT JOIN report rp ON r.seq = rp.reply_seq \r\n";
		
		boolean searchKeyword = (keyword != null && !keyword.trim().isEmpty());
		if(searchKeyword) {
			sql += "    WHERE m.nickname LIKE '%' || ? || '%' ";
		}
		sql += "    GROUP BY \r\n"
				+ "        r.seq, r.parent_seq, m.nickname, r.content, \r\n"
				+ "        r.write_date, r.re_reply_seq, r.member_id ";
				
		//신고 일반 카테고리 조건 추가
		if("report".equals(category)) {
			sql += " HAVING COUNT(distinct rp.seq)>0";
		}else if("normal".equals(category)) {
			sql += " HAVING COUNT(distinct rp.seq)=0";
		}
		sql +=") WHERE rn BETWEEN ? AND ?";
		
		if(searchKeyword) {
			return jdbc.query(sql, new BeanPropertyRowMapper<ReplyDTO>(ReplyDTO.class),keyword,start,end);
		}else {
			return jdbc.query(sql, new BeanPropertyRowMapper<ReplyDTO>(ReplyDTO.class),start,end);
		}
		
	}
	
	//신고된 댓글 가져옴
	public List<ReplyDTO> admin_report_replyList() {
		String sql = "SELECT "
	               + "    r.seq, r.parent_seq, m.nickname AS member_id, "
	               + "    r.content, r.write_date, r.re_reply_seq, r.member_id AS writer, "
	               + "    COUNT(rp.seq) AS report_count, "
	               + "    LISTAGG(rp.reason, ', ') WITHIN GROUP (ORDER BY rp.seq) AS reason " // rp.seq로 정렬하면 날짜 컬럼 없어도 안전합니다.
	               + "FROM reply r "
	               + "JOIN members m ON r.member_id = m.id "
	               + "JOIN report rp ON r.seq = rp.reply_seq "
	               + "GROUP BY "
	               + "    r.seq, r.parent_seq, m.nickname, r.content, "
	               + "    r.write_date, r.re_reply_seq, r.member_id "
	               + "HAVING COUNT(rp.seq) > 0 "
	               + "ORDER BY r.seq DESC";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<ReplyDTO>(ReplyDTO.class));
	}
	
}
