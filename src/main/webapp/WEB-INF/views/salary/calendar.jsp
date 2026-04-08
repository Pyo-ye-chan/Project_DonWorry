<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>돈워리 - 급여 캘린더</title>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.20/index.global.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.20/main.min.css">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Pretendard', sans-serif;
	background-color: #ffffff;
	color: #333;
	line-height: 1.6;
}

.container {
	max-width: 1100px;
	margin: 0 auto;
	padding: 0 20px;
}

.top-auth {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 15px;
	padding: 8px 0;
}

.logout-btn {
	width: 60px;
	height: 30px;
	background-color: #ffffff;
	color: #868e96;
	border: 1px solid #dee2e6;
	border-radius: 6px;
	font-size: 13px;
	transition: all 0.2s ease;
}

.logout-btn:hover {
	background-color: #f8f9fa;
	color: #495057;
	border-color: #ced4da;
}

.navbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 20px 0;
	border-bottom: 1px solid #f0f0f0;
}

.logo {
	color: #2563eb;
	font-weight: 800;
	font-size: 20px;
	text-decoration: none;
}

.nav-menu {
	display: flex;
	gap: 40px;
}

.nav-menu a {
	text-decoration: none;
	color: #666;
	font-size: 14px;
	font-weight: 500;
}

.my-page {
	display: flex;
	align-items: center;
	gap: 8px;
	text-decoration: none;
	color: #666;
	font-size: 14px;
	font-weight: 500;
	padding: 5px 10px;
	cursor: pointer;
}

.nav-menu a.active {
	color: #2563eb;
}

.now-admin, .now-business, .now-personal {
	width: 60px;
	height: 30px;
	background-color: #2563eb;
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 6px;
	border: none;
	font-size: 13px;
	cursor: pointer;
}

.section-header {
	font-size: 24px;
	font-weight: 800;
	color: #111827;
	margin: 38px 0 22px;
	letter-spacing: -0.4px;
}

.calendar-layout {
	display: flex;
	gap: 24px;
	align-items: flex-start;
	margin-bottom: 56px;
	width: 100%;
	min-height: 700px;
}

.calendar-left {
	width: 270px;
	display: flex;
	flex-direction: column;
	gap: 16px;
}

.calendar-right {
	flex: 1;
	min-width: 0;
	display: flex;
	flex-direction: column;
	gap: 18px;
}

.card, .calendar-box, .salary-box, .selected-date {
	background: #fff;
	border: 1px solid #edf1f5;
	border-radius: 18px;
	box-shadow: 0 8px 24px rgba(15, 23, 42, 0.04);
}

.card {
	padding: 22px 20px;
}

.card-title {
	font-size: 16px;
	font-weight: 700;
	color: #111827;
	margin-bottom: 18px;
}

.info-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 14px;
	margin-bottom: 10px;
}

.info-item:last-child {
	margin-bottom: 0;
}

.info-label {
	color: #9ca3af;
}

.info-val {
	color: #111827;
	font-weight: 700;
}

.info-val.blue {
	color: #2563eb;
	font-size: 18px;
}

.add-card {
	min-height: 132px;
	border: 1.5px dashed #dbe4ee;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #6b7280;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	transition: 0.2s;
	background: #fff;
}

.add-card:hover {
	border-color: #b9c9dd;
	color: #111827;
}

.calendar-box {
	padding: 22px;
	min-height: 760px;
}

#calendar {
	width: 100%;
	min-height: 700px;
}

.fc .fc-toolbar.fc-header-toolbar {
	margin-bottom: 18px;
}

.fc .fc-toolbar-title {
	font-size: 24px;
	font-weight: 800;
	color: #111827;
	letter-spacing: -0.3px;
}

.fc .fc-button {
	background: #fff !important;
	border: 1px solid #dbe3ec !important;
	color: #374151 !important;
	border-radius: 10px !important;
	box-shadow: none !important;
	padding: 8px 14px !important;
	font-size: 13px !important;
	font-weight: 600 !important;
}

.fc .fc-button:hover {
	background: #f8fafc !important;
	border-color: #cbd5e1 !important;
}

.fc-theme-standard .fc-scrollgrid {
	border: 1px solid #edf1f5;
	border-radius: 14px;
	overflow: hidden;
}

.fc-theme-standard th {
	background: #fafbfd;
	border-color: #edf1f5;
	color: #6b7280;
	font-size: 13px;
	font-weight: 600;
	height: 44px;
}

.fc-theme-standard td {
	border-color: #edf1f5;
}

.fc .fc-daygrid-day-frame {
	min-height: 96px;
	padding: 6px;
}

.fc .fc-daygrid-day-number {
	font-size: 14px;
	color: #374151;
	padding: 4px 6px;
	font-weight: 500;
}

.fc .fc-day-today {
	background: #fbfdff !important;
}

.fc-daygrid-event {
	border: none !important;
	background: #2563eb !important;
	border-radius: 8px !important;
	padding: 4px 7px !important;
	font-size: 12px !important;
	font-weight: 600;
}

.salary-box {
	padding: 24px 24px 22px;
}

.salary-box h3 {
	font-size: 21px;
	font-weight: 800;
	color: #111827;
	margin-bottom: 18px;
	letter-spacing: -0.3px;
}

.salary-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 9px 0;
	font-size: 15px;
}

.salary-row span {
	color: #6b7280;
}

.salary-row strong {
	color: #111827;
	font-weight: 700;
}

.salary-total {
	margin-top: 16px;
	padding-top: 16px;
	border-top: 1px solid #edf1f5;
	text-align: right;
	font-size: 24px;
	font-weight: 800;
	color: #2563eb;
}

.container-footer {
	border-top: 1px solid #edf1f5;
	background: #fafbfc;
	padding: 36px 0;
	margin-top: 72px;
	text-align: center;
	color: #9ca3af;
	font-size: 13px;
	width: 100vw;
	margin-left: calc(-50vw + 50%);
}

.modal {
	display: none;
	position: fixed;
	inset: 0;
	z-index: 9999;
	background: rgba(15, 23, 42, 0.16);
	padding: 20px;
	align-items: center;
	justify-content: center;
	overflow: hidden;
}

.modal-content {
	width: 820px;
	max-width: 100%;
	max-height: calc(100vh - 40px);
	background: #fff;
	border: 1px solid #edf1f5;
	border-radius: 22px;
	box-shadow: 0 24px 64px rgba(15, 23, 42, 0.10);
	margin: auto;
	overflow: hidden;
	display: flex;
	flex-direction: column;
}

.modal-body {
	overflow-y: auto;
	max-height: calc(100vh - 230px);
	padding: 14px 28px 10px;
	scrollbar-gutter: stable;
}

.modal-body::-webkit-scrollbar {
	width: 8px;
}

.modal-body::-webkit-scrollbar-thumb {
	background: rgba(148, 163, 184, 0.4);
	border-radius: 10px;
}

.modal-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 20px 28px 14px;
	border-bottom: 1px solid #f1f5f9;
}

.modal-header h2 {
	margin: 0;
	font-size: 22px;
	font-weight: 800;
	color: #111827;
	letter-spacing: -0.3px;
	width: 100%;
	text-align: center;
}

.close-btn {
	width: 38px;
	height: 38px;
	border: none;
	background: transparent;
	border-radius: 10px;
	font-size: 24px;
	color: #6b7280;
	cursor: pointer;
}

.close-btn:hover {
	background: #f8fafc;
	color: #111827;
}

.section-title {
	margin: 12px 0 12px;
	font-size: 13px;
	font-weight: 800;
	color: #374151;
	letter-spacing: 0.2px;
	text-transform: uppercase;
}

.form-grid {
	display: grid;
	gap: 13px;
}

.form-grid.two-col {
	grid-template-columns: 1fr 1fr;
}

.form-row {
	margin-bottom: 5px;
}

.form-row label {
	display: block;
	margin-bottom: 4px;
	font-size: 13px;
	font-weight: 700;
	color: #374151;
}

.form-row input, .form-row select, .form-row textarea {
	width: 100%;
	background: #fff;
	border: 1px solid #dbe3ec;
	border-radius: 12px;
	padding: 4px 12px;
	font-size: 14px;
	color: #111827;
	font-family: inherit;
	outline: none;
	transition: 0.15s ease;
}

.form-row input, .form-row select {
	height: 46px;
}

.form-row textarea {
	min-height: 30px;
	max-height: 120px;
	resize: vertical;
	line-height: 1.6;
}

.form-row input:focus, .form-row select:focus, .form-row textarea:focus {
	border-color: #94a3b8;
	box-shadow: 0 0 0 4px rgba(148, 163, 184, 0.10);
}

.result-box {
	margin-top: 18px;
	border: 1px solid #edf1f5;
	border-radius: 16px;
	padding: 16px 18px;
	background: #fcfcfd;
	margin-bottom: 10px;
}

.result-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 14px;
	color: #4b5563;
	padding: 4px 0;
}

.result-row strong {
	color: #111827;
	font-size: 15px;
	font-weight: 800;
}

.modal-footer {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	padding: 14px 28px 14px;
	border-top: 1px solid #f1f5f9;
}

.btn {
	min-width: 110px;
	height: 44px;
	border: none;
	border-radius: 12px;
	font-size: 14px;
	font-weight: 700;
	cursor: pointer;
	transition: 0.15s ease;
}

.btn-cancel {
	background: #f3f4f6;
	color: #4b5563;
}

.btn-cancel:hover {
	background: #e5e7eb;
}

.btn-save {
	background: #111827;
	color: #fff;
}

.btn-save:hover {
	background: #1f2937;
}

.btn-delete {
	margin-right: auto;
}

.full-width {
	grid-column: 1/-1;
	width: 100%;
}

.tax-option-group {
	display: flex;
	flex-wrap: nowrap;
	align-items: center;
	gap: 12px;
	margin-top: 8px;
	background: #f8fafc;
	padding: 10px 14px;
	border-radius: 12px;
}

