<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="workModal" class="modal">
	<div class="modal-content modal-lg">
		<div class="modal-header">
			<h2>근무 등록</h2>
			<button type="button" id="closeModal" class="close-btn">×</button>
		</div>

		<form id="worklogForm" action="/worklog/insert" method="post">
			<input type="hidden" id="seq" name="seq" value="0">

			<div class="modal-body">
				<div class="form-grid two-col">
					<div class="form-row">
						<label for="parent_seq">근무지</label> <select id="parent_seq"
							name="parent_seq" required></select>
					</div>
					<div class="form-row">
						<label for="work_date">근무 날짜</label> <input type="date"
							id="work_date" name="work_date" required>
					</div>
				</div>

				<div class="section-title">근무 시간</div>
				<div class="form-grid two-col">
					<div class="form-row">
						<label for="start_time">근무 시작시간</label> <input
							type="datetime-local" id="start_time" name="start_time" required>
					</div>
					<div class="form-row">
						<label for="end_time">근무 종료시간</label> <input type="datetime-local"
							id="end_time" name="end_time" required>
					</div>
				</div>

				<div class="section-title">휴게 시간</div>
				<div class="form-grid two-col">
					<div class="form-row">
						<label for="breaktime">휴게 시간(분)</label> <input type="number"
							id="breaktime" name="breaktime" min="0" value="0"
							placeholder="예: 30">
					</div>
				</div>

				<div class="section-title">수당 / 급여</div>
				<div class="form-grid two-col">
					<div class="form-row">
						<label for="night_pay">야간수당</label> <input type="number"
							id="night_pay" name="night_pay" min="0" value="0">
					</div>
					<div class="form-row">
						<label for="overtime_pay">연장수당</label> <input type="number"
							id="overtime_pay" name="overtime_pay" min="0" value="0">
					</div>
					<div class="form-row">
						<label for="holiday_pay">휴일수당</label> <input type="number"
							id="holiday_pay" name="holiday_pay" min="0" value="0">
					</div>
					<div class="form-row">
						<label for="total_pay">총 급여</label> <input type="number"
							id="total_pay" name="total_pay" min="0" value="0" required>
					</div>
				</div>

				<div class="result-box">
					<div class="result-row">
						<span>총 근무시간</span> <strong id="workResult">0시간 0분</strong>
					</div>
					<div class="result-row">
						<span>총 휴게시간</span> <strong id="breakResult">0시간 0분</strong>
					</div>
					<div class="result-row">
						<span>실근무시간</span> <strong id="realWorkResult">0시간 0분</strong>
					</div>
				</div>

				<div class="form-row">
					<label for="memo">메모</label>
					<textarea id="memo" name="memo" rows="5" maxlength="300"
						placeholder="근무 특이사항, 지각/조퇴, 메모 등을 입력하세요."></textarea>
					<span id="memoCount" style="font-size:12px; color:#666;">0/300</span>
				</div>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-cancel" id="cancelBtn">취소</button>
				<button type="submit" class="btn btn-save" id="saveBtn">저장</button>
			</div>
		</form>
	</div>
</div>