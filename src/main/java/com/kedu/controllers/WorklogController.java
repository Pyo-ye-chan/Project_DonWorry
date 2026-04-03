package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.WorklogDAO;
import com.kedu.dto.WorklogDTO;

@Controller
@RequestMapping("/worklog")
public class WorklogController {
	
	@Autowired
	public WorklogDAO dao;
	
	@RequestMapping("/insert")
	public String addWorklog(WorklogDTO dto, HttpSession session) {
		String id = (String)session.getAttribute("loginId");
		int result = dao.insertWorklog(dto,id);	
		if(result > 0) {
			return "redirect:/salary/calendar?insertSuccess=true";
		}else {
			return "redirect:/salary/calendar?insertSuccess=false";
		}
	}
	
	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {	
		e.printStackTrace();
		return "error";
	}

}
