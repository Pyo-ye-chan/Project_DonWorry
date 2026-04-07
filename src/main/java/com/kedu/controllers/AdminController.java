package com.kedu.controllers;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kedu.dao.BoardsDAO;
import com.kedu.dao.FilesDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dao.QnaDAO;
import com.kedu.dto.BoardsDTO;
import com.kedu.dto.FilesDTO;
import com.kedu.dto.MembersDTO;
import com.kedu.dto.QnaDTO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	

	@Autowired
	private MembersDAO dao;
	
	@Autowired
	private BoardsDAO bdao;
	
	@Autowired
	private FilesDAO fdao;
	
	@Autowired
	private QnaDAO qdao;
	
	@RequestMapping("/admin/admin_main")
	public String adminMain(Model model) {
		
		List<MembersDTO> recentMembersList = dao.getRecentMembers();

	    model.addAttribute("today", "2026-04-06");

	    model.addAttribute("totalMembers", 3300);
	    model.addAttribute("todayJoinCount", 18);

	    model.addAttribute("totalBoards", 1200);
	    model.addAttribute("todayBoardCount", 27);

	    model.addAttribute("unansweredInquiryCount", 23);
	    model.addAttribute("overdueInquiryCount", 6);
	    model.addAttribute("todayInquiryCount", 9);

	    model.addAttribute("businessMemberCount", 323);
	    model.addAttribute("businessMemberPercent", 9.8);
	    model.addAttribute("personalMemberCount", 2977);
	    model.addAttribute("personalMemberPercent", 90.2);

	    model.addAttribute("jobPostCount", 132);
	    model.addAttribute("recruitingJobCount", 98);

	    model.addAttribute("reportCount", 13);
	    model.addAttribute("urgentReportCount", 4);

	    model.addAttribute("visitorChartLabels", Arrays.asList("4/1", "4/2", "4/3", "4/4", "4/5", "4/6", "4/7"));
	    model.addAttribute("visitorChartData", Arrays.asList(120, 148, 162, 155, 180, 176, 190));

	    model.addAttribute("postChartLabels", Arrays.asList("11월", "12월", "1월", "2월", "3월", "4월"));
	    model.addAttribute("boardChartData", Arrays.asList(120, 180, 240, 210, 230, 260));
	    model.addAttribute("inquiryChartData", Arrays.asList(80, 130, 180, 160, 170, 190));

	    model.addAttribute("recentMembers", recentMembersList);

	    return "admin/admin_main";
	}
	
	@RequestMapping("/admin_main")
	public String toAdmin() {
		return "admin/admin_main";
	}
	
	@RequestMapping("/admin_members")
	public String toMembers(Model model, int page) {
		List<MembersDTO> membersList = dao.getMembers(page*10-9, page*10);
		
		int recordTotalCount = dao.membersTotalCount();
		
		model.addAttribute("currentPage",page);
		model.addAttribute("recordCountPerPage",10);
		model.addAttribute("naviCountPerPage",10);
		model.addAttribute("recordTotalCount",recordTotalCount);
		model.addAttribute("membersList", membersList);
		
		return "admin/admin_members";
	}
	
/* 관리자 - 게시물 관리 */
	@RequestMapping("/admin_boards")
	public String adminBoards(int page, Model model) {
		//회원 게시글 페이지네이션 적용
		List<BoardsDTO> board_mainList =  bdao.mainList(page*5-4,page*5);		
		int recordTotalCount = bdao.mainRecordTotalCount();
		
		model.addAttribute("currentPage",page);
		model.addAttribute("recordCountPerPage",5);
		model.addAttribute("naviCountPerPage",10);
		model.addAttribute("recordTotalCount",recordTotalCount);
		model.addAttribute("board_mainList", board_mainList);
		
		//공지글 페이지 ㄴ
		List<BoardsDTO> notice_mainList =  bdao.adminNoticeList();
		model.addAttribute("notice_mainList",notice_mainList);
		
		return "admin/admin_boards";
	}
	
	//게시물 상세보기
	@RequestMapping("/admin_board_detail")
	public String admin_board_detail(int seq, int page, Model model){
		BoardsDTO dto = bdao.detail(seq);
		model.addAttribute("dto",dto);
		model.addAttribute("currentPage",page);
		return "admin/admin_board_detail";
	}
	//게시물 삭제
	@RequestMapping("/admin_board_delete")
	public String delete(int seq, int page) {
		bdao.delete(seq);
		
		return "redirect:/admin/admin_boards?page="+page;
	}
	//공지 글 쓰기
	@RequestMapping("/notice_Towrite")
	public String adminWrite() {
		return "admin/notice_write";
	}

	//공지글 등록
	@RequestMapping("/notice_write")
	public String noticeWrite(BoardsDTO dto,MultipartFile[] files) {
		
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
		
		
		return "redirect:/admin/admin_boards?page=1";
	}
	
	@RequestMapping("/admin_inquiry")
	public String toInquiry(Model model) {
			
		model.addAttribute("allCount",qdao.selectAllCount());
		model.addAttribute("waitCount",qdao.selectWaitCount());
		model.addAttribute("completeCount",qdao.selectCompleteCount());
		
		model.addAttribute("weekNewCount",qdao.selectWeekNewCount());
		model.addAttribute("overwaitCount",qdao.selectOverdueWaitCount());
		model.addAttribute("replyTime",qdao.selectAvgReplyTime());
		
		
		return "admin/admin_inquiry";
	}
	@ResponseBody
    @RequestMapping("/api/inquiry_list")
    public Map<String, Object> getInquiryList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "all") String status,
            @RequestParam(defaultValue = "") String keyword) {
        
        int recordCountPerPage = 10;
        int naviCountPerPage = 10;
        
        // 검색 조건이 포함된 리스트와 전체 개수 조회
        List<QnaDTO> mainList = qdao.selectSearchList(page, status, keyword, recordCountPerPage);
        for(QnaDTO dto : mainList) {
        	dto.setWrite_date_str(
    		        new SimpleDateFormat("yyyy-MM-dd").format(dto.getWrite_date())
    		    );
        }
        
        int recordTotalCount = qdao.selectSearchCount(status, keyword);
        
        Map<String, Object> response = new HashMap<>();
        response.put("mainList", mainList);
        response.put("currentPage", page);
        response.put("recordCountPerPage", recordCountPerPage);
        response.put("naviCountPerPage", naviCountPerPage);
        response.put("recordTotalCount", recordTotalCount);
        
        return response;
    }
	@RequestMapping("/qnaDetail")
	public String qnaDetail(int seq,Model model) {
		model.addAttribute("dto",qdao.detail(seq));
		
		return "/admin/qna_detail";
	}
	
	
	

}
