package com.kedu.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kedu.dto.JobPostDTO;

@Repository
public class JobPostDAO {
    @Autowired
    private JdbcTemplate jdbc;

    // 공통 RowMapper: DB의 분 단위를 HH:mm 형식으로 변환
    private final RowMapper<JobPostDTO> jobPostMapper = (rs, rowNum) -> {
        JobPostDTO dto = new JobPostDTO();
        dto.setSeq(rs.getInt("seq"));
        dto.setMember_id(rs.getString("member_id"));
        dto.setCompany_name(rs.getString("company_name"));
        dto.setPhone(rs.getString("phone"));
        dto.setSido(rs.getString("sido"));
        dto.setGugun(rs.getString("gugun"));
        dto.setDong(rs.getString("dong"));
        dto.setAddress_detail(rs.getString("address_detail"));
        dto.setAddress(rs.getString("address"));
        dto.setCount(rs.getInt("count"));
        dto.setTitle(rs.getString("title"));
        dto.setPay(rs.getString("pay"));
        dto.setWork_days(rs.getString("work_days"));
        
        int startMin = rs.getInt("work_starttime");
        int endMin = rs.getInt("work_endtime");
        
        // 1440(자정)인 경우에도 % 60 연산을 하면 00분으로 잘 나옴
        dto.setWork_starttime(String.format("%02d:%02d", startMin / 60, startMin % 60));
        dto.setWork_endtime(String.format("%02d:%02d", endMin / 60, endMin % 60));

        dto.setMain_category(rs.getString("main_category"));
        dto.setSub_category(rs.getString("sub_category"));
        dto.setContent(rs.getString("content"));
        dto.setBenefit(rs.getString("benefit"));
        
        dto.setWrite_date(rs.getTimestamp("write_date"));
        
        try { dto.setMain_category_name(rs.getString("main_category_name")); } catch (Exception e) {}
        try { dto.setSub_category_name(rs.getString("sub_category_name")); } catch (Exception e) {}
        
        dto.setStatus(rs.getString("status")); // 마감 공고
        return dto;
    };

    // [1] 기본 리스트 조회
    public List<JobPostDTO> jobList(int start, int end, String workDay, Integer startT, Integer endT) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM ( SELECT p.*, c1.cat_name AS main_category_name, c2.cat_name AS sub_category_name, ");
        sql.append("ROW_NUMBER() OVER(ORDER BY p.write_date DESC) AS rn FROM job_post p ");
        sql.append("LEFT JOIN job_categories c1 ON p.main_category = c1.cat_id LEFT JOIN job_categories c2 ON p.sub_category = c2.cat_id ");
        sql.append("WHERE p.status = '진행중' "); // 마감 제외
        
        List<Object> params = new ArrayList<>();

        if (workDay != null && !workDay.isEmpty()) {
            sql.append(" AND p.work_days = ? ");
            params.add(workDay);
        }
        
        if (startT != null && endT != null) {
            sql.append(" AND ((p.work_starttime BETWEEN ? AND ?) OR (p.work_endtime BETWEEN ? AND ?)) ");
            params.add(startT); params.add(endT);
            params.add(startT); params.add(endT);
        }
        
        sql.append(") WHERE rn BETWEEN ? AND ?");
        params.add(start); params.add(end);
        
        return jdbc.query(sql.toString(), jobPostMapper, params.toArray());
    }

    // [2] 기본 리스트 총 개수
    public int jobRecordTotalCount(String workDay, Integer startT, Integer endT) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM job_post WHERE status = '진행중' ");
        List<Object> params = new ArrayList<>();
        
        if (workDay != null && !workDay.isEmpty()) {
            sql.append(" AND work_days = ? ");
            params.add(workDay);
        }

