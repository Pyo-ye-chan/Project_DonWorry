<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>돈워리- 구인구직</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* [1] 공통 초기화 */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Pretendard', sans-serif;
	background-color: #ffffff;
	line-height: 1.6;
	min-height: 105vh;
	display: flex;
	flex-direction: column;
	overflow-x: hidden;
}

/* [2] 컨테이너 및 상단바 */
.community-container {
	max-width: 1100px;
	width: 100%;
	margin: 0 auto;
	padding: 0 20px;
	flex: 1;
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

.now-admin, .now-business, .now-personal {
	width: 60px;
	height: 30px;
	background-color: #2563eb;
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 6px;
	font-size: 13px;
	cursor: pointer;
}

/* [3] 네비게이션 */
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

/* [4] 구인구직 섹션 */
.job-section {
	text-align: center;
	margin-top: 20px;
}

.job-section h2 {
	font-size: 32px;
	margin-bottom: 10px;
	font-weight: 700;
	color: #2563eb;
}

.job-section p {
	color: #888;
	margin-bottom: 40px;
}

/* 검색창 및 필터 */
.search-filter-wrap {
	max-width: 1040px;
	margin: 0 auto;
	position: relative;
}

.search-wrapper {
	display: flex;
	background: #f1f3f5;
	border: 1px solid #cce0ff;
	border-radius: 15px;
	padding: 8px 10px;
	align-items: center;
	transition: 0.3s;
	margin-bottom: 30px;
}

.search-wrapper:focus-within {
	background: #fff;
	border-color: #2563eb;
	box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
}

.search-wrapper i {
	color: #adb5bd;
	margin-left: 15px;
	font-size: 20px;
}

.search-wrapper input {
	flex: 1;
	border: none;
	background: transparent;
	padding: 12px 15px;
	font-size: 16px;
	outline: none;
}

.search-btn {
	background-color: #2563eb;
	color: white;
	border: none;
	border-radius: 10px;
	padding: 10px 25px;
	font-weight: 600;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 8px;
}

.filter-group {
	display: flex;
	justify-content: flex-start;
	gap: 12px;
	margin-bottom: 20px;
}

.filter-btn {
	padding: 10px 18px;
	border: 1px solid #e1e7f0;
	border-radius: 10px;
	background: white;
	color: #444;
	font-size: 14px;
	font-weight: 500;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 10px;
	transition: 0.2s;
}

.filter-btn:hover, .filter-btn.active {
	border-color: #2563eb;
	color: #2563eb;
	background: #f8faff;
}

.filter-btn i:first-child {
	color: #2563eb;
	font-size: 16px;
}

/* 위치 선택 레이어 팝업 */
#locationLayer {
	display: none;
	position: absolute;
	top: 100%;
	left: 0;
	width: 100%;
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 12px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	z-index: 100;
	margin-top: 10px;
	overflow: hidden;
}

.layer-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px 20px;
	border-bottom: 1px solid #eee;
	background: #fcfcfc;
}

.layer-content {
	display: flex;
	height: 320px;
}

.loc-list {
	flex: 1;
	border-right: 1px solid #eee;
	height: 100%; /* 부모 높이에 맞춤 */
	overflow-y: auto; /* 항목 많으면 스크롤 생성 */
	text-align: left;
	list-style: none;
}

/* 스크롤바 디자인 (파란색 포인트와 어울리게 연하게) */
.loc-list::-webkit-scrollbar {
	width: 5px;
}

.loc-list::-webkit-scrollbar-thumb {
	background-color: #dee2e6;
	border-radius: 10px;
}

.loc-list:last-child {
	border-right: none;
}

.loc-list li {
	padding: 12px 20px;
	font-size: 14px;
	color: #555;
	cursor: pointer;
	border-bottom: 1px solid #f9f9f9;
	position: relative;
}

.loc-list li:hover {
	background-color: #f0f7ff;
	color: #2563eb;
}

.loc-list li.active {
	background-color: #eef2ff;
	color: #2563eb;
	font-weight: 600;
	color: #2563eb;
}

.loc-list li.active::after {
	content: '✔';
	position: absolute;
	right: 15px;
	font-size: 12px;
}

.list-header {
	background: #f9f9f9;
	font-weight: 600;
	color: #777 !important;
	position: sticky;
	top: 0;
	cursor: default !important;
}