.tax-option-item {
	display: flex;
	align-items: center;
	white-space: nowrap;
	font-size: 13.5px;
	font-weight: 500;
	cursor: pointer;
}

.tax-option-item input[type="radio"] {
	width: 16px;
	height: 16px;
	margin-right: 6px;
	cursor: pointer;
}
</style>
</head>
<body>

	<div class="container">

		<c:choose>
			<c:when test="${nickName==null}">
				<div class="top-auth">
					<span style="font-size: 13px; color: #666; cursor: pointer;">
						<a href="members/toLogin" style="text-decoration: none; color: black; margin-right: 10px;">
							<i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right: 5px;"></i>로그인
						</a>
					</span>
				</div>
			</c:when>
			<c:otherwise>
				<div class="top-auth">
					<span style="font-size: 13px; color: #666; cursor: pointer;">
						<i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right: 5px;"></i>
						${nickName}님 환영합니다.
						<a href="members/logout" style="text-decoration: none; color: black">
							<button class="logout-btn" style="margin-left: 10px;">로그아웃</button>
						</a>
					</span>
					<c:if test="${type=='관리자'}">
						<a href="/admin/admin_main" style="text-decoration: none;"><div class="now-admin">관리자</div></a>
					</c:if>
					<c:if test="${type=='사업자'}">
						<div class="now-business">사업자</div>
					</c:if>
					<c:if test="${type=='개인'}">
						<div class="now-personal">개인</div>
					</c:if>
				</div>
			</c:otherwise>
		</c:choose>

		<nav class="navbar">
			<div style="display: flex; align-items: center; gap: 40px;">
				<a href="/" class="logo">돈워리</a>
				<div class="nav-menu">
					<a href="/"><i class="fa-solid fa-house fa-lg" style="color: rgb(203, 203, 203);"></i> 홈</a>
					<a href="/salary/calendar" class="active"><i class="fa-regular fa-calendar fa-lg" style="color: rgb(36, 99, 235); margin-right: 5px;"></i> 급여 캘린더</a>
					<a href="/jobposts/jobpost"><i class="fa-solid fa-briefcase fa-lg" style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 구인구직</a>
					<a href="/boards/mainboard_list?page=1"><i class="fa-regular fa-message fa-lg" style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 커뮤니티</a>
					<a href="/qna/qna"><i class="fa-solid fa-question fa-lg" style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 고객지원</a>
				</div>
			</div>
			<a class="my-page" href="/mypage/toMypage"><i class="fa-solid fa-user-gear fa-lg" style="color: rgb(197, 197, 197);"></i> 마이페이지</a>
		</nav>

		<h2 class="section-header">급여 캘린더</h2>

		<div class="calendar-layout">
			<div class="calendar-left">
				<c:forEach var="i" items="${placeList}">
					<div class="card" data-seq="${i.seq}">
						<div class="card-title">${i.name}</div>
						<div class="info-item">
							<span class="info-label">예상 급여</span>
							<span class="info-val blue">${i.totalPay}원</span>
						</div>
						<div class="info-item">
							<span class="info-label">근무 일수</span>
							<span class="info-val">${i.workDays}일</span>
						</div>
						<div class="info-item">
							<span class="info-label">근무 시간</span>
							<span class="info-val">${i.totalHours}시간</span>
						</div>
					</div>
				</c:forEach>

				<div class="card add-card" id="addWorkBtn">
					<span>+ 근무지 등록</span>
				</div>
			</div>

			<div class="calendar-right">
				<div class="calendar-box">
					<div id="calendar"></div>
				</div>
				<div class="salary-box">
				    <h3>급여 명세서</h3>
				
				    <div class="salary-row">
				        <span>총 근무 시간</span>
				        <strong id="summaryTotalHours">0시간 0분</strong>
				    </div>
				    <div class="salary-row">
				        <span>기본 급여</span>
				        <strong id="summaryBasePay">0원</strong>
				    </div>
				    <div class="salary-row">
				        <span>야간수당</span>
				        <strong id="summaryNightPay">+ 0원</strong>
				    </div>
				    <div class="salary-row">
				        <span>연장수당</span>
				        <strong id="summaryOvertimePay">+ 0원</strong>
				    </div>
				    <div class="salary-row">
				        <span>휴일수당</span>
				        <strong id="summaryHolidayPay">+ 0원</strong>
				    </div>
				    <div class="salary-row">
				        <span>주휴 수당</span>
				        <strong id="summaryWeeklyPay">+ 0원</strong>
				    </div>
				    <div class="salary-row">
				        <span id="summaryTaxLabel">세금</span>
				        <strong id="summaryTax">- 0원</strong>
				    </div>
				    <div class="salary-row">
				        <span id="summaryInsuranceLabel">보험료</span>
				        <strong id="summaryInsurance">- 0원</strong>
				    </div>
				
				    <div class="salary-total" id="summaryFinalPay">0원</div>
				</div>
				
			</div>
		</div>

		<div class="container-footer">
			<p>© 2026 돈워리. All rights reserved.</p>
			<p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
		</div>
	</div>

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
							<label for="parent_seq">근무지</label>
							<select id="parent_seq" name="parent_seq" required></select>
						</div>
						<div class="form-row">
							<label for="work_date">근무 날짜</label>
							<input type="date" id="work_date" name="work_date" required>
						</div>
					</div>

					<div class="section-title">근무 시간</div>
					<div class="form-grid two-col">
						<div class="form-row">
							<label for="start_time">근무 시작시간</label>
							<input type="datetime-local" id="start_time" name="start_time" required>
						</div>
						<div class="form-row">
							<label for="end_time">근무 종료시간</label>
							<input type="datetime-local" id="end_time" name="end_time" required>
						</div>
					</div>

					<div class="section-title">휴게 시간</div>
					<div class="form-grid two-col">
						<div class="form-row">
							<label for="breaktime">휴게 시간(분)</label>
							<input type="number" id="breaktime" name="breaktime" min="0" value="0" placeholder="예: 30">
						</div>
					</div>

					<div class="section-title">수당 / 급여</div>
					<div class="form-grid two-col">
						<div class="form-row">
							<label for="night_pay">야간수당</label>
							<input type="number" id="night_pay" name="night_pay" min="0" value="0">
						</div>
						<div class="form-row">
							<label for="overtime_pay">연장수당</label>
							<input type="number" id="overtime_pay" name="overtime_pay" min="0" value="0">
						</div>
						<div class="form-row">
							<label for="holiday_pay">휴일수당</label>
							<input type="number" id="holiday_pay" name="holiday_pay" min="0" value="0">
						</div>
						<div class="form-row">
							<label for="total_pay">총 급여</label>
							<input type="number" id="total_pay" name="total_pay" min="0" value="0" required>
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
						<textarea id="memo" name="memo" rows="5" placeholder="근무 특이사항, 지각/조퇴, 메모 등을 입력하세요."></textarea>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-cancel" id="cancelBtn">취소</button>
					<button type="submit" class="btn btn-save" id="saveBtn">저장</button>
				</div>
			</form>
		</div>
	</div>

	<div id="workplaceModal" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<h2>새 근무지 등록</h2>
				<button type="button" id="closeWorkplaceModal" class="close-btn">×</button>
			</div>

			<form id="workplaceForm" action="/workplaces/insert" method="post">
				<div class="modal-body">
					<div class="form-row">
						<label for="name">근무지 이름</label>
						<input type="text" id="name" name="name" placeholder="예: 강남 편의점" required>
					</div>

					<div class="form-grid two-col">
						<div class="form-row">
							<label for="pay_per_hour">급여 금액</label>
							<input type="number" id="pay_per_hour" name="pay_per_hour" value="10320" min="0" required>
						</div>

						<div class="form-row">
							<label for="pay_type">급여 타입</label>
							<select id="pay_type" name="pay_type" required>
								<option value="시급">시급</option>
								<option value="일급">일급</option>
								<option value="월급">월급</option>
							</select>
						</div>
					</div>

					<div class="form-grid two-col">
						<div class="form-row">
							<label for="pay_cycle">지급 주기</label>
							<select id="pay_cycle" name="pay_cycle" required>
								<option value="주급">주급</option>
								<option value="월급">월급</option>
							</select>
						</div>

						<div class="form-row" style="margin-top: 5px;">
							<label for="payday">급여일</label>
							<div style="display: flex; align-items: center; gap: 8px;">
								<select id="payday" name="payday" required
									style="width: 100px; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
									<option value="">선택</option>
									<c:forEach var="i" begin="1" end="31">
										<option value="${i}">${i}일</option>
									</c:forEach>
								</select>
								<span style="font-size: 14px; color: #666;">매월 정해진 날짜에 급여가 계산됩니다.</span>
							</div>
						</div>
					</div>

					<div class="section-title">세금 / 보험</div>

					<div class="form-row full-width">
						<label>세금 적용 여부</label>
						<div class="tax-option-group">
							<label class="tax-option-item"><input type="radio" name="tax_radio" value="0" checked> 미적용</label>
							<label class="tax-option-item"><input type="radio" name="tax_radio" value="3.3"> 3.3% (프리랜서 등)</label>
							<label class="tax-option-item"><input type="radio" name="tax_radio" value="custom" id="taxCustom"> 직접 입력</label>

							<div class="custom-tax-input" style="display: flex; align-items: center; gap: 4px;">
								<input type="number" id="custom_tax_value" name="custom_tax_value" placeholder="0.0" step="0.1" min="0" max="100"
									style="width: 60px; height: 30px; padding: 4px; font-size: 13px;" disabled>
								<span style="font-size: 13px; color: #374151;">%</span>
							</div>
							<input type="hidden" id="tax_applied" name="tax_applied" value="0">
						</div>
					</div>

					<div class="form-row full-width" style="margin-top: 5px;">
						<label>4대보험 적용 여부</label>
						<div class="tax-option-group">
							<label class="tax-option-item"><input type="radio" name="insurance_radio" value="N" checked> 미적용</label>
							<label class="tax-option-item"><input type="radio" name="insurance_radio" value="Y"> 적용</label>
						</div>
						<input type="hidden" id="insurance_applied" name="insurance_applied" value="N">
					</div>

					<div class="form-row full-width" style="margin-top: 5px;">
						<label>고용보험 적용 여부</label>
						<div class="tax-option-group">
							<label class="tax-option-item"><input type="radio" name="employment_radio" value="N" checked> 미적용</label>
							<label class="tax-option-item"><input type="radio" name="employment_radio" value="Y"> 적용</label>
						</div>
						<input type="hidden" id="employment_insurance" name="employment_insurance" value="N">
					</div>

					<div class="section-title">기본 근무 시간 (선택)</div>
					<div class="form-grid two-col">
						<div class="form-row">
							<label for="work_start_time">기본 시작시간</label>
							<input type="time" id="work_start_time" name="work_start_time">
						</div>
						<div class="form-row">
							<label for="work_end_time">기본 종료시간</label>
							<input type="time" id="work_end_time" name="work_end_time">
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
							<label for="detail_parent_seq">근무지</label>
							<select id="detail_parent_seq" name="parent_seq" required disabled></select>
						</div>

						<div class="form-row">
							<label for="detail_work_date">근무 날짜</label>
							<input type="date" id="detail_work_date" name="work_date" required readonly>
						</div>
					</div>

					<div class="section-title">근무 시간</div>
					<div class="form-grid two-col">
						<div class="form-row">
							<label for="detail_start_time">근무 시작시간</label>
							<input type="datetime-local" id="detail_start_time" name="start_time" required readonly>
						</div>

						<div class="form-row">
							<label for="detail_end_time">근무 종료시간</label>
							<input type="datetime-local" id="detail_end_time" name="end_time" required readonly>
						</div>
					</div>

					<div class="section-title">휴게 시간</div>
					<div class="form-grid two-col">
						<div class="form-row">
							<label for="detail_breaktime">휴게 시간(분)</label>
							<input type="number" id="detail_breaktime" name="breaktime" min="0" value="0" readonly>
						</div>
					</div>

					<div class="section-title">수당 / 급여</div>
					<div class="form-grid two-col">
						<div class="form-row">
							<label for="detail_night_pay">야간수당</label>
							<input type="number" id="detail_night_pay" name="night_pay" min="0" value="0" readonly>
						</div>

						<div class="form-row">
							<label for="detail_overtime_pay">연장수당</label>
							<input type="number" id="detail_overtime_pay" name="overtime_pay" min="0" value="0" readonly>
						</div>

						<div class="form-row">
							<label for="detail_holiday_pay">휴일수당</label>
							<input type="number" id="detail_holiday_pay" name="holiday_pay" min="0" value="0" readonly>
						</div>

						<div class="form-row">
							<label for="detail_total_pay">총 급여 (세금 및 보험료 적용)</label>
							<input type="number" id="detail_total_pay" name="total_pay" min="0" value="0" required readonly>
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
							<span>실근무시간</span> <strong id="detailRealWorkResult">0시간 0분</strong>
						</div>
					</div>

					<div class="form-row">
						<label for="detail_memo">메모</label>
						<textarea id="detail_memo" name="memo" rows="5" readonly placeholder="근무 특이사항, 지각/조퇴, 메모 등을 입력하세요."></textarea>
					</div>
				</div>

				<div class="modal-footer" id="detailViewButtons">
					<button type="button" class="btn btn-delete" id="detailDeleteBtn">삭제</button>
					<button type="button" class="btn btn-cancel" id="detailCloseBtn">확인</button>
					<button type="button" class="btn btn-save" id="detailEditBtn">수정</button>
				</div>

				<div class="modal-footer" id="detailEditButtons" style="display: none;">
					<button type="button" class="btn btn-cancel" id="detailEditCancelBtn">수정 취소</button>
					<button type="submit" class="btn btn-save" id="detailSaveBtn">저장</button>
				</div>
			</form>
		</div>
	</div>

	<div id="workplaceDetailModal" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<h2 id="workplaceDetailTitle">근무지 상세보기</h2>
				<button type="button" id="closeWorkplaceDetailModal" class="close-btn">×</button>
			</div>

			<form id="workplaceDetailForm">
				<input type="hidden" id="detail_workplace_seq" name="seq" value="0">

				<div class="modal-body">
					<div class="form-row">
						<label for="detail_workplace_name">근무지 이름</label>
						<input type="text" id="detail_workplace_name" name="name" placeholder="예: 강남 편의점">
					</div>

					<div class="form-grid two-col">
						<div class="form-row">
							<label for="detail_workplace_pay_per_hour">급여 금액</label>
							<input type="number" id="detail_workplace_pay_per_hour" name="pay_per_hour" min="0">
						</div>

						<div class="form-row">
							<label for="detail_workplace_pay_type">급여 타입</label>
							<select id="detail_workplace_pay_type" name="pay_type">
								<option value="시급">시급</option>
								<option value="일급">일급</option>
								<option value="월급">월급</option>
							</select>
						</div>
					</div>

					<div class="form-grid two-col">
						<div class="form-row">
							<label for="detail_workplace_pay_cycle">지급 주기</label>
							<select id="detail_workplace_pay_cycle" name="pay_cycle">
								<option value="주급">주급</option>
								<option value="월급">월급</option>
							</select>
						</div>

						<div class="form-row" style="margin-top: 5px;">
							<label for="detail_workplace_payday">급여일</label>
							<div style="display: flex; align-items: center; gap: 8px;">
								<select id="detail_workplace_payday" name="payday"
									style="width: 100px; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
									<option value="">선택</option>
									<c:forEach var="i" begin="1" end="31">
										<option value="${i}">${i}일</option>
									</c:forEach>
								</select>
								<span style="font-size: 14px; color: #666;">매월 정해진 날짜에 급여가 계산됩니다.</span>
							</div>
						</div>
					</div>

					<div class="section-title">세금 / 보험</div>

					<div class="form-row full-width">
						<label>세금 적용 여부</label>
						<div class="tax-option-group">
							<label class="tax-option-item"><input type="radio" name="detail_workplace_tax_radio" value="0"> 미적용</label>
							<label class="tax-option-item"><input type="radio" name="detail_workplace_tax_radio" value="3.3"> 3.3% (프리랜서 등)</label>
							<label class="tax-option-item"><input type="radio" name="detail_workplace_tax_radio" value="custom" id="detail_workplace_tax_custom_radio"> 직접 입력</label>

							<div class="custom-tax-input" style="display: flex; align-items: center; gap: 4px;">
								<input type="number" id="detail_workplace_custom_tax_value" placeholder="0.0" step="0.1" min="0" max="100"
									style="width: 60px; height: 30px; padding: 4px; font-size: 13px;" disabled>
								<span style="font-size: 13px; color: #374151;">%</span>
							</div>
						</div>
						<input type="hidden" id="detail_workplace_tax_applied" name="tax_applied" value="0">
					</div>

					<div class="form-row full-width" style="margin-top: 5px;">
						<label>4대보험 적용 여부</label>
						<div class="tax-option-group">
							<label class="tax-option-item"><input type="radio" name="detail_workplace_insurance_radio" value="N"> 미적용</label>
							<label class="tax-option-item"><input type="radio" name="detail_workplace_insurance_radio" value="Y"> 적용</label>
						</div>
						<input type="hidden" id="detail_workplace_insurance_applied" name="insurance_applied" value="N">
					</div>

					<div class="form-row full-width" style="margin-top: 5px;">
						<label>고용보험 적용 여부</label>
						<div class="tax-option-group">
							<label class="tax-option-item"><input type="radio" name="detail_workplace_employment_radio" value="N"> 미적용</label>
							<label class="tax-option-item"><input type="radio" name="detail_workplace_employment_radio" value="Y"> 적용</label>
						</div>
						<input type="hidden" id="detail_workplace_employment_insurance" name="employment_insurance" value="N">
					</div>

					<div class="section-title">기본 근무 시간 (선택)</div>
					<div class="form-grid two-col">
						<div class="form-row">
							<label for="detail_workplace_start_time">기본 시작시간</label>
							<input type="time" id="detail_workplace_start_time" name="work_start_time">
						</div>
						<div class="form-row">
							<label for="detail_workplace_end_time">기본 종료시간</label>
							<input type="time" id="detail_workplace_end_time" name="work_end_time">
						</div>
					</div>
				</div>

				<div class="modal-footer" id="workplaceDetailViewButtons">
					<button type="button" class="btn btn-delete" id="workplaceDetailDeleteBtn">삭제</button>
					<button type="button" class="btn btn-cancel" id="workplaceDetailCloseBtn">확인</button>
					<button type="button" class="btn btn-save" id="workplaceDetailEditBtn">수정</button>
				</div>

				<div class="modal-footer" id="workplaceDetailEditButtons" style="display: none;">
					<button type="button" class="btn btn-cancel" id="workplaceDetailCancelEditBtn">수정 취소</button>
					<button type="button" class="btn btn-save" id="workplaceDetailSaveBtn">저장</button>
				</div>
			</form>
		</div>
	</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const calendarEl = document.getElementById("calendar");

    const summaryTotalHoursEl = document.getElementById("summaryTotalHours");
    const summaryBasePayEl = document.getElementById("summaryBasePay");
    const summaryNightPayEl = document.getElementById("summaryNightPay");
    const summaryOvertimePayEl = document.getElementById("summaryOvertimePay");
    const summaryHolidayPayEl = document.getElementById("summaryHolidayPay");
    const summaryWeeklyPayEl = document.getElementById("summaryWeeklyPay");
    const summaryTaxLabelEl = document.getElementById("summaryTaxLabel");
    const summaryTaxEl = document.getElementById("summaryTax");
    const summaryInsuranceLabelEl = document.getElementById("summaryInsuranceLabel");
    const summaryInsuranceEl = document.getElementById("summaryInsurance");
    const summaryFinalPayEl = document.getElementById("summaryFinalPay");

    const workModal = document.getElementById("workModal");
    const closeModal = document.getElementById("closeModal");
    const cancelBtn = document.getElementById("cancelBtn");
    const worklogForm = document.getElementById("worklogForm");

    const seqEl = document.getElementById("seq");
    const parentSeqEl = document.getElementById("parent_seq");
    const workDateEl = document.getElementById("work_date");
    const startTimeEl = document.getElementById("start_time");
    const endTimeEl = document.getElementById("end_time");
    const breaktimeEl = document.getElementById("breaktime");
    const nightPayEl = document.getElementById("night_pay");
    const overtimePayEl = document.getElementById("overtime_pay");
    const holidayPayEl = document.getElementById("holiday_pay");
    const totalPayEl = document.getElementById("total_pay");
    const memoEl = document.getElementById("memo");

    const workResultEl = document.getElementById("workResult");
    const breakResultEl = document.getElementById("breakResult");
    const realWorkResultEl = document.getElementById("realWorkResult");

    const workplaceModal = document.getElementById("workplaceModal");
    const addWorkBtn = document.getElementById("addWorkBtn");
    const closeWP = document.getElementById("closeWorkplaceModal");
    const cancelWP = document.getElementById("cancelWorkplaceBtn");

    const workplaceForm = document.getElementById("workplaceForm");
    const customTaxInput = document.getElementById("custom_tax_value");
    const taxCustomRadio = document.getElementById("taxCustom");
    const taxAppliedHidden = document.getElementById("tax_applied");
    const insuranceAppliedHidden = document.getElementById("insurance_applied");
    const employmentInsuranceHidden = document.getElementById("employment_insurance");

    const detailModal = document.getElementById("detailModal");
    const closeDetailModal = document.getElementById("closeDetailModal");
    const detailCloseBtn = document.getElementById("detailCloseBtn");
    const detailEditBtn = document.getElementById("detailEditBtn");
    const detailDeleteBtn = document.getElementById("detailDeleteBtn");
    const detailEditCancelBtn = document.getElementById("detailEditCancelBtn");
    const detailForm = document.getElementById("detailForm");

    const detailSeqEl = document.getElementById("detail_seq");
    const detailParentSeqEl = document.getElementById("detail_parent_seq");
    const detailWorkDateEl = document.getElementById("detail_work_date");
    const detailStartTimeEl = document.getElementById("detail_start_time");
    const detailEndTimeEl = document.getElementById("detail_end_time");
    const detailBreaktimeEl = document.getElementById("detail_breaktime");
    const detailNightPayEl = document.getElementById("detail_night_pay");
    const detailOvertimePayEl = document.getElementById("detail_overtime_pay");
    const detailHolidayPayEl = document.getElementById("detail_holiday_pay");
    const detailTotalPayEl = document.getElementById("detail_total_pay");
    const detailMemoEl = document.getElementById("detail_memo");

    const detailWorkResultEl = document.getElementById("detailWorkResult");
    const detailBreakResultEl = document.getElementById("detailBreakResult");
    const detailRealWorkResultEl = document.getElementById("detailRealWorkResult");

    const detailViewButtons = document.getElementById("detailViewButtons");
    const detailEditButtons = document.getElementById("detailEditButtons");

    const workplaceDetailModal = document.getElementById("workplaceDetailModal");
    const workplaceDetailTitleEl = document.getElementById("workplaceDetailTitle");

    const detailWorkplaceSeqEl = document.getElementById("detail_workplace_seq");
    const detailWorkplaceNameEl = document.getElementById("detail_workplace_name");
    const detailWorkplacePayPerHourEl = document.getElementById("detail_workplace_pay_per_hour");
    const detailWorkplacePayTypeEl = document.getElementById("detail_workplace_pay_type");
    const detailWorkplacePayCycleEl = document.getElementById("detail_workplace_pay_cycle");
    const detailWorkplacePaydayEl = document.getElementById("detail_workplace_payday");
    const detailWorkplaceTaxAppliedEl = document.getElementById("detail_workplace_tax_applied");
    const detailWorkplaceInsuranceAppliedEl = document.getElementById("detail_workplace_insurance_applied");
    const detailWorkplaceEmploymentInsuranceEl = document.getElementById("detail_workplace_employment_insurance");
    const detailWorkplaceCustomTaxValueEl = document.getElementById("detail_workplace_custom_tax_value");
    const detailWorkplaceTaxCustomRadioEl = document.getElementById("detail_workplace_tax_custom_radio");
    const detailWorkplaceStartTimeEl = document.getElementById("detail_workplace_start_time");
    const detailWorkplaceEndTimeEl = document.getElementById("detail_workplace_end_time");

    const closeWorkplaceDetailModalBtn = document.getElementById("closeWorkplaceDetailModal");
    const workplaceDetailCloseBtn = document.getElementById("workplaceDetailCloseBtn");
    const workplaceDetailEditBtn = document.getElementById("workplaceDetailEditBtn");
    const workplaceDetailCancelEditBtn = document.getElementById("workplaceDetailCancelEditBtn");
    const workplaceDetailSaveBtn = document.getElementById("workplaceDetailSaveBtn");
    const workplaceDetailDeleteBtn = document.getElementById("workplaceDetailDeleteBtn");

    const workplaceDetailViewButtons = document.getElementById("workplaceDetailViewButtons");
    const workplaceDetailEditButtons = document.getElementById("workplaceDetailEditButtons");

    let originalDetailData = null;
    let originalWorkplaceData = null;
    let currentWorkplaceSeq = 0;

    function normalizeTimeValue(timeStr) {
        if (!timeStr) return "";
        const str = String(timeStr).trim();
        if (str.includes("T")) return str.split("T")[1].substring(0, 5);
        if (str.includes(" ")) return str.split(" ")[1].substring(0, 5);
        if (str.includes(":")) return str.substring(0, 5);
        return "";
    }

    function normalizeTimeInputValue(value) {
        return normalizeTimeValue(value);
    }

    function toMinutes(datetimeLocalValue) {
        if (!datetimeLocalValue) return null;

        const parts = String(datetimeLocalValue).split("T");
        if (parts.length !== 2) return null;

        const dateParts = parts[0].split("-");
        const timeParts = parts[1].split(":");
        if (dateParts.length !== 3 || timeParts.length < 2) return null;

        const year = parseInt(dateParts[0], 10);
        const month = parseInt(dateParts[1], 10) - 1;
        const day = parseInt(dateParts[2], 10);
        const hour = parseInt(timeParts[0], 10);
        const minute = parseInt(timeParts[1], 10);

        if ([year, month, day, hour, minute].some(isNaN)) return null;

        const date = new Date(year, month, day, hour, minute);
        if (isNaN(date.getTime())) return null;

        return Math.floor(date.getTime() / 60000);
    }

    function formatMinutes(totalMinutes) {
        if (totalMinutes === null || totalMinutes === undefined || totalMinutes < 0) {
            return "0시간 0분";
        }
        const hour = Math.floor(totalMinutes / 60);
        const minute = totalMinutes % 60;
        return hour + "시간 " + minute + "분";
    }

    function formatWon(value) {
        return Number(value || 0).toLocaleString("ko-KR") + "원";
    }

    function formatHourText(minutes) {
        const totalMinutes = Number(minutes || 0);
        const hour = Math.floor(totalMinutes / 60);
        const minute = totalMinutes % 60;
        return hour + "시간 " + minute + "분";
    }

    function toDateInputValue(value) {
        if (!value) return "";
        if (typeof value === "string") return value.substring(0, 10);
        if (Array.isArray(value)) {
            return value[0] + "-" + String(value[1]).padStart(2, "0") + "-" + String(value[2]).padStart(2, "0");
        }
        if (typeof value === "object") {
            return value.year + "-" + String(value.monthValue || value.month || 1).padStart(2, "0") + "-" + String(value.dayOfMonth || value.day || 1).padStart(2, "0");
        }
        return "";
    }

    function toDatetimeLocalValue(value) {
        if (!value) return "";
        if (typeof value === "string") return value.replace(" ", "T").substring(0, 16);
        if (Array.isArray(value)) {
            return value[0] + "-" + String(value[1]).padStart(2, "0") + "-" + String(value[2]).padStart(2, "0")
                + "T" + String(value[3] || 0).padStart(2, "0") + ":" + String(value[4] || 0).padStart(2, "0");
        }
        if (typeof value === "object") {
            return value.year + "-" + String(value.monthValue || value.month || 1).padStart(2, "0") + "-"
                + String(value.dayOfMonth || value.day || 1).padStart(2, "0") + "T"
                + String(value.hour || 0).padStart(2, "0") + ":" + String(value.minute || 0).padStart(2, "0");
        }
        return "";
    }

    function normalizeYn(value) {
        if (value === null || value === undefined) return "N";
        return String(value).trim().toUpperCase() === "Y" ? "Y" : "N";
    }

    function normalizeTaxValue(value) {
        if (value === null || value === undefined || value === "") return "0";
        return String(value).trim();
    }

    function normalizeNumberInput(el) {
        if (!el) return;
        if (el.value === null || el.value === undefined || String(el.value).trim() === "") {
            el.value = 0;
        }
    }

    function calculateBasePay(timeData, payPerHour, payType) {
        if (payType === "시급") return Math.floor((timeData.realWork / 60) * payPerHour);
        if (payType === "일급") return payPerHour;
        if (payType === "월급") return payPerHour;
        return 0;
    }

    function calculateTax(amount, taxRate) {
        const rate = Number(taxRate || 0);
        if (rate <= 0) return 0;
        return Math.floor(amount * (rate / 100));
    }

    function calculateInsurance(amount, insuranceApplied, employmentInsurance) {
        if (insuranceApplied === "Y") {
            return Math.floor(amount * 0.09);
        }
        if (employmentInsurance === "Y") {
            return Math.floor(amount * 0.009);
        }
        return 0;
    }

    function syncWorkplaceTaxValue() {
        const selectedTaxRadio = document.querySelector('input[name="tax_radio"]:checked');
        if (!selectedTaxRadio) {
            taxAppliedHidden.value = "0";
            return;
        }
        taxAppliedHidden.value = selectedTaxRadio.value === "custom"
            ? (customTaxInput.value || "0")
            : selectedTaxRadio.value;
    }

    function syncInsuranceValues() {
        const selectedInsurance = document.querySelector('input[name="insurance_radio"]:checked');
        const selectedEmployment = document.querySelector('input[name="employment_radio"]:checked');

        insuranceAppliedHidden.value = selectedInsurance ? selectedInsurance.value : "N";
        employmentInsuranceHidden.value = selectedEmployment ? selectedEmployment.value : "N";
    }

    function toggleEmploymentInsurance() {
        const selectedInsurance = document.querySelector('input[name="insurance_radio"]:checked');
        const employmentRadios = document.querySelectorAll('input[name="employment_radio"]');
        const employmentNoRadio = document.querySelector('input[name="employment_radio"][value="N"]');

        if (!selectedInsurance) return;

        if (selectedInsurance.value === "Y") {
            if (employmentNoRadio) employmentNoRadio.checked = true;
            employmentRadios.forEach(function (radio) {
                radio.disabled = true;
            });
        } else {
            employmentRadios.forEach(function (radio) {
                radio.disabled = false;
            });
        }

        syncInsuranceValues();
    }

    function syncDetailWorkplaceHiddenValues() {
        const selectedTaxRadio = document.querySelector('input[name="detail_workplace_tax_radio"]:checked');
        let taxValue = "0";

        if (selectedTaxRadio) {
            taxValue = selectedTaxRadio.value === "custom"
                ? (detailWorkplaceCustomTaxValueEl.value || "0")
                : selectedTaxRadio.value;
        }

        const selectedInsuranceRadio = document.querySelector('input[name="detail_workplace_insurance_radio"]:checked');
        const selectedEmploymentRadio = document.querySelector('input[name="detail_workplace_employment_radio"]:checked');

        detailWorkplaceTaxAppliedEl.value = taxValue;
        detailWorkplaceInsuranceAppliedEl.value = selectedInsuranceRadio ? selectedInsuranceRadio.value : "N";
        detailWorkplaceEmploymentInsuranceEl.value = selectedEmploymentRadio ? selectedEmploymentRadio.value : "N";
    }

    function toggleDetailEmploymentInsurance() {
        const selectedInsurance = document.querySelector('input[name="detail_workplace_insurance_radio"]:checked');
        const employmentRadios = document.querySelectorAll('input[name="detail_workplace_employment_radio"]');
        const employmentNoRadio = document.querySelector('input[name="detail_workplace_employment_radio"][value="N"]');

        if (!selectedInsurance) return;

        if (selectedInsurance.value === "Y") {
            if (employmentNoRadio) employmentNoRadio.checked = true;
            employmentRadios.forEach(function (radio) {
                radio.disabled = true;
            });
        } else {
            if (!detailWorkplacePayTypeEl.disabled) {
                employmentRadios.forEach(function (radio) {
                    radio.disabled = false;
                });
            }
        }

        syncDetailWorkplaceHiddenValues();
    }

    function renderSalarySummary(data) {
        if (!summaryTotalHoursEl) return;

        if (!data) {
            summaryTotalHoursEl.innerText = "0시간 0분";
            summaryBasePayEl.innerText = "0원";
            summaryNightPayEl.innerText = "+ 0원";
            summaryOvertimePayEl.innerText = "+ 0원";
            summaryHolidayPayEl.innerText = "+ 0원";
            summaryWeeklyPayEl.innerText = "+ 0원";
            summaryTaxLabelEl.innerText = "세금(근무지별 합산)";
            summaryTaxEl.innerText = "- 0원";
            summaryInsuranceLabelEl.innerText = "보험료(근무지별 합산)";
            summaryInsuranceEl.innerText = "- 0원";
            summaryFinalPayEl.innerText = "0원";
            return;
        }

        const totalWorkMinutes = Number(data.totalWorkMinutes || data.total_work_minutes || 0);
        const basePay = Number(data.basePay || data.base_pay || 0);
        const nightPay = Number(data.nightPay || data.night_pay || 0);
        const overtimePay = Number(data.overtimePay || data.overtime_pay || 0);
        const holidayPay = Number(data.holidayPay || data.holiday_pay || 0);
        const weeklyPay = Number(data.weeklyPay || data.weekly_pay || 0);
        const taxRate = Number(data.taxRate || data.tax_rate || 0);
        const tax = Number(data.tax || 0);
        const insurance = Number(data.insurance || 0);
        const insuranceType = data.insuranceType || data.insurance_type || "보험료";
        const finalPay = Number(data.finalPay || data.final_pay || 0);

        summaryTotalHoursEl.innerText = formatHourText(totalWorkMinutes);
        summaryBasePayEl.innerText = formatWon(basePay);
        summaryNightPayEl.innerText = "+ " + formatWon(nightPay);
        summaryOvertimePayEl.innerText = "+ " + formatWon(overtimePay);
        summaryHolidayPayEl.innerText = "+ " + formatWon(holidayPay);
        summaryWeeklyPayEl.innerText = "+ " + formatWon(weeklyPay);
        summaryTaxLabelEl.innerText = taxRate > 0 ? "세금(근무지별 합산)" : "세금";
        summaryTaxEl.innerText = "- " + formatWon(tax);
        summaryInsuranceLabelEl.innerText = "보험료(근무지별 합산)";
        summaryInsuranceEl.innerText = "- " + formatWon(insurance);
        summaryFinalPayEl.innerText = formatWon(finalPay);
    }

    function loadSalarySummary(year, month) {
        $.ajax({
            url: "/worklog/summary",
            type: "get",
            dataType: "json",
            data: { year: year, month: month },
            success: function (resp) {
                renderSalarySummary(resp);
            },
            error: function () {
                renderSalarySummary(null);
            }
        });
    }

    function loadCurrentCalendarSummary() {
        const currentDate = calendar.getDate();
        loadSalarySummary(currentDate.getFullYear(), currentDate.getMonth() + 1);
    }

    function getWorkTimeData() {
        const workStart = toMinutes(startTimeEl.value);
        const workEnd = toMinutes(endTimeEl.value);
        const breakMinutes = parseInt(breaktimeEl.value || "0", 10);

        let totalWork = 0;
        let totalBreak = 0;
        let realWork = 0;

        if (workStart !== null && workEnd !== null && workEnd > workStart) totalWork = workEnd - workStart;
        if (!isNaN(breakMinutes) && breakMinutes > 0) totalBreak = breakMinutes;

        realWork = totalWork - totalBreak;
        if (realWork < 0) realWork = 0;

        return { totalWork: totalWork, totalBreak: totalBreak, realWork: realWork };
    }

    function calculateTotalPay() {
        const selectedOption = parentSeqEl.options[parentSeqEl.selectedIndex];
        if (!selectedOption || !selectedOption.value) {
            totalPayEl.value = 0;
            return;
        }

        normalizeNumberInput(nightPayEl);
        normalizeNumberInput(overtimePayEl);
        normalizeNumberInput(holidayPayEl);

        const payPerHour = parseInt(selectedOption.dataset.payPerHour || "0", 10);
        const payType = selectedOption.dataset.payType || "시급";
        const taxRate = parseFloat(selectedOption.dataset.taxApplied || "0");
        const insuranceApplied = selectedOption.dataset.insuranceApplied || "N";
        const employmentInsurance = selectedOption.dataset.employmentInsurance || "N";

        const timeData = getWorkTimeData();
        const nightPay = parseInt(nightPayEl.value || "0", 10);
        const overtimePay = parseInt(overtimePayEl.value || "0", 10);
        const holidayPay = parseInt(holidayPayEl.value || "0", 10);

        const basePay = calculateBasePay(timeData, payPerHour, payType);
        const grossPay = basePay + nightPay + overtimePay + holidayPay;

        const tax = calculateTax(grossPay, taxRate);
        const insurance = calculateInsurance(grossPay, insuranceApplied, employmentInsurance);

        const finalPay = grossPay - tax - insurance;
        totalPayEl.value = finalPay > 0 ? finalPay : 0;
    }

    function calculateTimes() {
        const timeData = getWorkTimeData();
        workResultEl.innerText = formatMinutes(timeData.totalWork);
        breakResultEl.innerText = formatMinutes(timeData.totalBreak);
        realWorkResultEl.innerText = formatMinutes(timeData.realWork);
        calculateTotalPay();
    }

    function renderWorkplaceList(list, selectedSeq) {
        parentSeqEl.innerHTML = '<option value="">근무지 선택</option>';

        list.forEach(function (w) {
            const option = document.createElement("option");
            option.value = w.seq;
            option.textContent = w.name;

            option.dataset.payPerHour = w.pay_per_hour || w.payPerHour || 0;
            option.dataset.payType = w.pay_type || w.payType || "시급";
            option.dataset.payCycle = w.pay_cycle || w.payCycle || "월급";
            option.dataset.taxApplied = w.tax_applied || w.taxApplied || "0";
            option.dataset.insuranceApplied = w.insurance_applied || w.insuranceApplied || "N";
            option.dataset.employmentInsurance = w.employment_insurance || w.employmentInsurance || "N";
            option.dataset.workStartTime = w.work_start_time || w.workStartTime || "";
            option.dataset.workEndTime = w.work_end_time || w.workEndTime || "";

            if (selectedSeq && String(selectedSeq) === String(w.seq)) option.selected = true;
            parentSeqEl.appendChild(option);
        });
    }

    function applySelectedWorkplaceTime() {
        const selectedOption = parentSeqEl.options[parentSeqEl.selectedIndex];
        if (!selectedOption || !selectedOption.value) {
            calculateTimes();
            return;
        }

        const savedStartTime = normalizeTimeValue(selectedOption.dataset.workStartTime || "");
        const savedEndTime = normalizeTimeValue(selectedOption.dataset.workEndTime || "");

        if (workDateEl.value && savedStartTime) {
            startTimeEl.value = workDateEl.value + "T" + savedStartTime;
        }
        if (workDateEl.value && savedEndTime) {
            endTimeEl.value = workDateEl.value + "T" + savedEndTime;
        }

        calculateTimes();
    }

    function loadWorkplaceList(selectedSeq) {
        $.ajax({
            url: "/workplaces/list",
            type: "get",
            dataType: "json",
            success: function (list) {
                renderWorkplaceList(list, selectedSeq);
                applySelectedWorkplaceTime();
            },
            error: function () {
                alert("근무지 목록을 불러오지 못했습니다.");
            }
        });
    }

    function closeWorkModal() {
        workModal.style.display = "none";
    }

    function resetWorkForm() {
        seqEl.value = 0;
        parentSeqEl.value = "";
        workDateEl.value = "";
        startTimeEl.value = "";
        endTimeEl.value = "";
        breaktimeEl.value = 0;
        nightPayEl.value = 0;
        overtimePayEl.value = 0;
        holidayPayEl.value = 0;
        totalPayEl.value = 0;
        memoEl.value = "";

        workResultEl.innerText = "0시간 0분";
        breakResultEl.innerText = "0시간 0분";
        realWorkResultEl.innerText = "0시간 0분";
    }

    function openInsertModal(dateStr) {
        resetWorkForm();
        seqEl.value = 0;
        workDateEl.value = dateStr || "";

        if (dateStr) {
            startTimeEl.value = dateStr + "T09:00";
            endTimeEl.value = dateStr + "T18:00";
        }

        loadWorkplaceList();
        calculateTimes();
        workModal.style.display = "flex";
    }

    function getDetailWorkTimeData() {
        const workStart = toMinutes(detailStartTimeEl.value);
        const workEnd = toMinutes(detailEndTimeEl.value);
        const breakMinutes = parseInt(detailBreaktimeEl.value || "0", 10);

        let totalWork = 0;
        let totalBreak = 0;
        let realWork = 0;

        if (workStart !== null && workEnd !== null && workEnd > workStart) totalWork = workEnd - workStart;
        if (!isNaN(breakMinutes) && breakMinutes > 0) totalBreak = breakMinutes;

        realWork = totalWork - totalBreak;
        if (realWork < 0) realWork = 0;

        return { totalWork: totalWork, totalBreak: totalBreak, realWork: realWork };
    }

    function calculateDetailTimes() {
        const startMinutes = toMinutes(detailStartTimeEl.value);
        const endMinutes = toMinutes(detailEndTimeEl.value);
        const breakMinutes = Number(detailBreaktimeEl.value || 0);

        if (startMinutes == null || endMinutes == null || endMinutes < startMinutes) {
            detailWorkResultEl.innerText = "0시간 0분";
            detailBreakResultEl.innerText = formatMinutes(breakMinutes);
            detailRealWorkResultEl.innerText = "0시간 0분";
            return;
        }

        const totalWork = endMinutes - startMinutes;
        const realWork = Math.max(0, totalWork - breakMinutes);

        detailWorkResultEl.innerText = formatMinutes(totalWork);
        detailBreakResultEl.innerText = formatMinutes(breakMinutes);
        detailRealWorkResultEl.innerText = formatMinutes(realWork);
    }

    function calculateDetailTotalPay() {
        const selectedOption = detailParentSeqEl.options[detailParentSeqEl.selectedIndex];
        if (!selectedOption || !selectedOption.value) {
            detailTotalPayEl.value = 0;
            return;
        }

        normalizeNumberInput(detailNightPayEl);
        normalizeNumberInput(detailOvertimePayEl);
        normalizeNumberInput(detailHolidayPayEl);

        const payPerHour = parseInt(selectedOption.dataset.payPerHour || "0", 10);
        const payType = selectedOption.dataset.payType || "시급";
        const taxRate = parseFloat(selectedOption.dataset.taxApplied || "0");
        const insuranceApplied = selectedOption.dataset.insuranceApplied || "N";
        const employmentInsurance = selectedOption.dataset.employmentInsurance || "N";

        const timeData = getDetailWorkTimeData();
        const nightPay = parseInt(detailNightPayEl.value || "0", 10);
        const overtimePay = parseInt(detailOvertimePayEl.value || "0", 10);
        const holidayPay = parseInt(detailHolidayPayEl.value || "0", 10);

        const basePay = calculateBasePay(timeData, payPerHour, payType);
        const grossPay = basePay + nightPay + overtimePay + holidayPay;

        const tax = calculateTax(grossPay, taxRate);
        const insurance = calculateInsurance(grossPay, insuranceApplied, employmentInsurance);

        const finalPay = grossPay - tax - insurance;
        detailTotalPayEl.value = finalPay > 0 ? finalPay : 0;
    }

    function renderDetailWorkplaceList(list, selectedSeq) {
        detailParentSeqEl.innerHTML = '<option value="">근무지 선택</option>';

        list.forEach(function (w) {
            const option = document.createElement("option");
            option.value = w.seq;
            option.textContent = w.name;

            option.dataset.payPerHour = w.pay_per_hour || w.payPerHour || 0;
            option.dataset.payType = w.pay_type || w.payType || "시급";
            option.dataset.payCycle = w.pay_cycle || w.payCycle || "월급";
            option.dataset.taxApplied = w.tax_applied || w.taxApplied || "0";
            option.dataset.insuranceApplied = w.insurance_applied || w.insuranceApplied || "N";
            option.dataset.employmentInsurance = w.employment_insurance || w.employmentInsurance || "N";
            option.dataset.workStartTime = w.work_start_time || w.workStartTime || "";
            option.dataset.workEndTime = w.work_end_time || w.workEndTime || "";

            if (String(selectedSeq) === String(w.seq)) option.selected = true;
            detailParentSeqEl.appendChild(option);
        });
    }

    function applyDetailSelectedWorkplaceTime() {
        const selectedOption = detailParentSeqEl.options[detailParentSeqEl.selectedIndex];
        if (!selectedOption || !selectedOption.value) {
            calculateDetailTimes();
            calculateDetailTotalPay();
            return;
        }

        const savedStartTime = normalizeTimeValue(selectedOption.dataset.workStartTime || "");
        const savedEndTime = normalizeTimeValue(selectedOption.dataset.workEndTime || "");

        if (detailWorkDateEl.value && savedStartTime) {
            detailStartTimeEl.value = detailWorkDateEl.value + "T" + savedStartTime;
        }
        if (detailWorkDateEl.value && savedEndTime) {
            detailEndTimeEl.value = detailWorkDateEl.value + "T" + savedEndTime;
        }

        calculateDetailTimes();
        calculateDetailTotalPay();
    }

    function loadDetailWorkplaceList(selectedSeq, callback) {
        $.ajax({
            url: "/workplaces/list",
            type: "get",
            dataType: "json",
            success: function (list) {
                renderDetailWorkplaceList(list, selectedSeq);
                if (typeof callback === "function") callback();
            },
            error: function () {
                alert("근무지 목록을 불러오지 못했습니다.");
            }
        });
    }

    function setDetailReadonlyMode(isReadonly) {
        detailParentSeqEl.disabled = isReadonly;
        detailWorkDateEl.readOnly = isReadonly;
        detailStartTimeEl.readOnly = isReadonly;
        detailEndTimeEl.readOnly = isReadonly;
        detailBreaktimeEl.readOnly = isReadonly;
        detailNightPayEl.readOnly = isReadonly;
        detailOvertimePayEl.readOnly = isReadonly;
        detailHolidayPayEl.readOnly = isReadonly;
        detailTotalPayEl.readOnly = true;
        detailMemoEl.readOnly = isReadonly;

        detailViewButtons.style.display = isReadonly ? "flex" : "none";
        detailEditButtons.style.display = isReadonly ? "none" : "flex";
    }

    function fillDetailForm(dto) {
        detailSeqEl.value = dto.seq || 0;
        detailWorkDateEl.value = toDateInputValue(dto.workDate || dto.work_date);
        detailStartTimeEl.value = toDatetimeLocalValue(dto.startTime || dto.start_time);
        detailEndTimeEl.value = toDatetimeLocalValue(dto.endTime || dto.end_time);
        detailBreaktimeEl.value = dto.breaktime || dto.break_time || 0;
        detailNightPayEl.value = dto.nightPay || dto.night_pay || 0;
        detailOvertimePayEl.value = dto.overtimePay || dto.overtime_pay || 0;
        detailHolidayPayEl.value = dto.holidayPay || dto.holiday_pay || 0;
        detailTotalPayEl.value = dto.totalPay || dto.total_pay || 0;
        detailMemoEl.value = dto.memo || "";

        const parentSeq = dto.parentSeq || dto.parent_seq || 0;
        loadDetailWorkplaceList(parentSeq, function () {
            calculateDetailTimes();
            calculateDetailTotalPay();
        });
    }

    function openDetailModal(event) {
        const seq = event.id || (event.extendedProps && event.extendedProps.seq);
        if (!seq) {
            alert("근무기록 번호를 찾을 수 없습니다.");
            return;
        }

        $.ajax({
            url: "/worklog/detail",
            type: "get",
            data: { seq: seq },
            dataType: "json",
            success: function (dto) {
                if (!dto || !dto.seq) {
                    alert("해당 근무기록이 없습니다.");
                    return;
                }

                originalDetailData = dto;
                fillDetailForm(dto);
                setDetailReadonlyMode(true);
                detailModal.style.display = "flex";
            },
            error: function (xhr) {
                console.log(xhr.responseText);
                alert("근무 상세 정보를 불러오지 못했습니다.");
            }
        });
    }

    function closeDetailModalFunc() {
        detailModal.style.display = "none";
        setDetailReadonlyMode(true);
    }

    function setDetailWorkplaceReadonlyMode(isReadonly) {
        workplaceDetailTitleEl.innerText = isReadonly ? "근무지 상세보기" : "근무지 수정";

        detailWorkplaceNameEl.readOnly = isReadonly;
        detailWorkplacePayPerHourEl.readOnly = isReadonly;
        detailWorkplacePayTypeEl.disabled = isReadonly;
        detailWorkplacePayCycleEl.disabled = isReadonly;
        detailWorkplacePaydayEl.disabled = isReadonly;
        detailWorkplaceStartTimeEl.readOnly = isReadonly;
        detailWorkplaceEndTimeEl.readOnly = isReadonly;

        document.querySelectorAll('input[name="detail_workplace_tax_radio"]').forEach(function (radio) {
            radio.disabled = isReadonly;
        });

        detailWorkplaceCustomTaxValueEl.disabled = isReadonly || !detailWorkplaceTaxCustomRadioEl.checked;

        document.querySelectorAll('input[name="detail_workplace_insurance_radio"]').forEach(function (radio) {
            radio.disabled = isReadonly;
        });

        document.querySelectorAll('input[name="detail_workplace_employment_radio"]').forEach(function (radio) {
            radio.disabled = isReadonly;
        });

        workplaceDetailViewButtons.style.display = isReadonly ? "flex" : "none";
        workplaceDetailEditButtons.style.display = isReadonly ? "none" : "flex";

        if (!isReadonly) {
            toggleDetailEmploymentInsurance();
        }
    }

    function fillWorkplaceDetailForm(dto) {
        detailWorkplaceSeqEl.value = dto.seq || 0;
        detailWorkplaceNameEl.value = dto.name || "";
        detailWorkplacePayPerHourEl.value = dto.pay_per_hour || dto.payPerHour || 0;
        detailWorkplacePayTypeEl.value = dto.pay_type || dto.payType || "시급";
        detailWorkplacePayCycleEl.value = dto.pay_cycle || dto.payCycle || "월급";
        detailWorkplacePaydayEl.value = dto.payday || "";

        detailWorkplaceStartTimeEl.value = normalizeTimeInputValue(dto.work_start_time || dto.workStartTime);
        detailWorkplaceEndTimeEl.value = normalizeTimeInputValue(dto.work_end_time || dto.workEndTime);

        const taxValue = normalizeTaxValue(dto.tax_applied ?? dto.taxApplied);
        const insuranceValue = normalizeYn(dto.insurance_applied ?? dto.insuranceApplied);
        const employmentValue = normalizeYn(dto.employment_insurance ?? dto.employmentInsurance);

        document.querySelectorAll('input[name="detail_workplace_tax_radio"]').forEach(function (radio) {
            radio.checked = false;
        });

        if (taxValue === "0" || taxValue === "0.0") {
            const radio = document.querySelector('input[name="detail_workplace_tax_radio"][value="0"]');
            if (radio) radio.checked = true;
            detailWorkplaceCustomTaxValueEl.value = "";
            detailWorkplaceCustomTaxValueEl.disabled = true;
        } else if (taxValue === "3.3") {
            const radio = document.querySelector('input[name="detail_workplace_tax_radio"][value="3.3"]');
            if (radio) radio.checked = true;
            detailWorkplaceCustomTaxValueEl.value = "";
            detailWorkplaceCustomTaxValueEl.disabled = true;
        } else {
            detailWorkplaceTaxCustomRadioEl.checked = true;
            detailWorkplaceCustomTaxValueEl.value = taxValue;
            detailWorkplaceCustomTaxValueEl.disabled = false;
        }

        document.querySelectorAll('input[name="detail_workplace_insurance_radio"]').forEach(function (radio) {
            radio.checked = radio.value === insuranceValue;
        });

        document.querySelectorAll('input[name="detail_workplace_employment_radio"]').forEach(function (radio) {
            radio.checked = radio.value === employmentValue;
        });

        syncDetailWorkplaceHiddenValues();
        toggleDetailEmploymentInsurance();
    }

    function openWorkplaceDetailModal(seq) {
        if (!seq) {
            alert("근무지 번호를 찾을 수 없습니다.");
            return;
        }

        currentWorkplaceSeq = seq;

        $.ajax({
            url: "/workplaces/detail",
            type: "get",
            data: { seq: seq },
            dataType: "json",
            success: function (dto) {
                if (!dto || !dto.seq) {
                    alert("해당 근무지 정보가 없습니다.");
                    return;
                }

                originalWorkplaceData = dto;
                fillWorkplaceDetailForm(dto);
                setDetailWorkplaceReadonlyMode(true);
                workplaceDetailDeleteBtn.disabled = false;
                workplaceDetailModal.style.display = "flex";
            },
            error: function (xhr) {
                console.log(xhr.responseText);
                alert("근무지 상세 정보를 불러오지 못했습니다.");
            }
        });
    }

    function closeWorkplaceDetailModalFunc() {
        workplaceDetailModal.style.display = "none";
        currentWorkplaceSeq = 0;
        setDetailWorkplaceReadonlyMode(true);
        workplaceDetailDeleteBtn.disabled = true;
    }

    const calendar = new FullCalendar.Calendar(calendarEl, {
        locale: "ko",
        initialView: "dayGridMonth",
        height: "auto",
        headerToolbar: {
            left: "today",
            center: "title",
            right: "prev,next"
        },
        buttonText: {
            today: "오늘"
        },
        events: [
            <c:forEach var="i" items="${detailList}" varStatus="status">
            {
                id: "${i.logSeq}",
                title: "${i.name}",
                start: "${i.workDate}",
                extendedProps: { seq: "${i.logSeq}" }
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ],
        dateClick: function (info) {
            openInsertModal(info.dateStr);
        },
        eventClick: function (info) {
            openDetailModal(info.event);
        },
        datesSet: function () {
            loadCurrentCalendarSummary();
        }
    });

    calendar.render();
    loadCurrentCalendarSummary();

    document.querySelectorAll(".card[data-seq]").forEach(function (card) {
        card.addEventListener("click", function () {
            openWorkplaceDetailModal(this.dataset.seq);
        });
    });

    closeModal.addEventListener("click", closeWorkModal);
    cancelBtn.addEventListener("click", closeWorkModal);

    addWorkBtn.addEventListener("click", function () {
        $.ajax({
            url: "/workplaces/countrow",
            type: "get",
            dataType: "json",
            success: function (count) {
                if (count < 5) {
                    resetWorkplaceForm();
                    workplaceModal.style.display = "flex";
                } else {
                    alert("근무지는 최대 다섯개까지 등록 가능합니다.");
                }
            },
            error: function () {
                alert("근무지 개수 확인 실패");
            }
        });
    });

    function closeWorkplaceModal() {
        workplaceModal.style.display = "none";
    }

    closeWP.addEventListener("click", closeWorkplaceModal);
    cancelWP.addEventListener("click", closeWorkplaceModal);

    function resetWorkplaceForm() {
        workplaceForm.reset();
        customTaxInput.disabled = true;
        customTaxInput.value = "";
        taxAppliedHidden.value = "0";

        const defaultTaxRadio = document.querySelector('input[name="tax_radio"][value="0"]');
        const defaultInsuranceRadio = document.querySelector('input[name="insurance_radio"][value="N"]');
        const defaultEmploymentRadio = document.querySelector('input[name="employment_radio"][value="N"]');

        if (defaultTaxRadio) defaultTaxRadio.checked = true;
        if (defaultInsuranceRadio) defaultInsuranceRadio.checked = true;
        if (defaultEmploymentRadio) defaultEmploymentRadio.checked = true;

        toggleEmploymentInsurance();
        syncInsuranceValues();
    }

    document.querySelectorAll('input[name="tax_radio"]').forEach(function (radio) {
        radio.addEventListener("change", function () {
            if (this.value === "custom") {
                customTaxInput.disabled = false;
                customTaxInput.focus();
            } else {
                customTaxInput.disabled = true;
                customTaxInput.value = "";
            }
            syncWorkplaceTaxValue();
        });
    });

    customTaxInput.addEventListener("input", function () {
        if (taxCustomRadio.checked) {
            syncWorkplaceTaxValue();
        }
    });

    workplaceForm.addEventListener("submit", function (e) {
        const selectedTaxRadio = document.querySelector('input[name="tax_radio"]:checked');

        if (!selectedTaxRadio) {
            alert("세금 적용 여부를 선택해주세요.");
            e.preventDefault();
            return;
        }

        if (selectedTaxRadio.value === "custom") {
            const customValue = parseFloat(customTaxInput.value);
            if (customTaxInput.value === "" || isNaN(customValue) || customValue < 0) {
                alert("직접 입력 세율을 올바르게 입력해주세요.");
                customTaxInput.focus();
                e.preventDefault();
                return;
            }
        }

        syncWorkplaceTaxValue();
        syncInsuranceValues();
    });

    document.querySelectorAll('input[name="insurance_radio"]').forEach(function (radio) {
        radio.addEventListener("change", toggleEmploymentInsurance);
    });

    document.querySelectorAll('input[name="employment_radio"]').forEach(function (radio) {
        radio.addEventListener("change", syncInsuranceValues);
    });

    toggleEmploymentInsurance();
    syncInsuranceValues();

    parentSeqEl.addEventListener("change", function () {
        applySelectedWorkplaceTime();
    });

    workDateEl.addEventListener("change", function () {
        applySelectedWorkplaceTime();
    });

    startTimeEl.addEventListener("change", calculateTimes);
    endTimeEl.addEventListener("change", calculateTimes);
    breaktimeEl.addEventListener("input", calculateTimes);
    nightPayEl.addEventListener("input", calculateTotalPay);
    overtimePayEl.addEventListener("input", calculateTotalPay);
    holidayPayEl.addEventListener("input", calculateTotalPay);

    closeDetailModal.addEventListener("click", closeDetailModalFunc);
    detailCloseBtn.addEventListener("click", closeDetailModalFunc);

    detailEditBtn.addEventListener("click", function () {
        setDetailReadonlyMode(false);
    });

    detailEditCancelBtn.addEventListener("click", function () {
        if (originalDetailData) fillDetailForm(originalDetailData);
        setDetailReadonlyMode(true);
    });

    detailDeleteBtn.addEventListener("click", function () {
        const seq = detailSeqEl.value;

        $.ajax({
            url: "/worklog/delete",
            type: "get",
            data: { seq: seq },
            success: function (resp) {
                if (Number(resp) > 0) {
                    alert("근무 내역을 삭제했습니다.");
                    const event = calendar.getEventById(String(seq));
                    if (event) event.remove();
                    closeDetailModalFunc();
                    loadCurrentCalendarSummary();
                } else {
                    alert("삭제할 근무 내역이 없습니다.");
                }
            },
            error: function () {
                alert("근무 내역을 삭제하지 못했습니다.");
            }
        });
    });

    detailParentSeqEl.addEventListener("change", function () {
        if (!detailParentSeqEl.disabled) {
            applyDetailSelectedWorkplaceTime();
        }
    });

    detailWorkDateEl.addEventListener("change", function () {
        calculateDetailTimes();
        calculateDetailTotalPay();
    });

    detailStartTimeEl.addEventListener("change", function () {
        calculateDetailTimes();
        calculateDetailTotalPay();
    });

    detailEndTimeEl.addEventListener("change", function () {
        calculateDetailTimes();
        calculateDetailTotalPay();
    });

    detailBreaktimeEl.addEventListener("input", function () {
        calculateDetailTimes();
        calculateDetailTotalPay();
    });

    detailNightPayEl.addEventListener("input", calculateDetailTotalPay);
    detailOvertimePayEl.addEventListener("input", calculateDetailTotalPay);
    detailHolidayPayEl.addEventListener("input", calculateDetailTotalPay);

    if (closeWorkplaceDetailModalBtn) {
        closeWorkplaceDetailModalBtn.addEventListener("click", closeWorkplaceDetailModalFunc);
    }

    if (workplaceDetailCloseBtn) {
        workplaceDetailCloseBtn.addEventListener("click", closeWorkplaceDetailModalFunc);
    }

    if (workplaceDetailEditBtn) {
        workplaceDetailEditBtn.addEventListener("click", function () {
            setDetailWorkplaceReadonlyMode(false);
            toggleDetailEmploymentInsurance();
        });
    }

    if (workplaceDetailCancelEditBtn) {
        workplaceDetailCancelEditBtn.addEventListener("click", function () {
            if (originalWorkplaceData) fillWorkplaceDetailForm(originalWorkplaceData);
            setDetailWorkplaceReadonlyMode(true);
        });
    }

    workplaceDetailDeleteBtn.addEventListener("click", function () {
        if (!currentWorkplaceSeq) {
            alert("삭제할 근무지가 없습니다.");
            return;
        }

        if (!confirm("정말 삭제하시겠습니까?")) return;
        location.href = "/workplaces/delete?seq=" + currentWorkplaceSeq;
    });

    document.querySelectorAll('input[name="detail_workplace_tax_radio"]').forEach(function (radio) {
        radio.addEventListener("change", function () {
            if (this.value === "custom") {
                detailWorkplaceCustomTaxValueEl.disabled = false;
                detailWorkplaceCustomTaxValueEl.focus();
            } else {
                detailWorkplaceCustomTaxValueEl.disabled = true;
                detailWorkplaceCustomTaxValueEl.value = "";
            }
            syncDetailWorkplaceHiddenValues();
        });
    });

    detailWorkplaceCustomTaxValueEl.addEventListener("input", function () {
        if (detailWorkplaceTaxCustomRadioEl.checked) {
            syncDetailWorkplaceHiddenValues();
        }
    });

    document.querySelectorAll('input[name="detail_workplace_insurance_radio"]').forEach(function (radio) {
        radio.addEventListener("change", toggleDetailEmploymentInsurance);
    });

    document.querySelectorAll('input[name="detail_workplace_employment_radio"]').forEach(function (radio) {
        radio.addEventListener("change", syncDetailWorkplaceHiddenValues);
    });

    if (workplaceDetailSaveBtn) {
        workplaceDetailSaveBtn.addEventListener("click", function () {
            syncDetailWorkplaceHiddenValues();

            const selectedTaxRadio = document.querySelector('input[name="detail_workplace_tax_radio"]:checked');
            if (!selectedTaxRadio) {
                alert("세금 적용 여부를 선택해주세요.");
                return;
            }

            if (selectedTaxRadio.value === "custom") {
                const customValue = parseFloat(detailWorkplaceCustomTaxValueEl.value);
                if (detailWorkplaceCustomTaxValueEl.value === "" || isNaN(customValue) || customValue < 0) {
                    alert("직접 입력 세율을 올바르게 입력해주세요.");
                    detailWorkplaceCustomTaxValueEl.focus();
                    return;
                }
            }

            const formData = {
                seq: detailWorkplaceSeqEl.value,
                name: detailWorkplaceNameEl.value,
                pay_per_hour: detailWorkplacePayPerHourEl.value,
                pay_type: detailWorkplacePayTypeEl.value,
                pay_cycle: detailWorkplacePayCycleEl.value,
                payday: detailWorkplacePaydayEl.value,
                tax_applied: detailWorkplaceTaxAppliedEl.value,
                insurance_applied: detailWorkplaceInsuranceAppliedEl.value,
                employment_insurance: detailWorkplaceEmploymentInsuranceEl.value,
                work_start_time: detailWorkplaceStartTimeEl.value,
                work_end_time: detailWorkplaceEndTimeEl.value
            };

            $.ajax({
                url: "/workplaces/update",
                type: "post",
                dataType: "text",
                data: formData,
                success: function (resp) {
                    if (String(resp).trim() === "1") {
                        alert("근무지 정보가 수정되었습니다.");
                        location.reload();
                    } else {
                        alert("근무지 수정에 실패했습니다.");
                    }
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                    alert("근무지 수정에 실패했습니다.");
                }
            });
        });
    }

    worklogForm.addEventListener("submit", function (e) {
        normalizeNumberInput(breaktimeEl);
        normalizeNumberInput(nightPayEl);
        normalizeNumberInput(overtimePayEl);
        normalizeNumberInput(holidayPayEl);
        normalizeNumberInput(totalPayEl);

        const workStart = toMinutes(startTimeEl.value);
        const workEnd = toMinutes(endTimeEl.value);
        const breakMinutes = parseInt(breaktimeEl.value || "0", 10);

        if (!parentSeqEl.value) {
            alert("근무지를 선택해주세요.");
            e.preventDefault();
            return;
        }

        if (!workDateEl.value) {
            alert("근무 날짜를 선택해주세요.");
            e.preventDefault();
            return;
        }

        if (!startTimeEl.value || !endTimeEl.value) {
            alert("근무 시작시간과 종료시간을 입력해주세요.");
            e.preventDefault();
            return;
        }

        if (workStart === null || workEnd === null || workEnd <= workStart) {
            alert("근무 종료시간은 시작시간보다 늦어야 합니다.");
            e.preventDefault();
            return;
        }

        if (isNaN(breakMinutes) || breakMinutes < 0) {
            alert("휴게시간은 0 이상으로 입력해주세요.");
            e.preventDefault();
            return;
        }

        if (breakMinutes >= (workEnd - workStart)) {
            alert("휴게시간이 총 근무시간보다 길 수 없습니다.");
            e.preventDefault();
            return;
        }

        calculateTotalPay();
    });

    detailForm.addEventListener("submit", function (e) {
        normalizeNumberInput(detailBreaktimeEl);
        normalizeNumberInput(detailNightPayEl);
        normalizeNumberInput(detailOvertimePayEl);
        normalizeNumberInput(detailHolidayPayEl);
        normalizeNumberInput(detailTotalPayEl);

        const workStart = toMinutes(detailStartTimeEl.value);
        const workEnd = toMinutes(detailEndTimeEl.value);
        const breakMinutes = parseInt(detailBreaktimeEl.value || "0", 10);

        if (!detailParentSeqEl.value) {
            alert("근무지를 선택해주세요.");
            e.preventDefault();
            return;
        }

        if (!detailWorkDateEl.value) {
            alert("근무 날짜를 선택해주세요.");
            e.preventDefault();
            return;
        }

        if (!detailStartTimeEl.value || !detailEndTimeEl.value) {
            alert("근무 시작시간과 종료시간을 입력해주세요.");
            e.preventDefault();
            return;
        }

        if (workStart === null || workEnd === null || workEnd <= workStart) {
            alert("근무 종료시간은 시작시간보다 늦어야 합니다.");
            e.preventDefault();
            return;
        }

        if (isNaN(breakMinutes) || breakMinutes < 0) {
            alert("휴게시간은 0 이상으로 입력해주세요.");
            e.preventDefault();
            return;
        }

        if (breakMinutes >= (workEnd - workStart)) {
            alert("휴게시간이 총 근무시간보다 길 수 없습니다.");
            e.preventDefault();
            return;
        }

        calculateDetailTotalPay();
    });
});
</script>
<c:if test="${param.insertSuccess == 'false'}">
	<script>
	    alert("근무 등록에 실패했습니다.");
	</script>
</c:if>

<c:if test="${param.deleteSuccess == 'true'}">
	<script>
	    alert("삭제가 완료되었습니다.");
	</script>
</c:if>

<c:if test="${param.deleteSuccess == 'false'}">
	<script>
	    alert("삭제에 실패했습니다.");
	</script>
</c:if>

</body>
</html>