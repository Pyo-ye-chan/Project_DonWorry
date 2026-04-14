<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>돈워리 - 회원가입</title>
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
	display: block; /* flex 해제 */
	background-color: #ffffff;
	min-height: 100vh;
}

/* 레이아웃 컨테이너 */
.container {
	max-width: 1100px;
	width: 100%;
	margin: 0 auto;
	padding: 0 20px;
	flex: 1; /* 컨텐츠가 적을 때 푸터를 아래로 밀어주는 최소한의 장치 */
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

/* [4] 히어로 섹션 */
.hero {
	height: 300px;
	text-align: center;
	padding: 80px 0;
}

.hero-badge {
	background-color: #eff6ff;
	color: #2563eb;
	padding: 5px 15px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: bold;
	display: inline-block;
	margin-bottom: 20px;
}

.hero h1 {
	font-size: 42px;
	font-weight: 800;
	margin-bottom: 15px;
	line-height: 1.3;
}

.hero p {
	color: #888;
	margin-bottom: 35px;
}

.reg-btn {
	background-color: #2563eb;
	color: white;
	padding: 12px 25px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: bold;
	display: inline-block;
}
/* 1. 전체적인 분위기 (메인 페이지 스타일 계승) */
:root { -
	-primary-color: #0055FF; /* 메인 파란색 */ -
	-bg-color: #F4F6F9; /* 배경 회색 */ -
	-text-color: #333; -
	-border-radius: 12px; /* 둥글게 둥글게 */
}

body {
	font-family: 'Noto Sans KR', sans-serif; /* 깔끔한 폰트 */
	background-color: var(- -bg-color);
	margin: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	color: var(- -text-color);
}

/* 2. 가입 폼 컨테이너 */
.register-container {
	background-color: #fff;
	padding: 40px; /* 패딩 상하 조절 */
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
	width: 100%;
	max-width: 700px;
	margin: 35px auto; /* 상하 여백을 주고 가로 중앙 정렬 */
	text-align: center;
}

.input-row.rrn-email-row {
	display: flex;
	align-items: flex-end;
	gap: 8px;
	width: 100%;
}

/* 3. 타이틀 스타일 ("알바 급여 관리..." 느낌) */
.register-container h2 {
	font-size: 28px;
	font-weight: 700;
	margin-bottom: 10px;
	color: #000;
}

.register-container p {
	color: #666;
	margin-bottom: 25px;
	font-size: 16px;
}

/* 4. 입력 필드 스타일 (시원시원하게) */
.form-group {
	text-align: left;
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	font-weight: 500;
	margin-bottom: 5px;
	font-size: 15px;
}

.form-group input, .form-group select {
	width: 100%;
	padding: 15px;
	border: 1px solid #DDD;
	border-radius: var(- -border-radius);
	font-size: 16px;
	transition: all 0.3s;
	box-sizing: border-radius; /* 패딩 포함 크기 계산 */
}

.form-group input:focus, .form-group select:focus {
	outline: none;
	border-color: var(- -primary-color);
	box-shadow: 0 0 0 3px rgba(0, 85, 255, 0.1);
}

.form-group input {
	width: 100%;
	box-sizing: border-box; /* 패딩이 너비를 벗어나지 않게 */
}

/* 5. 주소/카테고리 선택 셀렉트 박스 (가로 배치) */
.address-group, .category-group {
	display: flex;
	gap: 10px; /* 셀렉트 박스 사이 간격 */
}

.address-group select, .category-group select {
	flex: 1; /* 너비 똑같이 나눔 */
}

/* 6. 가입하기 버튼 ("근무 일정 등록하기" 느낌) */
.submit-btn {
	width: 100%;
	padding: 18px;
	background-color: #9ca3af;
	color: #fff;
	border: none;
	border-radius: 50px; /* 아주 둥글게 */
	font-size: 18px;
	font-weight: 600;
	cursor: pointer;
	transition: background-color 0.3s, transform 0.1s;
	margin-top: 20px;
}

.submit-btn:hover {
	background-color: #0044CC;
}

.submit-btn:active {
	transform: scale(0.98); /* 클릭 시 꾹 누르는 효과 */
}

/* 하단 링크 */
.footer-link {
	margin-top: 30px;
	font-size: 14px;
	color: #888;
}

.footer-link a {
	color: var(- -primary-color);
	text-decoration: none;
}

.type-selector {
	display: flex;
	gap: 10px;
	margin-top: 10px;
}

.type-selector input[type="radio"] {
	display: none; /* 실제 체크박스는 숨김  */
}

.type-selector label {
	flex: 1;
	text-align: center;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 10px;
	cursor: pointer;
	transition: all 0.3s;
	background: #fff;
}
/* 체크되었을 때 스타일 */
.type-selector input[type="radio"]:checked+label {
	background: #0055FF;
	color: #fff;
	border-color: #0055FF;
	font-weight: bold;
}

.input-row {
	display: flex;
	gap: 15px; /* 이름과 닉네임 사이 간격 */
	width: 100%; /* 전체 너비 사용 */
}

.input-row>div {
	flex: 1; /* 1:1 비율로 나눔 */
	min-width: 0; /* ⭐ 매우 중요: 자식 요소가 부모보다 커지는 걸 방지 */
	display: flex;
	flex-direction: column;
}

.input-row input {
	width: 100% !important; /* 부모 div 너비에 무조건 맞춤 */
	box-sizing: border-box; /* 패딩 때문에 늘어나는 것 방지 */
}

.input-row button {
	flex: 1; /* 버튼은 적당하게 */
	white-space: nowrap; /* 글자 줄바꿈 방지 */
}

.id-check-group {
	display: flex;
	gap: 10px; /* 입력창과 버튼 사이 간격 */
}

.id-check-group input {
	flex: 1; /* 입력창이 남는 공간 다 차지 */
}

.id-check-btn, .email-check-btn, .check-btn {
	padding: 0 20px;
	background-color: #E6EEFF; /* 메인 파란색의 아주 연한 버전 */
	color: #0055FF; /* 글자는 진한 파란색 */
	border: 1px solid #0055FF;
	border-radius: 12px; /* 입력창이랑 똑같은 곡률 */
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s;
	white-space: nowrap; /* 글자 줄바꿈 방지 */
}

.id-check-btn:hover {
	background-color: #0055FF; /* 마우스 올리면 반전 */
	color: #fff;
}

#idCheck-box {
	display: none;
}

