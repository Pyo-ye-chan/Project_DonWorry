package com.kedu.controllers;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kedu.dao.QnaDAO;
import com.kedu.dao.Qna_replyDAO;
import com.kedu.dto.QnaDTO;
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
		if(!loginId.equals("admin")) {
			return "denied";
		}
		dto.setMember_id(loginId);
		dao.insert(dto);
		
		qdao.statusUpdate(dto.getQna_num());
		return "success";
	}
	@ResponseBody
	@RequestMapping("/list")
	public String list(int qna_num) {
		List<Qna_replyDTO> list = dao.list(qna_num);
		for(Qna_replyDTO dto : list) {
        	dto.setWrite_date_str(
    		        new SimpleDateFormat("yyyy-MM-dd").format(dto.getWrite_date())
    		    );
        }
		return gson.toJson(list);
	}
	@ResponseBody
	@RequestMapping("/delete")
	public String delete(int seq, int qna_num) {
		int result = dao.delete(seq);
		if(result > 0) {
			qdao.statusReset(qna_num);
			return "success"; 
		}
		return "fail";
	}
	@ResponseBody
	@RequestMapping("/update")
	public String update(int seq, String content) {
		int result = dao.update(seq,content);
		if(result > 0) {
			return "success"; 
		}return "fail";
	}

}
