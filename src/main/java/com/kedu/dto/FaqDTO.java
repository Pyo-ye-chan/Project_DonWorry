package com.kedu.dto;

import java.sql.Timestamp;

public class FaqDTO {
	
	private int seq;
	private String title;
	private String content;
	private Timestamp write_date;
	private String is_show;
	private int sort_order;
	
	private String reg_date_str;
	
	
	public String getReg_date_str() {
		return reg_date_str;
	}

	public void setReg_date_str(String reg_date_str) {
		this.reg_date_str = reg_date_str;
	}

	public FaqDTO() {}
	
	public FaqDTO(int seq, String title, String content, Timestamp write_date, String is_show, int sort_order) {
		super();
		this.seq = seq;
		this.title = title;
		this.content = content;
		this.write_date = write_date;
		this.is_show = is_show;
		this.sort_order = sort_order;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public String getIs_show() {
		return is_show;
	}
	public void setIs_show(String is_show) {
		this.is_show = is_show;
	}
	public int getSort_order() {
		return sort_order;
	}
	public void setSort_order(int sort_order) {
		this.sort_order = sort_order;
	}
	
	
	

}
