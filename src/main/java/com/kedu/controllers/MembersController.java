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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
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
	@Autowired
	private Gson g;
	
	private EncryptionUtils eu = new EncryptionUtils();
	
	@RequestMapping("/toLogin")
	public String toLogin() {
		return "/members/login";
	}
	
	@RequestMapping("/login")
	public String login(String id, String pw,HttpSession session,RedirectAttributes rttr, Model model) {
		int memberStatus = dao.memberStatus(id);
		if(memberStatus > 0) {
			rttr.addFlashAttribute("msg", "정지 상태인 계정입니다.");
			return "redirect:/members/toLogin";
		}
		boolean result = dao.login(id,eu.getSha512(pw));
		if(result) {	
			session.setAttribute("loginId",id);
			session.setAttribute("nickName", dao.getNickname(id));	
			session.setAttribute("type", dao.getType(id));
			model.addAttribute("memberStatus", memberStatus);
		}else {
			rttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "redirect:/members/toLogin";
		}
		return "redirect:/";
	}
	
	@RequestMapping("/idCheck")
	@ResponseBody
	public String idCheck(String id) {
		String idcheck = g.toJson(dao.selectById(id));
		return idcheck;
	}

	@RequestMapping("/toIdSearch")
	public String toIdSearch() {
		return "/members/idSearch";
	}
	@ResponseBody
	@RequestMapping("/idSearch")
	public String idSearch(String name, String email) {
		List<MembersDTO> list = dao.idSearch(name,email);
		return g.toJson(list);
	}
	
	@ResponseBody
	@RequestMapping("/nickNameCheck")
	public String nickNameCheck(String nickname, Model model) {
		String nickName = g.toJson(dao.nickNameCheck(nickname));
		return nickName;
	}
	
	@RequestMapping("/toSignUp")
	public String toSignUp() {
		return "/members/joinform";
	}
	
	@RequestMapping("/signup")
	public String signup(MembersDTO dto, RedirectAttributes rattr) {
		dto.setPw(eu.getSha512(dto.getPw()));
		int result = dao.signup(dto);
		
		if(result > 0) {
			rattr.addFlashAttribute("joinSuccess", "회원가입이 완료되었습니다. 로그인창으로 이동합니다.");
			return "redirect:/";
		}else {
			return "redirect:error";
		}
		
		
	}
	
	@RequestMapping("/toPwSearch")
	public String toPwSearch() {
		return "/members/toPwSearch";
	}
	
	@RequestMapping(value = "/sendAuthCode", method = RequestMethod.POST)
	@ResponseBody
	public String sendAuthCode(@RequestParam(value="id", required=false) String id, String email, HttpSession session) {
	    
	    // [1] 비밀번호 찾기 모드 (ID가 넘어왔을 때)
	    if (id != null && !id.trim().isEmpty()) {
	        int result = dao.checkMemberForPw(id, email); 
	        if (result == 0) {
	            return "not_found"; // 일치하는 정보 없음
	        }
	        session.setAttribute("targetId", id);
	    } 
	    // [2] 회원가입 모드 (ID가 없을 때)
	    else {
	        // DB에서 이메일 중복 여부를 체크하는 메서드를 호출 (예: checkEmailExists)
	        int emailCount = dao.checkEmailExists(email); 
	        if (emailCount > 0) {
	            return "already_exists"; // 이미 가입된 이메일
	        }
	    }

	    // [3] 인증번호 생성 및 메일 발송 (이후 로직은 동일)
	    int checkNum = new Random().nextInt(888888) + 111111;
	    String authCode = String.valueOf(checkNum);
	    
	    try {
	        MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
	        helper.setFrom("dlawndud6544@gmail.com");
	        helper.setTo(email);
	        
	        String content = 
	        	    "<div style='max-width: 500px; margin: 40px auto; padding: 40px; border: 1px solid #eef2ff; border-radius: 24px; font-family: sans-serif; box-shadow: 0 10px 20px rgba(0,0,0,0.05); text-align: center;'>" +
	        	    "  <h1 style='color: #2563eb; font-size: 28px; font-weight: 800; margin-bottom: 24px;'>돈워리</h1>" +
	        	    "  <div style='margin-bottom: 30px;'>" +
	        	    "    <p style='font-size: 18px; font-weight: 700; color: #333; margin-bottom: 8px;'>회원가입 인증번호 안내</p>" +
	        	    "    <p style='font-size: 14px; color: #666;'>안녕하세요. 돈워리를 방문해주셔서 감사합니다.<br>아래의 인증번호를 입력하여 가입을 완료해주세요.</p>" +
	        	    "  </div>" +
	        	    "  <div style='background-color: #f8faff; border-radius: 16px; padding: 30px; margin-bottom: 30px;'>" +
	        	    "    <span style='display: block; font-size: 12px; color: #2563eb; font-weight: 700; margin-bottom: 10px; letter-spacing: 1px;'>VERIFICATION CODE</span>" +
	        	    "    <span style='font-size: 36px; font-weight: 800; color: #2563eb; letter-spacing: 8px;'>" + authCode + "</span>" +
	        	    "  </div>" +
	        	    "  <p style='font-size: 12px; color: #999; line-height: 1.6;'>" +
	        	    "    본 인증번호는 발송 후 3분 동안 유효합니다.<br>" +
	        	    "    만약 요청한 적이 없다면 이 메일을 무시해주세요." +
	        	    "  </p>" +
	        	    "  <hr style='border: none; border-top: 1px solid #eee; margin: 30px 0;'>" +
	        	    "  <p style='font-size: 11px; color: #bbb;'>© 2026 돈워리. All rights reserved.</p>" +
	        	    "</div>";
	        
	        String title = (id != null) ? "[돈워리] 비밀번호 찾기 인증번호" : "[돈워리] 회원가입 인증번호";
	        helper.setSubject(title);
	        helper.setText(content, true);

	        mailSender.send(message);
	        session.setAttribute("authCode", authCode); 
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

	    int result = dao.updatePw(id, eu.getSha512(pw));
	    
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
