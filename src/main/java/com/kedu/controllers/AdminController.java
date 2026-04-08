package com.kedu.controllers;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.kedu.dao.AdminDAO;
import com.kedu.dao.BoardsDAO;
import com.kedu.dao.FaqDAO;
import com.kedu.dao.FilesDAO;
import com.kedu.dao.JobPostDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dao.QnaDAO;
import com.kedu.dao.ReplyDAO;
import com.kedu.dao.ReportDAO;
import com.kedu.dto.BoardsDTO;
import com.kedu.dto.FaqDTO;
import com.kedu.dto.FilesDTO;
import com.kedu.dto.MembersDTO;
import com.kedu.dto.QnaDTO;
import com.kedu.dto.ReplyDTO;

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

	@Autowired
	private AdminDAO adao;

	@Autowired
	private ReplyDAO rdao;

	@Autowired
	private FaqDAO fadao;

	@Autowired
	private Gson gson;

	@Autowired
	private JobPostDAO jdao;

	@Autowired
	private ReportDAO rrdao;

	@RequestMapping("/admin_main")
	public String adminMain(Model model, @RequestParam(value="page", defaultValue="1") int page) {
		int recordTotalCount;
		int start = page * 7 - 6;
		int end = page * 7;

		List<MembersDTO> recentMembersList = dao.getRecentMembers(start, end);
		recordTotalCount = dao.getRecentMembersCount();
		int totalMembers = dao.membersTotalCount();
		int todayJoin = dao.getTodayJoinCount();

		int totalBoards = bdao.mainRecordTotalCount();
		int todayBoards = bdao.getTodayBoardCount();

		int unansweredQna = qdao.getUnansweredCount();
		int overdueQna = qdao.getOverdueCount();
		int todayInquiryCount = qdao.getTodayInquiryCount();

		int reportStatusCount = rrdao.getReportStatusCount();

		int businessCount = dao.getbusinessMemberCount();
		int personalCount = dao.getpersonalMemberCount();

		int jobCount = jdao.getPostCount();

		int reportCount = rrdao.getReportCount();



		// 2. 퍼센트 계산 (0으로 나누기 방지)
		int validUserSum = personalCount + businessCount;

		double bizPercent = (validUserSum > 0) ? (double)businessCount / validUserSum * 100 : 0;
		double perPercent = (validUserSum > 0) ? (double)personalCount / validUserSum * 100 : 0;

		model.addAttribute("totalMembers", totalMembers);
		model.addAttribute("todayJoinCount", todayJoin);

		model.addAttribute("totalBoards", totalBoards);
		model.addAttribute("todayBoardCount", todayBoards);

		model.addAttribute("unansweredInquiryCount", unansweredQna);
		model.addAttribute("overdueInquiryCount", overdueQna);
		model.addAttribute("todayInquiryCount", todayInquiryCount);

		model.addAttribute("businessMemberCount", businessCount);
		model.addAttribute("businessMemberPercent", String.format("%.1f", bizPercent)); // 소수점 한자리
		model.addAttribute("personalMemberCount", personalCount);
		model.addAttribute("personalMemberPercent", String.format("%.1f", perPercent));

		model.addAttribute("jobPostCount", jobCount);

		model.addAttribute("reportCount", reportCount);
		model.addAttribute("urgentReportCount", reportStatusCount);

		model.addAttribute("recentMembers", recentMembersList);

		model.addAttribute("currentPage", page);
		model.addAttribute("recordCountPerPage", 7);
		model.addAttribute("naviCountPerPage", 10);
		model.addAttribute("recordTotalCount", recordTotalCount);

		int pageCount = (int)Math.ceil(recordTotalCount / (double)7); 

		int startNavi = ((page - 1) / 10) * 10 + 1;

		int endNavi = startNavi + 10 - 1;
		if (endNavi > pageCount) { endNavi = pageCount; }

		model.addAttribute("startNavi", startNavi);
		model.addAttribute("endNavi", endNavi);
		model.addAttribute("pageCount", pageCount);

		return "admin/admin_main";
	}

	@RequestMapping("/admin_members")
	public String toMembers(Model model, @RequestParam(value="page", defaultValue="1") int page) {
		List<MembersDTO> membersList = dao.getMembers(page*10-9, page*10);

		int statecount = dao.getStateCount();
		int recordTotalCount = dao.membersTotalCount();
		System.out.println(recordTotalCount);

		model.addAttribute("currentPage",page);
		model.addAttribute("recordCountPerPage",10);
		model.addAttribute("naviCountPerPage",10);
		model.addAttribute("recordTotalCount",recordTotalCount);
		model.addAttribute("membersList", membersList);
		model.addAttribute("membersCount", recordTotalCount);
		model.addAttribute("StateCount", statecount);

		return "admin/admin_members";
	}

	/* 관리자 - 게시물 관리 */
	@RequestMapping("/admin_boards")
	public String adminBoards(int page, Model model) {
		//회원 게시글 페이지네이션 적용
		List<BoardsDTO> board_mainList =  adao.admin_boardList(page*5-4,page*5);		
		int recordTotalCount = bdao.mainRecordTotalCount();

		model.addAttribute("currentPage",page);
		model.addAttribute("recordCountPerPage",5);
		model.addAttribute("naviCountPerPage",10);
		model.addAttribute("recordTotalCount",recordTotalCount);
		model.addAttribute("board_mainList", board_mainList);

		//공지글 페이지 ㄴ
		List<BoardsDTO> notice_mainList =  adao.adminNoticeList();
		model.addAttribute("notice_mainList",notice_mainList);

		//댓글 목록
		int replyCount = rdao.replyCount();
		model.addAttribute("replyCount",replyCount);
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

	//댓글리스트

	@RequestMapping("/admin_reply")
	public String admin_Reply(//page가 없을 때 자동으로 1
			@RequestParam(value="page", defaultValue="1")int page, Model model) {
		//회원 댓글 전체 불러옴
		List<ReplyDTO> replyList =  adao.admin_replyList(page*5-4,page*5);
		int recordTotalCount = rdao.replyCount();
		
		model.addAttribute("currentPage",page);
		model.addAttribute("recordCountPerPage",5);
		model.addAttribute("naviCountPerPage",10);
		model.addAttribute("recordTotalCount",recordTotalCount);
		model.addAttribute("replyList", replyList);
		
		//신고댓글만 불러옴
		List<ReplyDTO> report_replyList = adao.admin_report_replyList();
		model.addAttribute("report_replyList", report_replyList);
		
		return "admin/admin_reply";
	}
	
	//댓글 삭제
	@RequestMapping("/admin_reply_delete")
	public String admin_reply_delete(int seq, int page) {
		rdao.delete(seq);
		return "redirect:/admin/admin_reply?page=" + page;
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

	@ResponseBody
	@RequestMapping("/changeMemberState")
	public String changeMemberState(String nickname, String state) {
		try {
			// id와 바꿀 state('Y' or 'N')를 같이 던짐
			int result = dao.updateMemberState(nickname, state);

			return (result > 0) ? "success" : "fail";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
	@ResponseBody
	@RequestMapping("/api/faq_register")
	public String faq_register(FaqDTO dto) {
		int result = fadao.insert(dto);
		if(result > 0) {
			return "success";
		}return "fail";
	}
	@ResponseBody
	@RequestMapping("/api/faq_list")
	public String faq_list(@RequestParam(value="page", defaultValue="1")int page) {

		int countPerPage = 5;

		int start = (page - 1) * countPerPage + 1;
		int end = page * countPerPage;

		List<FaqDTO> list = fadao.adminList(start,end);
		int totalCount = fadao.getTotalCount();

		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		map.put("currentPage", page);

		return gson.toJson(map);
	}
	@ResponseBody
	@RequestMapping("/api/faq_toggle_show")
	public String faq_toggle_show(int seq,String is_show) {
		int result = fadao.updateIs_show(seq,is_show);
		if(result > 0) {
			return "success";
		}return "fail";

	}
	@ResponseBody
	@Transactional
	@RequestMapping("/api/faq_update_sort")
	public String faq_update_sort(int seq,int sort_order) {
		fadao.pullBackOrder(seq);
		fadao.pushBackOrder(sort_order);

		int result = fadao.updateSort(seq,sort_order);
		if(result > 0) {
			return "success";
		}return "fail";
	}
	@ResponseBody
	@RequestMapping("/api/faq_delete")
	public String faq_delete(int seq) {
		fadao.pullBackOrder(seq);
		int result = fadao.delete(seq);

		if(result > 0) {
			return "success";
		}return "fail";
	}




}
