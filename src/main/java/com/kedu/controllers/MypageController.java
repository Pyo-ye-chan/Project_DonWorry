package com.kedu.controllers;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.kedu.commons.EncryptionUtils;
import com.kedu.dao.ApplicantResumeDAO;
import com.kedu.dao.BoardsDAO;
import com.kedu.dao.BookmarkDAO;
import com.kedu.dao.CateGoryDAO;
import com.kedu.dao.FilesDAO;
import com.kedu.dao.JobPostDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dao.MypageDAO;
import com.kedu.dao.ResumeDAO;
import com.kedu.dto.ApplicantResumeDTO;
import com.kedu.dto.BoardsDTO;
import com.kedu.dto.CateGoryDTO;
import com.kedu.dto.FilesDTO;
import com.kedu.dto.JobPostDTO;
import com.kedu.dto.MembersDTO;
import com.kedu.dto.ResumeDTO;

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
	private JobPostDAO jpdao;
	@Autowired
	private BookmarkDAO bookdao;
	@Autowired
    private CateGoryDAO catdao;
	@Autowired
	private ResumeDAO rdao;
	@Autowired
	private ApplicantResumeDAO ardao;

	
	
	@Autowired
	private Gson gson;
	
	private EncryptionUtils eu = new EncryptionUtils();
	
	@RequestMapping("/toMypage")
	public String toMypage(HttpSession session, Model model) {
		String id =(String)session.getAttribute("loginId");	
		List<MembersDTO> list = mdao.selectAll(id);
		String type = (String)session.getAttribute("type");
		model.addAttribute("list",list);
		
		int bookmarkCount =  bookdao.countBookmark(id);
		model.addAttribute("bookmarkCount",bookmarkCount);
		
		int resumeCount = rdao.countById(id);
		model.addAttribute("resumeCount",resumeCount);
		
		int boardsCount = bdao.mypostRecordTotalCount(id);
		model.addAttribute("boardsCount",boardsCount);
		
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
	//이력서 작성
	@RequestMapping("/resume")
	public String toResume(Model model) {
		List<JobPostDTO> main_jobCateList =  dao.getJobCategory();
		model.addAttribute("main_jobCateList",main_jobCateList);
		
		return "mypage/resume";
	}
	
	//이력서 저장
	@RequestMapping("/insert_resume")
	public String insert_resume(HttpSession session,ResumeDTO dto) {
		String id = (String)session.getAttribute("loginId");
		dto.setId(id);
		int resume = rdao.insert_resume(dto);
		System.out.println("resume:"+resume);
		return "redirect:/mypage/job_activity";
	}
	
	//대분류 선택 시 소분류 목록을 가져오는 AJAX API
    @ResponseBody
    @RequestMapping(value = "/getSubCategories", produces = "application/json; charset=utf-8")
    public List<JobPostDTO> getSubCategories(@RequestParam("parentId") int parentId) {
        // 부모 ID(대분류 ID)를 전달하여 소분류 목록 반환
        return dao.getSubCategory(parentId);
    }
	
	@RequestMapping("/toAccount")
	public String toAccount(HttpSession session,Model model) {
		String id = (String)session.getAttribute("loginId");
		MembersDTO dto = mdao.selectByLoginId(id);
		model.addAttribute("dto",dto);
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
	public String toEmploy_activity(HttpSession session, Model model, int page) {
		String memberId = (String)session.getAttribute("loginId");
		
		int count = jpdao.mypostRecordTotalCount(memberId);
		List<JobPostDTO> allList = jpdao.selectById(memberId, page*2-1, page*2);
		
		int recordTotalCount = jpdao.mypostRecordTotalCount(memberId);
		
	    Map<Integer, List<ApplicantResumeDTO>> applicantMap = new HashMap<>();

	    for (JobPostDTO post : allList) {
	        List<ApplicantResumeDTO> applicants = ardao.selectApplicantsByPost(post.getSeq());
	        applicantMap.put(post.getSeq(), applicants);
	    }
		
		model.addAttribute("currentPage", page);
		model.addAttribute("recordCountPerPage",2);
		model.addAttribute("naviCountPerPage",10);
		model.addAttribute("recordTotalCount",recordTotalCount);
		model.addAttribute("allList", allList);
		model.addAttribute("count", count);
		  model.addAttribute("applicantMap", applicantMap);
		return "mypage/employ_activity";
	}
	
	@RequestMapping("/mypost")
	public String toMypost(HttpSession session, Model model, int page) {
		String memberId = (String)session.getAttribute("loginId");
		
		int count = bdao.mypostRecordTotalCount(memberId);
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
	
	@RequestMapping("/myjobpost")
	public String toMyjobpost(int seq, Model model) {
		JobPostDTO post = jpdao.getPostDetail(seq);
		model.addAttribute("post", post);
		return "mypage/myjobpost";
	}
	
	
	@RequestMapping("/bookmark")
	public String bookmark(HttpSession session, Model model,@RequestParam(value="page", defaultValue="1") int page) {
		String memberId = (String)session.getAttribute("loginId");
		
		//int count = bdao.mypostRecordTotalCount(memberId);
		int count = bdao.bookmarkRecordTotalCount(memberId);
		List<BoardsDTO> bookmarkList = bdao.selectByBookmark(memberId, page*10-9, page*10);
		//List<BoardsDTO> allList = bdao.selectById(memberId, page*10-9, page*10);
		
		//int recordTotalCount = bdao.mypostRecordTotalCount(memberId);
		
		model.addAttribute("currentPage", page);
		model.addAttribute("recordCountPerPage",10);
		model.addAttribute("naviCountPerPage",10);
		model.addAttribute("recordTotalCount",count);
		model.addAttribute("bookmarkList", bookmarkList);
		model.addAttribute("count", count);
		return "mypage/bookmark";
	}
	@ResponseBody
	@RequestMapping("/checkPw")
	public boolean checkPw(String pw ,HttpSession session) {
		String id = (String)session.getAttribute("loginId");
		return mdao.login(id,eu.getSha512(pw));
	}
	@RequestMapping("/changePw")
	public String changePw(HttpSession session,String pw , String newPw,RedirectAttributes ra) {
		String id = (String)session.getAttribute("loginId");
		int result = mdao.changePw(id,eu.getSha512(pw),eu.getSha512(newPw));
		
		if (result > 0) {
	        // [성공] 로그아웃 후 로그인 폼으로
			ra.addFlashAttribute("msg", "비밀번호가 변경되었습니다. 다시 로그인해주세요.");
	        session.invalidate();
	        
	        return "redirect:/members/toLogin"; 
	    } else {
	        // [실패] 다시 설정 페이지로 (메시지 포함)
	        ra.addFlashAttribute("msg", "현재 비밀번호가 일치하지 않습니다.");
	        return "redirect:/mypage/toAccount"; // 원래 있던 페이지 주소
	    }
	}
	@RequestMapping("/myresume")
	public String myResume(HttpSession session,Model model) {
		String id = (String)session.getAttribute("loginId");
		int count = rdao.countById(id);
		model.addAttribute("count",count);
		List<ResumeDTO> list = rdao.myList(id);
		model.addAttribute("list",list);
		
		return "mypage/resume/myresume";
	}
	@RequestMapping("/resume_detail")
	public String resume_detail(int seq,Model model) {
		ResumeDTO dto = rdao.detail(seq);
		model.addAttribute("dto",dto);
		return "mypage/resume/detail";
	}
	@RequestMapping("/resume_delete")
	public String resume_delete(int seq) {
		rdao.delete(seq);
		return "redirect:/mypage/myresume";
	}
	
	
	@RequestMapping("/myjobpost_update")
	public String toMyjobpost_update(int seq, HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("loginId");
		JobPostDTO post = jpdao.getPostDetail(seq);
		
		List<CateGoryDTO> upperList = catdao.getUpperCategories();
		
		model.addAttribute("upperList", upperList);
		model.addAttribute("post", post);
		
		System.out.println("sysout: " + post.getWork_starttime());
		return "mypage/myjobpost_update";
		
		
	}
	
	@RequestMapping("/jobpost_update")
	public String JobPostUpdate(JobPostDTO dto, int seq) {
		int result = jpdao.JobPostUpdate(dto);
		
		
		if(result > 0) {
			return "redirect:/mypage/myjobpost?seq="+seq;
		}else {
			return "redirect:/mypage/myjobpost?isSuccess=false"+seq;
		}
	}
	@RequestMapping("/toUpdateResume")
	public String toUpdateResume(int seq,Model model) {
		ResumeDTO dto = rdao.detail(seq);
		model.addAttribute("dto",dto);
		List<JobPostDTO> main_jobCateList =  dao.getJobCategory();
		model.addAttribute("main_jobCateList",main_jobCateList);
		return "mypage/resume/update";
	}
	@RequestMapping("/update_resume")
	public String update_resume(ResumeDTO dto) {
		rdao.update(dto);
		return "redirect:/mypage/resume_detail?seq=" + dto.getSeq();
	}
	
	@RequestMapping("/viewresume")
	public String toViewResume(int resume_num) {
		
		return "mypage/viewresume";
	}
	
}
