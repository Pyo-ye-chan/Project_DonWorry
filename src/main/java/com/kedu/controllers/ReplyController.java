package com.kedu.controllers;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kedu.dao.ReplyDAO;
import com.kedu.dto.ReplyDTO;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	
	@Autowired
	private ReplyDAO dao;
	
	@Autowired
	private Gson gson;
	
	@ResponseBody
	@RequestMapping("/insert")
	public void insert(ReplyDTO dto) {
		dao.insert(dto);
	}
	
	@ResponseBody
	@RequestMapping("/list")
	public String list(int parent_seq) {
		List<ReplyDTO> list = dao.selectByParent_seq(parent_seq);
		
		int totalCount = list.size();
		
		List<ReplyDTO> comments = new ArrayList<>();
		List<ReplyDTO> replies = new ArrayList<>();

		for(ReplyDTO dto : list){

		    dto.setWrite_date_str(
		        new SimpleDateFormat("yyyy-MM-dd").format(dto.getWrite_date())
		    );

		    if(dto.getRe_reply_seq() == null){
		        comments.add(dto);
		    }else{
		        replies.add(dto);
		    }
		}
		
		for(ReplyDTO comment : comments){
		    List<ReplyDTO> child = new ArrayList<>();

		    for(ReplyDTO reply : replies){
		        if(reply.getRe_reply_seq().equals(comment.getSeq())){
		        
		            child.add(reply);
		        }
		    }

		    comment.setReplies(child); // 🔥 핵심
		}
		
		Map<String, Object> result = new HashMap<>();
		result.put("list", comments);
		result.put("totalCount", totalCount);
		
		return gson.toJson(result);
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	public void delete(int seq) {
		dao.delete(seq);
	}
	@ResponseBody
	@RequestMapping("/update")
	public void update(int seq,String content) {
		dao.update(seq,content);
	}

}