/* 공고 리스트 */
.job-list {
	display: flex;
	flex-direction: column;
	gap: 20px;
	margin-top: 40px;
	max-width: 1040px; /* 상단 검색창 너비와 맞춤 */
	margin-left: auto; /* 가로 가운데 정렬 */
	margin-right: auto; /* 가로 가운데 정렬 */
	width: 100%;
}

.job-card {
	border: 1px solid #e1e7f0;
	border-radius: 16px;
	padding: 25px;
	display: flex;
	gap: 20px;
	text-align: left;
	background: #fff;
	transition: 0.2s;
	width: 100%; /* 부모 너비에 꽉 차게 */
	box-sizing: border-box; /* 패딩이 너비에 포함되게 */
}

.job-card:hover {
	border-color: #2563eb;
	box-shadow: 0 8px 20px rgba(37, 99, 235, 0.08);
}

.job-icon {
	width: 60px;
	height: 60px;
	background: #2563eb;
	border-radius: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 28px;
	color: white;
	flex-shrink: 0;
}

.job-info {
	flex: 1;
	display: flex;
	flex-direction: column;
	gap: 8px;
	min-width: 0;
}

.job-title-row {
	display: flex;
	align-items: center;
	gap: 8px;
}

.job-title-row h3 {
	font-size: 20px;
	font-weight: 700;
	color: #333;
	display: block;           /* 말줄임표를 위해 필요 */
    width: 100%;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    word-break: break-all;
}

.job-badge {
	background: #eef2ff;
	color: #2563eb;
	padding: 2px 8px;
	border-radius: 4px;
	font-size: 12px;
	white-space: nowrap;
	width: fit-content;
}

.job-meta-row {
	display: flex;
	flex-wrap: wrap;
	gap: 40px;
	padding-top: 15px;
	border-top: 1px solid #f1f3f5;
	margin-top: 5px;
}

.meta-item {
	display: flex;
	align-items: center;
	gap: 8px;
	font-size: 14px;
	color: #555;
	font-weight: 500;
}

.meta-item i {
	font-size: 16px;
	color: #2563eb;
}

.pay-text {
	color: #2563eb;
	font-weight: 700;
}

.job-btn-group {
	display: flex;
	gap: 10px;
	margin-top: 10px;
	justify-content: flex-end;
}

.btn-apply {
	padding: 10px 25px;
	background: #2563eb;
	color: white;
	border: none;
	border-radius: 8px;
	font-weight: 600;
	cursor: pointer;
}

.btn-detail {
	padding: 10px 25px;
	background: white;
	color: #2563eb;
	border: 1px solid #2563eb;
	border-radius: 8px;
	font-weight: 600;
	cursor: pointer;
}

/* 푸터 및 플로팅 */
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

.floating-write-btn {
	position: fixed;
	bottom: 30px;
	right: 30px;
	display: flex;
	align-items: center;
	gap: 8px;
	padding: 15px 25px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 30px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	transition: 0.2s, transform 0.2s;
	z-index: 1000;
}

.floating-write-btn:hover {
	background-color: #0056b3;
	transform: translateY(-3px);
}

/* 직종/지역 리스트 글자가 안 보일 때를 대비한 강제 스타일 */
.loc-list li {
	color: #333 !important; /* 글자색을 진한 회색으로 강제 */
	min-height: 40px; /* 최소 높이 확보 */
	display: block; /* 영역 확보 */
	width: 100%;
}

.loc-list li:hover {
	background-color: #f0f7ff !important;
	color: #2563eb !important;
}

/* [직종 레이어 리스트 강제 출력 스타일] */
#categoryLayer .loc-list {
	background-color: #ffffff !important;
	min-height: 320px !important;
	display: block !important;
}

#mainCatList li, #subCatList li {
	color: #333333 !important; /* 글자색을 진한 회색으로 강제 */
	padding: 12px 20px !important;
	font-size: 14px !important;
	display: block !important; /* 영역 확보 */
	background-color: #ffffff !important;
	cursor: pointer !important;
	border-bottom: 1px solid #f1f3f5 !important;
	text-align: left !important;
	visibility: visible !important; /* 숨김 방지 */
	opacity: 1 !important; /* 투명도 방지 */
}

