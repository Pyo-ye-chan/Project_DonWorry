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
			@RequestParam(value="searchKeyword", required=false) String searchKeyword, 
			@RequestParam(value="page", defaultValue="1") int page,
			@RequestParam(value="workDay", required=false) String workDay, 
			@RequestParam(value="startTime", required=false) Integer starttime, 
			@RequestParam(value="endTime", required=false) Integer endtime) {

		List<JobPostDTO> jobList;
		int recordTotalCount;

		// 한 페이지에 7개씩 보여주기로 했으니까!
		int recordCountPerPage = 7; 
		int naviCountPerPage = 7;

		int start = page * recordCountPerPage - (recordCountPerPage - 1);
		int end = page * recordCountPerPage;

		if (searchKeyword != null && searchKeyword.trim().isEmpty()) {
			searchKeyword = null; 
		}

		if (searchKeyword != null) {
			jobList = dao.searchKeywordPaged(searchKeyword, start, end, workDay, starttime, endtime);
			recordTotalCount = dao.getSearchTotalCount(searchKeyword, workDay, starttime, endtime);
			model.addAttribute("searchKeyword", searchKeyword);
		} else {
			jobList = dao.jobList(start, end, workDay, starttime, endtime);
			recordTotalCount = dao.jobRecordTotalCount(workDay, starttime, endtime);
		}

		// [여기가 핵심!] JSP의 페이징 계산식에서 사용할 변수들을 꼭 보내줘야 함
		model.addAttribute("recordCountPerPage", recordCountPerPage); // 이게 없어서 Infinity 뜬 거야!
		model.addAttribute("naviCountPerPage", naviCountPerPage);

		model.addAttribute("workDay", workDay);
		model.addAttribute("starttime", starttime);
		model.addAttribute("endtime", endtime);
		model.addAttribute("currentPage", page);
		model.addAttribute("recordTotalCount", recordTotalCount);
		model.addAttribute("jobList", jobList);

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
