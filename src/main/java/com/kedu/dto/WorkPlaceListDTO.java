package com.kedu.dto;

import java.time.LocalDate;

public class WorkPlaceListDTO {
	
	private int seq;
    private String name;

    private LocalDate workDate;
    
    private Integer logSeq;
    
    private int totalPay;
    private int workDays;
    private Integer totalHours;
    
    private int payPerHour;
    private String payType;
    private double taxApplied;
    private String insuranceApplied;
    private String employmentInsurance;
    
    public WorkPlaceListDTO() {}

	public WorkPlaceListDTO(int seq, String name, LocalDate workDate, Integer logSeq, int totalPay, int workDays,
			Integer totalHours, int payPerHour, String payType, double taxApplied, String insuranceApplied,
			String employmentInsurance) {
		super();
		this.seq = seq;
		this.name = name;
		this.workDate = workDate;
		this.logSeq = logSeq;
		this.totalPay = totalPay;
		this.workDays = workDays;
		this.totalHours = totalHours;
		this.payPerHour = payPerHour;
		this.payType = payType;
		this.taxApplied = taxApplied;
		this.insuranceApplied = insuranceApplied;
		this.employmentInsurance = employmentInsurance;
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

	public Integer getTotalHours() {
		return totalHours;
	}

	public void setTotalHours(Integer totalHours) {
		this.totalHours = totalHours;
	}

	public int getPayPerHour() {
		return payPerHour;
	}

	public void setPayPerHour(int payPerHour) {
		this.payPerHour = payPerHour;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public double getTaxApplied() {
		return taxApplied;
	}

	public void setTaxApplied(double taxApplied) {
		this.taxApplied = taxApplied;
	}

	public String getInsuranceApplied() {
		return insuranceApplied;
	}

	public void setInsuranceApplied(String insuranceApplied) {
		this.insuranceApplied = insuranceApplied;
	}

	public String getEmploymentInsurance() {
		return employmentInsurance;
	}

	public void setEmploymentInsurance(String employmentInsurance) {
		this.employmentInsurance = employmentInsurance;
	}

    
	
}
