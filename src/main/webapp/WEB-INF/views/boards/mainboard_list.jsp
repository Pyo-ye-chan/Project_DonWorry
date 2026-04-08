<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>돈워리 - 질문게시판</title>
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
        min-height: 105vh;
        display: flex;
        flex-direction: column;
        overflow-x: hidden;
    }
    
    /* [2] 상단바 포함 컨테이너 (사용자 원본 1100px 완벽 유지) */
    .community-container {
    min-height: calc(100vh - 200px); /* 화면 높이에서 헤더/푸터 대략적인 값을 뺀 최소 높이 */
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
    /* 헤더 */
        .comm-header h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 8px;
            margin-top: 10px;
        }

        .comm-header i {
            margin-top: 50px;
        }

        .comm-header p {
            color: #666;
            font-size: 14px;
        }

        /* 배너 */
        .main-banner {
            width: 100%;
            height: 180px;
            background-color: #000;
            border-radius: 20px;
            margin: 30px 0;

            overflow: hidden;
        }

        .main-banner img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.8;
        }

        /* 탭 메뉴 */
        .tab-menu {
            display: flex;
            background-color: #eee;
            padding: 5px;
            border-radius: 12px;
            margin-bottom: 30px;
        }

        .tab-menu a {
            text-decoration: none;
            color: #555;
        }

        .tab-item {
            flex: 1;
            border: none;
            padding: 12px;
            background: none;
            cursor: pointer;
            font-size: 14px;
            color: #555;
            border-radius: 10px;
        }

        .tab-item.active {
            background-color: white;
            font-weight: bold;
            color: #333;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
		/* [6] 공지사항 섹션 */
		.notice-board {
			margin:auto;
			width:100%;
            border:none;
		    padding: 0 10px;
		    background-color: #ffffff;
		    display: flex;
		    flex-direction: column; /* 세로로 쌓이게 설정 */
		    gap: 10px;              /* 게시글 사이의 간격 */
		}
		
		/* 공지사항 게시물 한 칸 */
		.notice-board-item {
		    border: 1px solid #c3dfff;
		    border-radius: 12px;
		    padding: 15px 25px;
		    background-color: #f1f7ff;
		    display: flex;
		    align-items: center;
		}
		
		/* 내부 정보 컨테이너 */
		.notice-item-info {
		    text-decoration: none;
		    width: 100%;
		    display: flex;
		    flex-direction: row;
		    align-items: center;
		    justify-content: space-between;
		    gap: 10px;
		}
		
		/* 각 텍스트 항목 공통 스타일 */
		.notice-item-info > div, 
		.notice-item-info > span {
			flex: 1.5;	    
		    font-weight:bold; 
		    font-size: 14px;
		    color: #333;
		    /* text-align: left; */
		}
		.notice-item-info >.notice-title{
			flex: 8;
		}
		
		/* 작성일자 오른쪽 정렬 */
		.notice-date {
		 	font-size: 12px !important;
            color: #888 !important;
            font-weight:normal !important;
            margin-top: 2px;
		    flex: 1;
		    text-align: right;
		}

        /* 게시글 카드 */
        .post-list {
            text-align: left;
        }

        .post-card {
            background-color: white;
            border: 1px solid #e1e4e8;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.2s;
            cursor: pointer;
        }

        .post-card:hover {
            border-color: #007bff;
        }

        .user-info {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .profile-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 12px;
            margin-right: 12px;
            display: none;
        }

        .meta .nickname {
            font-weight: bold;
            font-size: 14px;
        }

        .meta .time {
            font-size: 12px;
            color: #999;
            margin-top: 2px;
        }

        /* 태그 스타일 */
        .tag {
            font-size: 11px;
            padding: 2px 8px;
            border-radius: 10px;
            margin-left: 5px;
        }

        .tag.question {
            background-color: #e7f3ff;
            color: #007bff;
        }

        .tag.free {
            background-color: #e6fffa;
            color: #38b2ac;
        }

        /* 게시글 묶은 div */
        .post-container {
            /*max-height: 600px;*/
            /*overflow-y:auto;*/
            background-color: #ffffff;
            padding: 10px;
            border-radius: 15px;
        }

        /* 게시글 카드 간의 간격 조정 (마지막 카드는 마진 제거) */
        .post-card:last-child {
            margin-bottom: 0;
        }

        .post-title {
            font-size: 18px;
            margin-bottom: 10px;
            color: #222;
        }

        .post-content {
            font-size: 14px;
            color: #666;
            margin-bottom: 15px;
            line-height: 1.5;
        }

        /* 푸터 (좋아요, 댓글) */
        .post-footer {
            border-top: 1px solid #f1f1f1;
            padding-top: 15px;
            display: flex;
            gap: 20px;
            color: #888;
            font-size: 13px;
        }

        .post-footer span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .material-count {
            margin-top: 3px;
        }

        .material-symbols-outlined {
            margin-bottom: 3px;
            font-size: 14px;
        }

        /* 하단 고정 글쓰기 버튼 스타일 추가 */
        .floating-write-btn {
            position: fixed;
            /* 글쓰기 버튼 고정(따라다님) */
            bottom: 30px;
            right: 30px;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 15px 25px;
            background-color: #007bff;
            /* 파란색 포인트 컬러 */
            color: white;
            border: none;
            border-radius: 30px;
            /* 둥근 모양 */
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s, transform 0.2s;
            z-index: 1000;
            /* 다른 요소보다 위에 오도록 설정 */
        }

        .floating-write-btn:hover {
            background-color: #0056b3;
            /* 호버 시 더 짙은 파란색 */
            transform: translateY(-3px);
            /* 약간 위로 떠오르는 효과 */
        }

        .floating-write-btn .material-symbols-outlined {
            font-size: 22px;
        }

        /* 페이지네이션 컨테이너 */
        .page-nav {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 30px;
            padding-bottom: 10px;
        }

        /* 개별 숫자 버튼 스타일 */
        .page-num {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 35px;
            height: 35px;
            border: 1px solid lightgrey;
            background-color: white;
            color: #555;
            font-size: 14px;
            text-decoration: none;
            border-radius: 8px;
            /* 살짝 둥근 사각형 */
            cursor: pointer;
            transition: all 0.2s ease;
        }

        /* 호버 시 스타일 (파란색 배경, 흰색 글자) */
        .page-num:hover {
            background-color: #007bff;
            /* 요청하신 blue 계열 */
            color: white;
            border-color: #007bff;
            /*transform: translateY(-2px);*/
            /* 살짝 떠오르는 효과 */
        }

        /* 현재 활성화된 페이지 표시 (선택 사항) */
        .page-num.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
            font-weight: bold;
        }
