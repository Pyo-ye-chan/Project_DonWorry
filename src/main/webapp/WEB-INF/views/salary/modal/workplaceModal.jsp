<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="workplaceModal" class="modal">
	<div class="modal-content">
		<div class="modal-header">
			<h2>새 근무지 등록</h2>
			<button type="button" id="closeWorkplaceModal" class="close-btn">×</button>
		</div>

		<form id="workplaceForm" action="/workplaces/insert" method="post">
			<div class="modal-body">
				<div class="form-row">
					<label for="name">근무지 이름</label> <input type="text" id="name"
						name="name" maxlength="16" placeholder="예: 강남 편의점" required>
					<span id="nameCount" style="font-size:12px; color:#666;">0/16</span>
				</div>

				<div class="form-grid two-col">
					<div class="form-row">
						<label for="pay_per_hour">급여 금액</label> <input type="number"
							id="pay_per_hour" name="pay_per_hour" value="10320" min="0"
							required>
					</div>

					<div class="form-row">
						<label for="pay_type">급여 타입</label> <select id="pay_type"
							name="pay_type" required>
							<option value="시급">시급</option>
							<option value="일급">일급</option>
						</select>
					</div>
				</div>

				<div class="form-grid two-col">
					<div class="form-row">
						<label for="pay_cycle">지급 주기</label> <select id="pay_cycle"
							name="pay_cycle" required>
							<option value="주급">주급</option>
							<option value="월급">월급</option>
						</select>
					</div>

					<div class="form-row" style="margin-top: 5px;">
						<label for="payday">급여일</label>
						<div style="display: flex; align-items: center; gap: 8px;">
							<select id="payday" name="payday" required>
								<option value="">선택</option>
								<c:forEach var="i" begin="1" end="31">
									<option value="${i}">${i}일</option>
								</c:forEach>
							</select> <span style="font-size: 14px; color: #666;">급여 정산 기준으로 사용됩니다.</span>
						</div>
					</div>
				</div>

				<div class="section-title">세금 / 보험</div>

				<div class="form-row full-width">
					<label>세금 적용 여부</label>
					<div class="tax-option-group">
						<label class="tax-option-item"><input type="radio"
							name="tax_radio" value="0" checked> 미적용</label> <label
							class="tax-option-item"><input type="radio"
							name="tax_radio" value="3.3"> 3.3% (프리랜서 등)</label> <label
							class="tax-option-item"><input type="radio"
							name="tax_radio" value="custom" id="taxCustom"> 직접 입력</label>

						<div class="custom-tax-input"
							style="display: flex; align-items: center; gap: 4px;">
							<input type="number" id="custom_tax_value"
								name="custom_tax_value" placeholder="0.0" step="0.1" min="0"
								max="100"
								style="width: 60px; height: 30px; padding: 4px; font-size: 13px;"
								disabled> <span style="font-size: 13px; color: #374151;">%</span>
						</div>
						<input type="hidden" id="tax_applied" name="tax_applied" value="0">
					</div>
				</div>

				<div class="form-row full-width" style="margin-top: 5px;">
					<label>4대보험 적용 여부</label>
					<div class="tax-option-group">
						<label class="tax-option-item"><input type="radio"
							name="insurance_radio" value="N" checked> 미적용</label> <label
							class="tax-option-item"><input type="radio"
							name="insurance_radio" value="Y"> 적용</label>
					</div>
					<input type="hidden" id="insurance_applied"
						name="insurance_applied" value="N">
				</div>

				<div class="form-row full-width" style="margin-top: 5px;">
					<label>고용보험 적용 여부</label>
					<div class="tax-option-group">
						<label class="tax-option-item"><input type="radio"
							name="employment_radio" value="N" checked> 미적용</label> <label
							class="tax-option-item"><input type="radio"
							name="employment_radio" value="Y"> 적용</label>
					</div>
					<input type="hidden" id="employment_insurance"
						name="employment_insurance" value="N">
				</div>

				<div class="section-title">기본 근무 시간 (선택)</div>
				<div class="form-grid two-col">
					<div class="form-row">
						<label for="work_start_time">기본 시작시간</label> <input type="time"
							id="work_start_time" name="work_start_time">
					</div>
					<div class="form-row">
						<label for="work_end_time">기본 종료시간</label> <input type="time"
							id="work_end_time" name="work_end_time">
					</div>
				</div>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-cancel" id="cancelWorkplaceBtn">취소</button>
				<button type="submit" class="btn btn-save">근무지 저장</button>
			</div>
		</form>
	</div>
</div>