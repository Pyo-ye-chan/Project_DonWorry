package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kedu.commons.EncryptionUtils;
import com.kedu.dao.BoardsDAO;
import com.kedu.dao.FilesDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dao.MypageDAO;
import com.kedu.dto.BoardsDTO;
import com.kedu.dto.FilesDTO;
import com.kedu.dto.MembersDTO;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Autowired
	private MembersDAO mdao;
	@Autowired
	private MypageDAO dao;
	@Autowired
	private BoardsDAO bdao;
	@Autowired
	private FilesDAO fdao;
	
	@Autowired
	private Gson gson;
	
	private EncryptionUtils eu = new EncryptionUtils();
	
	@RequestMapping("/toMypage")
	public String toMypage(HttpSession session, Model model) {
		String id =(String)session.getAttribute("loginId");	
		List<MembersDTO> list = mdao.selectAll(id);
		String type = (String)session.getAttribute("type");
		model.addAttribute("list",list);
		
		return "mypage/mypage";
	}
	
	@RequestMapping("/toProfile")
	public String toProfile(HttpSession session, Model model) {
		String id =(String)session.getAttribute("loginId");	
		List<MembersDTO> list = mdao.selectAll(id);		
		model.addAttribute("list",list);
		
		return "mypage/profile";
	}
	
	@RequestMapping("/profile_update")
	public String updateProfile(HttpSession session, MembersDTO dto) {
		String id =(String)session.getAttribute("loginId");	
		String type = (String)session.getAttribute("type");
		int up = mdao.updateMember(id.trim(),dto);
		return "redirect:/mypage/toProfile";
	}
	
	@RequestMapping("/job_activity")
	public String to_Job_activity(HttpSession session) {
		String id =(String)session.getAttribute("loginId");	
		String type = (String)session.getAttribute("type");
		
		List<MembersDTO> list = mdao.selectAll(id);	
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
		if(result > 0) {
			session.invalidate();
		}
		return result > 0;
		
	}
	
	@RequestMapping("/employ_activity")
	public String toEmploy_activity() {
		return "mypage/employ_activity";
	}
	
	@RequestMapping("/mypost")
	public String toMypost(HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("loginId");
		List<BoardsDTO> allList = bdao.selectById(memberId);
		model.addAttribute("allList", allList);
		return "mypage/mypost";
	}
	
	@RequestMapping("/view")
	public String view_count(int seq,int view_count) {
		bdao.view_count(seq,view_count);
		return "redirect:/mypage/mypostdetail?seq="+seq;
	}
	
	@RequestMapping("/mypostdetail")
	public String detail(int seq,Model model,HttpSession session) {
		BoardsDTO dto = bdao.detail(seq);
		
		model.addAttribute("dto",dto);
		
		List<FilesDTO> filesList = fdao.selectByParent_seq(seq);
		model.addAttribute("filesList",filesList);
		String writer = bdao.writer(seq);
		model.addAttribute("board_writer",writer);
		
		return "mypage/mypostdetail";
	}
	
}