</style>
</head>
<body>

<div class="community-container">
    <c:choose>
        <c:when test="${nickName==null}">
            <div class="top-auth">
                <span style="font-size: 13px; color: #666; cursor: pointer;">
                    <a href="/members/toLogin" style="text-decoration: none; color:black">
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
                <a href="/" >
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
                <a href="/boards/mainboard_list?page=1" class="active">
                    <i class="fa-regular fa-message fa-lg" style="color: rgb(36, 99, 235); margin-right:5px;"></i>
                    커뮤니티</a>
                  <a href="/qna/qna"> 
                    <i class="fa-solid fa-question fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    고객지원
                </a>                   
            </div>          
        </div>   
        <c:if test="${nickName==null }">   
	        <a class="my-page" href="/members/toLogin"> 
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
    
    <div class="main-banner">
            <img src="banner.png" alt="커뮤니티 이미지">
        </div>

        <nav class="tab-menu">
            <button class="tab-item active" onclick = "location.href = '/boards/mainboard_list?page=1'">메인 게시판</button>                  
            <button class="tab-item " onclick = "location.href = '/boards/freeboard_list?page=1'"> 자유 게시판</button>
            <button class="tab-item " onclick = "location.href = '/boards/qnaboard_list?page=1'"> 질문 게시판</button>
            <button class="tab-item" onclick = "location.href = '/boards/reviewboard_list?page=1'"> 리뷰 게시판</button>
        </nav>
			<div class="notice-board">
			    <c:forEach var="i" items="${notice_mainList}">
				<div class="notice-board-item">
		            <i class="fa-solid fa-circle-exclamation" style="color: rgb(64, 131, 231); margin-right:10px;"></i>
			        <c:choose>
		                <c:when test="${type == '관리자'}">
		                    <a href="/admin/admin_board_detail?seq=${i.seq}" class="notice-item-info">
		                </c:when>
		                <c:otherwise>
		                    <a href="/boards/view?seq=${i.seq}&view_count=${i.view_count }" class="notice-item-info">
		                </c:otherwise>
	            	</c:choose>
		                <div class="notice-title" style="flex: 3;">${i.title}</div>
		                <div class="notice-writer">${i.member_id}</div> <%-- 닉네임인 '관리자'가 출력됨 --%>
		                <div class="notice-date">
		                    <fmt:formatDate value="${i.write_date}" pattern="yyyy-MM-dd" />
		                </div>
		            </a>
	        	</div>
			    </c:forEach>
			</div>
		
        <section class="post-list">
            <div class="post-container">
            
                <c:forEach var="i" items="${mainList }">
                <c:if test="${i.member_id!='관리자'}">
                    <article class="post-card"
                        onclick="location.href='/boards/view?seq=${i.seq}&view_count=${i.view_count }'">
                        <div class="user-info">
                            <div class="profile-img green">편의</div>
                            <div class="meta">
                                <span class="nickname">${i.member_id }</span>
                                <span class="tag free">
                                    <c:choose>
                                        <c:when test="${i.category == 'main'}">메인게시판</c:when>
                                        <c:when test="${i.category == 'free'}">자유게시판</c:when>
                                        <c:when test="${i.category == 'qna'}">질문게시판</c:when>
                                        <c:when test="${i.category == 'review'}">리뷰게시판</c:when>
                                    </c:choose>
                                </span>
                                <p class="time">
                                    <fmt:formatDate value="${i.write_date }" pattern="yyyy-MM-dd" />
                                </p>
                            </div>
                        </div>
                        <h2 class="post-title">${i.title }</h2>
                        <div class="post-footer">
                            <span>
                                <span class="material-symbols-outlined">조회수</span>${i.view_count }
                            </span>
                            <span>
                                <i class="fa-regular fa-message" style="color: rgb(203, 203, 203);"></i> ${i.reply_count
                                }
                            </span>
                        </div>
                    </article>
                    </c:if>
                </c:forEach>
            </div>
            <div class="page-nav">


            </div>
            <button class="floating-write-btn">
                <span class="material-symbols-outlined">edit</span>
                <span>글쓰기</span>
            </button>
            </section>
    </div>
    
    

