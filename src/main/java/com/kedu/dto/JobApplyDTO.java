package com.kedu.dto;

public class JobApplyDTO {
	private int seq;
	private String member_id;
	private int resume_num;
	private int job_post_num;
	private String status;
	
	
	
	public JobApplyDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public JobApplyDTO(int seq, String member_id, int resume_num, int job_post_num, String status) {
		super();
		this.seq = seq;
		this.member_id = member_id;
		this.resume_num = resume_num;
		this.job_post_num = job_post_num;
		this.status = status;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getResume_num() {
		return resume_num;
	}
	public void setResume_num(int resume_num) {
		this.resume_num = resume_num;
	}
	public int getJob_post_num() {
		return job_post_num;
	}
	public void setJob_post_num(int job_post_num) {
		this.job_post_num = job_post_num;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
