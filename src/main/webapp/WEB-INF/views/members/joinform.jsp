<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>돈워리 - 회원가입</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
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
	padding: 10px 40px;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05); /* 은은한 그림자 */
	width: 100%;
	max-width: 500px; /* 너무 넓지 않게 */
	text-align: center;
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
	background-color: var(- -primary-color);
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

.id-check-btn {
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
</style>
</head>
<body>

	<div class="register-container">
		<div
			style="font-size: 24px; font-weight: 800; color: #0055FF; margin-bottom: 20px;">돈워리
			시작하기</div>

		<h2></h2>
		<p>쉽고 정확한 알바 관리, 지금 가입하세요.</p>


		<form action="/members/signup" method="post">

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
					<input type="text" placeholder="아이디를 입력해주세요" name="id">
					<button type="button" class="id-check-btn">중복확인</button>
				</div>
			</div>

			<div class="form-group">
				<label for="memberPw">비밀번호</label> <input type="password"
					id="memberPw" name="pw" placeholder="영문, 숫자 포함 8자 이상" required>
			</div>

			<div class="form-group">
				<label for="memberRePw">비밀번호 확인</label> <input type="password"
					id="memberRePw" name="memberRePw" placeholder="영문, 숫자 포함 8자 이상"
					required>
			</div>

			<div class="form-group">
				<label for="phone">전화번호</label> <input type="text" id="phone"
					name="phone" placeholder="영문, 숫자 포함 8자 이상" required>
			</div>

			<div class="form-group">
				<div class="input-row">
					<div style="flex: 1; display: flex; flex-direction: column;">
						<label for="name">이름</label> <input type="text" id="name"
							name="name" placeholder="실명 입력" required>
					</div>

					<div style="flex: 1; display: flex; flex-direction: column;">
						<label for="nickname">닉네임</label> <input type="text" id="nickname"
							name="nickname" placeholder="닉네임 입력" required>
					</div>
				</div>
			</div>

			<div class="form-group" id="businessNumberGroup"
				style="display: none;">
				<label for="business_number">사업자 번호</label> <input type="text"
					id="business_number" name="business_number" placeholder="사업자 번호 입력">
			</div>

			<div class="form-group">
				<div class="input-row"
					style="display: flex; align-items: flex-end; gap: 8px; width: 100%;">

					<div class="rrn-item"
						style="flex: 2; display: flex; flex-direction: column;">
						<label for="rrn_front">생년월일</label> <input type="text"
							id="rrn_front" name="rrn_front" placeholder="6자리 입력"
							maxlength="6" required>
					</div>

					<span class="rrn-item"
						style="margin-bottom: 12px; font-weight: 800; color: #9ca3af;">-</span>

					<div class="rrn-item"
						style="flex: 1; display: flex; flex-direction: column;">
						<input type="text" id="rrn_back" name="rrn_back" placeholder="1"
							maxlength="1" required style="text-align: center;">
					</div>

					<div
						style="flex: 3; display: flex; flex-direction: column; margin-left: 5px;">
						<label for="email">이메일</label> <input type="text" id="email"
							name="email" placeholder="이메일 입력" required>
					</div>
				</div>
			</div>

			<!--   <div class="form-group">
				<label>희망 근무 지역</label>
				<div class="address-group">
					<select name="sido" id="sido">
						<option value="">시/도 선택</option>
						<option value="서울특별시">서울특별시</option>
						<option value="부산광역시">부산광역시</option>
						<option value="대구광역시">대구광역시</option>
						<option value="인천광역시">인천광역시</option>
						<option value="광주광역시">광주광역시</option>
						<option value="대전광역시">대전광역시</option>
						<option value="울산광역시">울산광역시</option>
						<option value="세종특별자치시">세종특별자치시</option>
						<option value="경기도">경기도</option>
						<option value="강원특별자치도">강원특별자치도</option>
						<option value="충청북도">충청북도</option>
						<option value="충청남도">충청남도</option>
						<option value="전라북도">전라북도</option>
						<option value="전라남도">전라남도</option>
						<option value="경상북도">경상북도</option>
						<option value="경상남도">경상남도</option>
						<option value="제주특별자치도">제주특별자치도</option>
					</select> <select name="gugun" id="gugun">
						<option value="">구/군 선택</option>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label>관심 알바 업종</label>
				<div class="category-group">
					<select name="mainCategory" id="mainCategory">
						<option value="">대분류</option>
						<option value="100">외식·음료</option>
						<option value="200">매장관리·판매</option>
						<option value="300">서비스·문화</option>
						<option value="400">사무·교육</option>
						<option value="500">생산·물류</option>
						<option value="600">IT·디자인</option>
					</select> <select name="subCategory" id="subCategory">
						<option value="">소분류</option>
					</select>
				</div>
			</div> -->

			<button type="submit" class="submit-btn">가입하기</button>
		</form>

		<div class="footer-link">
			이미 계정이 있으신가요? <a href="#">로그인</a>
		</div>
	</div>

	<script>
	$(document).ready(function() {
	    // ... 기존 라디오 버튼 클릭 로직 유지 ...

	    $('input[name="type"]').change(function() {
	        if ($(this).val() === '사업자') {
	            $('#businessNumberGroup').show();
	            $('#business_number').prop('required', true);
	            
	            // 생년월일 관련 클래스(.rrn-item) 한꺼번에 숨기기
	            $('.rrn-item').hide();
	            $('#rrn_front, #rrn_back').prop('required', false).val("");
	        } else {
	            $('#businessNumberGroup').hide();
	            $('#business_number').prop('required', false).val("");
	            
	            // 생년월일 관련 클래스(.rrn-item) 다시 보이기
	            // ※ .show() 대신 .css('display', 'flex')를 쓰면 레이아웃이 더 잘 유지돼!
	            $('.rrn-item').show();
	            $('#rrn_front, #rrn_back').prop('required', true);
	        }
	    });
	});
</script>

</body>
</html>