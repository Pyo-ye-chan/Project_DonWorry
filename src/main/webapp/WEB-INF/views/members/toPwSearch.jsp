<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>돈워리 - 비밀번호찾기</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* 돈워리 공통 스타일 테마 */
.find-container {
	max-width: 450px;
	margin: 60px auto;
	padding: 40px;
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
	font-family: 'Pretendard', sans-serif;
}

.find-title {
	font-size: 24px;
	font-weight: 700;
	text-align: center;
	margin-bottom: 30px;
	color: #333;
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: 600;
	font-size: 14px;
}

.input-row {
	display: flex;
	gap: 10px;
}

input[type="text"], input[type="email"] {
	flex: 1;
	padding: 12px 15px;
	border: 1px solid #ddd;
	border-radius: 8px;
	outline: none;
	transition: border-color 0.3s;
}

input:focus {
	border-color: #0055ff;
}
/* 돈워리 시그니처 블루 버튼 */
.btn-blue {
	background-color: #0055ff;
	color: white;
	border: none;
	border-radius: 8px;
	padding: 12px 20px;
	font-weight: 600;
	cursor: pointer;
	transition: background 0.2s;
}

.btn-blue:hover {
	background-color: #0044cc;
}

.btn-outline {
	background: white;
	color: #0055ff;
	border: 1px solid #0055ff;
	border-radius: 8px;
	padding: 0 15px;
	white-space: nowrap;
	cursor: pointer;
}

.full-btn {
	width: 100%;
	margin-top: 10px;
}