#pwCheck-box {
	color: #ff0000;
	margin-top: 10px;
	font-size: 14px;
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

/* --- 추가된 CSS 시작 --- */

/* 닉네임 중복확인 버튼을 아이디 중복확인 버튼과 동일한 크기로 맞춤 */
.nickname-check-btn {
	padding: 0 20px;
	background-color: #E6EEFF;
	color: #0055FF;
	border: 1px solid #0055FF;
	border-radius: 12px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s;
	white-space: nowrap;
}

.nickname-check-btn:hover {
	background-color: #0055FF;
	color: #fff;
}

/* 개별 행 사이의 간격 보정 */
.form-group {
	margin-bottom: 20px; /* 기존 15px에서 시각적 여백을 위해 살짝 확장 가능 */
}

/* --- 추가된 CSS 끝 --- */
</style>
</head>
<body>
	<div class="container">
		<c:choose>
			<c:when test="${nickName==null}">
				<div class="top-auth">
					<span style="font-size: 13px; color: #666; cursor: pointer;">
						<a href="/members/toLogin"
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
				<a href="/" class="logo"> 돈워리</a>
				<div class="nav-menu">
					<a href="/" class="active"> <i class="fa-solid fa-house fa-lg"
						style="color: rgb(36, 99, 235);"></i> 홈
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

		<div class="register-container">
			<div
				style="font-size: 24px; font-weight: 800; color: #0055FF; margin-bottom: 20px;">돈워리
				시작하기</div>

			<h2></h2>
			<p>쉽고 정확한 알바 관리, 지금 가입하세요.</p>


			<form action="/members/signup" method="post" id="form">

				<div class="form-group">
					<label>가입 유형</label>
					<div class="type-selector">
						<input type="radio" id="typeIndividual" name="type" value="개인"
							checked> <label for="typeIndividual">개인 회원</label> <input
							type="radio" id="typeBusiness" name="type" value="사업자"> <label
							for="typeBusiness">기업 회원</label>
					</div>
				</div>

				<div class="form-group">
					<label>아이디</label>
					<div class="id-check-group">
						<input type="text" placeholder="아이디를 입력해주세요" name="id"
							id="input-id" required>
						<button type="button" class="id-check-btn">중복확인</button>
					</div>
					<div id="idCheck-box"></div>
				</div>

				<div class="form-group">
					<label for="memberPw">비밀번호</label> <input type="password"
						id="memberPw" name="pw" placeholder="영문, 숫자 포함 8자 이상" required>
				</div>

				<div class="form-group">
					<label for="memberRePw">비밀번호 확인</label> <input type="password"
						id="memberRePw" name="memberRePw" placeholder="영문, 숫자 포함 8자 이상"
						required>
					<div id="pwCheck-box">비밀번호는 특수문자, 숫자, 대소문자가 최소 한글자씩은 포함되어야
						합니다.</div>
				</div>

				<div class="form-group">
					<label for="phone">전화번호</label> <input type="text" id="phone"
						name="phone" placeholder="전화번호를 입력해주세요 *숫자만 입력" required>
				</div>

				<div class="form-group">
					<label for="nickname">닉네임</label>
					<div class="id-check-group">
						<input type="text" id="nickname" name="nickname"
							placeholder="닉네임 입력 *2~10글자 내외" required>
						<button type="button" class="nickname-check-btn">중복확인</button>
					</div>
					<div id="nickNameCheck-box"></div>
				</div>

				<div class="form-group">
					<label for="name">이름</label> <input type="text" id="name"
						name="name" placeholder="실명 입력" required>
				</div>

				<div class="form-group" id="businessNumberGroup"
					style="display: none;">
					<label for="business_number">사업자 번호</label> <input type="text"
						id="business_number" name="business_number"
						placeholder="사업자 번호 입력 *숫자만 입력">
				</div>

				<div class="form-group rrn-item">
					<label for="rrn">생년월일</label> <input type="text" id="rrn"
						name="rrn" placeholder="6자리 입력 (예: 950101)" maxlength="6" required>
				</div>

				<div class="form-group">
					<label for="email">이메일</label>
					<div class="id-check-group">
						<input type="text" id="email" name="email" placeholder="이메일 주소 입력"
							required>
						<button type="button" id="sendAuthBtn" class="email-check-btn">인증요청</button>
					</div>
				</div>

				<div class="form-group" id="authCodeGroup" style="display: none;">
					<label for="authCode">인증번호</label>
					<div class="id-check-group">
						<input type="text" id="authCode" placeholder="인증번호 6자리 입력"
							maxlength="6">
						<button type="button" id="verifyBtn" class="check-btn">확인</button>
					</div>
					<div id="authCheck-box" style="margin-top: 5px; font-size: 14px;"></div>
				</div>

				<button type="submit" class="submit-btn">가입하기</button>
			</form>

			<div class="footer-link">
				이미 계정이 있으신가요? <a href="/members/toLogin">로그인</a>
			</div>


		</div>
		<div class="container-footer">
			<p>© 2026 돈워리. All rights reserved.</p>
			<p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침
				| 이용약관 | 고객센터</p>
		</div>

		<script>
			$(document).ready(function() {
				$('input[name="type"]').change(function() {
					if ($(this).val() === '사업자') {
						$('#businessNumberGroup').show();
						$('#business_number').prop('required', true);

						// 생년월일 관련 클래스(.rrn-item) 한꺼번에 숨기기
						$('.rrn-item').hide();
						$('#rrn').prop('required', false).val("");
					} else {
						$('#businessNumberGroup').hide();
						$('#business_number').prop('required', false).val("");

						// 생년월일 관련 클래스(.rrn-item) 다시 보이기
						// ※ .show() 대신 .css('display', 'flex')를 쓰면 레이아웃이 더 잘 유지돼!
						$('.rrn-item').show();
						$('#rrn').prop('required', true);
					}
				});

			});

			$(".id-check-btn").on("click", function() {
				const userId = $("#input-id").val();

				// 1. 빈값 체크
				if (userId === "") {
					alert("아이디를 입력하세요");
					$("#input-id").focus();
					return;
				}
				$.ajax({
					url : "/members/idCheck?id=" + userId,
					dataType : "json"
				}).done(function(idcheck) {
					if (idcheck == 0) {
						$("#idCheck-box").html("사용 가능한 아이디입니다.").css({
							"color" : "#2563eb",
							"display" : "block",
							"margin-top" : "10px",
							"font-size" : "14px"
						});
					} else {
						$("#idCheck-box").html("중복된 아이디 입니다.").css({
							"color" : "#ff0000",
							"display" : "block",
							"margin-top" : "10px",
							"font-size" : "14px"
						});
					}
				}).fail(function() {
					alert("서버 통신에 실패했습니다.");
				});
			});

			$(".nickname-check-btn").on("click", function() {
				const userNickName = $("#nickname").val();

				// 1. 빈값 체크
				if (userNickName === "") {
					alert("닉네임을 입력하세요");
					$("#nickname").focus();
					return;
				}
				$.ajax({
					url : "/members/nickNameCheck?nickname=" + userNickName,
					dataType : "json"
				}).done(function(nicknamecheck) {
					if (nicknamecheck == 0) {
						$("#nickNameCheck-box").html("사용 가능한 닉네임 입니다.").css({
							"color" : "#2563eb",
							"display" : "block",
							"margin-top" : "10px",
							"font-size" : "14px"
						});
					} else {
						$("#nickNameCheck-box").html("중복된 닉네임 입니다.").css({
							"color" : "#ff0000",
							"display" : "block",
							"margin-top" : "10px",
							"font-size" : "14px"
						});
					}
				}).fail(function() {
					alert("서버 통신에 실패했습니다.");
				});
			});

			$("#memberPw, #memberRePw")
					.on(
							"keyup",
							function() {
								let pw = $("#memberPw").val();
								let rePw = $("#memberRePw").val();

								if (pw == "" && rePw == "") {
									$("#pwCheck-box")
											.html(
													"비밀번호는 특수문자, 숫자, 대소문자가 최소 한글자씩은 포함되어야 합니다.");
								} else if (pw == rePw) {
									$("#pwCheck-box").html("비밀번호 일치").css({
										"color" : "#2563eb",
										"display" : "block",
										"margin-top" : "10px",
										"font-size" : "14px"
									});
								} else {
									$("#pwCheck-box").html("비밀번호 불일치").css({
										"color" : "#ff0000",
										"display" : "block",
										"margin-top" : "10px",
										"font-size" : "14px"
									});
								}
							});

			// 아이디 키업 정규식
			$("#input-id")
					.on(
							"keyup",
							function() {
								if (!/^[a-z][a-z0-9]{3,13}$/
										.test($("#input-id").val())) {
									$("#idCheck-box")
											.html(
													"ID는 영문 소문자, 숫자 포함 4~14자리 이내로 생성 가능합니다.")
											.css({
												"color" : "#ff0000",
												"display" : "block",
												"margin-top" : "10px",
												"font-size" : "14px"
											});
								} else {
									$("#idCheck-box").html("ID 조건이 충족되었습니다.")
											.css({
												"color" : "#2563eb",
												"display" : "block",
												"margin-top" : "10px",
												"font-size" : "14px"
											});
								}
							});

			// 서브밋 정규식
			$("#form")
					.on(
							"submit",
							function() {
								// 0. 현재 선택된 가입 유형 가져오기
								let type = $('input[name="type"]:checked')
										.val();

								// 1. 아이디 체크
								if (!/^[a-z][a-z0-9]{6,16}$/
										.test($("#input-id").val())) {
									alert("아이디는 영소문자로 시작하며 숫자 포함 6~16글자여야 합니다.");
									$("#input-id").focus();
									return false;
								}

								// 2. 비밀번호 체크
								if (!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{4,16}$/
										.test($("#memberPw").val())) {
									alert("비밀번호는 특수문자, 숫자, 대소문자가 최소 한글자씩 포함된 4~16자여야 합니다.");
									$("#memberPw").focus();
									return false;
								}

								// 3. 비밀번호 확인
								if ($("#memberPw").val() !== $("#memberRePw")
										.val()) {
									alert("비밀번호가 일치하지 않습니다.");
									$("#memberRePw").focus();
									return false;
								}

								// 4. 전화번호 체크
								if (!/^010[0-9]{4}\d{4}$/.test($("#phone")
										.val())) {
									alert("전화번호 형식이 올바르지 않습니다. (예: 01012345678)");
									$("#phone").focus();
									return false;
								}

								// 5. 이름 체크
								if (!/^[가-힣a-zA-Z]{2,6}$/
										.test($("#name").val())) {
									alert("이름은 2~6자의 한글 또는 영문만 입력 가능합니다.");
									$("#name").focus();
									return false;
								}

								// 6. 닉네임 체크
								if (!/^[a-zA-Z가-힣0-9]{2,10}$/.test($(
										"#nickname").val())) {
									alert("닉네임은 한글, 영문, 숫자 포함 2~10글자 이내로 작성 가능합니다.");
									$("#nickname").focus();
									return false;
								}

								// --- 유형별 선택적 체크 ---
								if (type === "사업자") {
									// 사업자일 때만 사업자 번호 체크
									if (!/^[0-9]{10}$/.test($(
											"#business_number").val())) {
										alert("사업자번호 10자리를 숫자만 입력해주세요.");
										$("#business_number").focus();
										return false;
									}
								} else {
									// 개인일 때만 생년월일 및 성별 체크
									if (!/^([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])$/
											.test($("#rrn").val())) {
										alert("생년월일 형식이 올바르지 않습니다. (예: 950101)");
										$("#rrn").focus();
										return false;
									}
									//         if (!/^[1-4]{1}$/.test($("#rrn_back").val())) {
									//             alert("성별 코드가 올바르지 않습니다. (1~4 사이의 숫자 1자리)");
									//             $("#rrn_back").focus();
									//             return false;
									//         }
								}

								// 7. 이메일 체크
								// 								if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
								// 										.test($("#email").val())) {
								// 									alert("올바른 이메일 주소 형식이 아닙니다.");
								// 									$("#email").focus();
								// 									return false;
								// 								}

								return true; // 모든 검사 통과 시 전송
							});

			//이메일 인증
			$('#sendAuthBtn').click(
					function() {
						let email = $('#email').val();

						// 이메일 유효성 체크 (기존 정규식 활용)
						if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
								.test(email)) {
							alert("올바른 이메일 형식을 입력해주세요.");
							return;
						}

						const btn = $(this);

						// [중요] 재발송 연타 방지: 버튼 비활성화
						btn.prop('disabled', true).text("발송 중...");

						$.ajax({
							url : "/members/sendAuthCode",
							type : "POST",
							data : {
								email : email
							},
							success : function(res) {
								if (res === "success") {
									alert("인증번호가 발송되었습니다. (재발송 포함)");
									$('#authCodeGroup').fadeIn();
									btn.text("재발송"); // 버튼 텍스트를 재발송으로 변경
								} else if (res === "already_exists") {
									alert("이미 가입된 이메일입니다.");
									btn.text("인증요청");
								} else {
									alert("메일 발송 실패!");
									btn.text("재발송");
								}
							},
							error : function() {
								alert("서버 오류 발생");
								btn.text("재발송");
							},
							complete : function() {
								// 발송이 끝나면 다시 버튼 활성화 (3~5초 정도 딜레이를 주면 더 좋아)
								setTimeout(function() {
									btn.prop('disabled', false);
								}, 3000);
							}
						});
					});

			// [인증번호 확인 버튼 클릭 이벤트]
			$("#verifyBtn").on(
					"click",
					function() {
						const inputCode = $("#authCode").val(); // 사용자가 입력한 번호
						const authBox = $("#authCheck-box"); // 결과를 보여줄 영역 (아래 HTML 참고)

						if (inputCode === "") {
							alert("인증번호를 입력해주세요.");
							$("#authCode").focus();
							return;
						}

						$.ajax({
							url : "/members/verifyAuthCode",
							type : "POST",
							data : {
								inputCode : inputCode
							}, // 컨트롤러의 파라미터명과 맞춰야 함
							success : function(res) {
								if (res === "success") {
									alert("인증에 성공했습니다!");
									// 성공 시 처리
									$("#authCode").prop("readonly", true); // 입력창 잠그기
									$("#verifyBtn").prop("disabled", true)
											.text("인증완료");
									$("#email").prop("readonly", true); // 이메일 수정 방지
									$("#sendAuthBtn").prop("disabled", true);

									// 가입하기 버튼 활성화용 플래그 (선택사항)
									isEmailAuth = true;
								} else {
									alert("인증번호가 일치하지 않습니다. 다시 확인해주세요.");
									$("#authCode").val("").focus();
								}
							},
							error : function() {
								alert("서버 통신 실패!");
							}
						});
					});
		</script>
</body>
</html>