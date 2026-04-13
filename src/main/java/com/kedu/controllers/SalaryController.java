package com.kedu.controllers;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.WorkPlaceDAO;
import com.kedu.dao.WorkPlaceListDAO;
import com.kedu.dao.WorklogDAO;
import com.kedu.dto.WorkPlaceListDTO;
import com.kedu.dto.WorklogDTO;

@Controller
@RequestMapping("/salary")
public class SalaryController {
	
	@Autowired
	public WorklogDAO wldao;
	
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
	    
	    LocalDate now = LocalDate.now();
	    int year = now.getYear();
	    int month = now.getMonthValue();
	    
	    
	    List<WorkPlaceListDTO> placeList = wpldao.selectAllByIdCard(memberId, year, month);
	    List<WorkPlaceListDTO> detailList = wpldao.selectAllByIdDetail(memberId);
	    List<WorklogDTO> logList = wldao.selectAllById(memberId);
	    
	    model.addAttribute("placeList", placeList);
	    model.addAttribute("detailList", detailList);
	    model.addAttribute("logList", logList);
	    model.addAttribute("year", year);
	    model.addAttribute("month", month);
	    
		return "salary/calendar";
	}
	
	@RequestMapping("/placeListByMonth")
	@ResponseBody
	public List<WorkPlaceListDTO> placeListByMonth(HttpSession session, int year, int month) {

	    String memberId = (String) session.getAttribute("loginId");
	    if (memberId == null) {
	        return new ArrayList<>();
	    }

	    return wpldao.selectAllByIdCard(memberId, year, month);
	}

	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {	
		e.printStackTrace();
		return "error";
	}
	
	
	
	
	
	
	
	
}
