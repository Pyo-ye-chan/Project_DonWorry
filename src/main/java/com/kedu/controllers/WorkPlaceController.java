package com.kedu.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kedu.dao.WorkPlaceDAO;
import com.kedu.dto.WorkPlaceDTO;

@Controller
@RequestMapping("/workplaces")
public class WorkPlaceController {
	
	@Autowired
	private WorkPlaceDAO dao;
	
	@Autowired
	private Gson gson;
	
    @RequestMapping("/insert")
    public String insert(WorkPlaceDTO dto, HttpSession session) {
        String memberId = (String) session.getAttribute("loginId");
        dto.setId(memberId);

        if (dto.getPay_type() == null || dto.getPay_type().trim().isEmpty()) {
            dto.setPay_type("시급");
        }

        if (dto.getWork_start_time() != null && dto.getWork_start_time().trim().isEmpty()) {
            dto.setWork_start_time(null);
        }
        if (dto.getWork_end_time() != null && dto.getWork_end_time().trim().isEmpty()) {
            dto.setWork_end_time(null);
        }

        if (dto.getTax_applied() == null || dto.getTax_applied().trim().isEmpty() || "custom".equals(dto.getTax_applied())) {
            dto.setTax_applied("0");
        }

        if (dto.getInsurance_applied() == null || dto.getInsurance_applied().trim().isEmpty()) {
            dto.setInsurance_applied("N");
        }

        if (dto.getEmployment_insurance() == null || dto.getEmployment_insurance().trim().isEmpty()) {
            dto.setEmployment_insurance("N");
        }

        int result = dao.insertToworkpalce(dto);

        System.out.println("id : " + dto.getId());
        System.out.println("insurance_applied : " + dto.getInsurance_applied());
        System.out.println("employment_insurance : " + dto.getEmployment_insurance());

        if (result > 0) {
            return "redirect:/salary/calendar?insertSuccess=true";
        } else {
            return "redirect:/salary/calendar?insertSuccess=false";
        }
    }
	
	@ResponseBody
	@RequestMapping("/countrow")
	public int countrow(HttpSession session) {
	    String memberId = (String) session.getAttribute("loginId");
	    return dao.countRow(memberId);
	}
	
	
	@ResponseBody
	@RequestMapping("/list")
	public List<WorkPlaceDTO> list(HttpSession session) {
	    String memberId = (String) session.getAttribute("loginId");
	    return dao.selectByMemberId(memberId);
	}
	
	@ResponseBody
	@RequestMapping("/detail")
	public WorkPlaceDTO getDetail(int seq) {
	    return dao.selectBySeq(seq);
	}
	
	@ResponseBody
	@RequestMapping("/update")
	public String updateDetail(WorkPlaceDTO dto) {
	    int result = dao.update(dto);
	    return String.valueOf(result); // "1" or "0"
	}
	

	@RequestMapping("/delete")
	public String deleteDetail(int seq) {
		int result =  dao.deleteBySeq(seq);
		
		if(result > 0) {
	        return "redirect:/salary/calendar?deleteSuccess=true";
	    } else {
	        return "redirect:/salary/calendar?deleteSuccess=false";
	    }
	}
	
	
	
	

}
