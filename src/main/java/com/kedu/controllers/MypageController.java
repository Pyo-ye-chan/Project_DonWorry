package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kedu.commons.EncryptionUtils;
import com.kedu.dao.MypageDAO;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Autowired
	private MypageDAO dao;
	
	@Autowired
	private Gson gson;
	
	private EncryptionUtils eu = new EncryptionUtils();
	
	@RequestMapping("/toMypage")
	public String toMypage() {
		return "mypage/mypage";
	}
	
	@RequestMapping("/toProfile")
	public String toProfile() {
		return "mypage/profile";
	}
	
	@RequestMapping("/toAccount")
	public String toAccount() {
		return "mypage/account";
	}
	
	@RequestMapping("/toWithdraw")
	public String toWithdraw() {
		return "mypage/withdraw";
	}
	
	@ResponseBody
	@RequestMapping("/passwordCheck")
	public boolean passwordCheck(String memberPw, HttpSession session) {
		String pw = eu.getSha512(memberPw);
		String id = (String)session.getAttribute("loginId");
		return dao.passwordCheck(id, pw);	
	}
	
	@ResponseBody
	@RequestMapping("/withdraw")
	public boolean withdraw(String memberPw, HttpSession session) {
		String pw = eu.getSha512(memberPw);
		String id = (String)session.getAttribute("loginId");
		int result = dao.withdraw(id, pw);
		return result > 0;
		
	}
	
}
