<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정 설정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

.container-footer {
	border-top: 1px solid #e5e7eb; /* 테두리를 상단에만 */
	background-color: #f9fafb; /* 너무 어두운 회색 대신 밝은 회색 추천 */
	padding: 40px 0; /* % 높이 대신 안쪽 여백으로 높이 확보 */
	margin-top: 80px; /* 컨텐츠와의 간격 */
	text-align: center;
	color: #999;
	font-size: 13px;
	width: 100vw; /* 화면 끝까지 너비 확장 */
	margin-left: calc(-50vw + 50%); /* 컨테이너를 벗어나 화면 꽉 채우기 */
}

.container-footer {
	border-top: 1px solid #e5e7eb; /* 테두리를 상단에만 */
	background-color: #f9fafb; /* 너무 어두운 회색 대신 밝은 회색 추천 */
	padding: 40px 0; /* % 높이 대신 안쪽 여백으로 높이 확보 */
	margin-top: 80px; /* 컨텐츠와의 간격 */
	text-align: center;
	color: #999;
	font-size: 13px;
	width: 100vw; /* 화면 끝까지 너비 확장 */
	margin-left: calc(-50vw + 50%); /* 컨테이너를 벗어나 화면 꽉 채우기 */
}


/* =========================
   공통 페이지
========================= */
.page-section {
    padding: 56px 0 72px;
    background: #ffffff;
}

.page-inner {
    max-width: 760px;
    margin: 0 auto;
}

.page-title {
    font-size: 24px;
    font-weight: 800;
    color: #222;
    margin-bottom: 18px;
}

.page-divider {
    border: none;
    border-top: 1px solid #e5e7eb;
    margin: 18px 0;
}

/* 카드 */
.ui-card {
    border: 1px solid #d9dee5;
    border-radius: 14px;
    background: #fff;
    padding: 18px 18px 16px;
    margin-bottom: 14px;
}

.ui-card-title {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 17px;
    font-weight: 800;
    color: #222;
    margin-bottom: 12px;
}

/* input */
.ui-input {
    width: 100%;
    height: 38px;
    border: 1px solid #cfd6df;
    border-radius: 8px;
    padding: 0 12px;
    font-size: 14px;
    color: #222;
    outline: none;
    background: #fff;
}

.ui-input:focus {
    border-color: #94a3b8;
    box-shadow: 0 0 0 3px rgba(148, 163, 184, 0.10);
}

.ui-btn {
    width: 100%;
    height: 38px;
    border: 1px solid #cfd6df;
    border-radius: 8px;
    background: #fff;
    color: #222;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
    transition: 0.15s ease;
}

.ui-btn:hover {
    background: #f8fafc;
}

.ui-btn-danger {
    width: 100%;
    height: 38px;
    border: 1px solid #cfd6df;
    border-radius: 8px;
    background: #fff;
    color: #222;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
    transition: 0.15s ease;
}

.ui-btn-danger:hover {
    background: #f8fafc;
}

/* 계정 설정 전용 */
.account-form-group {
    margin-bottom: 12px;
}

.account-form-group:last-child {
    margin-bottom: 12px;
}

.account-form-group label {
    display: block;
    margin-bottom: 6px;
    font-size: 14px;
    color: #333;
    font-weight: 600;
}

.account-info-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.account-info-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 20px;
    font-size: 15px;
}

.account-info-label {
    color: #444;
    font-weight: 600;
}

.account-info-value {
    color: #222;
    text-align: right;
}

.account-withdraw-desc {
    color: #777;
    font-size: 14px;
    margin-bottom: 14px;
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
@media (max-width: 768px) {
    .nav-menu {
        gap: 18px;
        flex-wrap: wrap;
    }

    .page-title {
        font-size: 22px;
    }

    .account-info-row {
        flex-direction: column;
        align-items: flex-start;
        gap: 4px;
    }

    .account-info-value {
        text-align: left;
    }
}
</style>
</head>
<body>
<div class="container">
    <div class="top-auth">
        <span style="font-size: 13px; color: #666; cursor: pointer;">
            <a href="members/login" style="text-decoration: none; color: black">
                <i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right: 5px;"></i>
                로그인
            </a>
        </span>

        <div class="now-admin">관리자</div>
        <div class="now-business" style="display: none;">기업</div>
        <div class="now-personal" style="display: none;">개인</div>
    </div>

    <nav class="navbar">
        <div style="display: flex; align-items: center; gap: 40px;">
            <a href="/" class="logo">돈워리</a>
            <div class="nav-menu">
                <a href="/" class="active">
                    <i class="fa-solid fa-house fa-lg" style="color: rgb(36, 99, 235);"></i>
                    홈
                </a>
                <a href="salary/calendar">
                    <i class="fa-regular fa-calendar fa-lg" style="color: rgb(203, 203, 203); margin-right: 5px;"></i>
                    급여 캘린더
                </a>
                <a href="#">
                    <i class="fa-solid fa-briefcase fa-lg" style="color: rgb(203, 203, 203); margin-right: 5px;"></i>
                    구인구직
                </a>
                <a href="#">
                    <i class="fa-regular fa-message fa-lg" style="color: rgb(203, 203, 203); margin-right: 5px;"></i>
                    커뮤니티
                </a>
            </div>
        </div>

        <a class="my-page" href="#">
            <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(197, 197, 197);"></i>
            마이페이지
        </a>
    </nav>

    <div class="page-section">
        <div class="page-inner">
            <div class="page-title">계정 설정</div>
            <hr class="page-divider">

            <!-- 비밀번호 변경 -->
            <section class="ui-card">
                <div class="ui-card-title">
                    <i class="fa-solid fa-lock"></i>
                    <span>비밀번호 변경</span>
                </div>

                <div class="account-form-group">
                    <label for="currentPw">현재 비밀번호</label>
                    <input type="password" id="currentPw" class="ui-input" placeholder="현재 비밀번호를 입력하세요">
                </div>

                <div class="account-form-group">
                    <label for="newPw">새 비밀번호</label>
                    <input type="password" id="newPw" class="ui-input" placeholder="새 비밀번호 (8자 이상)">
                </div>

                <div class="account-form-group">
                    <label for="newPwCheck">새 비밀번호 확인</label>
                    <input type="password" id="newPwCheck" class="ui-input" placeholder="새 비밀번호를 다시 입력하세요">
                </div>

                <button type="button" class="ui-btn">비밀번호 변경</button>
            </section>

            <!-- 계정 정보 -->
            <section class="ui-card">
                <div class="ui-card-title">
                    <span>계정 정보</span>
                </div>

                <div class="account-info-list">
                    <div class="account-info-row">
                        <div class="account-info-label">이메일</div>
                        <div class="account-info-value">user@example.com</div>
                    </div>

                    <div class="account-info-row">
                        <div class="account-info-label">전화번호</div>
                        <div class="account-info-value">010-1234-5678</div>
                    </div>

                    <div class="account-info-row">
                        <div class="account-info-label">가입일</div>
                        <div class="account-info-value">2025.01.15</div>
                    </div>
                </div>
            </section>

            <!-- 회원 탈퇴 -->
            <section class="ui-card">
                <div class="ui-card-title">
                    <i class="fa-regular fa-trash-can"></i>
                    <span>회원 탈퇴</span>
                </div>

                <div class="account-withdraw-desc">
                    회원 탈퇴 시 모든 데이터가 삭제되며 복구할 수 없습니다.
                </div>

                <a href="/mypage/toWithdraw">
                    <button type="button" class="ui-btn-danger">회원 탈퇴하기</button>
                </a>
            </section>
        </div>
    </div>

    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
</div>
</body>
</html>

