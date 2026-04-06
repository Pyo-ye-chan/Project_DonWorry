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

/* 기본 초기화 및 폰트 설정 */
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

/* 레이아웃 컨테이너 */
.container {
	max-width: 1100px;
	margin: 0 auto;
	padding: 0 20px;
}

/* 로그인 및 관리자 */
.top-auth {
	display: flex;
	justify-content: flex-end; /* 오른쪽 정렬 핵심 */
	align-items: center;
	gap: 15px; /* 요소 간 간격 */
	padding: 8px 0; /* 위아래 여백 */
}

.logout-btn {
	width: 60px;
	height: 30px;
	background-color: #ffffff;
	color: #868e96;
	border: 1px solid #dee2e6;
	border-radius: 6px;
	font-size: 13px;
	transition: all 0.2s ease; /* 부드러운 변화를 위해 추가 */
}

.logout-btn:hover {
	width: 60px;
	height: 30px;
	background-color: #f8f9fa;
	color: #495057;
	border-color: #ced4da;
	border: 1px solid #dee2e6;
	border-radius: 6px;
	font-size: 13px;
	transition: all 0.2s ease; /* 부드러운 변화를 위해 추가 */
}
/* [3] 네비게이션바 */
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
	gap: 8px; /* 아이콘과 글자 사이 간격 */
	text-decoration: none;
	color: #666;
	font-size: 14px;
	font-weight: 500;
	/* 중요: 클릭 영역을 확실히 확보 */
	padding: 5px 10px;
	cursor: pointer;
}

.nav-menu a.active {
	color: #2563eb;
}
/*사용사 식별 표시*/
/*관리자 버튼*/
.now-admin {
	width: 60px;
	height: 30px;
	background-color: #2563eb;
	color: white;
	display: flex;
	align-items: center; /*세로 중앙 정렬*/
	justify-content: center; /* 가로 중앙 정렬 */
	border-radius: 6px;
	border: none;
	font-size: 13px;
	cursor: pointer;
}
/*기업 버튼*/
.now-business {
	width: 60px;
	height: 30px;
	background-color: #2563eb;
	color: white;
	display: flex;
	align-items: center; /*세로 중앙 정렬*/
	justify-content: center; /* 가로 중앙 정렬 */
	border-radius: 6px;
	border: none;
	font-size: 13px;
	cursor: pointer;
}
/*개인 버튼*/
.now-personal {
	width: 60px;
	height: 30px;
	background-color: #2563eb;
	color: white;
	display: flex;
	align-items: center; /*세로 중앙 정렬*/
	justify-content: center; /* 가로 중앙 정렬 */
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

/* 레이아웃 */
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

/* 공통 카드 */
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

/* 캘린더 */
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

/* 선택 상세 */
.selected-date {
	padding: 18px 20px;
	font-size: 14px;
	color: #4b5563;
}

#dailyWorklog {
	max-height: 160px;
	overflow-y: auto;
	line-height: 1.7;
}

/* 급여 박스 */
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

/* 푸터 */
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

/* =========================
   모달
========================= */
.modal {
	display: none; /* JS에서 block으로 바뀔 때 적용됨 */
	position: fixed;
	inset: 0;
	z-index: 9999;
	background: rgba(15, 23, 42, 0.4); /* 배경을 조금 더 어둡게 하면 모달이 잘 보여! */
	/* [핵심] 중앙 정렬 코드 */
	display: none; /* 기본은 none */
	align-items: center; /* 세로 중앙 */
	justify-content: center; /* 가로 중앙 */
}

/* JS에서 모달을 띄울 때 display: block 대신 flex를 써야 정렬이 먹혀! */
.modal.show {
	display: flex !important;
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
	overflow: hidden; /* ⭐ 핵심 */
	display: flex;
	flex-direction: column;
}

/* 실제 스크롤 영역 따로 분리 */
.modal-body {
	overflow-y: auto;
	max-height: calc(100vh - 230px); /* 헤더 제외 높이 */
	padding: 20px;
	/* 스크롤 디자인 */
	scrollbar-gutter: stable;
}

.modal-body::-webkit-scrollbar {
	width: 8px;
}

.modal-body::-webkit-scrollbar-thumb {
	background: rgba(148, 163, 184, 0.4);
	border-radius: 10px;
}

