package com.kedu.dto;

import java.sql.Timestamp;

public class MembersDTO {
	
	private String id;
	private String pw;
	private String name;
	private String nickname;
	private String phone;
	private String email;
	private String type;
	private String state;
	private String rrn;
	private String business_number;
	private String gender;
	private Timestamp join_date;
	
	
	
	public MembersDTO() {}
	
	public MembersDTO(String id, String pw, String name, String nickname, String phone, String email, String type,
			String state, String rrn, String business_number, String gender, Timestamp join_date) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.nickname = nickname;
		this.phone = phone;
		this.email = email;
		this.type = type;
		this.state = state;
		this.rrn = rrn;
		this.business_number = business_number;
		this.gender = gender;
		this.join_date = join_date;
	}
	
	public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getRrn() {
		return rrn;
	}
	public void setRrn(String rrn) {
		this.rrn = rrn;
	}
	public String getBusiness_number() {
		return business_number;
	}
	public void setBusiness_number(String business_number) {
		this.business_number = business_number;
	}
	public Timestamp getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Timestamp join_date) {
		this.join_date = join_date;
	}
	
	
	
	
	

}
