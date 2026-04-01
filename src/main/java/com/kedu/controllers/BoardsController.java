package com.kedu.controllers;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.kedu.dao.BoardsDAO;
import com.kedu.dao.FilesDAO;
import com.kedu.dto.BoardsDTO;
import com.kedu.dto.FilesDTO;

@Controller
@RequestMapping("/boards")
public class BoardsController {
	
	@Autowired
	private BoardsDAO dao;
	
	@Autowired
	private FilesDAO fdao;
	

	@RequestMapping("/mainboard_list")
	public String toMainBoard() {
		return "boards/mainboard/mainboard_list";
	}
	
	@RequestMapping("/jobpost")
	public String jobpost() {
		return "boards/jobpost";
	}
	
	@RequestMapping("/toWrite")
	public String toWrite() {
		return "boards/write";
	}
	@RequestMapping("/write")
	public String write(BoardsDTO dto,MultipartFile[] files) {
		System.out.println(dto.getContent() + " : " + dto.getCategory() );
		
		
		int nextVal = dao.seqNextval();
		dao.insert(nextVal,dto);
		
		
		String savePath = "c:/files";
		File savePathFile = new File(savePath);

		if(!savePathFile.exists()) {
			savePathFile.mkdir();
		}
		for(MultipartFile file : files) {
			if(!file.isEmpty()) { // 비어있는 더미 파일 객체라면 무시
				String oriName = file.getOriginalFilename(); // 파일 원본 이름
				String sysName = UUID.randomUUID() + "_" + oriName; // 중복되지 않게 가공된 파일 이름
				try {
					file.transferTo(new File(savePath+"/"+sysName));
				}catch(Exception e) {
					e.printStackTrace();
					return "error";
				}
				
				fdao.upload(new FilesDTO(0,oriName,sysName,nextVal));
			}	
		}
		
		
		return "redirect:/boards/mainboard_list";
	}
}
