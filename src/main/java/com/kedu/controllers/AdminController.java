package com.kedu.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.MembersDAO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private MembersDAO dao;
	
	@RequestMapping("/admin_main")
	public String toAdmin() {
		return "admin/admin_main";
	}
	
	@RequestMapping("/admin_members")
	public String toMembers() {
		
//		dao.getMembersList();
		
		return "admin/admin_members";
	}
	
	@RequestMapping("/admin_boards")
	public String toBoards() {
		return "admin/admin_boards";
	}
	
	@RequestMapping("/notice_write")
	public String adminWrite() {
		return "admin/notice_write";
	}
	
	@RequestMapping("/admin_inquiry")
	public String toInquiry() {
		return "admin/admin_inquiry";
	}

}
