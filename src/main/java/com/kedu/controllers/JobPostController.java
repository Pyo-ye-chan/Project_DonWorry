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
	                     @RequestParam(value="page", defaultValue="1") int page) {
	    
	    List<JobPostDTO> jobList;
	    int recordTotalCount;
	    
	    // 시작 번호와 끝 번호 계산 (10개씩 보기 기준)
	    int start = page * 7 - 6;
	    int end = page * 7;

	    if (searchKeyword != null && !searchKeyword.isEmpty()) {
	        // [검색어가 있을 때] 검색 결과 리스트 + 검색 결과 총 개수
	        jobList = dao.searchKeywordPaged(searchKeyword, start, end);
	        recordTotalCount = dao.getSearchTotalCount(searchKeyword);
	        model.addAttribute("searchKeyword", searchKeyword);
	    } else {
	        // [기본 리스트] 전체 리스트 + 전체 총 개수
	        jobList = dao.jobList(start, end);
	        recordTotalCount = dao.jobRecordTotalCount();
	    }
	    
	    // 페이징 네비게이터를 위한 속성들 (게시판 로직과 동일)
	    model.addAttribute("currentPage", page);
	    model.addAttribute("recordCountPerPage", 10);
	    model.addAttribute("naviCountPerPage", 10);
	    model.addAttribute("recordTotalCount", recordTotalCount);
	    model.addAttribute("jobList", jobList); // 기존 "list"에서 "jobList"로 명칭 통일 권장
	    
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
