package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.WorkPlaceDTO;
@Repository
public class WorkPlaceDAO {

	@Autowired
	public JdbcTemplate jdbc;
	
	public int insertToworkpalce(WorkPlaceDTO dto) {
	    String sql = "INSERT INTO workplace ("
	            + "seq, id, name, pay_per_hour, pay_type, pay_cycle, payday, "
	            + "tax_applied, insurance_applied, employment_insurance, "
	            + "work_start_time, work_end_time, workplace_date"
	            + ") VALUES (workplace_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, "
	            + "TO_DATE(?, 'HH24:MI'), TO_DATE(?, 'HH24:MI'), sysdate)";

	    // 2. 시간 데이터 처리 (HH:mm -> Date 객체 또는 적절한 포맷 필요시 처리)
	    // 만약 DB가 DATE 타입이라면 TO_DATE를 SQL에 쓰거나 자바에서 변환해야 함
	    
	    return jdbc.update(sql,
	            dto.getId(),
	            dto.getName(),
	            dto.getPay_per_hour(),
	            dto.getPay_type(),
	            dto.getPay_cycle(),
	            dto.getPayday(),
	            dto.getTax_applied(), // 'Y' 또는 'N'
	            dto.getInsurance_applied(), // 4대보험 여부
	            dto.getEmployment_insurance(), // 고용보험 여부
	            dto.getWork_start_time(),
	            dto.getWork_end_time()
	    );
	}
	
	
}
