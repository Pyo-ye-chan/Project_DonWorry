package com.kedu.dao;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.SalarySummaryDTO;
import com.kedu.dto.WorklogDTO;

@Repository
public class WorklogDAO {
	
	@Autowired
	public JdbcTemplate jdbc;
	
	public int insertWorklog(WorklogDTO dto, String memberId) {
		String sql = "insert into worklog (seq, id, parent_seq, work_Date,"
				+ "start_time, end_time, breaktime, night_pay, overtime_pay,"
				+ "holiday_pay, total_pay, memo, worklog_date) values("
				+ "worklog_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
		return jdbc.update(sql, memberId, dto.getParent_seq(), dto.getWork_date(),
					dto.getStart_time(),dto.getEnd_time(), dto.getBreaktime(),
					dto.getNight_pay(), dto.getOvertime_pay(), dto.getHoliday_pay(),
					dto.getTotal_pay(), dto.getMemo());
		}

	public List<WorklogDTO> selectAllById(String memberId) {
		String sql = "select * from worklog where id = ?";
		List<WorklogDTO> list = jdbc.query(sql, new BeanPropertyRowMapper<WorklogDTO>(WorklogDTO.class), memberId);
		return list;
	}
	
	public WorklogDTO selectBySeq(int seq) {
		String sql = "select * from worklog where seq = ?";
		List<WorklogDTO> list = jdbc.query(sql, new BeanPropertyRowMapper<>(WorklogDTO.class), seq);
	    if(list.isEmpty()) {
	        return null; // 없으면 null 반환
	    }
		System.out.println(list.size());
		return list.get(0);
	}	
	
	public int deleteBySeq(int seq) {
		String sql = "delete from worklog where seq = ?";
		return jdbc.update(sql, seq);			
	}
	
	public int update(WorklogDTO dto) {
		String sql = "update worklog set parent_seq = ?, work_date = ?, "
				+ "start_time = ?, end_time = ?, breaktime = ?, night_pay = ?, "
				+ "overtime_pay = ?, holiday_pay = ?, total_pay = ?, memo = ? "
				+ "where seq = ?";
		return jdbc.update(sql, dto.getParent_seq(), dto.getWork_date(),
				dto.getStart_time(),dto.getEnd_time(), dto.getBreaktime(),
				dto.getNight_pay(), dto.getOvertime_pay(), dto.getHoliday_pay(),
				dto.getTotal_pay(), dto.getMemo(), dto.getSeq());
	}
	
