package com.kedu.controllers;

import java.util.List;

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
	public String jobpost(Model model, String searchKeyword) {
		List<JobPostDTO> list;
	    
	    if (searchKeyword != null && !searchKeyword.isEmpty()) {
	        // 검색어가 있을 때
	        list = dao.searchKeyword(searchKeyword);
	        model.addAttribute("searchKeyword", searchKeyword); // 검색창에 남겨두기용
	    } else {
	        list = dao.getList();
	    }
	    
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
	
	
}
