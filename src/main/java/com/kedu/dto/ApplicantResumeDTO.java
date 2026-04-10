package com.kedu.dto;

import java.sql.Timestamp;

public class ApplicantResumeDTO {
	
    private int apply_seq;
    private String apply_status;
    private int job_post_num;
    private String member_id;
    private int resume_num;

    private String job_title;
    private String company_name;

    private String resume_title;
    private String preferred_job;
    private String working_condition;
    private String career;
    private String career_write;
    private String introduction;
    private Timestamp resume_date;

    // members 테이블에서 가져올 값 추가
    private String name;
    private String phone;

    public ApplicantResumeDTO() {}

    public ApplicantResumeDTO(int apply_seq, String apply_status, int job_post_num, String member_id, int resume_num,
            String job_title, String company_name, String resume_title, String preferred_job, String working_condition,
            String career, String career_write, String introduction, Timestamp resume_date, String name, String phone) {
        super();
        this.apply_seq = apply_seq;
        this.apply_status = apply_status;
        this.job_post_num = job_post_num;
        this.member_id = member_id;
        this.resume_num = resume_num;
        this.job_title = job_title;
        this.company_name = company_name;
        this.resume_title = resume_title;
        this.preferred_job = preferred_job;
        this.working_condition = working_condition;
        this.career = career;
        this.career_write = career_write;
        this.introduction = introduction;
        this.resume_date = resume_date;
        this.name = name;
        this.phone = phone;
    }

    public int getApply_seq() {
        return apply_seq;
    }

    public void setApply_seq(int apply_seq) {
        this.apply_seq = apply_seq;
    }

    public String getApply_status() {
        return apply_status;
    }

    public void setApply_status(String apply_status) {
        this.apply_status = apply_status;
    }

    public int getJob_post_num() {
        return job_post_num;
    }

    public void setJob_post_num(int job_post_num) {
        this.job_post_num = job_post_num;
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

    public String getJob_title() {
        return job_title;
    }

    public void setJob_title(String job_title) {
        this.job_title = job_title;
    }

    public String getCompany_name() {
        return company_name;
    }

    public void setCompany_name(String company_name) {
        this.company_name = company_name;
    }

    public String getResume_title() {
        return resume_title;
    }

    public void setResume_title(String resume_title) {
        this.resume_title = resume_title;
    }

    public String getPreferred_job() {
        return preferred_job;
    }

    public void setPreferred_job(String preferred_job) {
        this.preferred_job = preferred_job;
    }

    public String getWorking_condition() {
        return working_condition;
    }

    public void setWorking_condition(String working_condition) {
        this.working_condition = working_condition;
    }

    public String getCareer() {
        return career;
    }

    public void setCareer(String career) {
        this.career = career;
    }

    public String getCareer_write() {
        return career_write;
    }

    public void setCareer_write(String career_write) {
        this.career_write = career_write;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public Timestamp getResume_date() {
        return resume_date;
    }

    public void setResume_date(Timestamp resume_date) {
        this.resume_date = resume_date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}