/* 스크롤바 전체 */
.modal-content::-webkit-scrollbar {
	width: 8px;
}

/* 스크롤바 배경 */
.modal-content::-webkit-scrollbar-track {
	background: transparent;
}

/* 스크롤바 막대 */
.modal-content::-webkit-scrollbar-thumb {
	background: rgba(148, 163, 184, 0.4); /* 연한 회색 */
	border-radius: 10px;
	transition: 0.2s;
}

/* hover 시 진하게 */
.modal-content::-webkit-scrollbar-thumb:hover {
	background: rgba(100, 116, 139, 0.7);
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

.modal-body {
	padding: 14px 28px 10px;
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

.form-row input::placeholder, .form-row textarea::placeholder {
	color: #9ca3af;
}

.form-row input:focus, .form-row select:focus, .form-row textarea:focus
	{
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

/* 그리드 안에서 한 줄을 다 쓰게 만드는 설정 */
.full-width {
	grid-column: 1/-1;
	width: 100%;
}

.tax-option-group {
	display: flex;
	flex-wrap: nowrap;
	align-items: center;
	gap: 12px; /* 간격을 16px에서 12px로 살짝 줄여서 공간 확보 */
	margin-top: 8px;
	background: #f8fafc;
	padding: 10px 14px;
	border-radius: 12px;
}

#custom_tax_value {
	border: 1px solid #dbe3ec;
	border-radius: 6px;
	text-align: right;
	outline: none;
}

#custom_tax_value:focus {
	border-color: #2563eb;
}

.tax-option-item {
	display: flex;
	align-items: center;
	white-space: nowrap; /* 글자 줄바꿈 방지 */
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

/* 세부 세금 종류 박스 위치 조정 */
#taxDetailArea {
	display: none;
	background: #f8fafc;
	border-radius: 12px;
	padding: 16px;
	margin-top: 5px; /* 위쪽이랑 너무 붙지 않게 */
	height: fit-content; /* 내용물에 맞게 높이 조절 */
}
</style>
</head>
<body>

	<div class="container">


		<c:choose>
			<c:when test="${nickName==null}">
				<div class="top-auth">
					<span style="font-size: 13px; color: #666; cursor: pointer;">
						<a href="members/toLogin"
						style="text-decoration: none; color: black; margin-right: 10px;">
							<i class="fa-regular fa-user fa-lg"
							style="color: rgb(203, 203, 203); margin-right: 5px;"></i>로그인
					</a>
					</span>
				</div>
			</c:when>
			<c:otherwise>
				<div class="top-auth">
					<span style="font-size: 13px; color: #666; cursor: pointer;">
						<i class="fa-regular fa-user fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i>
						${nickName}님 환영합니다. <a href="members/logout"
						style="text-decoration: none; color: black">
							<button class="logout-btn" style="margin-left: 10px;">로그아웃</button>
					</a>
					</span>
					<c:if test="${type=='관리자'}">
						<a href="/admin/admin_main" style="text-decoration: none;"><div
								class="now-admin">관리자</div></a>
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
					<a href="/"> <i class="fa-solid fa-house fa-lg"
						style="color: rgb(203, 203, 203);"></i> 홈
					</a> <a href="/salary/calendar" class="active"> <i
						class="fa-regular fa-calendar fa-lg"
						style="color: rgb(36, 99, 235); margin-right: 5px;"></i> 급여 캘린더
					</a> <a href="/jobposts/jobpost"> <i
						class="fa-solid fa-briefcase fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 구인구직
					</a> <a href="/boards/mainboard_list"> <i
						class="fa-regular fa-message fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 커뮤니티
					</a>
				</div>
			</div>
			<a class="my-page" href="#"><i
				class="fa-solid fa-user-gear fa-lg"
				style="color: rgb(197, 197, 197);"></i> 마이페이지</a>
		</nav>

		<h2 class="section-header">급여 캘린더</h2>

		<div class="calendar-layout">

			<!-- 왼쪽 -->
			<div class="calendar-left">

				<c:forEach var="i" items="${placeList}">
					<div class="card">
						<div class="card-title">${i.name}</div>

						<div class="info-item">
							<span class="info-label">예상 급여</span> <span class="info-val blue">${i.totalPay}원</span>
						</div>

						<div class="info-item">
							<span class="info-label">근무 일수</span> <span class="info-val">${i.workDays}일</span>
						</div>

						<div class="info-item">
							<span class="info-label">근무 시간</span> <span class="info-val">${i.totalHours}시간</span>
						</div>
					</div>
				</c:forEach>


				<div class="card add-card" id="addWorkBtn">
					<span>+ 근무지 등록</span>
				</div>
			</div>

			<!-- 오른쪽 -->
			<div class="calendar-right">
				<div class="calendar-box">
					<div id="calendar"></div>
				</div>

				<div class="salary-box">
					<h3>급여 명세서</h3>

					<div class="salary-row">
						<span>총 근무 시간</span> <strong>22시간</strong>
					</div>
					<div class="salary-row">
						<span>기본 급여</span> <strong>240,420원</strong>
					</div>
					<div class="salary-row">
						<span>주휴 수당</span> <strong>+48,084원</strong>
					</div>
					<div class="salary-row">
						<span>세금 (3.3%)</span> <strong>-9,520원</strong>
					</div>

					<div class="salary-total">278,984원</div>
				</div>
			</div>
		</div>

		<div class="container-footer">
			<p>© 2026 돈워리. All rights reserved.</p>
			<p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 |
				고객센터</p>
		</div>
	</div>

	<!-- 근무 등록 모달 -->
	<div id="workModal" class="modal">
		<div class="modal-content modal-lg">
			<div class="modal-header">
				<h2>근무 등록</h2>
				<button type="button" id="closeModal" class="close-btn">×</button>
			</div>

			<form id="worklogForm" action="/worklog/insert" method="post">
				<!-- hidden -->
				<input type="hidden" id="seq" name="seq" value="0">

				<div class="modal-body">

					<div class="form-grid two-col">
						<div class="form-row">
							<label for="parent_seq">근무지</label> <select id="parent_seq"
								name="parent_seq" required>
							</select>
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
							<label for="end_time">근무 종료시간</label> <input
								type="datetime-local" id="end_time" name="end_time" required>
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
						<textarea id="memo" name="memo" rows="5"
							placeholder="근무 특이사항, 지각/조퇴, 메모 등을 입력하세요."></textarea>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-cancel" id="cancelBtn">취소</button>
					<button type="submit" class="btn btn-save" id="saveBtn">저장</button>
				</div>
			</form>
		</div>
	</div>

	<!-- 워크스페이스 모달 -->
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
							name="name" placeholder="예: 강남 편의점" required>
					</div>

					<div class="form-grid two-col">
						<div class="form-row">
							<label for="pay_per_hour">시급</label> <input type="number"
								id="pay_per_hour" name="pay_per_hour" value="10320" required>
						</div>
						<div class="form-row">
							<label for="pay_cycle">월급 주기</label> <select id="pay_cycle"
								name="pay_cycle">
								<option value="매월">매월</option>
								<option value="주급">주급</option>
							</select>
						</div>
					</div>

					<div>
						<div class="form-row">
							<div class="tax-option-group">
								<div class="form-row">
									<div>
										<div class="form-row full-width">
											<label>세금 적용 여부</label>
											<div class="tax-option-group">
												<label class="tax-option-item"> <input type="radio"
													name="tax_applied" value="0" checked> 미적용
												</label> <label class="tax-option-item"> <input type="radio"
													name="tax_applied" value="3.3"> 3.3% (프리랜서 등)
												</label> <label class="tax-option-item"> <input type="radio"
													name="tax_applied" value="custom" id="taxCustom">
													직접 입력
												</label>
												<div class="custom-tax-input"
													style="display: flex; align-items: center; gap: 4px;">
													<input type="number" id="custom_tax_value"
														name="custom_tax_value" placeholder="0.0" step="0.1"
														min="0" max="100"
														style="width: 60px; height: 30px; padding: 4px; font-size: 13px;"
														disabled> <span
														style="font-size: 13px; color: #374151;">%</span>
												</div>
											</div>
										</div>
										<div class="form-row full-width" style="margin-top: 5px;">
											<label>보험 적용 여부</label>
											<div class="tax-option-group">
												<label class="tax-option-item"> <input type="radio"
													name="insurance_applied" value="N" checked> 미적용
												</label> <label class="tax-option-item"> <input type="radio"
													name="insurance_applied" value="4"> 4대보험 적용
												</label> <label class="tax-option-item"> <input type="radio"
													name="insurance_applied" value="1"> 고용보험만 가입
												</label>
											</div>
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
												</select> <span style="font-size: 14px; color: #666;">매월 정해진
													날짜에 급여가 계산됩니다.</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>


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
					<button type="button" class="btn btn-cancel"
						id="cancelWorkplaceBtn">취소</button>
					<button type="submit" class="btn btn-save">근무지 저장</button>
				</div>
			</form>
		</div>
	</div>

	<!-- 근무 기록 수정/삭제 -->
	<!-- 근무 상세보기 / 수정 모달 -->
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
								id="detail_night_pay" name="night_pay" min="0" value="0"
								readonly>
						</div>

						<div class="form-row">
							<label for="detail_overtime_pay">연장수당</label> <input
								type="number" id="detail_overtime_pay" name="overtime_pay"
								min="0" value="0" readonly>
						</div>

						<div class="form-row">
							<label for="detail_holiday_pay">휴일수당</label> <input type="number"
								id="detail_holiday_pay" name="holiday_pay" min="0" value="0"
								readonly>
						</div>

						<div class="form-row">
							<label for="detail_total_pay">총 급여</label> <input type="number"
								id="detail_total_pay" name="total_pay" min="0" value="0"
								required readonly>
						</div>
					</div>

					<div class="result-box">
						<div class="result-row">
							<span>총 근무시간</span> <strong id="detailWorkResult">0시간 0분</strong>
						</div>
						<div class="result-row">
							<span>총 휴게시간</span> <strong id="detailBreakResult">0시간
								0분</strong>
						</div>
						<div class="result-row">
							<span>실근무시간</span> <strong id="detailRealWorkResult">0시간
								0분</strong>
						</div>
					</div>

					<div class="form-row">
						<label for="detail_memo">메모</label>
						<textarea id="detail_memo" name="memo" rows="5" readonly
							placeholder="근무 특이사항, 지각/조퇴, 메모 등을 입력하세요."></textarea>
					</div>
				</div>

				<div class="modal-footer" id="detailViewButtons">
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

	<script>
document.addEventListener("DOMContentLoaded", function () {
    const calendarEl = document.getElementById("calendar");

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
    
    
    const detailModal = document.getElementById("detailModal");
    const closeDetailModal = document.getElementById("closeDetailModal");
    const detailCloseBtn = document.getElementById("detailCloseBtn");
    const detailEditBtn = document.getElementById("detailEditBtn");
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

    let originalDetailData = null;

    
    //////////

    function toMinutes(datetimeLocalValue) {
        if (!datetimeLocalValue) return null;

        const date = new Date(datetimeLocalValue);
        if (isNaN(date.getTime())) return null;

        return Math.floor(date.getTime() / 60000);
    }

    function formatMinutes(totalMinutes) {
        if (!totalMinutes || totalMinutes < 0) return "0시간 0분";

        const hour = Math.floor(totalMinutes / 60);
        const minute = totalMinutes % 60;
        return `${hour}시간 ${minute}분`;
    }

    function calculateTimes() {
        const workStart = toMinutes(startTimeEl.value);
        const workEnd = toMinutes(endTimeEl.value);
        const breakMinutes = parseInt(breaktimeEl.value || "0", 10);

        let totalWork = 0;
        let totalBreak = 0;
        let realWork = 0;

        if (workStart !== null && workEnd !== null && workEnd > workStart) {
            totalWork = workEnd - workStart;
        }

        if (!isNaN(breakMinutes) && breakMinutes > 0) {
            totalBreak = breakMinutes;
        }

        realWork = totalWork - totalBreak;
        if (realWork < 0) realWork = 0;

        workResultEl.innerText = formatMinutes(totalWork);
        breakResultEl.innerText = formatMinutes(totalBreak);
        realWorkResultEl.innerText = formatMinutes(realWork);
    }

    function renderWorkplaceList(list, selectedSeq) {
        parentSeqEl.innerHTML = '<option value="">근무지 선택</option>';

        list.forEach(function (w) {
            const option = document.createElement("option");
            option.value = w.seq;
            option.textContent = w.name;

            if (selectedSeq && String(selectedSeq) === String(w.seq)) {
                option.selected = true;
            }

            parentSeqEl.appendChild(option);
        });
    }

    function loadWorkplaceList(selectedSeq) {
        $.ajax({
            url: "/workplaces/list",
            type: "get",
            dataType: "json",
            success: function (list) {
                renderWorkplaceList(list, selectedSeq);
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

    function openDetailModal(event) {
        const seq = event.id || event.extendedProps.seq;

        if (!seq) {
            alert("근무기록 번호를 찾을 수 없습니다.");
            return;
        }

        $.ajax({
            url: "/worklog/detail",
            type: "get",
            data: { seq: seq },
            dataType: "json",
            success: function(dto) {
                if (!dto || !dto.seq) {
                    alert("해당 근무기록이 없습니다.");
                    return;
                }

                originalDetailData = dto;
                fillDetailForm(dto);
                setDetailReadonlyMode(true);
                detailModal.style.display = "flex";
            },
            error: function(xhr) {
                console.log(xhr.responseText);
                alert("근무 상세 정보를 불러오지 못했습니다.");
            }
        });
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
            	id:"${i.logSeq}",
                title: "${i.name}",
                start: "${i.workDate}",
                extendedProps: {
                    seq: "${i.logSeq}"
                }
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ],
        dateClick: function (info) {
            openInsertModal(info.dateStr);
        },
        eventClick: function (info) {
        	console.log("클릭 이벤트 객체:", info.event);
            openDetailModal(info.event);
        }
    });

    calendar.render();
    
    
    function setDetailReadonlyMode(isReadonly) {
        detailParentSeqEl.disabled = isReadonly;
        detailWorkDateEl.readOnly = isReadonly;
        detailStartTimeEl.readOnly = isReadonly;
        detailEndTimeEl.readOnly = isReadonly;
        detailBreaktimeEl.readOnly = isReadonly;
        detailNightPayEl.readOnly = isReadonly;
        detailOvertimePayEl.readOnly = isReadonly;
        detailHolidayPayEl.readOnly = isReadonly;
        detailTotalPayEl.readOnly = isReadonly;
        detailMemoEl.readOnly = isReadonly;

        detailViewButtons.style.display = isReadonly ? "flex" : "none";
        detailEditButtons.style.display = isReadonly ? "none" : "flex";
    }

    function renderDetailWorkplaceList(list, selectedSeq) {
        detailParentSeqEl.innerHTML = '<option value="">근무지 선택</option>';

        list.forEach(function(w) {
            const option = document.createElement("option");
            option.value = w.seq;
            option.textContent = w.name;

            if (String(selectedSeq) === String(w.seq)) {
                option.selected = true;
            }

            detailParentSeqEl.appendChild(option);
        });
    }

    function loadDetailWorkplaceList(selectedSeq) {
        $.ajax({
            url: "/workplaces/list",
            type: "get",
            dataType: "json",
            success: function(list) {
                renderDetailWorkplaceList(list, selectedSeq);
            },
            error: function() {
                alert("근무지 목록을 불러오지 못했습니다.");
            }
        });
    }

    function calculateDetailTimes() {
        const workStart = toMinutes(detailStartTimeEl.value);
        const workEnd = toMinutes(detailEndTimeEl.value);
        const breakMinutes = parseInt(detailBreaktimeEl.value || "0", 10);

        let totalWork = 0;
        let totalBreak = 0;
        let realWork = 0;

        if (workStart !== null && workEnd !== null && workEnd > workStart) {
            totalWork = workEnd - workStart;
        }

        if (!isNaN(breakMinutes) && breakMinutes > 0) {
            totalBreak = breakMinutes;
        }

        realWork = totalWork - totalBreak;
        if (realWork < 0) realWork = 0;

        detailWorkResultEl.innerText = formatMinutes(totalWork);
        detailBreakResultEl.innerText = formatMinutes(totalBreak);
        detailRealWorkResultEl.innerText = formatMinutes(realWork);
    }

    function fillDetailForm(dto) {
        detailSeqEl.value = dto.seq;
        detailWorkDateEl.value = dto.work_date ? String(dto.work_date).substring(0, 10) : "";
        detailStartTimeEl.value = dto.start_time ? String(dto.start_time).substring(0, 16) : "";
        detailEndTimeEl.value = dto.end_time ? String(dto.end_time).substring(0, 16) : "";
        detailBreaktimeEl.value = dto.breaktime || 0;
        detailNightPayEl.value = dto.night_pay || 0;
        detailOvertimePayEl.value = dto.overtime_pay || 0;
        detailHolidayPayEl.value = dto.holiday_pay || 0;
        detailTotalPayEl.value = dto.total_pay || 0;
        detailMemoEl.value = dto.memo || "";

        loadDetailWorkplaceList(dto.parent_seq);
        calculateDetailTimes();
    }

    function closeDetailModalFunc() {
        detailModal.style.display = "none";
        setDetailReadonlyMode(true);
    }

    
    closeDetailModal.addEventListener("click", closeDetailModalFunc);
    detailCloseBtn.addEventListener("click", closeDetailModalFunc);

    detailEditBtn.addEventListener("click", function() {
        setDetailReadonlyMode(false);
    });

    detailEditCancelBtn.addEventListener("click", function() {
        if (originalDetailData) {
            fillDetailForm(originalDetailData);
        }
        setDetailReadonlyMode(true);
    });

    detailStartTimeEl.addEventListener("change", calculateDetailTimes);
    detailEndTimeEl.addEventListener("change", calculateDetailTimes);
    detailBreaktimeEl.addEventListener("input", calculateDetailTimes);

    window.addEventListener("click", function(e) {
        if (e.target === detailModal) {
            closeDetailModalFunc();
        }
    });

    closeModal.addEventListener("click", closeWorkModal);
    cancelBtn.addEventListener("click", closeWorkModal);

    function closeWorkplaceModal() {
        workplaceModal.style.display = "none";
    }

    if (addWorkBtn) {
        addWorkBtn.addEventListener("click", function () {
            workplaceModal.style.display = "flex";
        });
    }

    closeWP.addEventListener("click", closeWorkplaceModal);
    cancelWP.addEventListener("click", closeWorkplaceModal);

    window.addEventListener("click", function (e) {
        if (e.target === workModal) {
            closeWorkModal();
        }
        if (e.target === workplaceModal) {
            closeWorkplaceModal();
        }
    });

    startTimeEl.addEventListener("change", calculateTimes);
    endTimeEl.addEventListener("change", calculateTimes);
    breaktimeEl.addEventListener("input", calculateTimes);

    worklogForm.addEventListener("submit", function (e) {
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
    });

    const taxTypeRadios = document.querySelectorAll('input[name="tax_applied"]');
    const customTaxInput = document.getElementById("custom_tax_value");
    const taxCustomRadio = document.getElementById("taxCustom");

    taxTypeRadios.forEach(function (radio) {
        radio.addEventListener("change", function () {
            if (this.id === "taxCustom") {
                customTaxInput.disabled = false;
                customTaxInput.focus();
                this.value = customTaxInput.value;
            } else {
                customTaxInput.disabled = true;
                customTaxInput.value = "";
            }
        });
    });

    customTaxInput.addEventListener("input", function () {
        if (taxCustomRadio.checked) {
            taxCustomRadio.value = this.value;
        }
    });
});
</script>


	<!-- 근무기록 등록 -->
	<c:choose>
		<c:when test="${param.insertSuccess == 'true'}">
			<script>
        alert("근무가 등록되었습니다.");

        document.addEventListener("DOMContentLoaded", function() {
            document.getElementById("worklogForm").reset();
            document.getElementById("seq").value = 0;
            document.getElementById("work_date").value = "";
            document.getElementById("workResult").innerText = "0시간 0분";
            document.getElementById("breakResult").innerText = "0시간 0분";
            document.getElementById("realWorkResult").innerText = "0시간 0분";
        });
    </script>
		</c:when>
		<c:when test="${param.insertSuccess == 'false'}">
			<script>
				    alert("근무 등록에 실패했습니다.");
				</script>
		</c:when>
	</c:choose>

</body>
</html>