/* 마우스 올렸을 때 효과 */
#mainCatList li:hover, #subCatList li:hover {
	background-color: #f0f7ff !important;
	color: #2563eb !important;
}

/* 선택(클릭)되었을 때 스타일 */
#mainCatList li.active, #subCatList li.active {
	background-color: #eef2ff !important;
	color: #2563eb !important;
	font-weight: 600 !important;
}

/* 리스트 헤더(대분류/소분류 글자) 스타일 */
.list-header {
	background-color: #f8f9fa !important;
	color: #868e96 !important;
	font-weight: 600 !important;
	padding: 10px 20px !important;
	position: sticky !important;
	top: 0;
	z-index: 10;
}

/* 페이지 네비게이터 스타일 추가 */
.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
	margin: 50px 0;
}

.page-link {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	width: 38px;
	height: 38px;
	border: 1px solid #e1e7f0;
	border-radius: 8px;
	text-decoration: none;
	color: #666;
	font-size: 14px;
	font-weight: 500;
	transition: 0.2s;
}

.page-link:hover {
	border-color: #2563eb;
	color: #2563eb;
	background-color: #f8faff;
}

.page-link.active {
	background-color: #2563eb;
	color: white;
	border-color: #2563eb;
	font-weight: 700;
}

img{
        max-width: 100%;    /* 부모 너비를 넘지 않음 */
    height: auto;       /* 비율 유지 */
    display: block;     /* 하단 여백 제거 */
    margin: 10px 0;    /* 이미지 위아래 여백 */
        }
</style>
</head>
<body>
	<div class="community-container">
		<c:choose>
<c:when test="${nickName==null}">
    <div class="top-auth">
        <span style="font-size: 13px; color: #666; cursor: pointer;">
            <a href="/members/toLogin" style="text-decoration: none; color:black; margin-right:10px;">
                <i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>로그인
            </a>
        </span>
    </div>
