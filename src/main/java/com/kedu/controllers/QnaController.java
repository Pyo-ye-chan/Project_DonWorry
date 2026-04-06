package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.QnaDAO;
import com.kedu.dto.QnaDTO;

@Controller
@RequestMapping("/qna")
public class QnaController {
	
	@Autowired
	private QnaDAO dao;
	
	@RequestMapping("/qna")
	public String qna(HttpSession session,Model model) {
		String member_id = (String)session.getAttribute("loginId");
		List<QnaDTO> list = null;
		if(member_id != null) {
			if(member_id.equals("admin") ) {
				list = dao.listAll();
			}else {
				list = dao.list(member_id);
			}		
		}
		model.addAttribute("list",list);
		return "/qna/qna";
	}
	@RequestMapping("/toWrite")
	public String toWrite() {
		
		return "/qna/write";
	}
	@RequestMapping("/write")
	public String write(QnaDTO dto) {
		dao.insert(dto);
		return "redirect:/qna/qna";
	}
	@RequestMapping("/detail")
	public String detail(int seq,Model model) {
		QnaDTO dto = dao.detail(seq);
		model.addAttribute("dto",dto);
		return "/qna/detail";
	}

}
