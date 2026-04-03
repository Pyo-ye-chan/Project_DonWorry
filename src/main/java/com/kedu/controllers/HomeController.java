package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.WorkPlaceDAO;
import com.kedu.dao.WorkPlaceListDAO;
import com.kedu.dto.WorkPlaceListDTO;

@Controller
public class HomeController {
	@Autowired
	public WorkPlaceDAO wpdao;
	
	@Autowired
	public WorkPlaceListDAO wpldao;
	
	@RequestMapping("/")
	public String home(HttpSession session, Model model) {
		String id = (String) session.getAttribute("loginId");
		String type = (String)session.getAttribute("type");
		//type.equals("관리자")일 경우 로그인 안해서 type(비교객체)이 null이면 npe나옴 
		//반대는 되는 이유= 관리자라는 객체는 메모리에 저장이 되어있어 비교대상이 null이라도 if 넘기며 실행이 됨
		if("관리자".equals(type)) {
			return "admin/admin_main";
		}
		if("개인".equals(type)||"사업자".equals(type)){
			if(type!=null) {
				List<WorkPlaceListDTO> placeList = wpldao.selectAllById(id);
			    model.addAttribute("placeList", placeList);	   
			}		
		}
			return "home";		 
	}
}
	
