package com.kedu.dto;

import java.sql.Timestamp;

public class WorklogDTO {
	
	private int seq; // 근무 기록 번호
	private int parent_seq; // 근무지 번호
	private Timestamp work_date; //근무 날짜
	private Timestamp start_time; //
	private Timestamp end_time;
	private Timestamp break_starttime;
	private Timestamp break_endtime;
	private int night_pay;
	private int overtime_pay;
	private int holiday_pay;
	private int total_pay; // 총 급여
	private String memo;
	private Timestamp worklog_date;
	
	public WorklogDTO() {}

	public WorklogDTO(int seq, int parent_seq, Timestamp work_date, Timestamp start_time, Timestamp end_time,
			Timestamp break_starttime, Timestamp break_endtime, int night_pay, int overtime_pay, int holiday_pay,
			int total_pay, String memo, Timestamp worklog_date) {
		super();
		this.seq = seq;
		this.parent_seq = parent_seq;
		this.work_date = work_date;
		this.start_time = start_time;
		this.end_time = end_time;
		this.break_starttime = break_starttime;
		this.break_endtime = break_endtime;
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

	public Timestamp getWork_date() {
		return work_date;
	}

	public void setWork_date(Timestamp work_date) {
		this.work_date = work_date;
	}

	public Timestamp getStart_time() {
		return start_time;
	}

	public void setStart_time(Timestamp start_time) {
		this.start_time = start_time;
	}

	public Timestamp getEnd_time() {
		return end_time;
	}

	public void setEnd_time(Timestamp end_time) {
		this.end_time = end_time;
	}

	public Timestamp getBreak_starttime() {
		return break_starttime;
	}

	public void setBreak_starttime(Timestamp break_starttime) {
		this.break_starttime = break_starttime;
	}

	public Timestamp getBreak_endtime() {
		return break_endtime;
	}

	public void setBreak_endtime(Timestamp break_endtime) {
		this.break_endtime = break_endtime;
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

	public Timestamp getWorklog_date() {
		return worklog_date;
	}

	public void setWorklog_date(Timestamp worklog_date) {
		this.worklog_date = worklog_date;
	};
	
	

}