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
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.20/index.global.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Pretendard', 'Malgun Gothic', sans-serif;
        background-color: #ffffff;
        color: #333;
        line-height: 1.6;
    }

    .container {
        max-width: 1100px;
        margin: 0 auto;
        padding: 0 20px;
    }

    /* 로그인/상단 */
    .top-auth {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 15px;
        padding: 8px 0;
    }

    .admin-btn {
        background-color: #2563eb;
        color: white;
        padding: 8px 16px;
        border-radius: 6px;
        border: none;
        font-size: 13px;
        cursor: pointer;
    }

    /* 네비게이션 */
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

    .nav-menu a.active {
        color: #2563eb;
    }

    .my-page {
        justify-content: flex-end;
        margin-left: auto;
        text-decoration: none;
        color: #666;
        font-size: 14px;
        font-weight: 500;
    }

    /* 섹션 타이틀 */
    .section-header {
        font-size: 20px;
        font-weight: 700;
        margin: 40px 0 20px;
    }

    /* 캘린더 전체 레이아웃 */
    .calendar-layout {
        display: flex;
        gap: 24px;
        align-items: flex-start;
        margin-bottom: 60px;
    }

    .calendar-left {
        width: 260px;
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .calendar-right {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    /* 공통 카드 */
    .card {
        border: 1px solid #e5e7eb;
        border-radius: 15px;
        padding: 25px;
        background: #fff;
    }

    .card-title {
        color: #2563eb;
        font-weight: bold;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        font-size: 17px;
    }

    .info-item {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
        font-size: 14px;
    }

    .info-label {
        color: #aaa;
    }

    .info-val {
        font-weight: 700;
    }

    .info-val.blue {
        color: #2563eb;
        font-size: 18px;
    }

    .add-card {
        border: 2px dashed #e5e7eb;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        color: #ccc;
        min-height: 150px;
        cursor: pointer;
        transition: 0.2s;
    }

    .add-card:hover {
        background-color: #f8fbff;
        border-color: #bfd4ff;
        color: #2563eb;
    }

    /* 캘린더 박스 */
    .calendar-box {
        border: 1px solid #e5e7eb;
        border-radius: 16px;
        padding: 24px;
        background: #fff;
    }

    #calendar {
        width: 100%;
    }

    /* FullCalendar 커스텀 */
    .fc .fc-toolbar.fc-header-toolbar {
        margin-bottom: 20px;
    }

    .fc .fc-toolbar-title {
        font-size: 24px;
        font-weight: 700;
        color: #222;
    }

    .fc .fc-button {
        background: #fff !important;
        border: 1px solid #dbe2ea !important;
        color: #333 !important;
        border-radius: 8px !important;
        box-shadow: none !important;
        padding: 8px 14px !important;
        font-size: 13px !important;
    }

    .fc .fc-button:hover {
        background-color: #f8fbff !important;
        border-color: #bfd4ff !important;
        color: #2563eb !important;
    }

    .fc .fc-button-primary:not(:disabled).fc-button-active,
    .fc .fc-button-primary:not(:disabled):active {
        background-color: #eaf2ff !important;
        border-color: #bfd4ff !important;
        color: #2563eb !important;
    }

    .fc-theme-standard .fc-scrollgrid {
        border: 1px solid #eef2f7;
        border-radius: 12px;
        overflow: hidden;
    }

    .fc-theme-standard th {
        background-color: #fafbfc;
        border-color: #eef2f7;
        font-size: 13px;
        color: #666;
        height: 44px;
        vertical-align: middle;
    }

    .fc-theme-standard td {
        border-color: #eef2f7;
    }

    .fc .fc-daygrid-day-frame {
        min-height: 95px;
        padding: 6px;
    }

    .fc .fc-daygrid-day-number {
        font-size: 14px;
        color: #333;
        padding: 4px 6px;
    }

    .fc .fc-day-today {
        background-color: #f7fbff !important;
    }

    .fc-daygrid-event {
        border: none !important;
        background-color: #2563eb !important;
        border-radius: 6px !important;
        padding: 3px 6px !important;
        font-size: 12px !important;
    }

    /* 선택 날짜 */
    .selected-date {
        border: 1px solid #e5e7eb;
        border-radius: 12px;
        background-color: #f9fafb;
        padding: 14px 16px;
        font-size: 14px;
        color: #666;
    }

    .selected-date span {
        color: #2563eb;
        font-weight: 700;
    }

    /* 급여 명세서 */
    .salary-box {
        border: 1px solid #e5e7eb;
        border-radius: 16px;
        padding: 24px;
        background: #fff;
    }

    .salary-box h3 {
        font-size: 22px;
        font-weight: 700;
        margin-bottom: 18px;
        color: #222;
    }

    .salary-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 8px 0;
        font-size: 16px;
    }

    .salary-row span {
        color: #666;
    }

    .salary-row strong {
        color: #222;
    }

    .salary-total {
        margin-top: 16px;
        padding-top: 14px;
        border-top: 2px solid #eef2f7;
        text-align: right;
        font-size: 22px;
        font-weight: 800;
        color: #2563eb;
    }

    /* 푸터 */
    .container-footer {
        border-top: 1px solid #e5e7eb;
        background-color: #f9fafb;
        padding: 40px 0;
        margin-top: 80px;
        text-align: center;
        color: #999;
        font-size: 13px;
        width: 100vw;
        margin-left: calc(-50vw + 50%);
    }

    /* 반응형 */
    @media (max-width: 900px) {
        .calendar-layout {
            flex-direction: column;
        }

        .calendar-left {
            width: 100%;
        }

        .nav-menu {
            gap: 20px;
            flex-wrap: wrap;
        }
    }
