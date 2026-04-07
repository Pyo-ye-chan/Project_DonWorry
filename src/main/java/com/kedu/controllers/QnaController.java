package com.kedu.controllers;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.kedu.dao.FilesDAO;
import com.kedu.dao.QnaDAO;
import com.kedu.dto.FilesDTO;
import com.kedu.dto.QnaDTO;

@Controller
@RequestMapping("/qna")
public class QnaController {
	
	@Autowired
	private QnaDAO dao;
	
	@Autowired
	private FilesDAO fdao;
	
	@RequestMapping("/qna")
	public String qna(HttpSession session,Model model) {
		String member_id = (String)session.getAttribute("loginId");
		List<QnaDTO> list = null;
		if(member_id != null) {
			if(member_id.equals("admin") ) {
				list = dao.listAll();
			}else {
				list = dao.list(member_id);
			}		
		}
		model.addAttribute("list",list);
		return "/qna/qna";
	}
	@RequestMapping("/toWrite")
	public String toWrite() {
		
		return "/qna/write";
	}
	@RequestMapping("/write")
	public String write(QnaDTO dto) {
		dao.insert(dto);
		return "redirect:/qna/qna";
	}
	@RequestMapping("/detail")
	public String detail(int seq,Model model) {
		QnaDTO dto = dao.detail(seq);
		model.addAttribute("dto",dto);
		return "/qna/detail";
	}
	@RequestMapping("/toUpdate")
	public String toUpdate(int seq,Model model) {
		QnaDTO dto =  dao.detail(seq);
		model.addAttribute("dto",dto);
		List<FilesDTO> filesList = fdao.selectByParent_seq(seq);
		model.addAttribute("filesList",filesList);
		return "/qna/update";
	}
	@RequestMapping("/update")
	public String update(MultipartFile[] files,QnaDTO dto) {
		
		dao.update(dto);
		
		String savePath = "c:/files";
	    File savePathFile = new File(savePath);

	    if(!savePathFile.exists()) {
	        savePathFile.mkdir();
	    }

	    // [핵심 추가] 2. 만약 새로 첨부한 파일이 하나라도 있다면 기존 파일 처리를 결정해야 함
	    // (첫 번째 파일이 비어있지 않다면 = 사용자가 파일을 새로 선택했다면)
	    if(files != null && files.length > 0 && !files[0].isEmpty()) {
	        
	        // (A) 기존 파일 정보를 DB에서 가져와서 실제 C:/files 폴더 내의 파일들을 먼저 삭제
	        List<FilesDTO> oldFiles = fdao.selectByParent_seq(dto.getSeq());
	        for(FilesDTO oldFile : oldFiles) {
	            File f = new File(savePath + "/" + oldFile.getSysName());
	            if(f.exists()) f.delete(); // 실제 파일 삭제
	        }
	        
	        // (B) DB에서 기존 파일 데이터 삭제
	        fdao.deleteByParent_seq(dto.getSeq()); 
	        
	        // (C) 이제 새로 넘어온 파일들을 저장 (기존 로직 유지)
	        for(MultipartFile file : files) {
	            if(!file.isEmpty()) {
	                String oriName = file.getOriginalFilename();
	                String sysName = UUID.randomUUID() + "_" + oriName;
	                try {
	                    file.transferTo(new File(savePath + "/" + sysName));
	                    // 새 파일 DB 저장
	                    fdao.upload(new FilesDTO(0, oriName, sysName, dto.getSeq()));
	                } catch(Exception e) {
	                    e.printStackTrace();
	                    return "error";
	                }
	            }   
	        }
	    }
	    return "redirect:/qna/detail?seq="+dto.getSeq();
	}
	@RequestMapping("/delete")
	public String delete(int seq) {
		dao.delete(seq);
		return "redirect:/qna/qna";
	}
}
