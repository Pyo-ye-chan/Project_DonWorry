package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kedu.dao.QnaDAO;
import com.kedu.dao.Qna_replyDAO;
import com.kedu.dto.Qna_replyDTO;

@Controller
@RequestMapping("/qna_reply")
public class Qna_replyController {
	
	@Autowired
	private Qna_replyDAO dao;
	
	@Autowired
	private QnaDAO qdao;
		
	@Autowired
	private Gson gson;
	
	@ResponseBody
	@RequestMapping("/insert")
	public String insert(Qna_replyDTO dto,HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
//		if(!loginId.equals("admin")) {
//			return "denied";
//		}
		dto.setMember_id(loginId);
		dao.insert(dto);
		qdao.statusUpdate(dto.getQna_num());
		return "success";
	}
	@ResponseBody
	@RequestMapping("/list")
	public String list(int qna_num) {
		List<Qna_replyDTO> list = dao.list(qna_num);
		return gson.toJson(list);
	}

}
