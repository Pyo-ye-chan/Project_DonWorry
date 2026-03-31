package com.kedu.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/jobposts")
public class JobPostController {

	@RequestMapping("/jobpost")
	public String home() {
	return "jobpost/jobpost";	
	}
}
