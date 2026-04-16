<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="detailModal" class="modal">
	<div class="modal-content modal-lg">
		<div class="modal-header">
			<h2>근무 상세보기</h2>
			<button type="button" id="closeDetailModal" class="close-btn">×</button>
		</div>

		<form id="detailForm" action="/worklog/update" method="post">
			<input type="hidden" id="detail_seq" name="seq" value="0">

			<div class="modal-body">
				<div class="form-grid two-col">
					<div class="form-row">
						<label for="detail_parent_seq">근무지</label> <select
							id="detail_parent_seq" name="parent_seq" required disabled></select>
					</div>

					<div class="form-row">
						<label for="detail_work_date">근무 날짜</label> <input type="date"
							id="detail_work_date" name="work_date" required readonly>
					</div>
				</div>

				<div class="section-title">근무 시간</div>
				<div class="form-grid two-col">
					<div class="form-row">
						<label for="detail_start_time">근무 시작시간</label> <input
							type="datetime-local" id="detail_start_time" name="start_time"
							required readonly>
					</div>

					<div class="form-row">
						<label for="detail_end_time">근무 종료시간</label> <input
							type="datetime-local" id="detail_end_time" name="end_time"
							required readonly>
					</div>
				</div>

				<div class="section-title">휴게 시간</div>
				<div class="form-grid two-col">
					<div class="form-row">
						<label for="detail_breaktime">휴게 시간(분)</label> <input
							type="number" id="detail_breaktime" name="breaktime" min="0"
							value="0" readonly>
					</div>
				</div>

				<div class="section-title">수당 / 급여</div>
				<div class="form-grid two-col">
					<div class="form-row">
						<label for="detail_night_pay">야간수당</label> <input type="number"
							id="detail_night_pay" name="night_pay" min="0" value="0" readonly>
					</div>

					<div class="form-row">
						<label for="detail_overtime_pay">연장수당</label> <input type="number"
							id="detail_overtime_pay" name="overtime_pay" min="0" value="0"
							readonly>
					</div>

					<div class="form-row">
						<label for="detail_holiday_pay">휴일수당</label> <input type="number"
							id="detail_holiday_pay" name="holiday_pay" min="0" value="0"
							readonly>
					</div>

					<div class="form-row">
						<label for="detail_total_pay">총 급여</label> <input
							type="number" id="detail_total_pay" name="total_pay" min="0"
							value="0" required readonly>
					</div>
				</div>

				<div class="result-box">
					<div class="result-row">
						<span>총 근무시간</span> <strong id="detailWorkResult">0시간 0분</strong>
					</div>
					<div class="result-row">
						<span>총 휴게시간</span> <strong id="detailBreakResult">0시간 0분</strong>
					</div>
					<div class="result-row">
						<span>실근무시간</span> <strong id="detailRealWorkResult">0시간
							0분</strong>
					</div>
				</div>

				<div class="form-row">
					<label for="detail_memo">메모</label>
					<textarea id="detail_memo" name="memo" rows="5" maxlength="300" readonly
						placeholder="근무 특이사항, 지각/조퇴, 메모 등을 입력하세요."></textarea>
					<span id="detail_memoCount" style="font-size:12px; color:#666;">0/300</span>	
				</div>
			</div>

			<div class="modal-footer" id="detailViewButtons">
				<button type="button" class="btn btn-delete" id="detailDeleteBtn">삭제</button>
				<button type="button" class="btn btn-cancel" id="detailCloseBtn">확인</button>
				<button type="button" class="btn btn-save" id="detailEditBtn">수정</button>
			</div>

			<div class="modal-footer" id="detailEditButtons"
				style="display: none;">
				<button type="button" class="btn btn-cancel"
					id="detailEditCancelBtn">수정 취소</button>
				<button type="submit" class="btn btn-save" id="detailSaveBtn">저장</button>
			</div>
		</form>
	</div>
</div>
