package com.kedu.dto;

import java.sql.Timestamp;

public class Qna_replyDTO {
	
	private int seq;
	private int qna_num;
	private String member_id;
	private String content;
	private Timestamp write_date;
	
	public Qna_replyDTO() {}
	
	public Qna_replyDTO(int seq, int qna_num, String member_id, String content, Timestamp write_date) {
		super();
		this.seq = seq;
		this.qna_num = qna_num;
		this.member_id = member_id;
		this.content = content;
		this.write_date = write_date;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getQna_num() {
		return qna_num;
	}
	public void setQna_num(int qna_num) {
		this.qna_num = qna_num;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	
	
	

}