</c:when>
<c:otherwise>
    <div class="top-auth">  
        <span style="font-size: 13px; color: #666; cursor: pointer;">
        	<i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
            	${nickName}님 환영합니다.
            <a href="/members/logout" style="text-decoration: none; color:black">
            <button class="logout-btn" style="margin-left:10px;">로그아웃</button>              
            </a>
        </span>
		<c:if test="${type=='관리자'}">
            <a href="/admin/admin_main" style="text-decoration:none;"><div class="now-admin">관리자</div></a>
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
				<a href="/" class="logo"> 돈워리</a>
				<div class="nav-menu">
					<a href="/"> <i class="fa-solid fa-house fa-lg"
						style="color: rgb(203, 203, 203);"></i> 홈
					</a> <a href="/salary/calendar"> <i
						class="fa-regular fa-calendar fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 급여 캘린더
					</a> <a href="/jobposts/jobpost" class="active"> <i
						class="fa-solid fa-briefcase fa-lg"
						style="color: rgb(36, 99, 235); margin-right: 5px;"></i> 구인구직
					</a> <a href="/boards/mainboard_list?page=1"> <i
						class="fa-regular fa-message fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 커뮤니티
					</a> <a href="/qna/qna?page=1"> <i
						class="fa-solid fa-question fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 고객지원
					</a>
				</div>
			</div>
			<c:if test="${nickName==null }">
				<a class="my-page" href="/members/toLogin"> <i
					class="fa-solid fa-user-gear fa-lg"
					style="color: rgb(197, 197, 197);"></i> 마이페이지
				</a>
			</c:if>
			<c:if test="${nickName!=null }">
				<a class="my-page" href="/mypage/toMypage"> <i
					class="fa-solid fa-user-gear fa-lg"
					style="color: rgb(197, 197, 197);"></i> 마이페이지
				</a>
			</c:if>
		</nav>
	</div>

	<div class="job-section">
		<h2>
			<i class="fa-solid fa-briefcase"></i> 구인구직
		</h2>
		<p>나에게 맞는 알바를 찾아 보세요</p>

		<div class="search-filter-wrap">
			<div class="search-wrapper">
				<i class="fa-solid fa-magnifying-glass"></i> <input type="text"
					placeholder="어떤 알바를 찾으시나요?">
				<button class="search-btn">검색</button>
			</div>

			<div class="filter-group">
				<button class="filter-btn" id="btnLocation">
					<i class="fa-solid fa-location-dot"></i> 위치별 <i
						class="fa-solid fa-chevron-down"
						style="font-size: 12px; color: #ccc;"></i>
				</button>
				<button class="filter-btn" id="btnCategory">
					<i class="fa-solid fa-briefcase"></i> 직종별 <i
						class="fa-solid fa-chevron-down"
						style="font-size: 12px; color: #ccc;"></i>
				</button>
				<button class="filter-btn" id="btnCondition">
					<i class="fa-regular fa-clock"></i> 근무 조건 <i
						class="fa-solid fa-chevron-down"
						style="font-size: 12px; color: #ccc;"></i>
				</button>
			</div>

			<div id="locationLayer">
				<div class="layer-header">
					<h4 style="font-size: 15px; font-weight: 600;">지역 선택</h4>
					<button type="button" id="layerClose"
						style="font-size: 20px; color: #999; cursor: pointer;">&times;</button>
				</div>
				<div class="layer-content">
					<ul class="loc-list" id="sidoList">
						<li class="list-header">시·도</li>
					</ul>
					<ul class="loc-list" id="gugunList">
						<li class="list-header">시·구·군</li>
					</ul>
					<ul class="loc-list" id="dongList">
						<li class="list-header">동·읍·면</li>
					</ul>
				</div>
				<div
					style="display: flex; justify-content: center; gap: 10px; padding: 15px; background: #fcfcfc; border-top: 1px solid #eee;">
					<button class="filter-btn" style="padding: 8px 25px;">초기화</button>
					<button id="btnLayerSearch" class="filter-btn"
						style="padding: 8px 25px; background-color: #2563eb; color: white;">검색</button>
				</div>
			</div>

			<div id="categoryLayer"
				style="display: none; position: absolute; top: 100%; left: 0; width: 100%; background: #fff; border: 1px solid #ddd; border-radius: 12px; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); z-index: 101; margin-top: 10px; overflow: hidden;">
				<div class="layer-header">
					<h4 style="font-size: 15px; font-weight: 600;">직종 선택</h4>
					<button type="button" class="categoryLayerClose"
						style="font-size: 20px; color: #999; cursor: pointer; border: none; background: none;">&times;</button>
				</div>
				<div class="layer-content">
					<ul class="loc-list" id="mainCatList">
						<li class="list-header">대분류</li>
					</ul>
					<ul class="loc-list" id="subCatList" style="flex: 2;">
						<li class="list-header">소분류</li>
					</ul>
				</div>
				<div
					style="display: flex; justify-content: center; gap: 10px; padding: 15px; background: #fcfcfc; border-top: 1px solid #eee;">
					<button id="btnCatSearch" class="filter-btn"
						style="padding: 8px 25px; background-color: #2563eb; color: white;">선택
						완료</button>
				</div>
			</div>

			<div id="timeLayer"
				style="display: none; position: absolute; top: 100%; left: 110px; width: 520px; background: #fff; border: 1px solid #e1e7f0; border-radius: 16px; box-shadow: 0 15px 35px rgba(37, 99, 235, 0.15); z-index: 101; margin-top: 10px; overflow: hidden;">

				<div class="layer-header"
					style="display: flex; justify-content: space-between; align-items: center; padding: 16px 20px; border-bottom: 1px solid #f1f3f5; background: #fff;">
					<h4
						style="font-size: 15px; font-weight: 700; margin: 0; color: #1e293b;">
						<i class="fa-regular fa-clock"
							style="color: #2563eb; margin-right: 6px;"></i>근무 조건 상세 설정
					</h4>
					<button type="button" class="timeLayerClose"
						style="font-size: 22px; color: #94a3b8; cursor: pointer; border: none; background: none; padding: 0; line-height: 1;">&times;</button>
				</div>

				<div class="layer-content"
					style="display: flex !important; justify-content: space-between !important; align-items: center !important; padding: 25px 20px !important; gap: 10px !important;">

					<div class="select-box-wrap"
						style="flex: 1.2; display: flex; flex-direction: column; gap: 8px;">
						<p
							style="font-size: 12px; font-weight: 600; color: #64748b; margin: 0; text-align: left;">근무
							요일</p>
						<select id="searchWorkDay"
							style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0; font-size: 13px; color: #334155; background: #f8fafc; outline: none; transition: 0.2s;">
							<option value="">날짜무관</option>
							<option value="평일">평일 (월~금)</option>
							<option value="주말">주말 (토,일)</option>
						</select>
					</div>

					<div class="select-box-wrap"
						style="flex: 1; display: flex; flex-direction: column; gap: 8px;">
						<p
							style="font-size: 12px; font-weight: 600; color: #64748b; margin: 0; text-align: left;">시작
							시간</p>
						<select id="searchStartTime"
							style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0; font-size: 13px; color: #334155; background: #f8fafc; outline: none;">
							<c:forEach var="h" begin="0" end="23">
								<c:set var="ampm" value="${h < 12 ? '오전' : '오후'}" />
								<c:set var="displayHour" value="${h <= 12 ? h : h - 12}" />
								<c:if test="${displayHour == 0}">
									<c:set var="displayHour" value="12" />
								</c:if>
								<option value="${h * 60}">${ampm} ${displayHour}:00</option>
								<option value="${h * 60 + 30}">${ampm}
									${displayHour}:30</option>
							</c:forEach>
						</select>
					</div>

					<span style="font-size: 16px; color: #cbd5e1; margin-top: 22px;">~</span>

					<div class="select-box-wrap"
						style="flex: 1; display: flex; flex-direction: column; gap: 8px;">
						<p
							style="font-size: 12px; font-weight: 600; color: #64748b; margin: 0; text-align: left;">종료
							시간</p>
						<select id="searchEndTime"
							style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0; font-size: 13px; color: #334155; background: #f8fafc; outline: none;">
							<c:forEach var="h" begin="0" end="23">
								<c:set var="ampm" value="${h < 12 ? '오전' : '오후'}" />
								<c:set var="displayHour" value="${h <= 12 ? h : h - 12}" />
								<c:if test="${displayHour == 0}">
									<c:set var="displayHour" value="12" />
								</c:if>
								<option value="${h * 60}">${ampm} ${displayHour}:00</option>
								<option value="${h * 60 + 30}">${ampm}
									${displayHour}:30</option>
							</c:forEach>
							<option value="1440" selected>오전 12:00 (익일)</option>
						</select>
					</div>
				</div>

				<div
					style="display: flex; justify-content: flex-end; gap: 10px; padding: 16px 20px; background: #f8fafc; border-top: 1px solid #f1f3f5;">
					<button type="button" class="timeLayerClose"
						style="padding: 8px 16px; background: #fff; color: #64748b; border: 1px solid #e2e8f0; border-radius: 8px; font-size: 13px; font-weight: 600; cursor: pointer;">취소</button>
					<button id="btnTimeSearch"
						style="padding: 8px 24px; background: #2563eb; color: white; border: none; border-radius: 8px; font-size: 13px; font-weight: 700; cursor: pointer; transition: 0.2s;">조건
						적용</button>
				</div>
			</div>
		</div>

	</div>
	<div class="job-list">
		<c:forEach var="post" items="${jobList}">
			<div class="job-card">
				<div class="job-icon">
					<i class="fa-solid fa-briefcase"></i>
				</div>
				<div class="job-info">
					<div class="job-title-row">
						<h3>${post.title}</h3>
						<span class="job-badge">${post.work_days}</span>
					</div>
					<div class="company-name">${post.company_name}</div>
