<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    // 브라우저 캐시를 방지하여 '뒤로 가기' 시 서버를 다시 호출하게 함
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
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
	
	display: flex; /* 풋터 하단 이동 */
    flex-direction: column;
    min-height: 100vh;  /* 있으면 더 안정 */
}

/* 레이아웃 컨테이너 */
.container {
        max-width: 1100px;
        width: 100%;
        margin: 0 auto;
        padding: 0 20px;
        flex: 1;
}
/* 로그인 및 관리자 */
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

.my-page.active {
	color: #4f67e8;
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

.now-business, .now-personal, .now-admin {
	width: 60px;
	height: 30px;
	background-color: #2563eb;
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 6px;
	border: none;
	font-size: 13px;
	cursor: pointer;
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

/* =========================
   본문 영역
========================= */
.page-section {
        padding: 56px 0 72px;
        width: 70%;
        margin: auto;
}

.page-inner {
	max-width: 760px;
	margin: 0 auto;
}

.page-title {
	font-size: 24px;
	font-weight: 800;
	color: #222;
}

.page-subtext {
	margin-top: 6px;
	font-size: 14px;
	color: #666;
	padding-bottom: 10px;
	border-bottom: 1px solid #e5e7eb;
}

.ui-guide {
	margin-top: 18px;
	padding: 14px 16px;
	background: #f8fafc;
	border: 1px solid #e5e7eb;
	border-radius: 10px;
}

.ui-guide p {
	font-size: 14px;
	color: #4b5563;
	margin-bottom: 4px;
}

.ui-guide p:last-child {
	margin-bottom: 0;
}

.ui-guide span {
	color: #2563eb;
	font-weight: 600;
}

/* form */
.ui-form-box {
	margin-top: 14px;
	border: 1px solid #d9dee5;
	border-radius: 14px;
	overflow: hidden;
	background: #fff;
}

.ui-form-row {
	display: flex;
	min-height: 60px;
	border-bottom: 1px solid #e5e7eb;
}

.ui-form-row:last-child {
	border-bottom: none;
}

.ui-form-label {
	width: 140px;
	background: #fafafa;
	border-right: 1px solid #e5e7eb;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 14px;
	font-weight: 600;
	color: #374151;
}

.ui-form-value {
	flex: 1;
	padding: 12px 16px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	font-size: 14px;
	color: #222;
}

.ui-inline {
	display: flex;
	gap: 8px;
	align-items: center;
}

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

.ui-message {
	padding-left: 5px;
}

.ui-input:focus {
	border-color: #94a3b8;
	box-shadow: 0 0 0 3px rgba(148, 163, 184, 0.10);
}

.ui-btn {
	height: 38px;
	border: 1px solid #cfd6df;
	border-radius: 8px;
	background: #fff;
	color: #222;
	font-size: 14px;
	font-weight: 700;
	cursor: pointer;
	transition: 0.15s ease;
	padding: 0 14px;
	white-space: nowrap;
}

.ui-btn:hover {
	background: #f8fafc;
}

.ui-btn-primary {
	background: #2563eb;
	border-color: #2563eb;
	color: #fff;
}

.ui-btn-primary:hover {
	background: #1d4ed8;
	border-color: #1d4ed8;
}

.ui-message {
	margin-top: 8px;
	font-size: 13px;
	color: #777;
}

.ui-actions {
	display: flex;
	justify-content: flex-end;
	gap: 8px;
	margin-top: 14px;
}
</style>
</head>
<body>
	<div class="container">
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

		<nav class="navbar">
        <div style="display: flex; align-items: center; gap: 40px;">
            <a href="/" class="logo"> 돈워리</a>
            <div class="nav-menu">
                <a href="/"> 
                    <i class="fa-solid fa-house fa-lg" style="color: rgb(203, 203, 203);"></i>
                    홈
                </a>
                <a href="/salary/calendar">
                    <i class="fa-regular fa-calendar fa-lg" style="color:rgb(203, 203, 203); margin-right:5px;"></i>
                    급여 캘린더
                    </a>
                <a href="/jobposts/jobpost"> 
                    <i class="fa-solid fa-briefcase fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    구인구직
                </a>
                <a href="/boards/mainboard_list"> 
                    <i class="fa-regular fa-message fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i> 
                    커뮤니티
                </a>  
                <a href="/qna/qna"> 
                    <i class="fa-solid fa-question fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    고객지원
                </a>               
            </div>           
        </div>   
        <a class="my-page active" href="/mypage/toMypage"> 
            <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(36, 99, 235);"></i>
            마이페이지
        </a>    
    </nav>

		<div class="page-section">
			<div class="page-inner">
				<div class="page-title">회원탈퇴</div>
				<div class="page-subtext">돈워리 서비스를 이용해주셔서 감사합니다.</div>

				<div class="ui-guide">
					<p>비밀번호 확인 후 회원탈퇴를 진행해 주세요.</p>
					<p>탈퇴 후에는 동일 계정으로 복구가 어려울 수 있습니다.</p>
					<p>
						문의는 <span>donWorry@gmail.com</span> 으로 보내주세요.
					</p>
				</div>

				<div class="ui-form-box">
					<div class="ui-form-row">
						<div class="ui-form-label">아이디</div>
						<div class="ui-form-value">${loginId }</div>
					</div>

					<div class="ui-form-row">
						<div class="ui-form-label">비밀번호</div>
						<div class="ui-form-value">
							<div class="ui-inline">
								<input type="password" id="memberPw" name="memberPw"
									class="ui-input" placeholder="비밀번호를 입력하세요">
								<button type="button" id="passwordBtn" class="ui-btn">확인</button>
							</div>
							<div id="pwCheckMsg" class="ui-message">비밀번호 확인이 필요합니다.</div>
						</div>
					</div>
				</div>

				<div class="ui-actions">
					<button type="button" class="ui-btn ui-btn-primary"
						id="withdrawBtn">탈퇴하기</button>
					<button type="button" class="ui-btn" onclick="history.back()">취소</button>
				</div>
			</div>
		</div>

	</div>

	<div class="container-footer">
		<p>© 2026 돈워리. All rights reserved.</p>
		<p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 |
			고객센터</p>
	</div>
	<script>
let isPasswordVerified = false;

$("#passwordBtn").on("click", function() {
    let memberPw = $("#memberPw").val();

    if (memberPw === "") {
        $("#pwCheckMsg").text("비밀번호를 입력해주세요.").css("color", "#d9534f");
        isPasswordVerified = false;
        return;
    }

    $.ajax({
        url: "/mypage/passwordCheck",
        type: "post",
        data: {
            memberPw: memberPw
        },
        dataType: "json"
    }).done(function(resp) {
        if (resp == true) {
            $("#pwCheckMsg").text("비밀번호가 확인되었습니다.").css("color", "#2563eb");
            isPasswordVerified = true;
        } else {
            $("#pwCheckMsg").text("비밀번호가 일치하지 않습니다.").css("color", "#d9534f");
            isPasswordVerified = false;
        }
    }).fail(function() {
        $("#pwCheckMsg").text("비밀번호 확인 중 오류가 발생했습니다.").css("color", "#d9534f");
        isPasswordVerified = false;
    });
});

$("#memberPw").on("input", function() {
    isPasswordVerified = false;
    $("#pwCheckMsg").text("비밀번호 확인이 필요합니다.").css("color", "#666");
});

$("#withdrawBtn").on("click", function() {
    if (!isPasswordVerified) {
        alert("비밀번호 확인 후 회원 탈퇴가 가능합니다.");
        return;
    }

    if (!confirm("정말 회원 탈퇴를 진행하시겠습니까?")) {
        return;
    }

    $.ajax({
        url: "/mypage/withdraw",
        type: "post",
        data: {
            memberPw: $("#memberPw").val()
        }
    }).done(function(resp) {
        alert("회원 탈퇴가 완료되었습니다.");
        location.href = "/";
    }).fail(function() {
        alert("회원 탈퇴 처리 중 오류가 발생했습니다.");
    });
});

$(document).ready(function(){
	const loginUser = "${nickName}";
    if (!loginUser || loginUser === "") {
        alert("로그인이 필요한 서비스입니다.");
        location.replace("/members/toLogin"); // 기록을 남기지 않고 이동
    }
})
</script>
</body>
</html>