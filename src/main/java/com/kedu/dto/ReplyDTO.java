package com.kedu.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

public class ReplyDTO {
	
	private int seq;
	private int parent_seq;
	private String member_id;
	private String content;
	private Timestamp write_date;
	private Integer re_reply_seq;
	
	private String write_date_str;

	public String getWrite_date_str() {
	    return write_date_str;
	}

	public void setWrite_date_str(String write_date_str) {
	    this.write_date_str = write_date_str;
	}
		
	private String writer;
	
	
	
	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public ReplyDTO() {}
	
	public ReplyDTO(int seq, int parent_seq, String member_id, String content, Timestamp write_date,
			Integer re_reply_seq) {
		super();
		this.seq = seq;
		this.parent_seq = parent_seq;
		this.member_id = member_id;
		this.content = content;
		this.write_date = write_date;
		this.re_reply_seq = re_reply_seq;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
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
	public Integer getRe_reply_seq() {
		return re_reply_seq;
	}
	public void setRe_reply_seq(Integer re_reply_seq) {
		this.re_reply_seq = re_reply_seq;
	}
	
	private List<ReplyDTO> replies;

	public List<ReplyDTO> getReplies() {
	    return replies;
	}

	public void setReplies(List<ReplyDTO> replies) {
	    this.replies = replies;
	}
	
	
	
	

}
