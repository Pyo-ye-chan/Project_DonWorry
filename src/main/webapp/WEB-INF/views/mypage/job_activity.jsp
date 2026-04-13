<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>돈워리- 구직 활동 관리</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">    
<style>
    /* [1] 원본 초기화 및 레이아웃 유지 */
    * { margin: 0; padding: 0; box-sizing: border-box; }
    
    body {
        font-family: 'Pretendard', sans-serif;
        background-color: #ffffff;
        line-height: 1.6;
        min-height: 100vh;
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
    
    /* [3] 상단바 스타일 (보내주신 원본과 100% 일치) */
    .top-auth { display: flex; justify-content: flex-end; align-items: center; gap: 15px; padding: 8px 0; }
    .navbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 0; border-bottom: 1px solid #f0f0f0; }
    .logo { color: #2563eb; font-weight: 800; font-size: 20px; text-decoration: none; }
    .nav-menu { display: flex; gap: 40px; }
    .nav-menu a { text-decoration: none; color: #666; font-size: 14px; font-weight: 500; }
    .my-page { display: flex; align-items: center; gap: 8px; text-decoration: none; color: #666; font-size: 14px; font-weight: 500; padding: 5px 10px; cursor: pointer; }
    .nav-menu a.active { color: #2563eb; }
    
    /*사용사 식별 표시*/
    .now-business ,.now-personal ,.now-admin {
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

    /* [4] 컨텐츠 영역 */
    .page {
        padding: 56px 0 72px;
        width: 70%; 
        margin:auto;
    }

    .page-title { font-size: 24px; font-weight: 800; color: #222; text-align: left; margin-bottom: 18px; }
    .title-line { border: none; border-top: 1px solid #e5e7eb; margin: 18px 0; }

    .comm-header { text-align: center; margin-bottom: 40px; }
    .comm-header h5 { font-size: 24px; font-weight: 700; color: #333; margin-top: 15px; }
    .comm-header p { color: #666; font-size: 15px; margin-top: 8px; }

.resume-btn{
	 	background-color: #f8fafc;
        color: #475569;
        border: 1px solid #dbe2ea;
        /*상우하좌  */
        padding: 13px 15px 15px 15px;
        border-radius: 10px;
        font-size: 14px;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.2s ease;
        margin-bottom:10px;
        
        display: flex;       /* 아이콘과 글자 정렬을 위해 flex 권장 */
    	align-items: center;
    	margin-left: auto;   /* ★ 핵심: 왼쪽 마진을 자동으로 채워 오른쪽으로 밀기 */
}
.resume-btn:hover{
	   background-color: #eff6ff;
        color: #4f67e8;
        border-color: #c7d2fe;
}
.resume-btn:hover i{
        color: #4f67e8 !important;
}
    .tab-menu {
        display: flex;
        background-color: #f1f3f5;
        padding: 6px;
        border-radius: 12px;
        margin-bottom: 40px;
        width: 100%; 
    }
    .tab-item {
        flex: 1;
        border: none;
        padding: 16px; 
        background: none;
        cursor: pointer;
        font-size: 15px;
        color: #555;
        border-radius: 10px;
    }
    .tab-item.active { background-color: white; font-weight: 800; color: #2563eb; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }

    .post-list { text-align: left; width: 100%; }
    .post-card {
        background-color: white;
        border: 1px solid #e9ecef;
        border-radius: 18px;
        padding: 30px;
        margin-bottom: 24px;
        width: 100%;
    }

    .nickname { font-weight: 800; font-size: 18px; color: #222; }
    .time { font-size: 13px; color: #adb5bd; margin-top: 4px; }
    .post-content { font-size: 16px; margin: 25px 0; color: #495057; }

    .job-category-tag { font-size: 12px; padding: 4px 12px; border-radius: 8px; margin-left: 8px; background-color: #f8f9fa; color: #2f9e44; border: 1px solid #d3f9d8; }
    .city-category-tag { font-size: 12px; padding: 4px 12px; border-radius: 8px; margin-left: 5px; background-color: #f8f9fa; color: #1971c2; border: 1px solid #d0ebff; }

    .post-footer { border-top: 1px solid #f1f3f5; padding-top: 20px; display: flex; justify-content: flex-end; gap: 12px; }

	.apply-cancel-btn { 
	    background-color: #ffffff; color: #868e96; border: 1px solid #dee2e6; 
	    padding: 10px 24px; border-radius: 10px; font-weight: 600; cursor: pointer; font-size: 13px;
	    transition: all 0.2s ease; /* 부드러운 변화를 위해 추가 */
	}
	
	.apply-detail-btn { 
	    background-color: #2563eb; color: #ffffff; border: none; 
	    padding: 10px 24px; border-radius: 10px; font-weight: 600; cursor: pointer; font-size: 13px;
	    transition: all 0.2s ease; /* 부드러운 변화를 위해 추가 */
	}
	
	.apply-cancel-btn:hover {
	    background-color: #f8f9fa;
	    color: #495057;
	    border-color: #ced4da;
	}
	
	.apply-detail-btn:hover {
	    background-color: #1d4ed8; /* 원본 #2563eb보다 약간 진한 파랑 */
	    box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2); /* 미세한 그림자 효과 */
	}

    .page-nav { display: flex; justify-content: center; align-items: center; gap: 10px; margin-top: 40px; }
    .page-num { display: flex; justify-content: center; align-items: center; width: 40px; height: 40px; border: 1px solid #dee2e6; background-color: white; color: #495057; text-decoration: none; border-radius: 10px; font-size: 14px; }
    .page-num.active { background-color: #2563eb; color: white; border-color: #2563eb; }

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
    <c:if test="${nickName!=null}">
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
</c:if>
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
                    커뮤니티
                </a>
                 <a href="/qna/qna?page=1"> 
                    <i class="fa-solid fa-question fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    고객지원
                </a>              
            </div>          
        </div>   
        <a class="my-page" href="/mypage/toMypage">
            <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(197, 197, 197);"></i>
            마이페이지
        </a>    
    </nav>

    <div class="page">

        <div class="comm-header">
            <i class="fa-solid fa-briefcase fa-4x" style="color: #e9ecef;"></i>
            <h5>나의 지원 현황</h5>
            <p>지원한 공고의 진행 상태를 한눈에 확인하세요</p>
        </div>
        <a href="/mypage/resume" style="text-decoration:none;">
		<button class="resume-btn">
               <i class="fa-regular fa-clipboard fa-lg" style="color: rgb(98, 98, 98); margin-right:5px;"></i>
               <span>이력서 등록</span>
        </button>
        </a>

        <section class="post-list">
            <div style="font-size: 14px; color: #868e96; margin-bottom: 15px; font-weight: 600; padding-left: 5px;">전체 지원 내역 (${selectApplyList.size()})</div>
            <c:forEach var="i" items="${selectApplyList}">
            <div class="post-container">
                <div class="post-card">
                    <div class="user-info">
                        <div class="meta">
                            <span class="nickname">${i.company_name}</span>
                            <span class="job-category-tag">${i.main_category_name}/${i.sub_category_name}</span>
                            <span class="city-category-tag">${i.sido}/${i.gugun}/${i.dong}</span>
                            <p class="time"></p>
                        </div>
                    </div>
                    <h2 class="post-content">${i.title}</h2>
                    <div class="post-footer">
                        <button class="apply-cancel-btn" 
                        onclick="location.href='/jobapplys/delete?seq=${i.apply_seq}'">지원 취소</button>
                        <button class="apply-detail-btn"
                        onclick="location.href='/mypage/job_activity_detail?seq=${i.seq}'">상세보기</button>
                    </div>
                </div>
            </div>
            </c:forEach>
        </section>

        <div class="page-nav">
            <!-- <a href="#" class="page-num"><span class="material-symbols-outlined" style="font-size: 18px;">chevron_left</span></a>
            <a href="#" class="page-num active">1</a>
            <a href="#" class="page-num"><span class="material-symbols-outlined" style="font-size: 18px;">chevron_right</span></a> -->
        </div>
         
    </div>
</div>
<div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
<script>
    $(".tab-item").on("click", function(){
        $(".tab-item").removeClass("active");
        $(this).addClass("active");
    });
</script>
</body>
</html>