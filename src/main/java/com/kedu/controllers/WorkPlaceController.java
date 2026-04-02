package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.WorkPlaceDAO;
import com.kedu.dto.WorkPlaceDTO;

@Controller
@RequestMapping("/workplaces")
public class WorkPlaceController {
	
	@Autowired
	WorkPlaceDAO dao = new WorkPlaceDAO();
	
	@RequestMapping("/insert")
	public String insert(WorkPlaceDTO dto, HttpSession session) {
		String memberId = (String) session.getAttribute("loginId");
	    dto.setId(memberId);
	    System.out.println(memberId);
	    if(dto.getPay_type() == null) dto.setPay_type("시급");
	    
	    if (dto.getWork_start_time() != null && dto.getWork_start_time().isEmpty()) {
	        dto.setWork_start_time(null);
	    }
	    if (dto.getWork_end_time() != null && dto.getWork_end_time().isEmpty()) {
	        dto.setWork_end_time(null);
	    }
	    if (dto.getEmployment_insurance() == null) {
	        dto.setEmployment_insurance("N");
	    }
	    String taxVal = dto.getTax_applied();
	    if (taxVal == null || taxVal.equals("") || taxVal.equals("custom")) {
	        dto.setTax_applied("0");
	    }
	    
	    String insVal = dto.getInsurance_applied();

	    if ("4".equals(insVal)) {
	        dto.setInsurance_applied("Y");
	        dto.setEmployment_insurance("Y");
	    } else if ("1".equals(insVal)) {
	        dto.setInsurance_applied("N");
	        dto.setEmployment_insurance("Y");
	    } else {
	        dto.setInsurance_applied("N");
	        dto.setEmployment_insurance("N");
	    }
	    
		dao.insertToworkpalce(dto);
		
		return "redirect:/salary/calendar";
	}

}
