package com.kedu.dto;

public class SalarySummaryDTO {

	private int totalWorkMinutes;
	private int basePay;
	private int nightPay;
	private int overtimePay;
	private int holidayPay;
	private int weeklyPay;
	private double taxRate;
	private int tax;
	private int insurance;
	private int finalPay;
	private String insuranceType;	
	    
	public SalarySummaryDTO() {}

	public SalarySummaryDTO(int totalWorkMinutes, int basePay, int nightPay, int overtimePay, int holidayPay,
			int weeklyPay, double taxRate, int tax, int insurance, int finalPay, String insuranceType) {
		super();
		this.totalWorkMinutes = totalWorkMinutes;
		this.basePay = basePay;
		this.nightPay = nightPay;
		this.overtimePay = overtimePay;
		this.holidayPay = holidayPay;
		this.weeklyPay = weeklyPay;
		this.taxRate = taxRate;
		this.tax = tax;
		this.insurance = insurance;
		this.finalPay = finalPay;
		this.insuranceType = insuranceType;
	}

	public int getTotalWorkMinutes() {
		return totalWorkMinutes;
	}

	public void setTotalWorkMinutes(int totalWorkMinutes) {
		this.totalWorkMinutes = totalWorkMinutes;
	}

	public int getBasePay() {
		return basePay;
	}

	public void setBasePay(int basePay) {
		this.basePay = basePay;
	}

	public int getNightPay() {
		return nightPay;
	}

	public void setNightPay(int nightPay) {
		this.nightPay = nightPay;
	}

	public int getOvertimePay() {
		return overtimePay;
	}

	public void setOvertimePay(int overtimePay) {
		this.overtimePay = overtimePay;
	}

	public int getHolidayPay() {
		return holidayPay;
	}

	public void setHolidayPay(int holidayPay) {
		this.holidayPay = holidayPay;
	}

	public int getWeeklyPay() {
		return weeklyPay;
	}

	public void setWeeklyPay(int weeklyPay) {
		this.weeklyPay = weeklyPay;
	}

	public double getTaxRate() {
		return taxRate;
	}

	public void setTaxRate(double taxRate) {
		this.taxRate = taxRate;
	}

	public int getTax() {
		return tax;
	}

	public void setTax(int tax) {
		this.tax = tax;
	}

	public int getInsurance() {
		return insurance;
	}

	public void setInsurance(int insurance) {
		this.insurance = insurance;
	}

	public int getFinalPay() {
		return finalPay;
	}

	public void setFinalPay(int finalPay) {
		this.finalPay = finalPay;
	}

	public String getInsuranceType() {
		return insuranceType;
	}

	public void setInsuranceType(String insuranceType) {
		this.insuranceType = insuranceType;
	}

	
	    
}
