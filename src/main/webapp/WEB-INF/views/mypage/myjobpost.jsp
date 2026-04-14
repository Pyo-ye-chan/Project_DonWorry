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
<title>돈워리 - 내 공고 상세</title>

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

.my-page.active {
	color: #4f67e8;
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

.detail-wrap {
	display: flex;
	flex-direction: column;
	gap: 22px;
}

.detail-main-card {
	background-color: #ffffff;
	border: 1px solid #e5e7eb;
	border-radius: 20px;
	padding: 28px;
	box-shadow: 0 2px 10px rgba(15, 23, 42, 0.03);
}

.detail-top {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	gap: 24px;
	padding-bottom: 22px;
	border-bottom: 1px solid #eef2f7;
}

.detail-left {
	flex: 1;
	min-width: 0;
}

.detail-company {
	font-size: 15px;
	color: #475569;
	margin-bottom: 6px;
	font-weight: 600;
	padding-left: 13px;
}

.detail-title {
	font-size: 30px;
	font-weight: 800;
	color: #1e293b;
	line-height: 1.3;
	margin-bottom: 14px;
	word-break: keep-all;
	padding-left: 10px;
}

.detail-pay {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	color: #4f67e8;
	font-size: 24px;
	font-weight: 800;
	border-radius: 14px;
	padding-left: 10px;
}

.detail-right {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	gap: 10px;
	min-width: 180px;
}

.post-date-badge {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	color: #64748b;
	padding: 8px 12px;
	font-size: 13px;
	font-weight: 600;
}

.action-btn-group {
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
	justify-content: flex-end;
}

.line-btn {
	background-color: #ffffff;
	color: #64748b;
	border: 1px solid #dbe2ea;
	padding: 11px 18px;
	border-radius: 10px;
	font-weight: 600;
	cursor: pointer;
	font-size: 14px;
	transition: all 0.2s ease;
}

.line-btn:hover {
	background-color: #f8fafc;
	color: #475569;
	border-color: #cbd5e1;
}

.blue-btn {
	background-color: #4f67e8;
	color: #ffffff;
	border: none;
	padding: 11px 18px;
	border-radius: 10px;
	font-weight: 700;
	cursor: pointer;
	font-size: 14px;
	transition: all 0.2s ease;
}

.blue-btn:hover {
	background-color: #4258cf;
}

.detail-info-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 16px;
	margin-top: 24px;
}

.info-card {
	background: #f8fbff;
	border: 1px solid #e6edf8;
	border-radius: 16px;
	padding: 8px 20px;
}

.info-label {
	font-size: 13px;
	color: #64748b;
	margin-bottom: 8px;
	font-weight: 700;
	display: flex;
	align-items: center;
	gap: 8px;
}

.info-value {
	font-size: 15px;
	color: #1e293b;
	font-weight: 600;
	word-break: keep-all;
}

.content-card {
	background-color: #ffffff;
	border: 1px solid #e5e7eb;
	border-radius: 20px;
	padding: 26px 28px;
	box-shadow: 0 2px 10px rgba(15, 23, 42, 0.03);
}

.section-title {
	font-size: 20px;
	font-weight: 800;
	color: #1e293b;
	margin-bottom: 18px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.section-title::before {
	content: "";
	width: 5px;
	height: 22px;
	border-radius: 999px;
	background-color: #4f67e8;
	display: inline-block;
}

.content-body {
	background: #fbfcfe;
	border: 1px solid #eef2f7;
	border-radius: 14px;
	padding: 20px;
	color: #334155;
	font-size: 15px;
	line-height: 1.9;
	min-height: 140px;
	white-space: pre-line;
}

.bottom-action-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 12px;
	margin-top: 10px;
	flex-wrap: wrap;
}

.bottom-left-btns {
	display: flex;
	gap: 12px;
	flex-wrap: wrap;
}

.red-btn {
	background-color: #ef4444;
	color: #ffffff;
	border: none;
	padding: 12px 22px;
	border-radius: 10px;
	font-weight: 700;
	cursor: pointer;
	font-size: 14px;
	transition: all 0.2s ease;
}

