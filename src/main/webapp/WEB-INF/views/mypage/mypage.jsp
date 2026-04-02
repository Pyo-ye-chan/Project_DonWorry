<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>돈워리 - 마이페이지</title>
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
            width:100%;      
        }
        .card {
            background-color:#2563eb;
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
            background-color: rgba(255, 255, 255, 0.2); /* 반투명한 흰색 배경 */
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
            color: #ffffff;
            font-weight: bold;
       /* 상우하좌 */
            margin:5px 0px 0px 10px;
            display: flex;
            align-items: center;
        }
        .card-email{
            margin:5px 0px 20px 10px;
            color: #ffffff; font-size: 12px;
        }
        .info-item {
            width:100%;
            border-top:1px solid rgb(255, 255, 255,0.5);
            display: flex;
            flex-direction: column; /* 자식 요소들을 세로로 쌓음 */
            margin-bottom: 10px;
            font-size: 14px;
        }
        /*가입일*/
        .info-label { 
            color: #ffffff; font-size: 12px;
            margin-top: 15px;
            font-weight:0px;
        }
        /*날짜*/
        .info-val { 
            color: #ffffff; font-size: 12px; 
        }
        .profile-edit-btn{
            color: #e5e7eb;
            border: none;
            border-radius: 10px;
            background-color: rgba(255, 255, 255, 0.3);
            width:100px;
            height:30px;
            padding:5px 5px 10px 5px; 
        }
        .profile-edit-btn a{
            text-decoration: none;
            color:white;
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

/* [6] 내활동 */
       .bottom-grid{
            gap: 20px;
            margin-bottom: 60px;
            width: 100%;  
            width: 100%;
            max-width: 1060px;
            margin:auto;  /* 왼쪽 마진 자동 */
       }
       .my-activity {    
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            padding: 15px;
            background-color: #ffffff;
            display: flex;
            flex-direction: column; /* 세로로 쌓이게 설정 */
            margin:0px 0px 30px 0px;
            width:100%;
        }
        .my-activity-title{
            font-size: 14px;
            font-weight:700;
            color: #898989;
            text-align: left;   /* 왼 정렬 */
        }
        /* 내역 한 칸 */
        .my-activity-item {
            /* border: 1px solid #8d8d8d; */
            border-radius: 12px;
            padding: 0px 15px; /* 좌우 패딩을 넉넉히 */
            /* background-color: #fafbff; */
            display: flex;
            align-items: center; /* 세로 중앙 정렬 */
        }
        .my-activity-item:hover{
            background-color: #fafbff;
        }

        /* 내부 정보를 담는 컨테이너 */
        .my-apply-list  {
            text-decoration: none; /* 밑줄 제거 */ 
            width: 100%;
            display: flex;
            flex-direction: row; /* 가로 나열 */
            align-items: center;
            justify-content: space-between; /* 항목들 사이에 균등 공간 */
            gap: 10px;
        }

        /* 각 텍스트 항목 공통 스타일 */
        .my-apply-list > div, 
        .my-apply-list > span {
            font-size: 14px;
            color: #333;
            text-align: left;   /* 왼 정렬 */
        }
        /* 시급(마지막 항목) 강조 */
        .item-result {
            display: flex;         /* 요소들을 가로로 나열 */
            align-items: center;    /* 수직 중앙 정렬 (핵심!) */
            gap: 5px;              /* 숫자와 아이콘 사이 간격 */
            font-weight: 700;
            color: #666;
            text-align: right;
        }
        .apply-list-count {
            font-weight: normal;
            color: #666;
            margin-right: 5px;
            margin-top:15px;
        }
        .item-name {
            font-size: 15px;
            font-weight: 300;
        }
        .contents-title {
            font-size: 17px;
            color: #252525;
        } 
        .material-count{
            margin-top:3px;
        }
        .material-symbols-outlined {
            margin-bottom:3px;
            font-size: 13px;
            margin-top:3px
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
<c:choose>
<c:when test="${nickName==null}">
    <div class="top-auth">
        <span style="font-size: 13px; color: #666; cursor: pointer;">
            <a href="members/toLogin" style="text-decoration: none; color:black">
                <i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>로그인
            </a>
        </span>
        <!-- 일단 관리자 빼고 다 숨겨둠 -->
            <a href="/admin/admin_main" style="text-decoration:none;"><div class="now-admin" >관리자</div></a>
    </div>
</c:when>
<c:otherwise>
    <div class="top-auth">  
        <span style="font-size: 13px; color: #666; cursor: pointer;">
        	<i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
            	${nickName}님 환영합니다.
            <a href="/members/logout" style="text-decoration: none; color:black">
            <button class="logout-btn" style="margin-left:10px;">로그아웃</button>              
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
</c:otherwise>
</c:choose>
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
                <div class="card-email">${list[0].email}</div>
            </div>
            </div>          
                <div class="info-item">
                    <span class="info-label">가입일</span>
                    <span class="info-val">
                    	<fmt:formatDate value="${list[0].join_date}" pattern="yyyy-MM-dd" />
                    </span>
                </div> 
                <a href="/mypage/toProfile"><button class="profile-edit-btn">프로필 수정</button></a>       
            </div>          
        </div>
    </div>
    
<!-- 내활동 -->
   <div class="bottom-grid">
         <div class="my-activity">
        <div class="my-activity-title">내 활동</div>
        <div class="my-activity-item">
            <a href="/mypage/job_activity" class="my-apply-list">
                <div class="item-name">
                    <i class="fa-regular fa-file-lines" style="color: rgb(110, 110, 110); margin-right:5px;"></i>
                    구직 활동 관리
                </div>
                <div class="item-result">
                    <span class="apply-list-count" style="margin-bottom:15px; font-size: 13px;">12</span>
                    <span class="material-symbols-outlined" style="font-size: 20px;">chevron_right</span>
                </div> 
            </a>
        </div>  
        <div class="my-activity-item">
            <a href="#" class="my-apply-list">
                <div class="item-name">
                    <i class="fa-regular fa-file-lines" style="color: rgb(110, 110, 110); margin-right:5px;"></i>
                    내가 작성한 글
                </div>
                <div class="item-result">
                    <span class="apply-list-count" style="margin-bottom:15px; font-size: 13px;">12</span>
                    <span class="material-symbols-outlined" style="font-size: 20px;">chevron_right</span>
                </div> 
            </a>
        </div> 
         <div class="my-activity-item">
            <a href="#" class="my-apply-list">
                <div class="item-name">
                    <i class="fa-regular fa-bookmark" style="color: rgb(110, 110, 110); margin-right:5px;"></i>
                    북마크 글 보기
                </div>
                <div class="item-result">
                    <span class="apply-list-count" style="margin-bottom:15px; font-size: 13px;">12</span>
                    <span class="material-symbols-outlined" style="font-size: 20px;">chevron_right</span>
                </div> 
            </a>
        </div>       
    </div>    
  <!-- 설정 -->  
    <div class="my-activity">
        <div class="my-activity-title">설정</div>
        <div class="my-activity-item">
            <a href="spe.html" class="my-apply-list">
                <div class="item-name">
                    <i class="fa-regular fa-pen-to-square" style="color: rgb(110, 110, 110); margin-right:5px;"></i></i>
                    이력서 관리
                </div>
                <div class="item-result">
                    <span class="apply-list-count" style="margin-bottom:15px; font-size: 13px;">12</span>
                    <span class="material-symbols-outlined" style="font-size: 20px;">chevron_right</span>
                </div>
            </a>
        </div>  
        <div class="my-activity-item">
            <a href="#" class="my-apply-list">
                <div class="item-name">
                    <i class="fa-regular fa-bell" style="color: rgb(110, 110, 110); margin-right:7px;"></i>
                    알림 설정
                </div>
                <div class="item-result">
                    <span class="apply-list-count" style="margin-bottom:15px; font-size: 13px;">12</span>
                    <span class="material-symbols-outlined" style="font-size: 20px;">chevron_right</span>
                </div> 
            </a>
        </div> 
         <div class="my-activity-item">
            <a href="/mypage/toAccount" class="my-apply-list">
                <div class="item-name">
                    <i class="fa-solid fa-gear" style="color: rgb(128, 128, 128); margin-right:5px;"></i></i>
                    계정 설정
                </div>
                <div class="item-result">
                    <span class="apply-list-count" style="margin-bottom:15px; font-size: 13px;">12</span>
                    <span class="material-symbols-outlined" style="font-size: 20px;">chevron_right</span>
                </div> 
            </a>
        </div>       
    </div> 
   </div>
    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
</div>
</body>
</html>