	public SalarySummaryDTO getSalarySummary(String id, int year, int month) {

	    String sql =
	        "select " +
	        "    wl.seq as worklog_seq, " +
	        "    wl.parent_seq, " +
	        "    wl.start_time, " +
	        "    wl.end_time, " +
	        "    nvl(wl.breaktime, 0) as breaktime, " +
	        "    nvl(wl.night_pay, 0) as night_pay, " +
	        "    nvl(wl.overtime_pay, 0) as overtime_pay, " +
	        "    nvl(wl.holiday_pay, 0) as holiday_pay, " +
	        "    nvl(wp.pay_per_hour, 0) as pay_per_hour, " +
	        "    nvl(wp.pay_type, '시급') as pay_type, " +
	        "    nvl(wp.tax_applied, '0') as tax_applied, " +
	        "    nvl(wp.insurance_applied, 'N') as insurance_applied, " +
	        "    nvl(wp.employment_insurance, 'N') as employment_insurance " +
	        "from worklog wl " +
	        "left join workplace wp on wl.parent_seq = wp.seq " +
	        "where wl.id = ? " +
	        "and extract(year from wl.work_date) = ? " +
	        "and extract(month from wl.work_date) = ? " +
	        "order by wl.work_date asc";

	    List<Map<String, Object>> list = jdbc.queryForList(sql, id, year, month);

	    int totalWorkMinutes = 0;
	    int basePay = 0;
	    int nightPaySum = 0;
	    int overtimePaySum = 0;
	    int holidayPaySum = 0;
	    int weeklyPay = 0;
	    int tax = 0;
	    int insurance = 0;
	    int grossPay = 0;
	    double representativeTaxRate = 0.0;
	    String insuranceType = "보험료";

	    for (Map<String, Object> row : list) {
	        Timestamp startTime = (Timestamp) row.get("START_TIME");
	        Timestamp endTime = (Timestamp) row.get("END_TIME");

	        int breakMinutes = ((Number) row.get("BREAKTIME")).intValue();
	        int nightPay = ((Number) row.get("NIGHT_PAY")).intValue();
	        int overtimePay = ((Number) row.get("OVERTIME_PAY")).intValue();
	        int holidayPay = ((Number) row.get("HOLIDAY_PAY")).intValue();

	        int payPerHour = ((Number) row.get("PAY_PER_HOUR")).intValue();
	        String payType = String.valueOf(row.get("PAY_TYPE"));
	        String taxApplied = String.valueOf(row.get("TAX_APPLIED"));
	        String insuranceApplied = String.valueOf(row.get("INSURANCE_APPLIED"));
	        String employmentInsurance = String.valueOf(row.get("EMPLOYMENT_INSURANCE"));

	        int totalMinutes = 0;
	        if (startTime != null && endTime != null) {
	            long diffMillis = endTime.getTime() - startTime.getTime();
	            totalMinutes = (int) (diffMillis / (1000 * 60));
	        }

	        int realWorkMinutes = totalMinutes - breakMinutes;
	        if (realWorkMinutes < 0) realWorkMinutes = 0;

	        totalWorkMinutes += realWorkMinutes;

	        int rowBasePay = 0;
	        if ("시급".equals(payType)) {
	            rowBasePay = (int) Math.floor((realWorkMinutes / 60.0) * payPerHour);
	        } else if ("일급".equals(payType)) {
	            rowBasePay = payPerHour;
	        } else if ("월급".equals(payType)) {
	            rowBasePay = payPerHour;
	        }

	        int rowGrossPay = rowBasePay + nightPay + overtimePay + holidayPay;

	        double rowTaxRate = 0.0;
	        try {
	            rowTaxRate = Double.parseDouble(taxApplied);
	        } catch (Exception e) {
	            rowTaxRate = 0.0;
	        }

	        int rowTax = (int) Math.floor(rowGrossPay * (rowTaxRate / 100.0));

	        int rowInsurance = 0;
	        if ("Y".equalsIgnoreCase(insuranceApplied)) {
	            rowInsurance = (int) Math.floor(rowGrossPay * 0.09);
	            insuranceType = "4대보험";
	        } else if ("Y".equalsIgnoreCase(employmentInsurance)) {
	            rowInsurance = (int) Math.floor(rowGrossPay * 0.009);
	            insuranceType = "고용보험";
	        }

	        basePay += rowBasePay;
	        nightPaySum += nightPay;
	        overtimePaySum += overtimePay;
	        holidayPaySum += holidayPay;
	        tax += rowTax;
	        insurance += rowInsurance;
	        grossPay += rowGrossPay;

	        if (rowTaxRate > representativeTaxRate) {
	            representativeTaxRate = rowTaxRate;
	        }
	    }

	    int finalPay = grossPay + weeklyPay - tax - insurance;
	    if (finalPay < 0) finalPay = 0;

	    SalarySummaryDTO dto = new SalarySummaryDTO();
	    dto.setTotalWorkMinutes(totalWorkMinutes);
	    dto.setBasePay(basePay);
	    dto.setNightPay(nightPaySum);
	    dto.setOvertimePay(overtimePaySum);
	    dto.setHolidayPay(holidayPaySum);
	    dto.setWeeklyPay(weeklyPay);
	    dto.setTaxRate(representativeTaxRate);
	    dto.setTax(tax);
	    dto.setInsurance(insurance);
	    dto.setInsuranceType(insuranceType);
	    dto.setFinalPay(finalPay);

	    return dto;
	}
}
	