.red-btn:hover {
	background-color: #dc2626;
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
	.detail-top {
		flex-direction: column;
		align-items: flex-start;
	}
	.detail-right {
		align-items: flex-start;
		width: 100%;
	}
	.action-btn-group {
		justify-content: flex-start;
	}
	.detail-info-grid {
		grid-template-columns: 1fr;
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
				<i class="fa-solid fa-rectangle-list fa-4x"></i>
				<h5>공고 상세</h5>
				<p>등록한 공고의 상세 내용을 확인하고 관리할 수 있어요</p>
			</div>

			<div class="detail-wrap">
				<div class="detail-main-card">
					<div class="detail-top">
						<div class="detail-left">
							<div class="detail-company">${post.company_name}</div>
							<div class="detail-title">${post.title}</div>
							<div class="detail-pay">

								시급
								<fmt:formatNumber value="${post.pay}" pattern="#,###" />
								원
							</div>
						</div>

						<div class="detail-right">
							<div class="post-date-badge">
								<i class="fa-regular fa-calendar"></i> 등록일
								<fmt:formatDate value="${post.write_date}" pattern="yyyy-MM-dd" />
							</div>

						</div>
					</div>

					<div class="detail-info-grid">
						<div class="info-card">
							<div class="info-label">
								<i class="fa-solid fa-location-dot"></i> 근무지
							</div>
							<div class="info-value">${post.sido} ${post.gugun}
								${post.dong} ${post.address_detail}</div>
						</div>

						<div class="info-card">
							<div class="info-label">
								<i class="fa-solid fa-user-group"></i> 모집인원
							</div>
							<div class="info-value">${post.count}명</div>
						</div>

						<div class="info-card">
							<div class="info-label">
								<i class="fa-regular fa-clock"></i> 근무시간
							</div>
							<div class="info-value">${post.work_starttime} -
								${post.work_endtime}</div>
						</div>

						<div class="info-card">
							<div class="info-label">
								<i class="fa-solid fa-calendar-days"></i> 근무요일
							</div>
							<div class="info-value">${post.work_days}</div>
						</div>

						<div class="info-card">
							<div class="info-label">
								<i class="fa-solid fa-layer-group"></i> 카테고리
							</div>
							<div class="info-value">${post.main_category_name} /
								${post.sub_category_name}</div>
						</div>

						<div class="info-card">
							<div class="info-label">
								<i class="fa-solid fa-phone"></i> 연락처
							</div>
							<div class="info-value">${post.phone}</div>
						</div>
					</div>
				</div>

				<div class="content-card">
					<div class="section-title">상세 모집요강</div>
					<div class="content-body">${post.content}</div>
				</div>

				<div class="content-card">
					<div class="section-title">복리후생</div>
					<div class="content-body">${post.benefit}</div>
				</div>

			<div class="bottom-action-row">
			    <div class="bottom-left-btns">
					<c:if test="${post.status eq '진행중'}">
				    <button type="button" class="red-btn deadBtn" id="deadBtn">
				        공고 마감
				    </button>
				    </c:if>			    	   
			        <c:if test="${post.status eq '진행중'}">
			        <button type="button" id="updateBtn" class="blue-btn">
			            수정하기
			        </button>
			        </c:if>
			    </div>
				 <button type="button" class="line-btn" onclick="location.href='/mypage/employ_activity?page=1'">
			            목록
			     </button>
			</div>
			</div>
		</div>
	</div>

	<div class="container-footer">
	
		<p>© 2026 돈워리. All rights reserved.</p>
		<p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침
			| 이용약관 | 고객센터</p>
	</div>

<script>
$("#updateBtn").on("click", function() {
    let applicantSize = ${dto.size()};

    if(applicantSize > 0){
        alert("수정할 수 없는 공고입니다.");
    }else{
        location.href = "/mypage/myjobpost_update?seq=${post.seq}";
    }
});

$("#deadBtn").on("click", function() {
    location.href = "/mypage/jobpost_close?seq=${post.seq}"; 
});

$(document).ready(function() {
	const loginUser = "${nickName}";
    if (!loginUser || loginUser === "") {
        alert("잘못된 접근입니다.");
        location.replace("/members/toLogin"); // 기록을 남기지 않고 이동
    }
})
</script>	

</body>
</html>