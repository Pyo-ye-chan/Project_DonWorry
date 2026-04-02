package com.kedu.dto;

import java.sql.Timestamp;

public class WorkPlaceDTO {
	private int seq;
    private String id; // 회원 ID (FK)
    private String name;
    private int pay_per_hour;
    private String pay_type; // 기본값 '시급'
    private String pay_cycle;
    private int payday;
    private String tax_applied; // 'Y' or 'N'
    private String insurance_applied; // 'Y' or 'N'
    private String employment_insurance; // 'Y' or 'N'
    private String work_start_time; // HH:mm 형식
    private String work_end_time;
    private String workplace_date;
    
    
    
    
	public WorkPlaceDTO() {}
	
	public WorkPlaceDTO(int seq, String id, String name, int pay_per_hour, String pay_type, String pay_cycle,
			int payday, String tax_applied, String insurance_applied, String employment_insurance,
			String work_start_time, String work_end_time, String workplace_date) {
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.pay_per_hour = pay_per_hour;
		this.pay_type = pay_type;
		this.pay_cycle = pay_cycle;
		this.payday = payday;
		this.tax_applied = tax_applied;
		this.insurance_applied = insurance_applied;
		this.employment_insurance = employment_insurance;
		this.work_start_time = work_start_time;
		this.work_end_time = work_end_time;
		this.workplace_date = workplace_date;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPay_per_hour() {
		return pay_per_hour;
	}
	public void setPay_per_hour(int pay_per_hour) {
		this.pay_per_hour = pay_per_hour;
	}
	public String getPay_type() {
		return pay_type;
	}
	public void setPay_type(String pay_type) {
		this.pay_type = pay_type;
	}
	public String getPay_cycle() {
		return pay_cycle;
	}
	public void setPay_cycle(String pay_cycle) {
		this.pay_cycle = pay_cycle;
	}
	public int getPayday() {
		return payday;
	}
	public void setPayday(int payday) {
		this.payday = payday;
	}
	public String getTax_applied() {
		return tax_applied;
	}
	public void setTax_applied(String tax_applied) {
		this.tax_applied = tax_applied;
	}
	public String getInsurance_applied() {
		return insurance_applied;
	}
	public void setInsurance_applied(String insurance_applied) {
		this.insurance_applied = insurance_applied;
	}
	public String getEmployment_insurance() {
		return employment_insurance;
	}
	public void setEmployment_insurance(String employment_insurance) {
		this.employment_insurance = employment_insurance;
	}
	public String getWork_start_time() {
		return work_start_time;
	}
	public void setWork_start_time(String work_start_time) {
		this.work_start_time = work_start_time;
	}
	public String getWork_end_time() {
		return work_end_time;
	}
	public void setWork_end_time(String work_end_time) {
		this.work_end_time = work_end_time;
	}
	public String getWorkplace_date() {
		return workplace_date;
	}
	public void setWorkplace_date(String workplace_date) {
		this.workplace_date = workplace_date;
	}

    
    
}