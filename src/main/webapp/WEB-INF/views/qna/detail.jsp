<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>돈워리- css배포용</title>
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
    .post-detail {
            margin-top: 40px;
        }

        .post-detail {
            margin: 60px auto;
            max-width: 900px;
            /* 핵심: 중앙 + 크게 */
            padding: 40px 50px;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            background-color: #fff;
        }

        /* 제목 */
        .detail-title {
            font-size: 32px;
            /* 기존 24 → 크게 */
            font-weight: 800;
            margin-bottom: 20px;
            line-height: 1.4;
            word-break: break-all;
        }

        /* 작성 정보 */
        .detail-info {
            display: flex;
            justify-content: space-between;
            /* 좌우 분리 */
            font-size: 14px;
            color: #888;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        /* 본문 */
        .detail-content {
            margin-top: 30px;
            font-size: 17px;
            /* 기존 15 → 크게 */
            line-height: 1.9;
            /* 가독성 핵심 */
            color: #333;
            min-height: 300px;
            word-break: break-all;
        }

        /* 버튼 */
        .detail-actions {
            margin-top: 40px;
            display: flex;
            justify-content: flex-end;
            /* 오른쪽 정렬 */
            gap: 10px;
        }

        .detail-actions button {
            padding: 10px 20px;
            font-size: 14px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            background-color: #2563eb;
            color: white;
        }

        .detail-actions button:first-child {
            background-color: #6b7280;
        }

        .detail-category {
            display: inline-block;
            background-color: #e0edff;
            color: #2563eb;
            font-size: 13px;
            font-weight: 600;
            padding: 5px 12px;
            border-radius: 20px;
            margin-bottom: 10px;
        }

        .info-left {
            display: flex;
            align-items: center;
            gap: 12px;
            /* 🔥 여기로 간격 조절 */
        }

        /* | 여백 따로 더 주고 싶으면 */
        .divider {
            color: #ccc;
            margin: 0 5px;
        }

        .info-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        /* 신고 버튼 */
        .comment-actions .report-btn {
            font-size: 12px;
            color: #999;
            cursor: pointer;
        }

        .comment-actions .report-btn:hover {
            color: #ef4444;
            /* hover 시 빨강 */
        }

        .report-btn {
            font-size: 12px;
            color: #999;
            cursor: pointer;
        }

        .report-btn:hover {
            color: #ef4444;
            /* hover 시 빨강 */
        }

        /* 댓글 영역 */
        .comment-section {
            max-width: 900px;
            margin: 40px auto;
        }

        /* 제목 */
        .comment-title {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 15px;
        }

        /* 작성 */
        .comment-write {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .comment-write textarea {
            flex: 1;
            height: 80px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            resize: none;
            font-size: 14px;
        }

        .comment-write button {
            width: 80px;
            border: none;
            border-radius: 8px;
            background-color: #2563eb;
            color: white;
            cursor: pointer;
        }

        /* 리스트 */
        .comment-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
            word-break: break-all;
        }

        /* 댓글 */
        .comment-item {
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }

        /* 헤더 */
        .comment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }

        /* 작성자 + 날짜 */
        .comment-left {
            display: flex;
            gap: 10px;
            font-size: 13px;
            color: #888;
        }

        .comment-writer {
            font-weight: 600;
            color: #444;
        }

        /* 내용 */
        .comment-content {
            font-size: 14px;
            color: #333;
            line-height: 1.6;
        }

        /* 수정/삭제 */
        .comment-actions {
            display: flex;
            gap: 10px;
            font-size: 12px;
            color: #999;
            cursor: pointer;
        }

        .comment-actions span:hover {
            color: #2563eb;
        }

        /* 대댓글 영역 */
        .reply-list {
            margin-left: 20px;
            margin-top: 10px;
        }

        /* 대댓글 아이템 */
        .reply-item {
            position: relative;
            padding-left: 20px;
            margin-top: 10px;
        }

        /* 꺾인 화살표 */
        .reply-item::before {
            content: "↳";
            position: absolute;
            left: 0;
            top: 2px;
            font-size: 14px;
            color: #9ca3af;
        }

        /* 대댓글 입력창 */
        .reply-write {
            margin-top: 10px;
            margin-left: 20px;
            display: flex;
            gap: 10px;
        }

        .reply-write textarea {
            flex: 1;
            height: 60px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 6px;
            resize: none;
            font-size: 13px;
        }

        .reply-write button {
            width: 70px;
            border: none;
            border-radius: 6px;
            background-color: #2563eb;
            color: white;
            cursor: pointer;
        }

        .detail-files {
            margin-top: 15px;
            /* 🔥 작성정보랑 간격 */
            padding: 15px;
            background-color: #f9fafb;
            border-radius: 8px;
        }

        /* 리스트 */
        .file-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        /* 파일 */
        .file-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .file-item i {
            color: #2563eb;
        }

        .file-item a {
            text-decoration: none;
            color: #333;
            font-size: 14px;
        }

        .file-item a:hover {
            text-decoration: underline;
        }

        .no-file {
            font-size: 13px;
            color: #999;
        }
        .status-badge {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-waiting {
            background-color: #e9ecef;
            color: #868e96;
        }

        .status-complete {
            background-color: #e7f5ff;
            color: #228be6;
        }
        /* 답변 목록 컨테이너 */
.comment-list {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

/* 답변 카드 아이템 */
.reply-card {
    background: #f8fafc;
    padding: 20px;
    border-left: 5px solid #2563eb;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

/* 답변 헤더 (관리자 아이콘 + 날짜) */
.reply-card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12px;
}

.reply-card-header strong {
    color: #1e293b;
    font-size: 15px;
}

.reply-card-header i {
    margin-right: 6px;
    color: #2563eb;
}

.reply-card-date {
    font-size: 13px;
    color: #94a3b8;
}

/* 답변 본문 내용 */
.reply-card-content {
    color: #334155;
    line-height: 1.6;
    font-size: 14px;
    white-space: pre-wrap; /* 줄바꿈 유지 */
}

/* 답변 푸터 (삭제 버튼) */
.reply-card-footer {
    text-align: right;
    margin-top: 15px;
}

.btn-reply-del {
    padding: 5px 12px;
    font-size: 12px;
    background-color: #ef4444;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background 0.2s;
}

.btn-reply-del:hover {
    background-color: #dc2626;
}

/* 답변 없을 때 메시지 */
.no-reply {
    padding: 30px;
    color: #94a3b8;
    text-align: center;
    font-size: 14px;
}
.detail-content img{
        max-width: 100%;    /* 부모 너비를 넘지 않음 */
    height: auto;       /* 비율 유지 */
    display: block;     /* 하단 여백 제거 */
    margin: 10px 0;    /* 이미지 위아래 여백 */
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
                <a href="/boards/mainboard_list?page=1">
                    <i class="fa-regular fa-message fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    커뮤니티</a>   
                <a href="/qna/qna" class="active"> 
                    <i class="fa-solid fa-question fa-lg" style="color: rgb(36, 99, 235); margin-right:5px;"></i>
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
    
    <div class="post-detail">

            <!-- 카테고리 -->
            <div class="detail-category">
                1:1 문의하기
            </div>

            <!-- 제목 -->
            <h1 class="detail-title">${dto.title }</h1> <br>

            <!-- 작성 정보 -->
            <div class="detail-info">
                <div class="info-left">
                    <span class="writer">${dto.member_id }</span>
                    <span class="divider">|</span>
                    <span class="date">
                        <fmt:formatDate value="${dto.write_date}" pattern="yyyy-MM-dd" />
                    </span>
                </div>
                <div class="info-right">
                     <span
                                            class="status-badge ${dto.status == 'status-complete' ? 'status-complete' : 'status-waiting'}">
                                            ${dto.status == 'status-complete' ? '답변완료' : '접수중'}
                                        </span>
                    
                </div>
            </div>

            <!-- 🔥 여기 추가 -->
            <div class="detail-files">
                <c:if test="${not empty filesList}">
                    <ul class="file-list">
                        <c:forEach var="file" items="${filesList}">
                            <li class="file-item">
                                <i class="fa-regular fa-file-lines"></i>
                                <a href="/boards/download?sysName=${file.sysName}&oriName=${file.oriName}">
                                    ${file.oriName}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>

                <c:if test="${empty filesList}">
                    <div class="no-file">첨부파일이 없습니다.</div>
                </c:if>
            </div>


            <!-- 본문 -->
            <div class="detail-content">
                ${dto.content }
            </div>

            <!-- 버튼 -->
            <div class="detail-actions">
                <button onclick="location.href='/qna/qna'">목록</button>
                <c:if test="${loginId == dto.member_id }">
                    <button onclick="location.href='/qna/toUpdate?seq=${dto.seq}'">수정</button>
                    <button type="button" class="qna-delete-btn">삭제</button>
                </c:if>
            </div>

        </div>

        <!-- 댓글 영역 -->
        <div class="comment-section">
    <h3 class="comment-title">답변</h3>

    <div class="comment-list">
        <c:choose>
            <c:when test="${empty list}">
                <p class="no-reply">등록된 답변이 없습니다.</p>
            </c:when>
            
            <c:otherwise>
                <c:forEach var="comment" items="${list}">
                    <div class="reply-card">
                        <div class="reply-card-header">
                            <strong>
                                <i class="fa-solid fa-headset"></i>관리자 답변
                            </strong>
                            <span class="reply-card-date">
                                <fmt:formatDate value="${comment.write_date}" pattern="yyyy-MM-dd HH:mm" />
                            </span>
                        </div>
                        
                        <div class="reply-card-content">${comment.content}</div>
                        
                        <c:if test="${loginId == comment.member_id}">
                            <div class="reply-card-footer">
                                <button type="button" class="btn-reply-del" onclick="deleteReply(${comment.seq})">
                                    삭제
                                </button>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>
    
</div>
<div class="container-footer">
    <p>© 2026 돈워리. All rights reserved.</p>
    <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침 | 이용약관 | 고객센터</p>
</div>
<script>

$(".qna-delete-btn").on("click",function(){
	 if (!confirm("정말 삭제하시겠습니까?")) {
		return false;
	}
	 location.href = "/qna/delete?seq="+${dto.seq}
})


</script>
</body>
</html>