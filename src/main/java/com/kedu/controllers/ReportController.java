package com.kedu.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.ReportDAO;
import com.kedu.dto.ReportDTO;

@Controller
@RequestMapping("/report")
public class ReportController {
	
	@Autowired
	private ReportDAO dao;
	
	@ResponseBody
	@PostMapping("/report")
	public String report(ReportDTO dto) {
		
		int result = dao.report(dto);
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
}
