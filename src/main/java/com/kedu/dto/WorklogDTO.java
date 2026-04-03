package com.kedu.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;


public class WorklogDTO {
	
	private int seq; // 근무 기록 번호
	private int parent_seq; // 근무지 번호
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate work_date; // 근무 날짜
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	private LocalDateTime start_time; // 시작 시간
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	private LocalDateTime end_time; // 종료 시간
	private int breaktime; // 휴게 시간
	private int night_pay; // 야간수당
	private int overtime_pay; // 연장수당
	private int holiday_pay; // 휴일수당
	private int total_pay; // 총 급여
	private String memo;
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	private LocalDateTime worklog_date;
	
	public WorklogDTO() {}

	public WorklogDTO(int seq, int parent_seq, LocalDate work_date, LocalDateTime start_time, LocalDateTime end_time,
			int breaktime, int night_pay, int overtime_pay, int holiday_pay, int total_pay, String memo,
			LocalDateTime worklog_date) {
		super();
		this.seq = seq;
		this.parent_seq = parent_seq;
		this.work_date = work_date;
		this.start_time = start_time;
		this.end_time = end_time;
		this.breaktime = breaktime;
		this.night_pay = night_pay;
		this.overtime_pay = overtime_pay;
		this.holiday_pay = holiday_pay;
		this.total_pay = total_pay;
		this.memo = memo;
		this.worklog_date = worklog_date;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getParent_seq() {
		return parent_seq;
	}

	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}

	public LocalDate getWork_date() {
		return work_date;
	}

	public void setWork_date(LocalDate work_date) {
		this.work_date = work_date;
	}

	public LocalDateTime getStart_time() {
		return start_time;
	}

	public void setStart_time(LocalDateTime start_time) {
		this.start_time = start_time;
	}

	public LocalDateTime getEnd_time() {
		return end_time;
	}

	public void setEnd_time(LocalDateTime end_time) {
		this.end_time = end_time;
	}

	public int getBreaktime() {
		return breaktime;
	}

	public void setBreaktime(int breaktime) {
		this.breaktime = breaktime;
	}

	public int getNight_pay() {
		return night_pay;
	}

	public void setNight_pay(int night_pay) {
		this.night_pay = night_pay;
	}

	public int getOvertime_pay() {
		return overtime_pay;
	}

	public void setOvertime_pay(int overtime_pay) {
		this.overtime_pay = overtime_pay;
	}

	public int getHoliday_pay() {
		return holiday_pay;
	}

	public void setHoliday_pay(int holiday_pay) {
		this.holiday_pay = holiday_pay;
	}

	public int getTotal_pay() {
		return total_pay;
	}

	public void setTotal_pay(int total_pay) {
		this.total_pay = total_pay;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public LocalDateTime getWorklog_date() {
		return worklog_date;
	}

	public void setWorklog_date(LocalDateTime worklog_date) {
		this.worklog_date = worklog_date;
	}

	
}