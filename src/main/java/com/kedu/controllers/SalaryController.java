package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.WorkPlaceDAO;
import com.kedu.dao.WorkPlaceListDAO;
import com.kedu.dto.WorkPlaceDTO;
import com.kedu.dto.WorkPlaceListDTO;

@Controller
@RequestMapping("/salary")
public class SalaryController {
	
	@Autowired
	public WorkPlaceDAO wpdao;
	
	@Autowired
	public WorkPlaceListDAO wpldao;
	
	@RequestMapping("/calendar")
	public String toCalendar(HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("loginId");
	    if(memberId == null) {
	        return "redirect:/members/toLogin";
	    }
	    List<WorkPlaceListDTO> placeList = wpldao.selectAllById(memberId);
	    model.addAttribute("placeList", placeList);
		return "salary/calendar";
	}
	
	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {	
		e.printStackTrace();
		return "error";
	}
	
	
	
	
}
