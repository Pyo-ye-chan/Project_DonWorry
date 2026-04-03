package com.kedu.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.WorkPlaceDAO;
import com.kedu.dao.WorkPlaceListDAO;

@Controller
public class HomeController {
	@Autowired
	public WorkPlaceDAO wpdao;
	
	@Autowired
	public WorkPlaceListDAO wpldao;
	
	@RequestMapping("/")
	public String home() {
		return "home";	
	}
}
	
