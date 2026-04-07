<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>돈워리 - 메인(홈)</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        line-height: 1.6;
        min-height: 105vh;
        display: flex;
        flex-direction: column;
        overflow-x: hidden;
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
            gap: 15px;                 /* 요소 간 간격 */
            padding: 8px 0;           /* 위아래 여백 */
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

        /* [4] 히어로 섹션 */
        .hero {
            height:300px;
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

/* [5] 근무 요약 카드 섹션 */
        .section-header {
            font-size: 20px;
            font-weight: 700;
            margin: 40px 0 20px;
        }
        .summary-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 60px;
            padding:0;
        }
        .summary-grid a {
		    display: block;    /* inline을 block으로 변경 (영역 확보의 핵심) */
		    width: 100%;       /* 부모 너비 꽉 채우기 */
		    height: 100%;      /* 부모 높이 꽉 채우기 */
		    text-decoration: none;
		}
        .card {
            border: 1px solid #e5e7eb;
            border-radius: 15px;
            padding: 25px;
            background: #fff;
        }
        .card-title {
            color: #2563eb;
            font-weight: bold;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }
        .info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
        }
        .info-label { color: #aaa; }
        .info-val { font-weight: 700; }
        .info-val.blue { color: #2563eb; font-size: 18px; }

        .add-card {
            border: 2px dashed #e5e7eb;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100%;
            color: #ccc;
            padding:0;
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

/* [6] 구인구직 섹션 */
       .job-board {
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            padding: 24px;
            background-color: #ffffff;
            display: flex;
            flex-direction: column; /* 세로로 쌓이게 설정 */
            gap: 16px;             /* 게시글 사이의 간격 */
        }
        /* 게시물 한 칸 */
        .job-board-item {
            border: 1px solid #f0f4ff;
            border-radius: 12px;
            padding: 15px 25px; /* 좌우 패딩을 넉넉히 */
            background-color: #fafbff;
            display: flex;
            align-items: center; /* 세로 중앙 정렬 */
        }

        /* 내부 정보를 담는 컨테이너 */
        .job-item-info {
            text-decoration: none; /* 밑줄 제거 */ 
            width: 100%;
            display: flex;
            flex-direction: row; /* 가로 나열 */
            align-items: center;
            justify-content: space-between; /* 항목들 사이에 균등 공간 */
            gap: 10px;
        }

        /* 각 텍스트 항목 공통 스타일 */
        .job-item-info > div, 
        .job-item-info > span {
            flex: 1;            /* 모든 항목이 동일 너비 */
            font-size: 14px;
            color: #333;
            text-align: left;   /* 왼 정렬 */
        }
        /* 시급(마지막 항목) 강조 */
        .job-pay {
            flex: 1;
            text-align: right;  /* 시급만 오른쪽 정렬 */
            font-weight: 700;
            color: #2563eb;
        }
        .job-pay-label {
            font-weight: normal;
            color: #666;
            margin-right: 5px;
        }

/* [7] 인기게시판 섹션 */
        /* 인기 게시판 전체 감싸는 큰 박스 */
        .hot-board {
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            padding: 24px;
            background-color: #ffffff;
            display: flex;
            flex-direction: column; /* 세로로 쌓이게 설정 */
            gap: 16px;             /* 게시글 사이의 간격 */
        }

        /* 개별 게시물 한 칸 */
        .hot-board-item {
            border: 1px solid #f0f4ff;
            border-radius: 12px;
            padding: 20px;
            background-color: #fafbff;
            display: flex;
            justify-content: space-between; /* 왼쪽 텍스트와 오른쪽 시급을 양끝으로 */
            align-items: flex-end;         /* 아래쪽 기준으로 정렬 */
        }

        /* 게시물 왼쪽 정보 (이름, 역할 등) */
        .hot-item-info {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 6px;
            text-decoration: none; /* 밑줄 제거 */ 
        }

        .hot-item-title-row {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .item-name {
            font-size: 16px;
            font-weight: 700;
        }

        /* 상태 태그 (근무중, 퇴사 등) */
        .status-tag {
            font-size: 11px;
            padding: 2px 8px;
            border-radius: 4px;
            font-weight: bold;
        }
        .status-freeboard { background-color:#cff7ef; color: #179791; } /* 초록색 */
        .status-reviewboard{ background-color: #cfe5ff; color: #185fb0; }
		.status-qnaboard{ background-color: #ffb2b7; color: #a91620;}

        .contents-title {
            font-size: 17px;
            color: #252525;
        }
        .writer{
            font-size: 14px;
            color: #888;
        }
        /*리뷰게시판 및 좋댓 라인*/
        .hot-board-item-footer{
            width:100%;
            display: flex;
            justify-content: space-between; /* 왼쪽(카테고리)과 오른쪽(푸터) 양 끝 정렬 */
            align-items: center;           /* 높이 중앙 정렬 */
            margin-top: 15px;              /* 게시글 내용과의 간격 */
        }
        /* 게시판 카테고리 텍스트 설정 */
        .hot-board-category {
            font-size: 12px;
            color: #aaa;
            /* margin-top: 10px; <- 부모가 flex이므로 제거하거나 조정 */
        }
        /* 푸터 (좋아요, 댓글) */
        .hot-post-footer {
            padding-top: 15px;
            display: flex;
            gap: 20px;
            color: #888;
            font-size: 12px;
            text-decoration: none;
            margin:0;
        }
        .hot-post-footer span {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .material-count{
            margin-top:3px;
        }
        .material-symbols-outlined {
            margin-bottom:3px;
            font-size: 13px;
            margin-top:3px;
        }

        /* 게시물 오른쪽 금액/시급 정보 */
        .item-pay-info {
            text-align: right;
            color: #2563eb;
            font-weight: 700;
            font-size: 18px;
        }
        .pay-symbol {
            font-size: 14px;
            margin-right: 4px;
        }
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
            <a href="members/toLogin" style="text-decoration: none; color:black; margin-right:10px;">
                <i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>로그인
            </a>
        </span>
    </div>
</c:when>
<c:otherwise>
    <div class="top-auth">  
        <span style="font-size: 13px; color: #666; cursor: pointer;">
        	<i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
            	${nickName}님 환영합니다.
            <a href="members/logout" style="text-decoration: none; color:black">
            <button class="logout-btn" style="margin-left:10px;">로그아웃</button>              
            </a>
        </span>
		<c:if test="${type=='관리자'}">
            <a href="/admin/admin_main" style="text-decoration:none;"><div class="now-admin">관리자</div></a>
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
                <a href="/boards/mainboard_list?page=1"> 
                    <i class="fa-regular fa-message fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i> 
                    커뮤니티
                </a> 
                <a href="/qna/qna"> 
                    <i class="fa-solid fa-question fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    고객지원
                </a>              
            </div>           
        </div>
        <c:if test="${nickName==null }">   
	        <a class="my-page" href="members/toLogin"> 
	            <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(197, 197, 197);"></i>
	            마이페이지
	        </a>  
        </c:if> 
        <c:if test="${nickName!=null }">   
	        <a class="my-page" href="/mypage/toMypage"> 
	            <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(197, 197, 197);"></i>
	            마이페이지
	        </a>  
        </c:if>   
    </nav>

    <header class="hero">
        <div class="hero-badge">
            <i class="fa-solid fa-circle-dollar-to-slot fa-xl" style="color: rgb(36, 99, 235); margin-right:5px;"></i> 
             알바생을 위한 급여 관리 플랫폼
        </div>
        <h1>알바 급여 관리를<br>쉽고 정확하게</h1>
        <p>시급 계산부터 일정 관리까지, 하나의 플랫폼에서 만나보세요</p>
    </header>

    <h2 class="section-header">
        <i class="fa-solid fa-pen-to-square fa-lg" style="color: rgb(74, 82, 99);"></i>
        이번 달 근무 요약
    </h2>
<c:choose>
<c:when test="${nickName==null }">
<div class="summary-grid">
        <div class="card">
            <a href="members/toLogin" style="text-decoration: none; ">
            <div class="card-title">🏪 편의점 알바</div>
            <div class="info-item"><span class="info-label">예상 급여</span><span class="info-val blue">1,245,000원</span></div>
            <div class="info-item"><span class="info-label">근무 일수</span><span class="info-val">16일</span></div>
            <div class="info-item"><span class="info-label">총 시간</span><span class="info-val">128시간</span></div>
            </a>
        </div>
        <div class="card">     
            <a href="members/toLogin" style="text-decoration: none; ">      
            <div class="card-title">☕ 카페 알바</div>
            <div class="info-item"><span class="info-label">예상 급여</span><span class="info-val blue">850,000원</span></div>
            <div class="info-item"><span class="info-label">근무 일수</span><span class="info-val">12일</span></div>
            <div class="info-item"><span class="info-label">총 시간</span><span class="info-val">96시간</span></div>     
            </a>       
        </div>
        
	    	<a href="/salary/calendar" > 
		        <div class="card add-card" >              
		           + 알바 추가하기         
		        </div>
	        </a>
    	
    </div>
</c:when> 
 <c:otherwise>
 	<c:if test="${placeList[0].name == null }"> 
	     <div class="summary-grid">
	    	<a href="/salary/calendar" > 
		        <div class="card add-card" >              
		           + 알바 추가하기         
		        </div>
	        </a>
	    </div>   
   	</c:if>
   	<div class="summary-grid"> 
   	<c:if test="${placeList[0].name!=null }">
	   	<c:forEach var="i" items="${placeList}"> 
	   		<div class="card">     
            <a href="/salary/calendar" style="text-decoration: none; ">      
            <div class="card-title">${i.name }</div>
            <div class="info-item">
            	<span class="info-label">예상 급여</span><span class="info-val blue">${i.totalPay}원</span>
            </div>
            <div class="info-item">
            	<span class="info-label">근무 일수</span><span class="info-val">${i.workDays}일</span>
            </div>
            <div class="info-item">
            	<span class="info-label">총</span><span class="info-val">${i.totalHours}시간</span>
            </div>     
            </a>               	
        </div>
	   	</c:forEach>
	   	 	<a href="/salary/calendar" > 
		        <div class="card add-card" >              
		           + 알바 추가하기         
		        </div>
	        </a>
   	</c:if>
   	</div>
</c:otherwise>
</c:choose>
    <h2 class="section-header">
        <i class="fa-solid fa-briefcase fa-lg" style="color: rgb(103, 77, 67); "></i>
         구인구직</h2>
    <div class="job-board">
    <c:forEach var="i" items="${jobList}">
        <div class="job-board-item">
            <a href="/jobposts/jobdetail?seq=${i.seq}" class="job-item-info">
                <div class="item-name">${i.company_name}</div>
                <div class="item-role">${i.main_category_name}</div>
                <div class="item-loc">${i.sido}/${i.gugun}</div>
                <div class="item-days">${i.work_days}</div>
                <div class="job-pay">
                    <span class="job-pay-label">시급</span>${i.pay}원
                </div>
            </a>
        </div>
    </c:forEach> 
    </div>

    <h2 class="section-header">
        <i class="fa-solid fa-fire fa-lg" style="color: rgb(255, 94, 71);"></i>
        인기 게시판</h2>
    <div class="hot-board">
    <c:forEach var="i" items="${hotList}">
        <div class="hot-board-item">
            <a href="/boards/view?seq=${i.seq}&view_count=${i.view_count}" class="hot-item-info" >
                <div class="hot-item-title-row">
                    <span class="contents-title">${i.title}</span>
                    <c:if test="${i.category=='free'}">
                    	<span class="status-tag status-freeboard">자유게시판</span>
                    </c:if>
                    <c:if test="${i.category=='review'}">
                    	<span class="status-tag status-reviewboard">리뷰게시판</span>
                    </c:if>
                    <c:if test="${i.category=='qna'}">
                    	<span class="status-tag status-qnaboard">질문게시판</span>
                    </c:if>
                </div>
                <div class="writer">${i.member_id}</div>
                <div class="hot-board-item-footer">
                    <div class="board-category" style="font-size: 12px; color: #aaa; margin-top: 10px;">
                    	<fmt:formatDate value="${i.write_date }" pattern="yyyy-MM-dd" />
                    </div>
                    <div class="hot-post-footer">
                        <span>
                            <span class="material-symbols-outlined">
                                <i class="fa-regular fa-eye" style="color: rgb(203, 203, 203);"></i>
                            </span> ${i.view_count}
                        </span>
                        <span>
                            <i class="fa-regular fa-message" style="color: rgb(203, 203, 203);"></i> ${i.reply_count}
                        </span>
                    </div>
                </div>
            </a>
        </div> 
    </c:forEach>
    </div>
</div>
<div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
</div>

</body>
</html>