package com.kedu.dto;

import java.time.LocalDate;

public class WorkPlaceListDTO {
	
	private int seq;
    private String name;

    private LocalDate workDate;
    
    private Integer logSeq;
    
    private int totalPay;
    private int workDays;
    private int totalHours;
    
    public WorkPlaceListDTO() {}

	public WorkPlaceListDTO(int seq, String name, LocalDate workDate, Integer logSeq, int totalPay, int workDays,
			int totalHours) {
		super();
		this.seq = seq;
		this.name = name;
		this.workDate = workDate;
		this.logSeq = logSeq;
		this.totalPay = totalPay;
		this.workDays = workDays;
		this.totalHours = totalHours;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public LocalDate getWorkDate() {
		return workDate;
	}

	public void setWorkDate(LocalDate workDate) {
		this.workDate = workDate;
	}

	public Integer getLogSeq() {
		return logSeq;
	}

	public void setLogSeq(Integer logSeq) {
		this.logSeq = logSeq;
	}

	public int getTotalPay() {
		return totalPay;
	}

	public void setTotalPay(int totalPay) {
		this.totalPay = totalPay;
	}

	public int getWorkDays() {
		return workDays;
	}

	public void setWorkDays(int workDays) {
		this.workDays = workDays;
	}

	public int getTotalHours() {
		return totalHours;
	}

	public void setTotalHours(int totalHours) {
		this.totalHours = totalHours;
	}

	
}
