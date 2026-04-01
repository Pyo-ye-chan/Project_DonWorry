package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.MembersDAO;
import com.kedu.dto.MembersDTO;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Autowired
	private MembersDAO dao;
	
	@RequestMapping("/toMypage")
	public String toMypage() {
		return "mypage/mypage";
	}
	
	@RequestMapping("/toProfile")
	public String toProfile(HttpSession session, Model model) {
		System.out.println("select profile");
		String id = (String) session.getAttribute("targetId");
		List<MembersDTO> list = dao.selectAll(id);		
		System.out.println("list size:"+list.size());
		model.addAttribute("list",list);
		
		return "mypage/profile";
	}
	
	@RequestMapping("/job_activity")
	public String to_Job_activity() {
		return "mypage/job_activity";
	}
	
	@RequestMapping("/toAccount")
	public String toAccount() {
		return "mypage/account";
	}
	
	@RequestMapping("/toWithdraw")
	public String toWithdraw() {
		return "mypage/withdraw";
	}
	
}
