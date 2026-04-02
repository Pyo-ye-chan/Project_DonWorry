package com.kedu.controllers;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/files")
public class FilesController {
	// 게시판 이미지 

	@PostMapping("/upload")
	@ResponseBody
	public Map<String, String> upload(@RequestParam("image") MultipartFile file) throws Exception {
		
	    String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();

	    String path = "C:/upload/";
	    
	    File savePathFile = new File(path);
	    if(!savePathFile.exists()){
	        savePathFile.mkdirs(); 
	    }
	    
	    File dest = new File(path + fileName);
	    file.transferTo(dest);

	    Map<String, String> map = new HashMap<>();
	    map.put("url", "http://10.10.55.87:8080/upload/" + fileName); // ⭐ 이 URL이 핵심

	    return map;
	}
	
}
