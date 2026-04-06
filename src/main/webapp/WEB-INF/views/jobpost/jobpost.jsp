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
	width: 75px;
	height: 30px;
	background-color: #ffffff;
	color: #868e96;
	border: 1px solid #dee2e6;
	border-radius: 6px;
	font-size: 13px;
	transition: all 0.2s ease;
	cursor: pointer;
	white-space: nowrap;
	display: inline-flex;
	align-items: center;
	justify-content: center;
}

.logout-btn:hover {
	background-color: #f8f9fa;
	color: #495057;
	border-color: #ced4da;
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
	font-weight: 600;
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
	max-width: 1000px;
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
	margin-top: -15px;
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
}

.job-badge {
	background: #eef2ff;
	color: #2563eb;
	padding: 2px 8px;
	border-radius: 4px;
	font-size: 12px;
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
</style>
</head>
<body>
	<div class="community-container">
		<div class="top-auth">
			<c:choose>
				<c:when test="${nickName==null}">
					<span style="font-size: 13px; color: #666; cursor: pointer;">
						<a href="/members/toLogin"
						style="text-decoration: none; color: black"> <i
							class="fa-regular fa-user fa-lg"
							style="color: rgb(203, 203, 203); margin-right: 5px;"></i>로그인
					</a>
					</span>
					<a href="/admin/admin_main" style="text-decoration: none;"><div
							class="now-admin">관리자</div></a>
				</c:when>
				<c:otherwise>
					<span style="font-size: 13px; color: #666; cursor: pointer;">
						<i class="fa-regular fa-user fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i>
						${nickName}님 환영합니다. <a href="/members/logout"
						style="text-decoration: none;">
							<button class="logout-btn" style="margin-left: 10px;">로그아웃</button>
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
				</c:otherwise>
			</c:choose>
		</div>

		<nav class="navbar">
			<div style="display: flex; align-items: center; gap: 40px;">
				<a href="/" class="logo">돈워리</a>
				<div class="nav-menu">
					<a href="/"> <i class="fa-solid fa-house fa-lg"></i> 홈
					</a> <a href="/salary/calendar"> <i
						class="fa-regular fa-calendar fa-lg"></i> 급여 캘린더
					</a> <a href="/jobposts/jobpost" class="active"> <i
						class="fa-solid fa-briefcase fa-lg"></i> 구인구직
					</a> <a href="/boards/mainboard_list"> <i
						class="fa-regular fa-message fa-lg"></i> 커뮤니티
					</a>
				</div>
			</div>
			<a class="my-page"
				href="${nickName==null ? 'members/toLogin' : '/mypage/toMypage'}">
				<i class="fa-solid fa-user-gear fa-lg"
				style="color: rgb(197, 197, 197);"></i> 마이페이지
			</a>
		</nav>

		<div class="job-section">
			<h2>
				<i class="fa-solid fa-briefcase"></i> 구인구직
			</h2>
			<p>나에게 맞는 알바를 찾아 보세요</p>

			<div class="search-filter-wrap">
				<div class="search-wrapper">
					<i class="fa-solid fa-magnifying-glass"></i> <input type="text"
						placeholder="어떤 지역의 알바를 찾으시나요?">
					<button class="search-btn">검색</button>
				</div>

				<div class="filter-group">
					<button class="filter-btn" id="btnLocation">
						<i class="fa-solid fa-location-dot"></i> 위치별 <i
							class="fa-solid fa-chevron-down"
							style="font-size: 12px; color: #ccc;"></i>
					</button>
					<button class="filter-btn">
						<i class="fa-solid fa-briefcase"></i> 직종별 <i
							class="fa-solid fa-chevron-down"
							style="font-size: 12px; color: #ccc;"></i>
					</button>
					<button class="filter-btn">
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
							<li>서울</li>
							<li>경기</li>
							<li>인천</li>
							<li>강원</li>
							<li>대전</li>
							<li>세종</li>
							<li>충남</li>
							<li>충북</li>
							<li>부산</li>
							<li>울산</li>
							<li>경남</li>
							<li>경북</li>
							<li>대구</li>
							<li>광주</li>
							<li>전남</li>
							<li>전북</li>
							<li>제주</li>
							<li>전국</li>
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
						<button class="filter-btn"
							style="padding: 8px 25px; background: #495057; color: white;">검색</button>
					</div>
				</div>
			</div>

			<div class="job-list">
				<c:forEach var="post" items="${list}">
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
							<div class="job-desc">${post.content}</div>

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
								<button class="btn-apply">지원하기</button>
								<button class="btn-detail"
									onclick="location.href='/jobposts/detail?seq=${post.seq}'">자세히
									보기</button>
							</div>
						</div>
					</div>
				</c:forEach>

				<c:if test="${empty list}">
					<div style="padding: 100px 0; color: #999;">등록된 구인공고가 없습니다.</div>
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

	<footer class="container-footer">
		<p>© 2026 돈워리. All rights reserved.</p>
		<p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 |
			고객센터</p>
	</footer>

	<script>
	$(function() {
		const areaData = {
			    '서울': { '강남구': ['삼성동', '역삼동'], '강동구': ['천호동', '성내동'], '마포구': ['망원동', '연남동'], '송파구': ['잠실동', '가락동'], '영등포구': ['여의도동', '당산동'] },
			    '경기': { '수원시': ['팔달구', '영통구'], '성남시': ['분당구', '수정구'], '부천시': ['옥길동', '범박동'], '고양시': ['일산동구', '덕양구'], '용인시': ['수지구', '기흥구'] },
			    '인천': { '남동구': ['구월동', '간석동'], '연수구': ['송도동', '동춘동'], '부평구': ['부평동', '산곡동'], '미추홀구': ['주안동', '숭의동'] },
			    '강원': { '춘천시': ['퇴계동', '석사동'], '원주시': ['단계동', '무실동'], '강릉시': ['교동', '포남동'] },
			    '대전': { '서구': ['둔산동', '갈마동'], '유성구': ['봉명동', '상대동'], '중구': ['은행동', '대흥동'] },
			    '세종': { '세종시': ['도담동', '아름동', '종촌동', '나성동', '고운동'] },
			    '충남': { '천안시': ['두정동', '불당동'], '아산시': ['배방읍', '탕정면'], '서산시': ['읍내동', '동문동'] },
			    '충북': { '청주시': ['가경동', '복대동'], '충주시': ['연수동', '교현동'], '제천시': ['중앙로', '의림동'] },
			    '부산': { '해운대구': ['우동', '중동'], '부산진구': ['서면', '부암동'], '사하구': ['하단동', '괴정동'], '수영구': ['광안동', '민락동'] },
			    '울산': { '남구': ['삼산동', '무거동'], '중구': ['성남동', '복산동'], '북구': ['화봉동', '천곡동'] },
			    '경남': { '창원시': ['상남동', '중앙동'], '김해시': ['내동', '외동'], '진주시': ['평거동', '가좌동'] },
			    '경북': { '포항시': ['죽도동', '두호동'], '구미시': ['원평동', '인동동'], '경주시': ['황남동', '성건동'] },
			    '대구': { '중구': ['동성로', '삼덕동'], '수성구': ['범어동', '만촌동'], '달서구': ['상인동', '월성동'] },
			    '광주': { '북구': ['용봉동', '운암동'], '상무지구': ['치평동', '금호동'], '광산구': ['수완동', '첨단동'] },
			    '전남': { '여수시': ['학동', '문수동'], '순천시': ['조례동', '연향동'], '목포시': ['상동', '용당동'] },
			    '전북': { '전주시': ['효자동', '송천동'], '군산시': ['나운동', '수송동'], '익산시': ['영등동', '모현동'] },
			    '제주': { '제주시': ['노형동', '연동'], '서귀포시': ['서귀동', '중문동'] },
			    '전국': { '전체': ['전국 공고 보기'] }
			};

        // 레이어 토글 기능 추가
        $('#btnLocation').on('click', function(e) {
            e.stopPropagation();
            $('#locationLayer').stop().slideToggle(200);
            $(this).toggleClass('active');
        });

        $('#layerClose').on('click', function() {
            $('#locationLayer').slideUp(200);
            $('#btnLocation').removeClass('active');
        });

        // 외부 클릭 시 닫기
        $(document).on('click', function(e) {
            if (!$(e.target).closest('.search-filter-wrap').length) {
                $('#locationLayer').slideUp(200);
                $('#btnLocation').removeClass('active');
            }
        });

		// [1단계] 시·도 클릭
		$(document).on('click', '#sidoList li:not(.list-header)', function() {
			const sido = $(this).text().trim();
			$(this).addClass('active').siblings().removeClass('active');

			let gugunHtml = '<li class="list-header">시·구·군</li>';
			const gugunMap = areaData[sido];

			if (gugunMap) {
				Object.keys(gugunMap).forEach(gugun => {
					gugunHtml += "<li>" + gugun + "</li>";
				});
			}
			$('#gugunList').html(gugunHtml);
			$('#dongList').html('<li class="list-header">동·읍·면</li>');
		});

		// [2단계] 시·구·군 클릭
		$(document).on('click', '#gugunList li:not(.list-header)', function() {
			const sido = $('#sidoList li.active').text().trim();
			const gugun = $(this).text().trim();
			$(this).addClass('active').siblings().removeClass('active');

			let dongHtml = '<li class="list-header">동·읍·면</li>';
			const dongList = areaData[sido][gugun];

			if (dongList) {
				dongList.forEach(dong => {
					dongHtml += "<li>" + dong + "</li>";
				});
			}
			$('#dongList').html(dongHtml);
		});

		// [3단계] 동 클릭
		$(document).on('click', '#dongList li:not(.list-header)', function() {
			$(this).addClass('active').siblings().removeClass('active');
		});
	});
	
	$(function() {
	    // 검색 버튼 클릭 이벤트
	    $('.search-btn').on('click', function() {
	        let keyword = $('.search-wrapper input').val().trim();
	        if(keyword === "") {
	        	location.href = "/jobposts/jobpost";
	        }
	        // 주소창에 검색어를 담아서 이동
	        location.href = "/jobposts/jobpost?searchKeyword=" + encodeURIComponent(keyword);
	    });

	    // 엔터키 입력 시에도 검색되게 추가
	    $('.search-wrapper input').on('keypress', function(e) {
	        if(e.keyCode === 13) {
	            $('.search-btn').click();
	        }
	    });
	});
	</script>
</body>
</html>