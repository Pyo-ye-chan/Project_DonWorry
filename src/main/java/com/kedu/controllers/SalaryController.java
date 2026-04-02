package com.kedu.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/salary")
public class SalaryController {
	
	@RequestMapping("/calendar")
	public String toCalendar() {
		return "salary/calendar";
	}
	
	
}
