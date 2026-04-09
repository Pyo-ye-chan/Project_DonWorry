package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kedu.dao.JobApplyDAO;
import com.kedu.dao.ResumeDAO;

@Controller
@RequestMapping("/jobapplys")
public class JobApplyController {
	
	@Autowired
	public JobApplyDAO dao;
	
	@Autowired
	public ResumeDAO rdao;
	
	@RequestMapping("/insert")
	public String insert(int jobPostNum, HttpSession session, Model model, RedirectAttributes rattr) {
		String loginId = (String)session.getAttribute("loginId");
		if (dao.existsApply(loginId, jobPostNum)) {
			rattr.addFlashAttribute("error", "이미 지원하신 공고입니다.");
	        return "redirect:/jobposts/jobpost";
	    }
		
		int resumeNum = rdao.getPrimaryResume(loginId);
		
		dao.insert(loginId, resumeNum, jobPostNum);
		rattr.addFlashAttribute("message", "지원이 완료되었습니다.");
		
		return "redirect:/jobposts/jobpost";
	}
}