<%-- 					<div class="job-desc">${post.content}</div> --%>

					<div class="job-meta-row">
						<div class="meta-item">
							<i class="fa-solid fa-location-dot"></i> ${post.sido}
							${post.gugun} ${post.dong}
						</div>
						<div class="meta-item">
							<i class="fa-solid fa-won-sign"></i> <span class="pay-text">시급
								<fmt:formatNumber value="${post.pay}" pattern="#,###" />원
							</span>
						</div>
						<div class="meta-item">
							<i class="fa-regular fa-clock"></i> ${post.work_starttime} ~
							${post.work_endtime}
						</div>
						<div class="meta-item">
							<i class="fa-solid fa-suitcase"></i> ${post.main_category_name}
						</div>
					</div>

					<div class="job-btn-group">
						<c:if test="${type != '사업자'}">
							<button class="btn-apply" data-seq="${post.seq }">지원하기</button>
						</c:if>
						<button class="btn-detail"
							onclick="location.href='/jobposts/jobdetail?seq=${post.seq}&page=${currentPage }'">자세히
							보기</button>
					</div>
						<!-- 이력서 모달창 -->
					<div id="resumeModal"
						style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 1000;">
						<div
							style="width: 400px; background: #fff; margin: 100px auto; padding: 20px; border-radius: 12px;">
							<h4 style="margin-bottom: 15px;">지원할 이력서를 선택해주세요</h4>
							<ul id="modalResumeList"
								style="list-style: none; padding: 0; max-height: 300px; overflow-y: auto;">
							</ul>
							<div style="text-align: right; margin-top: 20px;">
								<button type="button" onclick="$('#resumeModal').hide()"
									style="padding: 8px 15px; border: none; background: #eee; border-radius: 6px; cursor: pointer;">취소</button>
								<button type="button" id="btnConfirmApply"
									style="padding: 8px 15px; border: none; background: #2563eb; color: #fff; border-radius: 6px; cursor: pointer;">지원하기</button>
							</div>
						</div>
					</div>

				</div>
			</div>
		</c:forEach>

		<c:if test="${empty jobList}">
			<div style="padding: 100px 0; color: #999;">등록된 구인공고가 없습니다.</div>
		</c:if>
	</div>

	<div class="pagination">
    <c:if test="${recordTotalCount > 0}">
        <fmt:parseNumber var="pageCount" value="${(recordTotalCount - 1) / recordCountPerPage + 1}" integerOnly="true" />
        <fmt:parseNumber var="tempStart" value="${(currentPage - 1) / naviCountPerPage}" integerOnly="true" />
        <c:set var="startNavi" value="${tempStart * naviCountPerPage + 1}" />
        <c:set var="endNavi" value="${startNavi + naviCountPerPage - 1}" />
        <c:if test="${endNavi > pageCount}">
            <c:set var="endNavi" value="${pageCount}" />
        </c:if>

        <%-- 공통 파라미터 문자열 생성 --%>
        <c:set var="query" value="&searchKeyword=${searchKeyword}&workDay=${param.workDay}&startTime=${param.startTime}&endTime=${param.endTime}" />

        <%-- [이전 묶음] 버튼 --%>
        <c:if test="${startNavi > 1}">
            <a href="/jobposts/jobpost?page=${startNavi - 1}${query}" class="page-link">&lt;</a>
        </c:if>

        <%-- [번호] 버튼 --%>
        <c:forEach var="i" begin="${startNavi}" end="${endNavi}">
            <a href="/jobposts/jobpost?page=${i}${query}"
                class="page-link ${currentPage == i ? 'active' : ''}">${i}</a>
        </c:forEach>

        <%-- [다음 묶음] 버튼 --%>
        <c:if test="${endNavi < pageCount}">
            <a href="/jobposts/jobpost?page=${endNavi + 1}${query}" class="page-link">&gt;</a>
        </c:if>
    </c:if>
