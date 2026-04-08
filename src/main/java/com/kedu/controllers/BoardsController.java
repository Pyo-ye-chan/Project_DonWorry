package com.kedu.controllers;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kedu.dao.AdminDAO;
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
	
	@Autowired
	private AdminDAO adao;
	

	@RequestMapping("/mainboard_list")
	public String toMainBoard(@RequestParam(value="page", defaultValue="1")int page,Model model,HttpSession session) {
		
		String loginId = (String)session.getAttribute("loginId");
		
		List<BoardsDTO> mainList =  dao.mainList(page*10-9,page*10,loginId);
		
		
		int recordTotalCount = dao.mainRecordTotalCount();
		
		model.addAttribute("currentPage",page);
		model.addAttribute("recordCountPerPage",10);
		model.addAttribute("naviCountPerPage",10);
		model.addAttribute("recordTotalCount",recordTotalCount);
		//model.addAttribute("recordTotalCount",233); // 임시
		model.addAttribute("mainList", mainList);
		
		//공지사항 
	    List<BoardsDTO> notice_mainList = adao.adminNoticeList();
	    model.addAttribute("notice_mainList", notice_mainList); // 바구니 이름을 JSP와 똑같이!
		
		return "boards/mainboard_list";
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
		
		int nextVal = dao.seqNextval();
		System.out.println(nextVal);
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
		
		
		return "redirect:/boards/mainboard_list?page=1";
	}
	
	
	@RequestMapping("/detail")
	public String detail(int seq,Model model,HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		BoardsDTO dto = dao.list_detail(seq,loginId);
		
		model.addAttribute("dto",dto);
		
		List<FilesDTO> filesList = fdao.selectByParent_seq(seq);
		model.addAttribute("filesList",filesList);
		String writer = dao.writer(seq);
		model.addAttribute("board_writer",writer);
		
		return "boards/detail";
	}
	@RequestMapping("/download")
	public void download(HttpServletResponse response,String sysName, String oriName) throws Exception{
		File target = new File("c:/files/" + sysName);
		
		oriName =  new String(oriName.getBytes("utf8"),"ISO-8859-1"); // 한글 깨짐 방지
		response.setHeader("content-disposition","attachment;filename="+oriName);
		
		
		try(DataInputStream dis = new DataInputStream(new FileInputStream(target));
				DataOutputStream dos = new DataOutputStream(response.getOutputStream());){

			byte[] fileContents = dis.readAllBytes(); 
			
			dos.write(fileContents);
			dos.flush();
		}
	}
	@RequestMapping("/toUpdate")
	public String toUpdate(int seq,Model model) {
		BoardsDTO dto = dao.detail(seq);
		model.addAttribute("dto",dto);
		List<FilesDTO> filesList = fdao.selectByParent_seq(seq);
		model.addAttribute("filesList",filesList);
		return "boards/update";
	}
	@RequestMapping("/update")
	public String update(BoardsDTO dto,MultipartFile[] files) {
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

		return "redirect:/boards/detail?seq="+dto.getSeq();
	}
	@RequestMapping("/delete")
	public String delete(int seq) {
		dao.delete(seq);
		return "redirect:/boards/mainboard_list?page=1";
	}
	@RequestMapping("/view")
	public String view_count(int seq,int view_count) {
		dao.view_count(seq,view_count);
		return "redirect:/boards/detail?seq="+seq;
	}
	@RequestMapping("/freeboard_list")
	public String freeboard_list(int page,Model model,HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		List<BoardsDTO> freeList = dao.freeList(page*10-9,page*10,loginId);
		
		int recordTotalCount = dao.freeRecordTotalCount();
		
		model.addAttribute("currentPage",page);
		model.addAttribute("recordCountPerPage",10);
		model.addAttribute("naviCountPerPage",10);
		model.addAttribute("recordTotalCount",recordTotalCount);
		//model.addAttribute("recordTotalCount",233); // 임시
		model.addAttribute("freeList", freeList);
		
		return "boards/freeboard_list";
	}
	@RequestMapping("/qnaboard_list")
	public String qnaboard_list(int page,Model model,HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		List<BoardsDTO> qnaList = dao.qnaList(page*10-9,page*10,loginId);
		
		int recordTotalCount = dao.qnaRecordTotalCount();
		
		model.addAttribute("currentPage",page);
		model.addAttribute("recordCountPerPage",10);
		model.addAttribute("naviCountPerPage",10);
		model.addAttribute("recordTotalCount",recordTotalCount);
		//model.addAttribute("recordTotalCount",233); // 임시
		model.addAttribute("qnaList", qnaList);
		
		return "boards/qnaboard_list";
	}
	@RequestMapping("/reviewboard_list")
	public String reviewboard_list(int page,Model model,HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		
		List<BoardsDTO> reviewList = dao.reviewList(page*10-9,page*10,loginId);
		
		int recordTotalCount = dao.reviewRecordTotalCount();
		
		model.addAttribute("currentPage",page);
		model.addAttribute("recordCountPerPage",10);
		model.addAttribute("naviCountPerPage",10);
		model.addAttribute("recordTotalCount",recordTotalCount);
		//model.addAttribute("recordTotalCount",233); // 임시
		model.addAttribute("reviewList", reviewList);
		
		return "boards/reviewboard_list";
	}
	
}
