package com.kedu.dto;

import java.sql.Timestamp;

public class ReportDTO {
	private int seq;
	private Integer boards_seq;
	private Integer reply_seq;
	private String member_id;
	private String reason;
	private Timestamp report_date;
	private String status;
	
	
	public ReportDTO() {}
	
	


	public ReportDTO(int seq, Integer boards_seq, Integer reply_seq, String member_id, String reason,
			Timestamp report_date, String status) {
		super();
		this.seq = seq;
		this.boards_seq = boards_seq;
		this.reply_seq = reply_seq;
		this.member_id = member_id;
		this.reason = reason;
		this.report_date = report_date;
		this.status = status;
	}




	public int getSeq() {
		return seq;
	}


	public void setSeq(int seq) {
		this.seq = seq;
	}


	public Integer getBoards_seq() {
		return boards_seq;
	}


	public void setBoards_seq(Integer boards_seq) {
		this.boards_seq = boards_seq;
	}


	public Integer getReply_seq() {
		return reply_seq;
	}


	public void setReply_seq(Integer reply_seq) {
		this.reply_seq = reply_seq;
	}


	public String getMember_id() {
		return member_id;
	}


	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}


	public String getReason() {
		return reason;
	}


	public void setReason(String reason) {
		this.reason = reason;
	}


	public Timestamp getReport_date() {
		return report_date;
	}


	public void setReport_date(Timestamp report_date) {
		this.report_date = report_date;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
	
	

}