<div class="container-footer">
    <p>© 2026 돈워리. All rights reserved.</p>
    <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침 | 이용약관 | 고객센터</p>
</div>
<script>
$(".floating-write-btn").on("click",function(){
	location.href  = "/boards/toWrite";
})
		let recordTotalCount = ${recordTotalCount}; // 총 개수
		let recordCountPerPage = ${recordCountPerPage}; // 한페이지에 몇개 (10)
		let naviCountPerPage  = ${naviCountPerPage }; // navi 몇개 (10)
		let currentPage = ${currentPage}; // 현재 페이지
		let pageTotalCount = Math.ceil(recordTotalCount/recordCountPerPage); 
		
		let startNavi = Math.floor((currentPage - 1) / naviCountPerPage) * naviCountPerPage +1;
		let endNavi = startNavi + naviCountPerPage - 1;
		
		if(endNavi > pageTotalCount){
			endNavi = pageTotalCount;
		}
		
		let needPrev = true;
		let needNext = true;
		
		if(startNavi == 1){
			needPrev = false;
		}
		if(endNavi == pageTotalCount){
			needNext = false;
		}
		if(needPrev){
			
			let span = $("<span>");
			span.addClass("material-symbols-outlined");
			span.css("font-size","16px");
			span.html("chevron_left");
			let a = $("<a>");
			a.addClass("page-num");
			a.attr("href","/boards/mainboard_list?page="+ (startNavi-1));
			a.append(span);
			$(".page-nav").append(a);
		}
		
		for(let i = startNavi; i <= endNavi; i++){
			let a = $("<a>")
			a.attr("href" , "/boards/mainboard_list?page="+i);
			a.addClass("page-num");
			
			if (i == currentPage) {
		        a.addClass("active");
		    }
			a.html(i);
			$(".page-nav").append(a);
		}
		
		if(needNext){
			 
			 let span = $("<span>");
				span.addClass("material-symbols-outlined");
				span.css("font-size","16px");
				span.html("chevron_right");
				let a = $("<a>");
				a.addClass("page-num");
				a.attr("href","/boards/mainboard_list?page="+(endNavi+1));
				a.append(span);
				$(".page-nav").append(a);
		}
</script>
</body>
</html>