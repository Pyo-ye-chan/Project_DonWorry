<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
</style>
</head>
<body>

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

	<script>
$(document).ready(function() {
    // 인증요청 버튼 클릭 시
    $('#sendAuthBtn').click(function() {
    let id = $('#id').val(); // HTML id 속성에 맞게 수정
    let email = $('#email').val();
    
    if(!id || !email) {
        alert("아이디와 이메일을 모두 입력해주세요.");
        return;
    }

    $.ajax({
        url: "/members/sendAuthCode", // 컨틀롤러 매핑 주소
        type: "POST",
        data: { id: id, email: email },
        success: function(res) {
            if(res === "success") {
                alert("인증번호가 발송되었습니다. 이메일을 확인해주세요!");
                $('#authCodeGroup').fadeIn();
                $('#sendAuthBtn').text("재발송");
            } else if(res === "not_found") {
                alert("일치하는 회원 정보가 없습니다.");
            } else {
                alert("메일 발송 중 오류가 발생했습니다.");
            }
        },
        error: function() {
            alert("서버 통신 실패!");
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