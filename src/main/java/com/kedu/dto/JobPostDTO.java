package com.kedu.dto;

import java.sql.Timestamp;

public class JobPostDTO {
    private int seq;
    private String member_id;
    private String company_name;
    private String phone;
    
    // 원본 ID값 (숫자형 문자열)
    private String main_category;
    private String sub_category;
    
    // [추가] JOIN 결과(카테고리 이름)를 담을 필드
    private String main_category_name;
    private String sub_category_name;
    
    private String sido;
    private String gugun;
    private String dong;
    private String address_detail;
    private int count;         
    private String title;
    private String pay;        
    private String work_days;  
    private String work_starttime; 
    private String work_endtime;   
    private String content;
    private String benefit;
    private Timestamp write_date;

    public JobPostDTO() {
        super();
    }

    // 전체 필드 생성자 (새로 추가된 name 필드 포함)
    public JobPostDTO(int seq, String member_id, String company_name, String phone, String main_category,
            String sub_category, String main_category_name, String sub_category_name, String sido, String gugun, 
            String dong, String address_detail, int count, String title, String pay, String work_days, 
            String work_starttime, String work_endtime, String content, String benefit, Timestamp write_date) {
        super();
        this.seq = seq;
        this.member_id = member_id;
        this.company_name = company_name;
        this.phone = phone;
        this.main_category = main_category;
        this.sub_category = sub_category;
        this.main_category_name = main_category_name;
        this.sub_category_name = sub_category_name;
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

    // [추가] Getter / Setter for Names
    public String getMain_category_name() {
        return main_category_name;
    }

    public void setMain_category_name(String main_category_name) {
        this.main_category_name = main_category_name;
    }

    public String getSub_category_name() {
        return sub_category_name;
    }

    public void setSub_category_name(String sub_category_name) {
        this.sub_category_name = sub_category_name;
    }

    // 기존 Getter / Setter
    public String getMain_category() { return main_category; }
    public void setMain_category(String main_category) { this.main_category = main_category; }
    public String getSub_category() { return sub_category; }
    public void setSub_category(String sub_category) { this.sub_category = sub_category; }
    public int getSeq() { return seq; }
    public void setSeq(int seq) { this.seq = seq; }
    public String getMember_id() { return member_id; }
    public void setMember_id(String member_id) { this.member_id = member_id; }
    public String getCompany_name() { return company_name; }
    public void setCompany_name(String company_name) { this.company_name = company_name; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getSido() { return sido; }
    public void setSido(String sido) { this.sido = sido; }
    public String getGugun() { return gugun; }
    public void setGugun(String gugun) { this.gugun = gugun; }
    public String getDong() { return dong; }
    public void setDong(String dong) { this.dong = dong; }
    public String getAddress_detail() { return address_detail; }
    public void setAddress_detail(String address_detail) { this.address_detail = address_detail; }
    public int getCount() { return count; }
    public void setCount(int count) { this.count = count; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getPay() { return pay; }
    public void setPay(String pay) { this.pay = pay; }
    public String getWork_days() { return work_days; }
    public void setWork_days(String work_days) { this.work_days = work_days; }
    public String getWork_starttime() { return work_starttime; }
    public void setWork_starttime(String work_starttime) { this.work_starttime = work_starttime; }
    public String getWork_endtime() { return work_endtime; }
    public void setWork_endtime(String work_endtime) { this.work_endtime = work_endtime; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getBenefit() { return benefit; }
    public void setBenefit(String benefit) { this.benefit = benefit; }
    public Timestamp getWrite_date() { return write_date; }
    public void setWrite_date(Timestamp write_date) { this.write_date = write_date; }
}