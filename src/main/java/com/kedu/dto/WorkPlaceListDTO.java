package com.kedu.dto;

public class WorkPlaceListDTO {
	
	private int seq;
    private String name;

    private int totalPay;
    private int workDays;
    private int totalHours;
    
    public WorkPlaceListDTO() {}

	public WorkPlaceListDTO(int seq, String name, int totalPay, int workDays, int totalHours) {
		super();
		this.seq = seq;
		this.name = name;
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
