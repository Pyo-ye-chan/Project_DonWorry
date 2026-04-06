package com.kedu.dto;

import java.sql.Timestamp;

public class JobPostDTO {
    private int seq;
    private String member_id;
    private String company_name;
    private String phone;
    private String category;
    private String sido;
    private String gugun;
    private String dong;
    private String address_detail;
    private int count;         // JSP: name="count"
    private String title;
    private String pay;        // JSP: name="pay"
    private String work_days;  // JSP: name="work_days"
    private String work_starttime; // JSP: name="start_time"
    private String work_endtime;   // JSP: name="end_time"
    private String content;
    private String benefit;
    private Timestamp write_date;
    
    
    
    
	public JobPostDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public JobPostDTO(int seq, String member_id, String company_name, String phone, String category, String sido,
			String gugun, String dong, String address_detail, int count, String title, String pay, String work_days,
			String work_starttime, String work_endtime, String content, String benefit, Timestamp write_date) {
		super();
		this.seq = seq;
		this.member_id = member_id;
		this.company_name = company_name;
		this.phone = phone;
		this.category = category;
		this.sido = sido;
		this.gugun = gugun;
		this.dong = dong;
		this.address_detail = address_detail;
		this.count = count;
		this.title = title;
		this.pay = pay;
		this.work_days = work_days;
		this.work_starttime = work_starttime;
		this.work_endtime = work_endtime;
		this.content = content;
		this.benefit = benefit;
		this.write_date = write_date;
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
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getGugun() {
		return gugun;
	}
	public void setGugun(String gugun) {
		this.gugun = gugun;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getAddress_detail() {
		return address_detail;
	}
	public void setAddress_detail(String address_detail) {
		this.address_detail = address_detail;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPay() {
		return pay;
	}
	public void setPay(String pay) {
		this.pay = pay;
	}
	public String getWork_days() {
		return work_days;
	}
	public void setWork_days(String work_days) {
		this.work_days = work_days;
	}
	public String getWork_starttime() {
		return work_starttime;
	}
	public void setWork_starttime(String work_starttime) {
		this.work_starttime = work_starttime;
	}
	public String getWork_endtime() {
		return work_endtime;
	}
	public void setWork_endtime(String work_endtime) {
		this.work_endtime = work_endtime;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getBenefit() {
		return benefit;
	}
	public void setBenefit(String benefit) {
		this.benefit = benefit;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
    
    
    
    
    
	

    
    
    }