        if (startT != null && endT != null) {
            sql.append(" AND work_starttime >= ? AND work_endtime <= ? ");
            params.add(startT); params.add(endT);
        }
        return jdbc.queryForObject(sql.toString(), Integer.class, params.toArray());
    }

    // [3] 검색 리스트 조회
    public List<JobPostDTO> searchKeywordPaged(String keyword, int start, int end, String workDay, Integer startT, Integer endT) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM ( SELECT p.*, c1.cat_name AS main_category_name, c2.cat_name AS sub_category_name, ");
        sql.append("ROW_NUMBER() OVER(ORDER BY p.write_date DESC) AS rn FROM job_post p ");
        sql.append("LEFT JOIN job_categories c1 ON p.main_category = c1.cat_id ");
        sql.append("LEFT JOIN job_categories c2 ON p.sub_category = c2.cat_id ");
        sql.append("WHERE p.status = '진행중' "); // 마감 제외
        sql.append("AND (p.sido LIKE ? OR p.gugun LIKE ? OR p.dong LIKE ? OR p.title LIKE ? OR p.company_name LIKE ? ");
        sql.append("OR c1.cat_name LIKE ? OR c2.cat_name LIKE ?) ");
        
        String tag = "%" + keyword + "%";
        List<Object> params = new ArrayList<>();
        for(int i=0; i<7; i++) params.add(tag); 

        if (workDay != null && !workDay.isEmpty() && !workDay.equals("요일협의")) {
            sql.append(" AND p.work_days = ? ");
            params.add(workDay);
        }

        if (startT != null && endT != null) {
            sql.append(" AND p.work_starttime >= ? AND p.work_endtime <= ? ");
            params.add(startT); params.add(endT);
        }
        
        sql.append(") WHERE rn BETWEEN ? AND ?");
        params.add(start); params.add(end);
        
        return jdbc.query(sql.toString(), jobPostMapper, params.toArray());
    }

    // [4] 검색 결과 총 개수
    public int getSearchTotalCount(String keyword, String workDay, Integer startT, Integer endT) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM job_post p ");
        sql.append("LEFT JOIN job_categories c1 ON p.main_category = c1.cat_id ");
        sql.append("LEFT JOIN job_categories c2 ON p.sub_category = c2.cat_id ");
        sql.append("WHERE p.status = '진행중' "); // 마감 제외
        sql.append("AND (p.sido LIKE ? OR p.gugun LIKE ? OR p.dong LIKE ? OR p.title LIKE ? OR p.company_name LIKE ? ");
        sql.append("OR c1.cat_name LIKE ? OR c2.cat_name LIKE ?) ");
        
        String tag = "%" + keyword + "%";
        List<Object> params = new ArrayList<>();
        for(int i=0; i<7; i++) params.add(tag);
        
        if (workDay != null && !workDay.isEmpty() && !workDay.equals("요일협의")) {
            sql.append(" AND p.work_days = ? ");
            params.add(workDay);
        }

        if (startT != null && endT != null) {
            sql.append(" AND p.work_starttime >= ? AND p.work_endtime <= ? ");
            params.add(startT); params.add(endT);
        }
        
        return jdbc.queryForObject(sql.toString(), Integer.class, params.toArray());
    }
    
    public int getSearchTotalCountByLocation(String keyword, String workDay, Integer startT, Integer endT) {
        StringBuilder sql = new StringBuilder();
        String cleanKeyword = (keyword == null) ? "" : keyword.replaceAll("\\s", "");
        
        sql.append("SELECT COUNT(*) FROM job_post p WHERE p.status = '진행중' ");
        sql.append("AND REPLACE(NVL(p.sido, '') || NVL(p.gugun, '') || NVL(p.dong, ''), ' ', '') LIKE ? ");
        
        List<Object> params = new ArrayList<>();
        params.add("%" + cleanKeyword + "%");

        if (workDay != null && !workDay.isEmpty()) {
            sql.append(" AND p.work_days = ? ");
            params.add(workDay);
        }
        if (startT != null && endT != null) {
            sql.append(" AND p.work_starttime >= ? AND p.work_endtime <= ? ");
            params.add(startT); params.add(endT);
        }

        return jdbc.queryForObject(sql.toString(), Integer.class, params.toArray());
    }
    
    public int seqNextval() {
		String sql = "select job_post_seq.nextval from dual";
		return jdbc.queryForObject(sql,Integer.class);
	}

    // [5] 공고 등록 (0을 1440으로 변환하는 로직)
    public int insert(JobPostDTO dto) {
        String sql = "INSERT INTO job_post (seq, member_id, company_name, phone, sido, gugun, dong, address_detail, address, count, title, pay, work_days, work_starttime, work_endtime, main_category, sub_category, content, benefit, write_date) "
                   + "VALUES (job_post_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
        

//        String으로 넘어온다면 Integer로 파싱해서 체크 (DTO 필드 타입에 따라 맞춰주세요)
//        int startTime = Integer.parseInt(dto.getWork_starttime());
//        int endTime = Integer.parseInt(dto.getWork_endtime());
        
        String[] startArr = dto.getWork_starttime().split(":"); // 수정본
        int startTime = Integer.parseInt(startArr[0]) * 60 
                      + Integer.parseInt(startArr[1]);

        String[] endArr = dto.getWork_endtime().split(":");
        int endTime = Integer.parseInt(endArr[0]) * 60 
                    + Integer.parseInt(endArr[1]);

        
        // 종료 시간이 0(자정)이라면 1440으로 변경해서 DB 정합성 유지
        if(endTime == 0) {
            endTime = 1440;
        }
        System.out.println(dto.getMember_id() + dto.getCompany_name() + dto.getPhone() +
            dto.getSido() + dto.getGugun() + dto.getDong() + dto.getAddress_detail() + dto.getAddress() +
            dto.getCount() +  dto.getTitle() + dto.getPay() + dto.getWork_days() + 
            startTime + endTime + 
            dto.getMain_category() + dto.getSub_category() +
            dto.getContent() + dto.getBenefit());

        return jdbc.update(sql,
            dto.getMember_id(), dto.getCompany_name(), dto.getPhone(), 
            dto.getSido(), dto.getGugun(), dto.getDong(), dto.getAddress_detail(), dto.getAddress(),
            dto.getCount(), dto.getTitle(), dto.getPay(), dto.getWork_days(), 
            startTime, endTime, 
            dto.getMain_category(), dto.getSub_category(), 
            dto.getContent(), dto.getBenefit()
        );
    }
    
    public List<JobPostDTO> selectByLocationPaged(String keyword, int start, int end, String workDay, Integer starttime, Integer endtime) {
        String cleanKeyword = (keyword == null) ? "" : keyword.replaceAll("\\s", "");
        if (cleanKeyword.isEmpty()) return new ArrayList<>();

        String sql = "SELECT * FROM ( "
                   + "    SELECT p.*, c1.cat_name AS main_category_name, c2.cat_name AS sub_category_name, "
                   + "    ROW_NUMBER() OVER(ORDER BY p.write_date DESC) as rn "
                   + "    FROM job_post p "
                   + "    LEFT JOIN job_categories c1 ON p.main_category = c1.cat_id "
                   + "    LEFT JOIN job_categories c2 ON p.sub_category = c2.cat_id "
                   + "    WHERE p.status = '진행중' "
                   + "    AND REPLACE(NVL(p.sido, '') || NVL(p.gugun, '') || NVL(p.dong, ''), ' ', '') LIKE ? "
                   + ") WHERE rn BETWEEN ? AND ?";

        String searchTag = "%" + cleanKeyword + "%";
        
        return jdbc.query(sql, jobPostMapper, searchTag, start, end);
    }

    public JobPostDTO getPostDetail(int seq) {
        String sql = "SELECT p.*, c1.cat_name AS main_category_name, c2.cat_name AS sub_category_name FROM job_post p "
                   + "LEFT JOIN job_categories c1 ON p.main_category = c1.cat_id LEFT JOIN job_categories c2 ON p.sub_category = c2.cat_id WHERE p.seq = ?";
        return jdbc.queryForObject(sql, jobPostMapper, seq);
    }

    public List<JobPostDTO> mainJobList() {
        String sql = "SELECT * FROM ( SELECT p.*, c1.cat_name AS main_category_name, c2.cat_name AS sub_category_name, ROW_NUMBER() OVER(ORDER BY p.write_date DESC) AS rn "
                   + "FROM job_post p LEFT JOIN job_categories c1 ON p.main_category = c1.cat_id LEFT JOIN job_categories c2 ON p.sub_category = c2.cat_id "
                   + "WHERE p.status = '진행중' ) WHERE rn BETWEEN 1 AND 3"; // 마감 제외
        return jdbc.query(sql, jobPostMapper);
    }
    

	public int mypostRecordTotalCount(String memberId, String status) {
		String sql = "select count(*) from job_post where member_id = ? and status = ?";
		return jdbc.queryForObject(sql,Integer.class, memberId, status);
	}
    
    public List<JobPostDTO> selectById(String memberId, String status, int start, int end){
    	String sql = "select * from (select row_number() over(order by seq desc) as rn, jp.* from job_post jp "
    			+ "where member_id = ? and status = ?) where rn between ? and ?";
    	return jdbc.query(sql, jobPostMapper, memberId, status, start, end);
    }

    public int getPostCount() {
    	String sql = "select count(*) from job_post";
    	
    	return jdbc.queryForObject(sql, Integer.class);
    }
    
    public int recruitingJobCount() {
    	String sql = "select count(*) from job_post where status = '진행중'";
    	
    	return jdbc.queryForObject(sql, Integer.class);
    }
    
    public int JobPostUpdate(JobPostDTO dto) {
    	String sql = "update job_post set company_name = ?, phone = ?, sido = ?, gugun =?,"
    			+ "dong = ?, address_detail = ?, count = ?, title = ?, pay = ?,"
    			+ "work_days = ?, work_starttime = ?, work_endtime = ?,"
    			+ "main_category = ?, sub_category = ?, content = ?, benefit = ? where seq =?";
    	
    	String[] startArr = dto.getWork_starttime().split(":");
    	int startTime = Integer.parseInt(startArr[0]) * 60 
    	              + Integer.parseInt(startArr[1]);

    	String[] endArr = dto.getWork_endtime().split(":");
    	int endTime = Integer.parseInt(endArr[0]) * 60 
    	            + Integer.parseInt(endArr[1]);

    	if(endTime == 0) {
    	    endTime = 1440;
    	}
        // 종료 시간이 0(자정)이라면 1440으로 변경해서 DB 정합성 유지
        if(endTime == 0) {
            endTime = 1440;
        }

        
    	return jdbc.update(sql, dto.getCompany_name(), dto.getPhone(), dto.getSido(),
    			dto.getGugun(), dto.getDong(), dto.getAddress_detail(), dto.getCount(),
    			dto.getTitle(), dto.getPay(), dto.getWork_days(), startTime,
    			endTime, dto.getMain_category(), dto.getSub_category(),
    			dto.getContent(), dto.getBenefit(), dto.getSeq());
    }
    
    public void deletePost(int seq) {
    	String sql = "delete from job_post where seq=?";
    	jdbc.update(sql,seq);
    }
    
    
    public int closeJobPost(int seq) {
        String sql = "update job_post set status = ? where seq = ?";
        int result = jdbc.update(sql, "마감", seq);
        System.out.println("closeJobPost result : " + result);
        System.out.println("closeJobPost seq : " + seq);
        return result;
    }
    public int jobPostCount(String member_id) {
    	String sql = "select count(*) from job_post where member_id = ?";
    	return jdbc.queryForObject(sql,Integer.class,member_id);
    }

}