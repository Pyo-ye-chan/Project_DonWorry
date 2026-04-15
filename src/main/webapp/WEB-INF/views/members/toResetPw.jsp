<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정 - 돈워리</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="shortcut icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon">
<link rel="icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon">
<style>
    .reset-container {
        max-width: 450px;
        margin: 60px auto;
        padding: 40px;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        font-family: 'Pretendard', sans-serif;
    }
    .reset-title {
        font-size: 24px;
        font-weight: 700;
        text-align: center;
        margin-bottom: 10px;
        color: #333;
    }
    .reset-subtitle {
        text-align: center;
        color: #666;
        font-size: 14px;
        margin-bottom: 30px;
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
    input[type="password"] {
        width: 100%;
        padding: 12px 15px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-sizing: border-box;
        outline: none;
        transition: border-color 0.3s;
    }
    input:focus {
        border-color: #0055ff;
    }
    .pw-msg {
        font-size: 12px;
        margin-top: 5px;
        display: none;
    }
    .btn-blue {
        width: 100%;
        background-color: #0055ff;
        color: white;
        border: none;
        border-radius: 8px;
        padding: 14px;
        font-weight: 600;
        cursor: pointer;
        margin-top: 10px;
    }
    .btn-blue:disabled {
        background-color: #ccc;
        cursor: not-allowed;
    }
</style>
</head>
<body>

	<div class="reset-container">
    <div class="reset-title">비밀번호 재설정</div>
    <div class="reset-subtitle">새로운 비밀번호를 입력해주세요.</div>
    
    <form id="resetPwForm">
        <div class="form-group">
            <label for="newPw">새 비밀번호</label>
            <input type="password" id="newPw" name="pw" placeholder="영문, 숫자 포함 8자 이상" required>
        </div>

        <div class="form-group">
            <label for="newPwConfirm">비밀번호 확인</label>
            <input type="password" id="newPwConfirm" placeholder="비밀번호 다시 입력" required>
            <div id="pwMatchMsg" class="pw-msg"></div>
        </div>
        
        <button type="button" id="submitBtn" class="btn-blue" disabled>비밀번호 변경하기</button>
    </form>
</div>

<script>
$(document).ready(function() {
    // 비밀번호 일치 여부 실시간 체크
    $('#newPw, #newPwConfirm').on('keyup', function() {
        const pw = $('#newPw').val();
        const pwConfirm = $('#newPwConfirm').val();
        const msg = $('#pwMatchMsg');
        const btn = $('#submitBtn');

        if (pw === "" || pwConfirm === "") {
            msg.hide();
            btn.prop('disabled', true);
            return;
        }

        msg.show();
        if (pw === pwConfirm) {
            msg.text("비밀번호가 일치합니다.").css("color", "green");
            btn.prop('disabled', false);
        } else {
            msg.text("비밀번호가 일치하지 않습니다.").css("color", "red");
            btn.prop('disabled', true);
        }
    });

    // 변경 버튼 클릭 시
    $('#submitBtn').click(function() {
    	
    	 if (!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{4,16}$/.test($("#newPw").val())) {
    	        alert("비밀번호는 특수문자, 숫자, 대소문자가 최소 한글자씩 포함된 4~16자여야 합니다.");
    	        $("#newPw").focus();
    	        return false;
    	    }
    	
        const newPw = $('#newPw').val();
        
        $.ajax({
            url: "/members/updatePw",
            type: "POST",
            data: { pw: newPw },
            success: function(res) {
                if(res === "success") {
                    alert("비밀번호가 성공적으로 변경되었습니다. 다시 로그인해주세요!");
                    location.href = "/members/toLogin";
                } else {
                    alert("변경에 실패했습니다. 다시 시도해주세요.");
                }
            }
        });
    });
});
</script>

</body>
</html>