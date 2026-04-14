<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    // 브라우저 캐시를 방지하여 '뒤로 가기' 시 서버를 다시 호출하게 함
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>돈워리 - 구인 활동 관리</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

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

.my-page.active {
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

.top-action-left, .top-action-right {
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
	height: 456px;
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
	background: linear-gradient(45deg, transparent 48%, #94a3b8 49%, #94a3b8 51%,
		transparent 52%),
		linear-gradient(-45deg, transparent 48%, #94a3b8 49%, #94a3b8 51%,
		transparent 52%);
	background-color: #f8fafc;
	flex-shrink: 0;
}

.job-info {
	min-width: 0;
	padding-left: 10px;
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

.job-location, .job-date {
	font-size: 14px;
	color: #64748b;
}

.job-right {
	text-align: right;
	min-width: 190px;
	padding-right: 10px;
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
	margin-top: 16px;
	background: #f1f5ff; /* 연한 푸른색 */
	border-radius: 14px;
	padding: 12px 0;
	height: 250px;
	max-height: 250px;
	overflow-y: auto; /* 스크롤 */
}

.empty-applicant {
	text-align: center;
	padding: 80px 0;
	color: #94a3b8;
	font-size: 14px;
}

.applicant-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 14px 0;
	border-bottom: 1px solid #e5e7eb;
	margin-left: 10px;
	margin-right: 15px;
}

/*     .applicant-row:last-child { */
/*         border-bottom: none; */
/*     } */
.applicant-left {
	display: flex;
	align-items: flex-start;
	gap: 10px;
	margin-left: 20px;
}

.applicant-check {
	width: 17px;
	height: 17px;
	margin-top: 13px;
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

@media ( max-width : 900px) {
	.page {
		width: 100%;
	}
	.job-top, .applicant-row, .top-action-row {
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
	.top-action-left, .top-action-right {
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
					<i class="fa-regular fa-user fa-lg"
					style="color: rgb(203, 203, 203); margin-right: 5px;"></i>
					${nickName}님 환영합니다. <a href="/members/logout"
					style="text-decoration: none; color: black">
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
			</div>
		</c:if>

		<nav class="navbar">
			<div style="display: flex; align-items: center; gap: 40px;">
				<a href="/" class="logo">돈워리</a>
				<div class="nav-menu">
					<a href="/"> <i class="fa-solid fa-house fa-lg"
						style="color: rgb(203, 203, 203);"></i> 홈
					</a> <a href="/salary/calendar"> <i
						class="fa-regular fa-calendar fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 급여 캘린더
					</a> <a href="/jobposts/jobpost"> <i
						class="fa-solid fa-briefcase fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 구인구직
					</a> <a href="/boards/mainboard_list?page=1"> <i
						class="fa-regular fa-message fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 커뮤니티
					</a> <a href="/qna/qna?page=1"> <i
						class="fa-solid fa-question fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 고객지원
					</a>
				</div>
			</div>

			<a class="my-page active" href="/mypage/toMypage"> <i
				class="fa-solid fa-user-gear fa-lg"
				style="color: rgb(79, 103, 232);"></i> 마이페이지
			</a>
		</nav>

		<div class="page">


			<div class="comm-header">
				<i class="fa-solid fa-briefcase fa-4x"></i>
				<h5>나의 구인 공고</h5>
				<p>등록한 공고와 지원자 진행 상태를 한눈에 확인하세요</p>
			</div>

			<div class="top-action-row">
				<div class="top-action-left"></div>
				<div class="top-action-right">
					<!-- <button type="button" class="top-sub-btn">구직자 이력서 보기</button> 3차 프로젝트 미션-->
				</div>
			</div>

<!-- 			<nav class="tab-menu"> -->
<!-- 				<button class="tab-item active">진행 중 공고</button> -->
<!-- 				<button class="tab-item">마감 공고</button> -->
<!-- 			</nav> -->
			
			<nav class="tab-menu">
			    <button type="button"
			        class="tab-item ${status eq '진행중' ? 'active' : ''}"
			        onclick="location.href='/mypage/employ_activity?page=1&status=진행중'">
			        진행 중 공고
			    </button>
			
			    <button type="button"
			        class="tab-item ${status eq '마감' ? 'active' : ''}"
			        onclick="location.href='/mypage/employ_activity?page=1&status=마감'">
			        마감 공고
			    </button>
			</nav>

			<div class="search-box">
				<input type="text" class="search-input"
					placeholder="등록된 구인 공고 제목을 검색">
				<button type="button" class="search-btn">검색</button>
			</div>

			<section class="post-list">
				<div class="list-count">공고 내역 ${count }개</div>
				<c:forEach var="a" items="${allList }">
					<div class="post-card search-item">
						<div class="job-top">
							<div class="job-left">
								<div class="job-info">
									<div class="job-title">${a.title }</div>
									<div class="job-company">${a.company_name }</div>
									<div class="job-location">${a.sido } ${a.gugun } ${a.dong }</div>
									<div class="job-date">
										등록일
										<fmt:formatDate value="${a.write_date}" pattern="yyyy-MM-dd" />
									</div>
								</div>
							</div>

							<div class="job-right">
								<div class="job-meta">
									<div>시급 ${a.pay }</div>
									<div>시간 ${a.work_starttime } - ${a.work_endtime }</div>
									<div>근무요일 ${a.work_days }</div>
								</div>
								<div class="job-btns">
									<button type="button" class="blue-btn"
										onclick="location.href='/mypage/myjobpost?seq='+${a.seq}">공고
										상세</button>
								</div>
							</div>
						</div>
						<div class="applicant-list">

							<c:set var="applicants" value="${applicantMap[a.seq]}" />

							<c:choose>
								<c:when test="${empty applicants}">
									<div class="empty-applicant">지원자가 없습니다.</div>
								</c:when>

								<c:otherwise>
									<c:forEach var="e" items="${applicants}">
										<div class="applicant-row">
											<div class="applicant-left">
												<div>
													<div class="applicant-name">${e.name}</div>
													<div class="applicant-phone">${e.phone}</div>
												</div>
											</div>
											<div class="applicant-right">
												<c:if test="${not empty e.apply_status}">
													<span class="step-badge blue">${e.apply_status}</span>
												</c:if>
												<button type="button" class="dark-btn"
													onclick="location.href='/mypage/viewresume?apply_seq=${e.apply_seq}'">지원자
													관리</button>
											</div>
										</div>
									</c:forEach>
								</c:otherwise>

							</c:choose>

						</div>

					</div>
				</c:forEach>

			</section>

			<div class="page-nav"></div>


		</div>
	</div>

	<div class="container-footer">
		<p>© 2026 돈워리. All rights reserved.</p>
		<p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침
			| 이용약관 | 고객센터</p>
	</div>

	<script>

	
	let recordTotalCount = ${recordTotalCount}; // 총 개수
	let recordCountPerPage = ${recordCountPerPage}; // 한페이지에 몇개 (10)
	let naviCountPerPage  = ${naviCountPerPage }; // navi 몇개 (10)
	let currentPage = ${currentPage}; // 현재 페이지
	let pageTotalCount = Math.ceil(recordTotalCount/recordCountPerPage); 
	
	let startNavi = Math.floor((currentPage - 1) / naviCountPerPage) * naviCountPerPage +1;
	let endNavi = startNavi + naviCountPerPage - 1;
	
	if(endNavi > pageTotalCount){
		endNavi = pageTotalCount;
	}
	
	let needPrev = true;
	let needNext = true;
	
	if(startNavi == 1){
		needPrev = false;
	}
	if(endNavi == pageTotalCount){
		needNext = false;
	}
	if(needPrev){
		
		let span = $("<span>");
		span.addClass("material-symbols-outlined");
		span.css("font-size","16px");
		span.html("chevron_left");
		let a = $("<a>");
		a.addClass("page-num");
		a.attr("href","/mypage/mypost?page="+ (startNavi-1) + "&status=" + encodeURIComponent("${status}"));
		a.append(span);
		$(".page-nav").append(a);
	}
	
	for(let i = startNavi; i <= endNavi; i++){
		let a = $("<a>")
		a.attr("href" , "/mypage/employ_activity?page="+i + "&status=" + encodeURIComponent("${status}"));
		a.addClass("page-num");
		
		if (i == currentPage) {
	        a.addClass("active");
	    }
		a.html(i);
		$(".page-nav").append(a);
	}
	
	if(needNext){
		 
		 let span = $("<span>");
			span.addClass("material-symbols-outlined");
			span.css("font-size","16px");
			span.html("chevron_right");
			let a = $("<a>");
			a.addClass("page-num");
			a.attr("href","/mypage/mypost?page="+(endNavi+1) + "&status=" + encodeURIComponent("${status}"));
			a.append(span);
			$(".page-nav").append(a);
	}	

		if (needNext) {

			let span = $("<span>");
			span.addClass("material-symbols-outlined");
			span.css("font-size", "16px");
			span.html("chevron_right");
			let a = $("<a>");
			a.addClass("page-num");
			a.attr("href", "/mypage/employ_activity?page=" + (endNavi + 1) + "&status=" + encodeURIComponent(status));
			a.append(span);
			$(".page-nav").append(a);
		}

		$(function() { // 검색기능
			
			const loginUser = "${nickName}";
            if (!loginUser || loginUser === "") {
                alert("잘못된 접근입니다.");
                location.replace("/members/toLogin"); // 기록을 남기지 않고 이동
            }

			function doSearch() {
				const keyword = $(".search-input").val().toLowerCase().trim();
				let visibleCount = 0;

				// 검색어 없으면 전체 표시
				if (keyword === "") {
					$(".search-item").show();
					return;
				}

				$(".search-item").each(function() {
					const text = $(this).text().toLowerCase();

					if (text.includes(keyword)) {
						$(this).show();
						visibleCount++;
					} else {
						$(this).hide();
					}
				});

				// 검색 결과 없음
				if (visibleCount === 0) {
					$(".search-item").show();
					alert("검색 결과가 없습니다.");
				}
			}

			// 🔹 버튼 클릭 검색
			$(".search-btn").on("click", function() {
				doSearch();
			});

		});
		
	</script>
</body>
</html>