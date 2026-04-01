package com.kedu.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kedu.dao.ReplyDAO;
import com.kedu.dto.ReplyDTO;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	
	@Autowired
	private ReplyDAO dao;
	
	@Autowired
	private Gson gson;
	
//	@ResponseBody
//	@RequestMapping("/insert")
//	public String insert(ReplyDTO dto) {
//		List<ReplyDTO> list = dao.insert(dto);
//		return gson.toJson(list);
//	}

}
