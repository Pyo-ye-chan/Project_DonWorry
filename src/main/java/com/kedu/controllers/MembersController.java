package com.kedu.controllers;

import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.commons.EncryptionUtils;
import com.kedu.dao.MembersDAO;
import com.kedu.dto.MembersDTO;

@Controller
@RequestMapping("/members")
public class MembersController {
	
	@Autowired
	private MembersDAO dao;
	@Autowired
    private JavaMailSender mailSender;
	
	private EncryptionUtils eu = new EncryptionUtils();
	
	@RequestMapping("/toLogin")
	public String toLogin() {
		return "/members/login";
	}
	
	@RequestMapping("/login")
	public String login(String id, String pw,HttpSession session) {
		
		boolean result = dao.login(id,eu.getSha512(pw));
		if(result) {	
			session.setAttribute("loginId",id);
			session.setAttribute("nickName", dao.getNickname(id));	
			session.setAttribute("type", dao.getType(id));	
		}
		return "redirect:/";
	}

	@RequestMapping("/toIdSearch")
	public String toIdSearch() {
		return "/members/idSearch";
	}
	@ResponseBody
	@RequestMapping("/idSearch")
	public String idSearch(String name, String email) {
		String id = dao.idSearch(name,email);
		return id;
	}
	
	@RequestMapping("/toSignUp")
	public String toSignUp() {
		return "/members/joinform";
	}
	
	@RequestMapping("/signup")
	public String signup(MembersDTO dto, String rrn_front, String rrn_back) {
		dto.setRrn(rrn_front + "-" + rrn_back);
		dto.setPw(eu.getSha512(dto.getPw()));
		dao.signup(dto);
		
		return "redirect:/";
	}
	
	@RequestMapping("/toPwSearch")
	public String toPwSearch() {
		return "/members/toPwSearch";
	}
	
	@RequestMapping(value = "/sendAuthCode", method = RequestMethod.POST)
	@ResponseBody
	public String sendAuthCode(String id, String email, HttpSession session) {

	    int result = dao.checkMemberForPw(id, email); 

	    if (result == 0) {
	        return "not_found"; 
	    }

	    int checkNum = new Random().nextInt(888888) + 111111;
	    String authCode = String.valueOf(checkNum);
	    
	    try {
	        MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");

	        helper.setFrom("dlawndud6544@gmail.com");
	        helper.setTo(email);
	        helper.setSubject("[돈워리] 비밀번호 찾기 인증번호입니다.");
	        helper.setText("안녕하세요. 돈워리입니다.<br>인증번호는 <b>" + authCode + "</b> 입니다.", true);

	        mailSender.send(message);

	        session.setAttribute("authCode", authCode); 
	        session.setAttribute("targetId", id);       
	        return "success";

	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error";
	    }
	}
	
	@ResponseBody
	@RequestMapping(value = "/verifyAuthCode", method = RequestMethod.POST)
	public String verifyAuthCode(String inputCode, HttpSession session) {
	    String authCode = (String) session.getAttribute("authCode");
	    
	    if (authCode != null && authCode.equals(inputCode)) {
	        return "success";
	    } else {
	        return "fail";
	    }
	}
	
	@RequestMapping("/toResetPw")
	public String toResetPw() {
		return "members/toResetPw";
	}
	
	@RequestMapping("/updatePw")
	@ResponseBody
	public String updatePw(String pw, HttpSession session) {
	    String id = (String) session.getAttribute("targetId");
	    

	    if (id == null) {
	        return "fail";
	    }

	    int result = dao.updatePw(id, pw);
	    
	    if (result > 0) {
	        session.invalidate(); 
	        return "success";
	    } else {
	        return "fail";
	    }
	}
	
	
//	public String updateProfile(HttpSession session) {
//		String id = (String) session.getAttribute("targetId");
//		return 
//	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

}