#authCodeGroup {
	display: none; /* 인증번호 발송 전에는 숨김 */
	margin-top: 15px;
	padding-top: 15px;
	border-top: 1px dashed #eee;
}
 /* [1] 원본 초기화 및 레이아웃 유지 */
    * { margin: 0; padding: 0; box-sizing: border-box; }
    
    body {
        font-family: 'Pretendard', sans-serif;
        background-color: #ffffff;
        line-height: 1.6;
        min-height: 105vh;
        display: flex;
        flex-direction: column;
        overflow-x: hidden;
    }
    
    /* [2] 상단바 포함 컨테이너 (사용자 원본 1100px 완벽 유지) */
    .community-container {
        max-width: 1100px;
        width: 100%; 
        margin: 0 auto;
        padding: 0 20px;
        flex: 1; /* 컨텐츠가 적을 때 푸터를 아래로 밀어주는 최소한의 장치 */
    }

    .logout-btn { 
         	width:60px;
            height:30px;
		    background-color: #ffffff; 
		    color: #868e96;
		    border: 1px solid #dee2e6; 
		    border-radius: 6px; 
		    font-size: 13px;
		    transition: all 0.2s ease; /* 부드러운 변화를 위해 추가 */
		}
		.logout-btn:hover { 
         	width:60px;
            height:30px;
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
            width:60px;
            height:30px;
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
            width:60px;
            height:30px;
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
            width:60px;
            height:30px;
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
        
    
    /* [3] 상단바 스타일 (보내주신 원본과 100% 일치) */
    .top-auth { display: flex; justify-content: flex-end; align-items: center; gap: 15px; padding: 8px 0; }
    .navbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 0; border-bottom: 1px solid #f0f0f0; }
    .logo { color: #2563eb; font-weight: 800; font-size: 20px; text-decoration: none; }
    .nav-menu { display: flex; gap: 40px; }
    .nav-menu a { text-decoration: none; color: #666; font-size: 14px; font-weight: 500; }
    .my-page { display: flex; align-items: center; gap: 8px; text-decoration: none; color: #666; font-size: 14px; font-weight: 500; padding: 5px 10px; cursor: pointer; }
    .nav-menu a.active { color: #2563eb; }
    .now-admin { width:60px; height:30px; background-color: #2563eb; color: white; display: flex; align-items: center; justify-content: center; border-radius: 6px; font-size: 13px; cursor: pointer; }

    /* [5] 푸터 (상단바와 무관하게 하단 고정 설정) */
    .container-footer {
        border-top: 1px solid #e5e7eb; /* 테두리를 상단에만 */
        background-color: #f9fafb;     /* 너무 어두운 회색 대신 밝은 회색 추천 */
        padding: 40px 0;               /* % 높이 대신 안쪽 여백으로 높이 확보 */
        margin-top: 80px;              /* 컨텐츠와의 간격 */
        text-align: center;
        color: #999;
        font-size: 13px;
        width: 100vw;                  /* 화면 끝까지 너비 확장 */
        margin-left: calc(-50vw + 50%); /* 컨테이너를 벗어나 화면 꽉 채우기 */
    }
</style>
</head>
<body>
<div class="community-container">
    <div class="top-auth">
        <span style="font-size: 13px; color: #666; cursor: pointer;">
            <a href="/members/toLogin" style="text-decoration: none; color:black; margin-right:10px;">
                <i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>로그인
            </a>
        </span>
    </div>
    <nav class="navbar">
        <div style="display: flex; align-items: center; gap: 40px;">
            <a href="/" class="logo"> 돈워리</a>
            <div class="nav-menu">
                <a href="/" class="active">
                    <i class="fa-solid fa-house fa-lg" style="color: rgb(36, 99, 235);"></i>
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
                <a href="/boards/mainboard_list?page=1">
                    <i class="fa-regular fa-message fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    커뮤니티</a>   
                 <a href="/qna/qna"> 
                    <i class="fa-solid fa-question fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    고객지원
                </a>           
            </div>          
        </div>   
        <a class="my-page" href="/members/toLogin">
            <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(197, 197, 197);"></i>
            마이페이지
        </a>    
    </nav>

	<div class="find-container">
		<div class="find-title">비밀번호 찾기</div>

		<form id="findPwForm">
			<div class="form-group">
				<label for="id">아이디</label> <input type="text" id="id"
					name="id" placeholder="아이디를 입력해주세요" required>
			</div>

			<div class="form-group">
				<label for="email">이메일 주소</label>
				<div class="input-row">
					<input type="email" id="email" name="email"
						placeholder="가입 시 등록한 이메일" required>
					<button type="button" id="sendAuthBtn" class="btn-outline">인증요청</button>
				</div>
			</div>

			<div id="authCodeGroup">
				<div class="form-group">
					<label for="authCode">인증번호 입력</label>
					<div class="input-row">
						<input type="text" id="authCode" placeholder="6자리 숫자 입력">
						<button type="button" id="verifyBtn" class="btn-blue">확인</button>
					</div>
				</div>
			</div>

			<button type="button" class="btn-blue full-btn"
				onclick="history.back()">뒤로가기</button>
		</form>
	</div>
	</div>
	
	<div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>

	<script>
$(document).ready(function() {
    // 인증요청 버튼 클릭 시
	$('#sendAuthBtn').click(function() {
	    let id = $('#id').val();
	    let email = $('#email').val();

	    if(!id || !email) {
	        alert("아이디와 이메일을 모두 입력해주세요.");
	        return;
	    }

	    // [추가] 버튼 비활성화 및 로딩 표시
	    const btn = $(this);
	    btn.prop('disabled', true).text("발송 중...");

	    $.ajax({
	        url: "/members/sendAuthCode",
	        type: "POST",
	        data: { id: id, email: email },
	        success: function(res) {
	            if(res === "success") {
	                alert("인증번호가 발송되었습니다. 이메일을 확인해주세요!");
	                $('#authCodeGroup').fadeIn();
	                btn.text("재발송"); // 텍스트 복구
	            } else {
	                if(res === "not_found") alert("일치하는 회원 정보가 없습니다.");
	                else alert("메일 발송 중 오류가 발생했습니다.");
	                btn.text("인증요청"); // 실패 시 원래대로
	            }
	        },
	        error: function() {
	            alert("서버 통신 실패!");
	            btn.text("인증요청");
	        },
	        complete: function() {
	            // [추가] 성공하든 실패하든 응답이 오면 버튼 다시 활성화
	            btn.prop('disabled', false);
	        }
	    });
	});
});

$('#verifyBtn').click(function() {
    const inputCode = $('#authCode').val(); // 사용자가 입력한 번호

    if(!inputCode) {
        alert("인증번호를 입력해주세요.");
        return;
    }

    $.ajax({
        url: "/members/verifyAuthCode",
        type: "POST",
        data: { inputCode: inputCode },
        success: function(res) {
            if(res === "success") {
                alert("인증에 성공했습니다! 비밀번호 재설정 페이지로 이동합니다.");
                // 인증 성공 시 비밀번호 변경 페이지로 이동
                location.href = "/members/toResetPw";
            } else {
                alert("인증번호가 일치하지 않습니다. 다시 확인해주세요.");
            }
        },
        error: function() {
            alert("서버 통신 오류!");
        }
    });
});
</script>

</body>
</html>