</div>

	</div>
	</div>

	<c:if test="${type=='사업자'}">
		<button class="floating-write-btn"
			onclick="location.href='/jobposts/jobwrite'">
			<span class="material-symbols-outlined">edit</span> <span>공고올리기</span>
		</button>
	</c:if>

	<div class="container-footer">
		<p>© 2026 돈워리. All rights reserved.</p>
		<p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침
			| 이용약관 | 고객센터</p>
	</div>

	<script>
	$(function() {
	    /* [1] 위치(지역) 선택 관련 로직 */
	    loadSido();

	    // 위치별 버튼 클릭 시 레이어 토글
	    $('#btnLocation').on('click', function(e) {
	        e.stopPropagation();
	        $('#categoryLayer').hide(); // 직종 레이어는 닫기
	        $(this).toggleClass('active');
	        $('#locationLayer').stop().slideToggle(200);
	    });

	    // 지역 레이어 닫기 버튼
	    $('#layerClose').on('click', function() {
	        $('#btnLocation').removeClass('active');
	        $('#locationLayer').slideUp(200);
	    });

	    function loadSido() {
	        $.ajax({
	            url: "/location/getSido",
	            type: "get",
	            success: function(data) {
	                let html = '<li class="list-header">시·도</li>';
	                data.forEach(sido => {
	                    html += "<li>" + sido + "</li>";
	                });
	                $('#sidoList').html(html);
	            }
	        });
	    }

	    // 시/도 클릭 -> 구/군 로드
	    $(document).on('click', '#sidoList li:not(.list-header)', function() {
	        const sido = $(this).text().trim();
	        $(this).addClass('active').siblings().removeClass('active');
	        $.ajax({
	            url: "/location/getGugun",
	            data: { sido: sido },
	            success: function(data) {
	                let html = '<li class="list-header">시·구·군</li>';
	                data.forEach(gugun => { if(gugun) html += "<li>" + gugun + "</li>"; });
	                $('#gugunList').html(html);
	                $('#dongList').html('<li class="list-header">동·읍·면</li>');
	            }
	        });
	    });

	    // 구/군 클릭 -> 동/읍/면 로드
	    $(document).on('click', '#gugunList li:not(.list-header)', function() {
	        const sido = $('#sidoList li.active').text().trim();
	        const gugun = $(this).text().trim();
	        $(this).addClass('active').siblings().removeClass('active');
	        $.ajax({
	            url: "/location/getDong",
	            data: { sido: sido, gugun: gugun },
	            success: function(data) {
	                let html = '<li class="list-header">동·읍·면</li>';
	                data.forEach(dong => { html += "<li>" + dong + "</li>"; });
	                $('#dongList').html(html);
	            }
	        });
	    });

	    $(document).on('click', '#dongList li:not(.list-header)', function() {
	        $(this).addClass('active').siblings().removeClass('active');
	    });

	    // 지역 검색 실행
	    $('#btnLayerSearch').on('click', function() {
	        let sido = $('#sidoList li.active').text().trim();
	        let gugun = $('#gugunList li.active').text().trim();
	        let dong = $('#dongList li.active').text().trim();
	        if (!sido) { alert("지역을 선택해주세요."); return; }
	        let selectByLocation = sido + (gugun ? " " + gugun : "") + (dong ? " " + dong : "");
	        location.href = "/jobposts/selectByLocation?selectByLocation=" + encodeURIComponent(selectByLocation);
	    });


	    /* [2] 직종 선택 관련 로직 */
	    
	    // 직종별 버튼 클릭 시 레이어 토글
	    $('#btnCategory').on('click', function(e) {
	        e.stopPropagation();
	        $('#locationLayer').hide(); // 지역 레이어는 닫기
	        $('#categoryLayer').stop().slideToggle(200);
	        loadMainCategory(); // 열 때마다 새로고침
	    });

	    // 직종 레이어 닫기
	    $('.categoryLayerClose').on('click', function() {
	        $('#categoryLayer').slideUp(200);
	    });

	    function loadMainCategory() {
	        $.ajax({
	            url: "/jobposts/getUpperCategory",
	            success: function(data) {
	                let html = '<li class="list-header">대분류</li>';
	                data.forEach(cat => {
	                    // \${ } 형태로 수정!
	                    html += `<li data-id="\${cat.cat_id}">\${cat.cat_name}</li>`;
	                });
	                $('#mainCatList').html(html);
	            }
	        });
	    }

	    // 대분류 클릭 -> 소분류 로드
	    $(document).on('click', '#mainCatList li:not(.list-header)', function() {
    const pId = $(this).attr('data-id');
    $(this).addClass('active').siblings().removeClass('active');

    $.ajax({
        url: "/jobposts/getSubCategory",
        data: { parentId: pId },
        success: function(data) {
            let html = '<li class="list-header">소분류</li>';
            data.forEach(cat => {
                // 여기도 \${ } 형태로 수정!
                html += `<li data-id="\${cat.cat_id}">\${cat.cat_name}</li>`;
            });
            $('#subCatList').html(html);
        }
    });
});

	    $(document).on('click', '#subCatList li:not(.list-header)', function() {
	        $(this).addClass('active').siblings().removeClass('active');
	    });

	    // 직종 검색 실행
	    $('#btnCatSearch').on('click', function() {
	        const catName = $('#subCatList li.active').text().trim();
	        if(!catName) { alert("직종을 선택해주세요."); return; }
	        location.href = "/jobposts/jobpost?searchKeyword=" + encodeURIComponent(catName);
	    });


	    /* [3] 상단 검색창 공통 로직 */
	    $('.search-btn').on('click', function() {
	        let keyword = $('.search-wrapper input').val().trim();
	        location.href = (keyword === "") ? "/jobposts/jobpost" : "/jobposts/jobpost?searchKeyword=" + encodeURIComponent(keyword);
	    });

	    $('.search-wrapper input').on('keypress', function(e) {
	        if(e.keyCode === 13) $('.search-btn').click();
	    });

	    // 레이어 외부 클릭 시 닫기
	    $(document).on('click', function(e) {
	        if (!$(e.target).closest('.search-filter-wrap').length) {
	            $('#locationLayer, #categoryLayer').slideUp(200);
	            $('#btnLocation').removeClass('active');
	        }
	    });
	    
	    $('#btnCondition').on('click', function(e) {
	        e.stopPropagation();
	        $('#locationLayer, #categoryLayer').hide(); 
	        $('#timeLayer').stop().slideToggle(200);
	    });
	    
	    $('.timeLayerClose').on('click', function() {
	        $('#timeLayer').slideUp(200);
	    });
	    
	    $('#btnTimeSearch').on('click', function() {
	        const workDay = $('#searchWorkDay').val();
	        const startTime = $('#searchStartTime').val();
	        const endTime = $('#searchEndTime').val();
	        
	        let url = "/jobposts/jobpost?workDay=" + encodeURIComponent(workDay);
	        
	        // 시간이 둘 다 선택되었을 때만 파라미터 추가
	        if(startTime !== "" && endTime !== "") {
	            if(parseInt(startTime) >= parseInt(endTime)) {
	                alert("종료 시간은 시작 시간보다 이후여야 합니다.");
	                return;
	            }
	            url += "&startTime=" + startTime + "&endTime=" + endTime;
	        }
	        location.href = url;
	});
	    
	        // [1] 페이지 로드 시 서버로부터 온 알림 메시지 처리 (1회성)
	        // 컨트롤러에서 RedirectAttributes로 보낸 메시지는 여기서 딱 한 번만 띄운다.
	        const successMsg = "${message}";
	        const resumeMsg = "${resume}";
	        
	        if (successMsg !== "") alert(successMsg);
	        if (resumeMsg !== "") alert(resumeMsg);

	        // [2] 지원하기 버튼 클릭 시 (이력서 목록 가져오기)
	        let selectedJobSeq = null; 

	        $(".btn-apply").on("click", function() {
	            const loginId = "${loginId}";
	            selectedJobSeq = $(this).attr("data-seq");

	            if (!loginId || loginId === "" || loginId === "null") {
	                alert("로그인이 필요한 서비스입니다.");
	                location.href = "/members/toLogin";
	                return;
	            }

	            $.ajax({
	                url: "/jobapplys/getMyResumes",
	                type: "get",
	                success: function(resumes) {
	                    if (!resumes || resumes.length === 0) {
	                        alert("등록된 이력서가 없습니다. 이력서를 먼저 작성해주세요!");
	                        location.href = "/mypage/resume";
	                        return; // 로직 중단
	                    }

	                    let html = "";
	                    resumes.forEach(r => {
	                        html += `
	                            <li style="padding:10px; border-bottom:1px solid #eee;">
	                                <label style="cursor:pointer; display:block;">
	                                    <input type="radio" name="resumeIdx" value="\${r.seq}"> \${r.title}
	                                </label>
	                            </li>`;
	                    });
	                    
	                    $("#modalResumeList").html(html);
	                    $("#resumeModal").fadeIn(200); // 부드럽게 나타나기
	                },
	                error: function() {
	                    alert("이력서 목록을 가져오는 데 실패했습니다.");
	                }
	            });
	        });

	        // [3] 모달 내 '최종 지원하기' 버튼 클릭 시
	        $("#btnConfirmApply").on("click", function() {
	            const resumeNum = $("input[name='resumeIdx']:checked").val();
	            
	            if (!resumeNum) {
	                alert("지원하실 이력서를 선택해주세요.");
	                return;
	            }

	            // 서버로 전송 (여기서는 알림 메시지 체크를 하지 않음!)
	            location.href = `/jobapplys/insert?jobPostNum=\${selectedJobSeq}&resumeNum=\${resumeNum}`;
	        });

	        // [4] 모달 외부나 취소 버튼 클릭 시 닫기 기능 (추가 권장)
	        $(document).on("click", function(e) {
	            if ($(e.target).is("#resumeModal")) {
	                $("#resumeModal").fadeOut(200);
	            }
	        });
	});
	</script>
</body>
</html>