package com.kedu.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;


public class WorklogDTO {
	
	private int seq; // 근무 기록 번호
	private int parent_seq; // 근무지 번호
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern="yyyy-MM-dd")
	private LocalDate work_date;
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	@JsonFormat(pattern="yyyy-MM-dd'T'HH:mm")
	private LocalDateTime start_time; // 시작 시간
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	@JsonFormat(pattern="yyyy-MM-dd'T'HH:mm")
	private LocalDateTime end_time; // 종료 시간
	private Integer breaktime;
	private Integer night_pay;
	private Integer overtime_pay;
	private Integer holiday_pay;
	private Integer total_pay;
	private String memo;
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	private LocalDateTime worklog_date;
	
	public WorklogDTO() {}

	public WorklogDTO(int seq, int parent_seq, LocalDate work_date, LocalDateTime start_time, LocalDateTime end_time,
			Integer breaktime, Integer night_pay, Integer overtime_pay, Integer holiday_pay, Integer total_pay,
			String memo, LocalDateTime worklog_date) {
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

	public Integer getBreaktime() {
		return breaktime;
	}

	public void setBreaktime(Integer breaktime) {
		this.breaktime = breaktime;
	}

	public Integer getNight_pay() {
		return night_pay;
	}

	public void setNight_pay(Integer night_pay) {
		this.night_pay = night_pay;
	}

	public Integer getOvertime_pay() {
		return overtime_pay;
	}

	public void setOvertime_pay(Integer overtime_pay) {
		this.overtime_pay = overtime_pay;
	}

	public Integer getHoliday_pay() {
		return holiday_pay;
	}

	public void setHoliday_pay(Integer holiday_pay) {
		this.holiday_pay = holiday_pay;
	}

	public Integer getTotal_pay() {
		return total_pay;
	}

	public void setTotal_pay(Integer total_pay) {
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