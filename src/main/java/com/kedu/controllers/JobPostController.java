package com.kedu.controllers;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.CateGoryDAO;
import com.kedu.dao.JobPostDAO;
import com.kedu.dto.CateGoryDTO;
import com.kedu.dto.JobPostDTO;

@Controller
@RequestMapping("/jobposts")
public class JobPostController {
	
	@Autowired
	private JobPostDAO dao;
	@Autowired
    private CateGoryDAO catdao;

	@RequestMapping("/jobpost")
	public String jobpost(Model model, 
	                     String searchKeyword, 
	                     @RequestParam(value="page", defaultValue="1") int page,
	                     Integer starttime, Integer endtime) {
	    
	    List<JobPostDTO> jobList;
	    int recordTotalCount;
	    
	    // 시작 번호와 끝 번호 계산 (페이지당 7개씩)
	    int start = page * 7 - 6;
	    int end = page * 7;

	    // [중요] 아무것도 입력 안 했을 때(전체보기) null 처리를 확실하게!
	    // 검색어가 공백으로 넘어오면 null로 취급해야 전체 리스트가 나옴
	    if (searchKeyword != null && searchKeyword.trim().isEmpty()) {
	        searchKeyword = null; 
	    }

	    if (searchKeyword != null) {
	        // [검색어가 있을 때] DAO 파라미터 순서: (키워드, 시작row, 끝row, 시작시간, 종료시간)
	        jobList = dao.searchKeywordPaged(searchKeyword, start, end, starttime, endtime);
	        recordTotalCount = dao.getSearchTotalCount(searchKeyword, starttime, endtime);
	        
	        model.addAttribute("searchKeyword", searchKeyword);
	    } else {
	        // [기본 리스트] DAO 파라미터 순서: (시작row, 끝row, 시작시간, 종료시간)
	        // 기존에 start, end를 중복해서 넣던 부분을 starttime, endtime으로 수정함!
	        jobList = dao.jobList(start, end, starttime, endtime);
	        recordTotalCount = dao.jobRecordTotalCount(starttime, endtime);
	    }
	    
	    // JSP에 검색 조건 유지를 위해 시간 값도 다시 보냄 (페이징 클릭 시 유지용)
	    model.addAttribute("starttime", starttime);
	    model.addAttribute("endtime", endtime);
	    
	    // 페이징 네비게이터를 위한 속성들
	    model.addAttribute("currentPage", page);
	    model.addAttribute("recordCountPerPage", 7);
	    model.addAttribute("naviCountPerPage", 7);
	    model.addAttribute("recordTotalCount", recordTotalCount);
	    model.addAttribute("jobList", jobList);
	    
	    return "jobpost/jobpost";
	}
	
	@RequestMapping("/selectByLocation")
	public String selectByLocation(String selectByLocation, Model model) {
		List<JobPostDTO> list;
		list = dao.selectByLocation(selectByLocation);
		model.addAttribute("list", list);
		return "jobpost/jobpost";
	}


	@RequestMapping("/jobwrite")
	public String jobwrite(Model model){
		List<CateGoryDTO> upperList = catdao.getUpperCategories();
		
		model.addAttribute("upperList", upperList);
		
		return "jobpost/jobwrite";
	}
	
	@RequestMapping("/insert")
	public String insert(JobPostDTO dto, HttpSession session) {
		String memberId = (String) session.getAttribute("loginId");
        dto.setMember_id(memberId);
		
        dao.insert(dto);
		
		return "redirect:/jobposts/jobpost";
	}
	
	@ResponseBody
	@RequestMapping("/getSub")
    public List<CateGoryDTO> getSubCategories(@RequestParam("parentId") int parentId) {
        // 대분류 ID를 받아서 하위 카테고리 리스트 반환
        return catdao.getSubCategories(parentId);
    }
	
	@RequestMapping("/getUpperCategory")
	@ResponseBody
	public List<CateGoryDTO> getUpperCategory() {
	    return catdao.getUpperCategories(); // parent_id IS NULL 인 것들
	}

	@RequestMapping("/getSubCategory")
	@ResponseBody
	public List<CateGoryDTO> getSubCategory(@RequestParam("parentId") int parentId) {
	    return catdao.getSubCategories(parentId); // parent_id = ? 인 것들
	}
	
	@RequestMapping("/jobdetail")
	public String jobdetail(int seq, Model model) {
		JobPostDTO post = dao.getPostDetail(seq);
		
		model.addAttribute("post", post);
		return "jobpost/jobdetail";
	}
	
	
}
