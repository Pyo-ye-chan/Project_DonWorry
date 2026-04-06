<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>돈워리 - 구인 활동 관리</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">    
<style>
    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
        font-family: 'Pretendard', sans-serif;
        background-color: #ffffff;
        line-height: 1.6;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        overflow-x: hidden;
        color: #334155;
    }

    .community-container {
        max-width: 1100px;
        width: 100%;
        margin: 0 auto;
        padding: 0 20px;
        flex: 1;
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
        cursor: pointer;
    }

    .logout-btn:hover { 
        background-color: #f8fafc;
        color: #475569;
        border-color: #cbd5e1;
    }

    .top-auth {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 15px;
        padding: 8px 0;
    }

    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px 0;
        border-bottom: 1px solid #e5e7eb;
    }

    .logo {
        color: #4f67e8;
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
        color: #4f67e8;
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

    .now-business, .now-personal, .now-admin {
        width: 60px;
        height: 30px;
        background-color: #4f67e8;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 6px;
        border: none;
        font-size: 13px;
        cursor: pointer;
    }

    .page {
        padding: 56px 0 72px;
        width: 70%;
        margin: auto;
    }

    .page-title {
        font-size: 24px;
        font-weight: 800;
        color: #1e293b;
        text-align: left;
        margin-bottom: 18px;
    }

    .title-line {
        border: none;
        border-top: 1px solid #e5e7eb;
        margin: 18px 0 28px;
    }

    .comm-header {
        text-align: center;
        margin-bottom: 34px;
    }

    .comm-header i {
        color: #dbe2ea;
        margin-bottom: 16px;
    }

    .comm-header h5 {
        font-size: 24px;
        font-weight: 700;
        color: #1e293b;
        margin-top: 8px;
    }

    .comm-header p {
        color: #64748b;
        font-size: 15px;
        margin-top: 10px;
    }

    .top-action-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 14px;
        margin-bottom: 18px;
    }

    .top-action-left,
    .top-action-right {
        display: flex;
        gap: 10px;
        align-items: center;
        flex-wrap: wrap;
    }

    .top-action-btn {
        background-color: #4f67e8;
        color: #ffffff;
        border: none;
        padding: 10px 18px;
        border-radius: 10px;
        font-size: 14px;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .top-action-btn:hover {
        background-color: #4258cf;
    }

    .top-sub-btn {
        background-color: #f8fafc;
        color: #475569;
        border: 1px solid #dbe2ea;
        padding: 10px 18px;
        border-radius: 10px;
        font-size: 14px;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .top-sub-btn:hover {
        background-color: #eff6ff;
        color: #4f67e8;
        border-color: #c7d2fe;
    }

    .tab-menu {
        display: flex;
        background-color: #eef2f7;
        padding: 6px;
        border-radius: 16px;
        margin-bottom: 30px;
        width: 100%;
    }

    .tab-item {
        flex: 1;
        border: none;
        padding: 18px 16px;
        background: none;
        cursor: pointer;
        font-size: 15px;
        color: #64748b;
        border-radius: 12px;
        font-weight: 600;
    }

    .tab-item.active {
        background-color: white;
        font-weight: 800;
        color: #4f67e8;
        box-shadow: 0 2px 8px rgba(79, 103, 232, 0.08);
    }

    .search-box {
        display: flex;
        gap: 12px;
        margin-bottom: 24px;
        align-items: center;
    }

    .search-input {
        flex: 1;
        height: 46px;
        border: 1px solid #dbe2ea;
        border-radius: 12px;
        padding: 0 16px;
        font-size: 14px;
        color: #334155;
        outline: none;
        background: #fff;
    }

    .search-input:focus {
        border-color: #c7d2fe;
        box-shadow: 0 0 0 3px rgba(79, 103, 232, 0.08);
    }

    .search-btn {
        height: 46px;
        padding: 0 18px;
        border: none;
        border-radius: 10px;
        background-color: #475569;
        color: #fff;
        font-size: 14px;
        font-weight: 700;
        cursor: pointer;
    }

    .search-btn:hover {
        background-color: #334155;
    }

    .list-count {
        font-size: 14px;
        color: #64748b;
        margin-bottom: 14px;
        font-weight: 600;
        padding-left: 4px;
    }

    .post-list {
        text-align: left;
        width: 100%;
    }

    .post-card {
        background-color: white;
        border: 1px solid #e5e7eb;
        border-radius: 18px;
        padding: 24px 24px 18px;
        margin-bottom: 22px;
        width: 100%;
    }

    .job-top {
        display: flex;
        justify-content: space-between;
        gap: 18px;
        align-items: flex-start;
        padding-bottom: 18px;
        border-bottom: 1px solid #eef2f7;
    }

    .job-left {
        display: flex;
        gap: 16px;
        flex: 1;
        min-width: 0;
    }

    .job-thumb {
        width: 88px;
        height: 88px;
        border: 1px solid #d9dee3;
        border-radius: 10px;
        background:
            linear-gradient(45deg, transparent 48%, #94a3b8 49%, #94a3b8 51%, transparent 52%),
            linear-gradient(-45deg, transparent 48%, #94a3b8 49%, #94a3b8 51%, transparent 52%);
        background-color: #f8fafc;
        flex-shrink: 0;
    }

    .job-info {
        min-width: 0;
    }

    .job-title {
        font-size: 22px;
        font-weight: 800;
        color: #1e293b;
        margin-bottom: 6px;
    }

    .job-company {
        font-size: 15px;
        color: #475569;
        margin-bottom: 2px;
    }

    .job-location,
    .job-date {
        font-size: 14px;
        color: #64748b;
    }

    .job-right {
        text-align: right;
        min-width: 190px;
    }

    .job-meta {
        font-size: 14px;
        color: #334155;
        line-height: 1.7;
    }

    .job-status {
        display: inline-block;
        margin-top: 10px;
        padding: 6px 14px;
        border-radius: 10px;
        font-size: 12px;
        font-weight: 700;
        background: #e2e8f0;
        color: #475569;
    }

    .job-status.open {
        background: #e0e7ff;
        color: #4f67e8;
    }

    .job-btns {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-top: 12px;
    }

    .line-btn {
        background-color: #ffffff;
        color: #64748b;
        border: 1px solid #dbe2ea;
        padding: 9px 16px;
        border-radius: 10px;
        font-weight: 600;
        cursor: pointer;
        font-size: 13px;
        transition: all 0.2s ease;
    }

    .line-btn:hover {
        background-color: #f8fafc;
        color: #475569;
        border-color: #cbd5e1;
    }

    .dark-btn {
        background-color: #475569;
        color: #ffffff;
        border: none;
        padding: 9px 16px;
        border-radius: 10px;
        font-weight: 700;
        cursor: pointer;
        font-size: 13px;
        transition: all 0.2s ease;
    }

    .dark-btn:hover {
        background-color: #334155;
    }

    .blue-btn {
        background-color: #4f67e8;
        color: #ffffff;
        border: none;
        padding: 9px 16px;
        border-radius: 10px;
        font-weight: 700;
        cursor: pointer;
        font-size: 13px;
        transition: all 0.2s ease;
    }

    .blue-btn:hover {
        background-color: #4258cf;
    }

    .applicant-list {
        padding-top: 8px;
    }

    .applicant-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 14px 0;
        border-bottom: 1px solid #eef2f7;
    }

    .applicant-row:last-child {
        border-bottom: none;
    }

    .applicant-left {
        display: flex;
        align-items: flex-start;
        gap: 10px;
    }

    .applicant-check {
        width: 17px;
        height: 17px;
        margin-top: 3px;
        accent-color: #4f67e8;
    }

    .applicant-name {
        font-size: 16px;
        font-weight: 700;
        color: #1e293b;
        line-height: 1.2;
    }

    .applicant-phone {
        font-size: 14px;
        color: #64748b;
        margin-top: 4px;
    }

    .applicant-right {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .step-badge {
        min-width: 76px;
        text-align: center;
        padding: 6px 12px;
        border-radius: 9px;
        background: #eef2f7;
        color: #475569;
        font-size: 12px;
        font-weight: 700;
    }

    .step-badge.blue {
        background: #e0e7ff;
        color: #4f67e8;
    }

    .bottom-action-row {
        display: flex;
        justify-content: center;
        margin-top: 22px;
    }

    .mypage-btn {
        background-color: #f8fafc;
        color: #4f67e8;
        border: 1px solid #c7d2fe;
        padding: 11px 22px;
        border-radius: 12px;
        font-size: 14px;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .mypage-btn:hover {
        background-color: #eef2ff;
        color: #4258cf;
    }

    .page-nav {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
        margin-top: 38px;
    }

    .page-num {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 40px;
        height: 40px;
        border: 1px solid #dbe2ea;
        background-color: white;
        color: #475569;
        text-decoration: none;
        border-radius: 10px;
        font-size: 14px;
    }

    .page-num.active {
        background-color: #4f67e8;
        color: white;
        border-color: #4f67e8;
    }

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

    @media (max-width: 900px) {
        .page {
            width: 100%;
        }

        .job-top,
        .applicant-row,
        .top-action-row {
            flex-direction: column;
            align-items: flex-start;
        }

        .job-right {
            text-align: left;
            min-width: auto;
            width: 100%;
        }

        .job-btns {
            justify-content: flex-start;
            flex-wrap: wrap;
        }

        .search-box {
            flex-direction: column;
            align-items: stretch;
        }

        .applicant-right {
            width: 100%;
            justify-content: flex-start;
            flex-wrap: wrap;
            margin-top: 10px;
        }

        .top-action-left,
        .top-action-right {
            width: 100%;
        }
    }
</style>
</head>
<body>

<div class="community-container">
    <c:if test="${nickName!=null}">
        <div class="top-auth">  
            <span style="font-size: 13px; color: #666; cursor: pointer;">
                <i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                ${nickName}님 환영합니다.
                <a href="/members/logout" style="text-decoration: none; color:black">
                    <button class="logout-btn" style="margin-left:10px;">로그아웃</button>              
                </a>
            </span>
            <c:if test="${type=='관리자'}">
                <div class="now-admin">관리자</div>
            </c:if>
            <c:if test="${type=='사업자'}">
                <div class="now-business">사업자</div>
            </c:if>
            <c:if test="${type=='개인'}">        
                <div class="now-personal">개인</div>
            </c:if>
        </div>
    </c:if>

    <nav class="navbar">
        <div style="display: flex; align-items: center; gap: 40px;">
            <a href="/" class="logo">돈워리</a>
            <div class="nav-menu">
                <a href="/">
                    <i class="fa-solid fa-house fa-lg" style="color: rgb(203, 203, 203);"></i>
                    홈
                </a>
                <a href="/salary/calendar">
                    <i class="fa-regular fa-calendar fa-lg" style="color:rgb(203, 203, 203); margin-right:5px;"></i>
                    급여 캘린더
                </a>
                <a href="/jobposts/jobpost" class="active">
                    <i class="fa-solid fa-briefcase fa-lg" style="color: rgb(79, 103, 232); margin-right:5px;"></i>
                    구인구직
                </a>
                <a href="/boards/mainboard_list">
                    <i class="fa-regular fa-message fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    커뮤니티
                </a>              
            </div>          
        </div>   

        <a class="my-page" href="/mypage/toMypage">
            <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(197, 197, 197);"></i>
            마이페이지
        </a>    
    </nav>

    <div class="page">
        <div class="page-title">구인 활동 관리</div>
        <hr class="title-line">

        <div class="comm-header">
            <i class="fa-solid fa-briefcase fa-4x"></i>
            <h5>나의 구인 공고</h5>
            <p>등록한 공고와 지원자 진행 상태를 한눈에 확인하세요</p>
        </div>

        <div class="top-action-row">
            <div class="top-action-left">
                <button type="button" class="top-action-btn">공고 등록</button>
            </div>
            <div class="top-action-right">
                <button type="button" class="top-sub-btn">구직자 이력서 보기</button>
            </div>
        </div>

        <nav class="tab-menu">
            <button class="tab-item active">진행 중 공고</button>
            <button class="tab-item">마감 공고</button>
        </nav>

        <div class="search-box">
            <input type="text" class="search-input" placeholder="등록된 구인 공고 제목을 검색">
            <button type="button" class="search-btn">검색</button>
        </div>

        <section class="post-list">
            <div class="list-count">전체 공고 내역 (2)</div>

            <div class="post-card">
                <div class="job-top">
                    <div class="job-left">
                        <div class="job-thumb"></div>
                        <div class="job-info">
                            <div class="job-title">바리스타 주말</div>
                            <div class="job-company">스타벅스 강남점</div>
                            <div class="job-location">서울 강남구 · 아르바이트</div>
                            <div class="job-date">등록일 2024-04-15</div>
                        </div>
                    </div>

                    <div class="job-right">
                        <div class="job-meta">
                            <div>시급 12,000원</div>
                            <div>시간 09:00 - 18:00</div>
                            <div>근무요일 토,일</div>
                        </div>
                        <div class="job-status open">모집중</div>
                        <div class="job-btns">
                            <button type="button" class="line-btn">공고 상세</button>
                            <button type="button" class="blue-btn">지원자 관리</button>
                        </div>
                    </div>
                </div>

                <div class="applicant-list">
                    <div class="applicant-row">
                        <div class="applicant-left">
                            <input type="checkbox" class="applicant-check">
                            <div>
                                <div class="applicant-name">김민수</div>
                                <div class="applicant-phone">010-1234-5678</div>
                            </div>
                        </div>
                        <div class="applicant-right">
                            <span class="step-badge blue">면접 예정</span>
                            <button type="button" class="dark-btn">이력서 보기</button>
                        </div>
                    </div>

                    <div class="applicant-row">
                        <div class="applicant-left">
                            <input type="checkbox" class="applicant-check">
                            <div>
                                <div class="applicant-name">신예리</div>
                                <div class="applicant-phone">010-4876-5432</div>
                            </div>
                        </div>
                        <div class="applicant-right">
                            <span class="step-badge blue">면접 예정</span>
                            <button type="button" class="dark-btn">이력서 보기</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="post-card">
                <div class="job-top">
                    <div class="job-left">
                        <div class="job-thumb"></div>
                        <div class="job-info">
                            <div class="job-title">매장 관리</div>
                            <div class="job-company">ABC 협력점</div>
                            <div class="job-location">서울 중구 · 알바</div>
                            <div class="job-date">등록일 2024-02-10</div>
                        </div>
                    </div>

                    <div class="job-right">
                        <div class="job-meta">
                            <div>시급 9,620원</div>
                            <div>시간 18:00 - 23:00</div>
                            <div>근무요일 수,목</div>
                        </div>
                        <div class="job-status">모집완료</div>
                        <div class="job-btns">
                            <button type="button" class="line-btn">공고 상세</button>
                            <button type="button" class="blue-btn">지원자 관리</button>
                        </div>
                    </div>
                </div>

                <div class="applicant-list">
                    <div class="applicant-row">
                        <div class="applicant-left">
                            <input type="checkbox" class="applicant-check">
                            <div>
                                <div class="applicant-name">박지출</div>
                                <div class="applicant-phone">010-1122-5678</div>
                            </div>
                        </div>
                        <div class="applicant-right">
                            <span class="step-badge">최종 합격</span>
                            <button type="button" class="dark-btn">이력서 보기</button>
                        </div>
                    </div>

                    <div class="applicant-row">
                        <div class="applicant-left">
                            <input type="checkbox" class="applicant-check">
                            <div>
                                <div class="applicant-name">김안경</div>
                                <div class="applicant-phone">010-3333-5678</div>
                            </div>
                        </div>
                        <div class="applicant-right">
                            <span class="step-badge blue">서류 합격</span>
                            <button type="button" class="dark-btn">이력서 보기</button>
                        </div>
                    </div>

                    <div class="applicant-row">
                        <div class="applicant-left">
                            <input type="checkbox" class="applicant-check">
                            <div>
                                <div class="applicant-name">이진출</div>
                                <div class="applicant-phone">010-5555-6789</div>
                            </div>
                        </div>
                        <div class="applicant-right">
                            <span class="step-badge blue">면접 예정</span>
                            <button type="button" class="dark-btn">이력서 보기</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div class="page-nav">
            <a href="#" class="page-num"><span class="material-symbols-outlined" style="font-size: 18px;">chevron_left</span></a>
            <a href="#" class="page-num active">1</a>
            <a href="#" class="page-num"><span class="material-symbols-outlined" style="font-size: 18px;">chevron_right</span></a>
        </div>

        <div class="bottom-action-row">
            <button type="button" class="mypage-btn" onclick="location.href='/mypage/toMypage'">마이페이지</button>
        </div>
    </div>
</div>

<div class="container-footer">
    <p>© 2026 돈워리. All rights reserved.</p>
    <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침 | 이용약관 | 고객센터</p>
</div>

<script>
    $(".tab-item").on("click", function(){
        $(".tab-item").removeClass("active");
        $(this).addClass("active");
    });
</script>
</body>
</html>