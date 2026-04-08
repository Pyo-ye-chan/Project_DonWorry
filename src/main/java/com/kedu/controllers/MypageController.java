package com.kedu.controllers;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.kedu.commons.EncryptionUtils;
import com.kedu.dao.BoardsDAO;
import com.kedu.dao.FilesDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dao.MypageDAO;
import com.kedu.dto.BoardsDTO;
import com.kedu.dto.FilesDTO;
import com.kedu.dto.MembersDTO;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Autowired
	private MembersDAO mdao;
	@Autowired
	private MypageDAO dao;
	@Autowired
	private BoardsDAO bdao;
	@Autowired
	private FilesDAO fdao;
	
	@Autowired
	private Gson gson;
	
	private EncryptionUtils eu = new EncryptionUtils();
	
	@RequestMapping("/toMypage")
	public String toMypage(HttpSession session, Model model) {
		String id =(String)session.getAttribute("loginId");	
		List<MembersDTO> list = mdao.selectAll(id);
		String type = (String)session.getAttribute("type");
		model.addAttribute("list",list);
		
		return "mypage/mypage";
	}
	
	@RequestMapping("/toProfile")
	public String toProfile(HttpSession session, Model model) {
		String id =(String)session.getAttribute("loginId");	
		List<MembersDTO> list = mdao.selectAll(id);		
		model.addAttribute("list",list);
		
		return "mypage/profile";
	}
	
	@RequestMapping("/profile_update")
	public String updateProfile(HttpSession session, MembersDTO dto) {
		String id =(String)session.getAttribute("loginId");	
		String type = (String)session.getAttribute("type");
		int up = mdao.updateMember(id.trim(),dto);
		return "redirect:/mypage/toProfile";
	}
	
	@RequestMapping("/job_activity")
	public String to_Job_activity(HttpSession session) {
		String id =(String)session.getAttribute("loginId");	
		String type = (String)session.getAttribute("type");
		
		List<MembersDTO> list = mdao.selectAll(id);	
		return "mypage/job_activity";
	}
	
	@RequestMapping("/toAccount")
	public String toAccount() {
		return "mypage/account";
	}
	
	@RequestMapping("/toWithdraw")
	public String toWithdraw() {
		return "mypage/withdraw";
	}
	
	@ResponseBody
	@RequestMapping("/passwordCheck")
	public boolean passwordCheck(String memberPw, HttpSession session) {
		String pw = eu.getSha512(memberPw);
		String id = (String)session.getAttribute("loginId");
		return dao.passwordCheck(id, pw);	
	}
	
	@ResponseBody
	@RequestMapping("/withdraw")
	public boolean withdraw(String memberPw, HttpSession session) {
		String pw = eu.getSha512(memberPw);
		String id = (String)session.getAttribute("loginId");
		int result = dao.withdraw(id, pw);
		if(result > 0) {
			session.invalidate();
		}
		return result > 0;
		
	}
	
	@RequestMapping("/employ_activity")
	public String toEmploy_activity() {
		return "mypage/employ_activity";
	}
	
	@RequestMapping("/mypost")
	public String toMypost(HttpSession session, Model model, int page) {
		String memberId = (String)session.getAttribute("loginId");
		
		int count = bdao.countMypost(memberId);
		List<BoardsDTO> allList = bdao.selectById(memberId, page*10-9, page*10);
		
		int recordTotalCount = bdao.mypostRecordTotalCount(memberId);
		
		model.addAttribute("currentPage", page);
		model.addAttribute("recordCountPerPage",10);
		model.addAttribute("naviCountPerPage",10);
		model.addAttribute("recordTotalCount",recordTotalCount);
		model.addAttribute("allList", allList);
		model.addAttribute("count", count);
		return "mypage/mypost";
	}
	
	@RequestMapping("/view")
	public String view_count(int seq,int view_count) {
		bdao.view_count(seq,view_count);
		return "redirect:/mypage/mypostdetail?seq="+seq;
	}
	
	@RequestMapping("/mypostdetail")
	public String detail(int seq,Model model,HttpSession session) {
		BoardsDTO dto = bdao.detail(seq);
		
		model.addAttribute("dto",dto);
		
		List<FilesDTO> filesList = fdao.selectByParent_seq(seq);
		model.addAttribute("filesList",filesList);
		String writer = bdao.writer(seq);
		model.addAttribute("board_writer",writer);
		
		return "mypage/mypostdetail";
	}
	
	@RequestMapping("/toUpdate")
	public String toUpdate(int seq,Model model) {
		BoardsDTO dto = bdao.detail(seq);
		model.addAttribute("dto",dto);
		List<FilesDTO> filesList = fdao.selectByParent_seq(seq);
		model.addAttribute("filesList",filesList);
		return "mypage/mypostupdate";
	}
	@RequestMapping("/update")
	public String update(BoardsDTO dto,MultipartFile[] files) {
		bdao.update(dto);
		
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

		return "redirect:/mypage/mypostdetail?seq="+dto.getSeq();
	}
	@RequestMapping("/delete")
	public String delete(int seq) {
		bdao.delete(seq);
		return "redirect:/mypage/mypost?page=1";
	}
	
	@RequestMapping("/toWrite")
	public String toWrite() {
		return "mypage/mypostwrite";
	}
	@RequestMapping("/write")
	public String write(BoardsDTO dto,MultipartFile[] files) {
		
		int nextVal = bdao.seqNextval();
		System.out.println(nextVal);
		bdao.insert(nextVal,dto);
		
		
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
		
		
		return "redirect:/mypage/mypost?page=1";
	}

	
}