</style>
</head>
<body>

<div class="container">

    <div class="top-auth">
        <span style="font-size: 13px; color: #666; cursor: pointer;">
        	<i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
            <a style="text-decoration: none; color:black" href="#">로그인</a>
        </span>
        <button class="admin-btn">관리자</button>
    </div>

    <nav class="navbar">
        <div style="display: flex; align-items: center; gap: 40px;">
            <a href="#" class="logo">돈워리</a>
            <div class="nav-menu">
                <a href="/">
                    <i class="fa-solid fa-house fa-lg" style="color: rgb(203, 203, 203);"></i>
                    홈
                </a>
                <a href="#" class="active">
                    <i class="fa-regular fa-calendar fa-lg" style="color: rgb(36, 99, 235); margin-right:5px;"></i>
                    급여 캘린더
                </a>
                <a href="#">
                    <i class="fa-solid fa-briefcase fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    구인구직
                </a>
                <a href="#">
                    <i class="fa-regular fa-message fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    커뮤니티
                </a>
            </div>
        </div>
        <a class="my-page" href="#"><i class="fa-solid fa-user-gear fa-lg" style="color: rgb(197, 197, 197);"></i>
        마이페이지</a>
    </nav>

    <h2 class="section-header">급여 캘린더</h2>

    <div class="calendar-layout">

        <!-- 왼쪽 -->
        <div class="calendar-left">
            <div class="card">
                <div class="card-title">편의점 알바</div>
                <div class="info-item"><span class="info-label">예상 급여</span><span class="info-val blue">1,245,000원</span></div>
                <div class="info-item"><span class="info-label">근무 일수</span><span class="info-val">16일</span></div>
                <div class="info-item"><span class="info-label">총 시간</span><span class="info-val">128시간</span></div>
            </div>

            <div class="card">
                <div class="card-title">카페 알바</div>
                <div class="info-item"><span class="info-label">예상 급여</span><span class="info-val blue">850,000원</span></div>
                <div class="info-item"><span class="info-label">근무 일수</span><span class="info-val">12일</span></div>
                <div class="info-item"><span class="info-label">총 시간</span><span class="info-val">96시간</span></div>
            </div>

            <div class="card add-card">
                <span>+ 근무 등록</span>
            </div>
        </div>

        <!-- 오른쪽 -->
        <div class="calendar-right">
            <div class="calendar-box">
                <div id="calendar"></div>
            </div>

            <div class="selected-date">
                선택 날짜 : <span id="selectedDate">없음</span>
            </div>

            <div class="salary-box">
                <h3>급여 명세서</h3>

                <div class="salary-row">
                    <span>총 근무 시간</span>
                    <strong>22시간</strong>
                </div>
                <div class="salary-row">
                    <span>기본 급여</span>
                    <strong>240,420원</strong>
                </div>
                <div class="salary-row">
                    <span>주휴 수당</span>
                    <strong>+48,084원</strong>
                </div>
                <div class="salary-row">
                    <span>세금 (3.3%)</span>
                    <strong>-9,520원</strong>
                </div>

                <div class="salary-total">
                    278,984원
                </div>
            </div>
        </div>
    </div>

    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var selectedDateEl = document.getElementById('selectedDate');

    var calendar = new FullCalendar.Calendar(calendarEl, {
        locale: 'ko',
        initialView: 'dayGridMonth',
        height: 'auto',

        
        headerToolbar: {
        	left: 'today',
        	center: 'title',
            right: 'prev,next', 
            
        },
		
        buttonText: {
            today: '오늘'
        },
     

        events: [
            { title: '편의점', start: '2026-03-08' },
            { title: '카페', start: '2026-03-16' },
            { title: '야간', start: '2026-03-27' }
        ],

        dateClick: function(info) {
            selectedDateEl.innerText = info.dateStr;
        },

        eventClick: function(info) {
            alert(info.event.title + " / " + info.event.startStr);
        }
    });

    calendar.render();
});
</script>

</body>
</html>