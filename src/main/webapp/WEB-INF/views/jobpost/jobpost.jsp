<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</style>
</head>
<body>

	<div class="container">
		<div class="top-auth">
			<span style="font-size: 13px; color: #666; cursor: pointer;">
				<a href="members/login" style="text-decoration: none; color: black">
					<i class="fa-regular fa-user fa-lg"
					style="color: rgb(203, 203, 203); margin-right: 5px;"></i>로그인
			</a>
			</span>
			<!-- 일단 관리자 빼고 다 숨겨둠 -->
			<div class="now-admin">관리자</div>
			<div class="now-business" style="display: none;">기업</div>
			<div class="now-personal" style="display: none;">개인</div>
		</div>
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
					</a> <a href="#"> <i class="fa-regular fa-message fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 커뮤니티
					</a>
				</div>
			</div>
			<a class="my-page" href="#"> <i
				class="fa-solid fa-user-gear fa-lg"
				style="color: rgb(197, 197, 197);"></i> 마이페이지
			</a>
		</nav>




		<div class="container-footer">
			<p>© 2026 돈워리. All rights reserved.</p>
			<p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 |
				고객센터</p>
		</div>
	</div>
</body>
</html>