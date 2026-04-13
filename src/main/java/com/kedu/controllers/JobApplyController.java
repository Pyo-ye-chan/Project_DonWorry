package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kedu.dao.JobApplyDAO;
import com.kedu.dao.ResumeDAO;
import com.kedu.dto.ResumeDTO;

@Controller
@RequestMapping("/jobapplys")
public class JobApplyController {
	
	@Autowired
	public JobApplyDAO dao;
	
	@Autowired
	public ResumeDAO rdao;
	
	@RequestMapping("/insert")
	public String insert(int jobPostNum, int resumeNum, HttpSession session, RedirectAttributes rattr) {
	    String loginId = (String) session.getAttribute("loginId");
	    
	    if (dao.existsApply(loginId, jobPostNum)) {
	        rattr.addFlashAttribute("resume", "이미 지원하신 공고입니다.");
	        return "redirect:/jobposts/jobpost";
	    }
	    dao.insert(loginId, resumeNum, jobPostNum);
	    
	    rattr.addFlashAttribute("message", "지원이 완료되었습니다.");
	    return "redirect:/jobposts/jobpost";
	}
	
	@RequestMapping("/delete")
	public String delete(int seq, RedirectAttributes rattr) {
	    int result = dao.delete(seq);
	    
	    if(result > 0) {
	        rattr.addFlashAttribute("message", "지원이 취소되었습니다.");
	    } else {
	        rattr.addFlashAttribute("message", "지원 취소에 실패했습니다.");
	    }
	    
	    return "redirect:/mypage/job_activity";
	}
	
	@ResponseBody
	@RequestMapping("/getMyResumes")
	public List<ResumeDTO> getMyResumes(HttpSession session) {
	    String loginId = (String)session.getAttribute("loginId");
	    return rdao.myList(loginId); 
	}
}
