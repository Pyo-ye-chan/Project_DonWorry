<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>돈워리 - 프로필 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
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
        gap: 15px;                 /* 요소 간 간격 */
        padding: 8px 0;           /* 위아래 여백 */
    }
    /* [3] 네비게이션바 */
    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px 0;
        border-bottom: 1px solid #f0f0f0;
        margin-bottom:30px;
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
    .my-page{
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
    .nav-menu a.active { color: #2563eb; }

/*사용사 식별 표시*/
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

/* [1] 사용자 정보 바 */
    .summary-grid {
        display: flex;
        gap: 20px;
        margin-bottom: 60px;     
        /* width:100%;       */
        margin-left:150px;
        width:760px;
    }
    .card {
        border:1px solid #ececec;
        background-color:#ffffff;
        border-radius: 15px;
        /* 상우하좌 */
        padding: 20px 20px 10px 20px;
        width:100%;
    }
    .card-top{
        display: flex;
    }
    
    .profile-img-box {
        width: 60px;
        height: 60px;
        background-color: #2563eb;
        border-radius: 50%; /* 완전한 원형 */
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 15px;
    }

    .profile-img-box i {
        font-size: 30px;
        color: white;
    }
    .card-title {
        color: #616161;
        font-weight: bold;
    /* 상우하좌 */
        margin:5px 0px 0px 10px;
        display: flex;
        align-items: center;
    }
    .card-email{
        margin:5px 0px 20px 10px;
        color: #616161; font-size: 12px;
    }
    .info-item {
        width:100%;
        border-top:1px solid #61616160;
        display: flex;
        flex-direction: column; /* 자식 요소들을 세로로 쌓음 */
        margin-bottom: 10px;
        font-size: 14px;
    }
    /*가입일*/
    .info-label { 
        color: #616161; font-size: 12px;
        margin-top: 15px;
        font-weight:0px;
    }
    /*날짜*/
    .info-val { 
        color: #616161; font-size: 12px; 
    }
    .profile-edit-btn{
        color: #e5e7eb;
        border: none;
        border-radius: 10px;
        background-color: #2563eb;
        width:100px;
        height:30px;
        padding:5px 5px 10px 5px; 
    }
    .profile-edit-btn a{
        text-decoration: none;
        color:white;
    }
    .profile-edit-btn:hover{
        color: #2563eb;
        transition: 0.3s;
        border: 1px solid #ccc;
        border-radius: 10px;
        background-color: #ffffff;;
        width:100px;
        height:30px;
        padding:5px 5px 10px 5px; 
    }
    .add-card {
        border: 2px dashed #e5e7eb;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        color: #ccc;
    }
    .add-card span {
        color: #ccc;
    }
    .add-card:hover{
        transition: 0.5s;
        color: #616161;
        border-color: #007bff;
        transform: translateY(-2px); /* 살짝 떠오르는 효과 */
    }

    .bottom-grid {
        /* width: 100%; */
        /* max-width: 1060px;  */
        width:760px;
        margin: 0 auto 60px auto;
    }

    .edit-section {    
        border: 1px solid #e5e7eb;
        border-radius: 16px;
        padding: 30px;
        background-color: #ffffff;
        display: flex;
        flex-direction: column;
        gap: 25px; /* 항목 간 간격 */
        margin-bottom: 30px;
    }

    .edit-section-title {
        font-size: 18px;
        font-weight: 700;
        color: #333;
        margin-bottom: 10px;
        padding-bottom: 15px;
        border-bottom: 2px solid #f0f0f0;
    }

    /* 입력 그룹 (라벨 + 인풋) */
    .form-group {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .form-label {
        font-size: 14px;
        font-weight: 600;
        color: #666;
    }

    /* 인풋 박스 스타일 */
    .form-input {
        width: 100%;
        padding: 12px 15px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 15px;
        color: #333;
        /* transition: all 0.3s; */
    }

    .update-input:focus {
        outline: none;
        border-color: #2563eb;
        /*가로 세로 번짐 확장  */
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    /* 수정 완료 버튼 */
    .submit-btn-box {
        display: flex;
        justify-content: center;
        gap: 15px;
    }

    .back-btn{
        background-color: #f3f4f6;
        color: #666;
        border: none;
        padding: 12px 40px;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        font-size: 15px;
    }
    .update-btn{
        background-color: #2563eb;
        color: white;
        border: none;
        padding: 12px 40px;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        font-size: 15px;
    }
    .save-btn {
        background-color: #2563eb;
        color: white;
        border: none;
        padding: 12px 40px;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        font-size: 15px;
    }

    .cancel-btn {
        background-color: #f3f4f6;
        color: #666;
        border: none;
        padding: 12px 40px;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        font-size: 15px;
    }
    /*하단 푸터*/
    .container-footer{
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

<div class="container">
    <div class="top-auth">
        <span style="font-size: 13px; color: #666; cursor: pointer;">
            <a href="members/toLogin"style="text-decoration: none; color:black">
                <i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>로그인
            </a>
        </span>
        <!-- 일단 관리자 빼고 다 숨겨둠 -->
            <div class="now-admin" >관리자</div>
            <div class="now-business" style="display: none;">기업</div>
            <div class="now-personal" style="display: none;">개인</div>
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
                <a href="/boards/mainboard_list"> 
                    <i class="fa-regular fa-message fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i> 
                    커뮤니티
                </a>               
            </div>           
        </div>   
        <a class="my-page" href="/mypage/mypage"> 
            <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(197, 197, 197);"></i>
            마이페이지
        </a>    
    </nav>

    <div class="summary-grid">
        <div class="card">
            <div class="card-top">
                <div class="profile-img-box">
                    <i class="fa-regular fa-user"></i>
                </div>
                <div style="flex:1;">
                <div class="card-title">${nickName}</div>
                <div class="card-email">${loginId}</div>
            </div>
            </div>          
                <div class="info-item">
                    <span class="info-label">가입일</span>
                    <span class="info-val">2026.03.03</span>
                </div>  
            </div>          
        </div>
    </div>
    
<!-- 내활동 -->
<form action="/" class="update-form">
<div class="bottom-grid">
    <div class="edit-section">
        <div class="edit-section-title">기본 정보 수정</div>
        
        <div class="form-group">
            <label class="form-label">아이디</label>
            <input type="text" class="form-input" readonly 
             name="id" value="${list[0].id}" style="background-color: #f9fafb; color: #999; cursor: not-allowed;">
        </div>

        <div class="form-group">
            <label class="form-label">닉네임</label>
            <input type="text" class="form-input update-input" placeholder="닉네임을 입력하세요" readonly 
            name="nickname" value="${list[0].nickname}" style="background-color: #f9fafb; color: #999; cursor: not-allowed;" >
        </div>

		<div class="form-group">
            <label class="form-label">이름</label>
            <input type="text" class="form-input" readonly 
			name="name" value="${list[0].name}" style="background-color: #f9fafb; color: #999; cursor: not-allowed;">
        </div>

		<div class="form-group">
            <label class="form-label">생년월일</label>
            <input type="text" class="form-input" readonly 
			name="rrn" value="${list[0].rrn}" style="background-color: #f9fafb; color: #999; cursor: not-allowed;">
        </div>

		<div class="form-group">
            <label class="form-label">전화번호</label>
            <input type="text" class="form-input update-input" placeholder="전화번호를 입력하세요" readonly 
            name="phone" value="${list[0].phone}" style="background-color: #f9fafb; color: #999; cursor: not-allowed;" >
        </div>

        <div class="form-group">
            <label class="form-label">이메일 주소</label>
            <input type="email" class="form-input update-input" placeholder="이메일을 입력하세요" readonly 
			name="email" value="${list[0].email}" style="background-color: #f9fafb; color: #999; cursor: not-allowed;" >
        </div>
    </div>
    
    <div class="submit-btn-box">
		<a href="/mypage/toMypage"><button type="button" class="back-btn">뒤로가기</button><a>
		<button type="button" class="update-btn">수정</button>
        <button type="button" class="cancel-btn">취소</button>
        <button type="submit" class="save-btn">수정 완료</button>
    </div>
</div>
    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
</div>
<script>
	//수정완료 취소 버튼 안보임
	$(".cancel-btn,.save-btn").css("display","none");

	//수정 버튼 누르면
	$(".update-btn").on("click",function(){
		$(".cancel-btn").css("display","block");
		$(".save-btn").css("display","block");

		$(".update-btn,.back-btn").css("display","none");
		//수정 가능한것들 활성화
		$(".update-input").prop("readonly",false);
		$(".update-input").val("");
		$(".update-input").css("background-color","#ffffff").css("cursor", "allowed");

        //취소 후 다시 수정 누를때 스타일
         $(".update-input").css({
            "background-color":"#f9fafb",
            "box-shadow":" 0 0 0 3px rgba(37, 99, 235, 0.1)",
            "border-color":"#2563eb",
            "cursor":"allowed"
        });

	})

	//취소 버튼 누르면
	$(".cancel-btn").on("click",function(){
        //수정과 뒤로가기 나타냄
		$(".update-btn,.back-btn").css("display","block");
		$(".cancel-btn,.save-btn").css("display","none");

        $(".update-input").val("");

        //취소 시 스타일 수정
        $(".update-input").prop("readonly",true);
        $(".update-input").css({
            "background-color":"#f9fafb",
            "box-shadow":"none",
            "border-color":"#ddd",
            "cursor":"not-allowed"
        });
	})

	//수정 완료 누르고 전송될때
	$(".update-form").on("submit",function(){
		
	})
</script>
</body>
</html>