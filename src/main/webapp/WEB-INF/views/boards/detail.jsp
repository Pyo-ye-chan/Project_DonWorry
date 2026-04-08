<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>돈워리 - 게시물</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* [1] 원본 초기화 및 레이아웃 유지 */
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

        /* [2] 상단바 포함 컨테이너 (사용자 원본 1100px 완벽 유지) */
        .community-container {
            max-width: 1100px;
            width: 100%;
            margin: 0 auto;
            padding: 0 20px;
            flex: 1;
            /* 컨텐츠가 적을 때 푸터를 아래로 밀어주는 최소한의 장치 */
        }

        .logout-btn {
            width: 60px;
            height: 30px;
            background-color: #ffffff;
            color: #868e96;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            font-size: 13px;
            transition: all 0.2s ease;
            /* 부드러운 변화를 위해 추가 */
        }

        .logout-btn:hover {
            width: 60px;
            height: 30px;
            background-color: #f8f9fa;
            color: #495057;
            border-color: #ced4da;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            font-size: 13px;
            transition: all 0.2s ease;
            /* 부드러운 변화를 위해 추가 */
        }

        /*관리자 버튼*/
        .now-admin {
            width: 60px;
            height: 30px;
            background-color: #2563eb;
            color: white;
            display: flex;
            align-items: center;
            /*세로 중앙 정렬*/
            justify-content: center;
            /* 가로 중앙 정렬 */
            border-radius: 6px;
            border: none;
            font-size: 13px;
            cursor: pointer;
        }

        /*기업 버튼*/
        .now-business {
            width: 60px;
            height: 30px;
            background-color: #2563eb;
            color: white;
            display: flex;
            align-items: center;
            /*세로 중앙 정렬*/
            justify-content: center;
            /* 가로 중앙 정렬 */
            border-radius: 6px;
            border: none;
            font-size: 13px;
            cursor: pointer;
        }

        /*개인 버튼*/
        .now-personal {
            width: 60px;
            height: 30px;
            background-color: #2563eb;
            color: white;
            display: flex;
            align-items: center;
            /*세로 중앙 정렬*/
            justify-content: center;
            /* 가로 중앙 정렬 */
            border-radius: 6px;
            border: none;
            font-size: 13px;
            cursor: pointer;
        }


        /* [3] 상단바 스타일 (보내주신 원본과 100% 일치) */
        .top-auth {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 15px;
            padding: 8px 0;
        }

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
            gap: 8px;
            text-decoration: none;
            color: #666;
            font-size: 14px;
            font-weight: 500;
            padding: 5px 10px;
            cursor: pointer;
        }

        .nav-menu a.active {
            color: #2563eb;
        }

        .now-admin {
            width: 60px;
            height: 30px;
            background-color: #2563eb;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
        }

        /* [5] 푸터 (상단바와 무관하게 하단 고정 설정) */
        .container-footer {
            border-top: 1px solid #e5e7eb;
            /* 테두리를 상단에만 */
            background-color: #f9fafb;
            /* 너무 어두운 회색 대신 밝은 회색 추천 */
            padding: 40px 0;
            /* % 높이 대신 안쪽 여백으로 높이 확보 */
            margin-top: 80px;
            /* 컨텐츠와의 간격 */
            text-align: center;
            color: #999;
            font-size: 13px;
            width: 100vw;
            /* 화면 끝까지 너비 확장 */
            margin-left: calc(-50vw + 50%);
            /* 컨테이너를 벗어나 화면 꽉 채우기 */
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

        /* 모달 배경 */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }

        /* 모달창 */
        .modal-content {
            background: #fff;
            width: 400px;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .close-modal {
            font-size: 24px;
            cursor: pointer;
            color: #999;
        }

        .report-options label {
            display: block;
            margin-bottom: 10px;
            font-size: 14px;
            cursor: pointer;
        }

        #etcReason {
            width: 100%;
            margin-top: 10px;
            height: 80px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 6px;
            resize: none;
        }

        .modal-footer {
            margin-top: 20px;
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        .btn-cancel {
            padding: 8px 15px;
            border: none;
            background: #eee;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-report-submit {
            padding: 8px 15px;
            border: none;
            background: #ef4444;
            color: #fff;
            border-radius: 6px;
            cursor: pointer;
        }
        /* 제목을 감싸는 영역에 기준점 설정 */
.detail-header {
    position: relative; 
    padding-right: 40px; /* 아이콘이 들어갈 공간 확보 */
}

/* 북마크 별 스타일 및 위치 조정 */
.bookmark-btn {
    position: absolute;
    top: 5px;
    right: 0;
    cursor: pointer;
    font-size: 26px; /* 크기 살짝 키움 */
    color: #ccc;
    transition: all 0.2s ease;
}

.bookmark-btn.active {
    color: #ffc107 !important;
}

.bookmark-btn:hover {
    transform: scale(1.2);
}

    </style>

<body>
    <div class="community-container">
        <c:choose>
            <c:when test="${nickName==null}">
                <div class="top-auth">
                    <span style="font-size: 13px; color: #666; cursor: pointer;">
                        <a href="/members/toLogin" style="text-decoration: none; color:black">
                            <i class="fa-regular fa-user fa-lg"
                                style="color: rgb(203, 203, 203); margin-right:5px;"></i>로그인
                        </a>
                    </span>
                    <!-- 일단 관리자 빼고 다 숨겨둠 -->
                    <a href="/admin/admin_main" style="text-decoration:none;">
                        <div class="now-admin">관리자</div>
                    </a>
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
                <a href="salary/calendar">
                    <i class="fa-regular fa-calendar fa-lg" style="color:rgb(203, 203, 203); margin-right:5px;"></i>
                    급여 캘린더
                </a>
                <a href="#">
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
                <c:choose>
                    <c:when test="${dto.category == 'main'}">메인게시판</c:when>
                    <c:when test="${dto.category == 'free'}">자유게시판</c:when>
                    <c:when test="${dto.category == 'qna'}">질문게시판</c:when>
                    <c:when test="${dto.category == 'review'}">리뷰게시판</c:when>
                </c:choose>
            </div>

            <!-- 제목 -->
            <div class="detail-header">
    <h1 class="detail-title">${dto.title}</h1>
    
    <i class="fa-bookmark bookmark-btn ${dto.bookmarked == 1 ? 'fa-solid active' : 'fa-regular'}" 
       data-seq="${dto.seq}" 
       onclick="toggleBookmark(this)"></i>
</div> <br>

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
                    👁 ${dto.view_count }
                    <span class="report-btn">신고</span>
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
                <button type="button" onclick="location.href=document.referrer">목록</button>
                <c:if test="${loginId == board_writer }">
                    <button onclick="location.href='/boards/toUpdate?seq=${dto.seq}'">수정</button>
                    <button type="button" class="boards-delete-btn">삭제</button>
                </c:if>
            </div>

        </div>

        <!-- 댓글 영역 -->
        <div class="comment-section">

            <h3 class="comment-title">댓글 3</h3>

            <!-- 댓글 작성 -->

            <div class="comment-write">

                <textarea placeholder="댓글을 입력하세요" name="content" class="content"></textarea>
                <button class="reply-insert-btn">등록</button>
            </div>

            <!-- 댓글 리스트 -->
            <div class="comment-list"></div>
        </div>

        <!-- 신고 -->
        <div id="reportModal" class="modal-overlay" style="display: none;">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>신고하기</h3>
                    <span class="close-modal" onclick="closeReportModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <p>신고 사유를 선택해주세요.</p> <br>
                    <input type="hidden" id="reportTargetSeq"> <input type="hidden" id="reportTargetType">
                    <div class="report-options">
                        <label><input type="radio" name="reportReason" value="부적절한 홍보 게시글"> 부적절한 홍보 게시글</label><br>
                        <label><input type="radio" name="reportReason" value="음란물 또는 청소년에게 부적합한 내용"> 음란물/부적합한
                            내용</label><br>
                        <label><input type="radio" name="reportReason" value="명예훼손/사생활 침해"> 명예훼손/사생활 침해</label><br>
                        <label><input type="radio" name="reportReason" value="욕설/비하 발언"> 욕설/비하 발언</label><br>
                        <label><input type="radio" name="reportReason" value="etc"> 기타 (직접 입력)</label>
                    </div>
                    <textarea id="etcReason" placeholder="기타 사유를 입력하세요 (최대 100자)" style="display:none;"></textarea>
                </div>
                <div class="modal-footer">
                    <button class="btn-cancel" onclick="closeReportModal()">취소</button>
                    <button class="btn-report-submit" onclick="submitReport()">신고하기</button>
                </div>
            </div>
        </div>

    </div>

    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
    
    
    
     <script>
         function toggleReply(el) {
           // 모든 입력창 닫기
          	 document.querySelectorAll('.reply-write').forEach(box => {
         	box.style.display = 'none';
          	});

                    const replyBox = el.closest('.comment-item').querySelector('.reply-write');
                    replyBox.style.display = "flex";
         }
         
         function getReplyList(){
        	 $.ajax({
        		 url : "/reply/list",
        		 data : {parent_seq : "${dto.seq}"},
        		 dataType:"json"
        	 }).done(function(data){
        		 $(".comment-title").html("댓글 "+data.totalCount);
        		 appendReplyList(data.list);
        		 
        		// 🔥 댓글 목록을 다 그린 후, URL에 해시(#reply)가 있다면 해당 위치로 이동
        	        if (location.hash) {
        	            let target = $(location.hash);
        	            if (target.length) {
        	                $('html, body').animate({
        	                    scrollTop: target.offset().top - 100 // 상단 여유를 위해 100px 정도 뺌
        	                }, 500);
        	                
        	                // 강조 효과 (선택사항)
        	                target.css("background-color", "#f0f7ff");
        	                setTimeout(() => target.css("background-color", "transparent"), 2000);
        	            }
        	        }
        	 })
         }
         $(document).ready(function(){
        	 
        	    getReplyList();
        	});
         
         function appendReplyList(list){
        	 let html = "";
        	 let loginId = "${loginId}"
        	 let isNotice = "${dto.member_id}" == "admin";
        	 
        	 list.forEach(function(comment){
        		 
        		 html += `<div class="comment-item" data-seq=`+comment.seq+` id="reply` + comment.seq + `">
        		        <div class="comment-header">
        	            <div class="comment-left">
        	                <span class="comment-writer">`+ comment.member_id +`</span>
        	                <span class="divider">|</span>
        	                <span class="comment-date">`+ comment.write_date_str +`</span>
        	            </div>
        	            <div class="comment-actions">
        	                <span onclick="toggleReply(this)">답글</span>`;
        	           
        	                if(loginId == comment.writer){
        	                	
        	                	html+=`
        	                		<span class="reply-edit-btn" onclick="toggleEdit(this)" style="cursor:pointer;">수정</span>
        	                        <span class="reply-delete-btn" style="cursor:pointer;">삭제</span>`;
        	                }
        	                html+=`
        	                <span class="report-btn">신고</span>
        	            </div>


        	        </div>

        	        <div class="comment-content">
        	            `+ comment.content +`
        	        </div>

        	        <div class="reply-write" style="display: none;">
        	            <textarea placeholder="답글을 입력하세요"></textarea>
        	            <button class ="reply-btn">등록</button>
        	        </div>
        	        <div class="reply-list">`;
        	        
        	        if(comment.replies && comment.replies.length > 0){
        	        	comment.replies.forEach(function(reply){
        	        		
        	        		html += `
            	        		<div class="reply-item" data-seq=`+reply.seq+` id="reply` + reply.seq + `"> 
                                <div class="comment-header">
                                    <div class="comment-left">
                                        <span class="comment-writer">`+reply.member_id+`</span>
                                        <span class="divider">|</span>
                                        <span class="comment-date">`+reply.write_date_str+`</span>
                                    </div>
                                    <div class="comment-actions">`;
                                    if(loginId == reply.writer){
                                    	html +=`
                                    		<span class="reply-edit-btn" onclick="toggleEdit(this)" style="cursor:pointer;">수정</span>
                                            <span class="reply-delete-btn" style="cursor:pointer;">삭제</span>`;
                                    }
                                    html +=`	
                                        <span class="report-btn">신고</span>
                                    </div>
                                </div>

                                <div class="comment-content">
                                	`+reply.content+`
                                </div>
                            </div>`;
        	        	})
        	        	    	
        	        }
        	        
        	        html+=`
        	        </div>
        	    </div>`;
        	 })
        	 $(".comment-list").html(html);
         }
         
         
         $(".reply-insert-btn").on("click",function(){
        	 let loginId = "${loginId}"
        	 if(loginId == ""){
        		 alert("로그인 후 입력가능합니다.")
        		 return false;
        	 }
        	 
        	 
        	 $.ajax({
        		 url : "/reply/insert",
        		 data :{parent_seq : "${dto.seq}",
        			 	member_id : "${loginId}",
        			 	content : $(".content").val(),
        			 	re_reply_seq: null},
        		 
        		 type: "post"
        	 }).done(function(){
        		 $(".content").val("")
        		 getReplyList();
        	 })
         })
         $(document).on("click",".reply-btn",function(){
        	 let loginId = "${loginId}"
            	 if(loginId == ""){
            		 alert("로그인 후 입력가능합니다.")
            		 return false;
            	 }
        	 let commentItem = $(this).closest(".comment-item");
			 let parentCommentSeq = commentItem.data("seq"); 
        	 let content = commentItem.find("textarea").val();
        	 
        	 $.ajax({
        		 url : "/reply/insert",
        		 type: "post",
        		 data :{parent_seq : "${dto.seq}",
        			 	member_id : "${loginId}",
    			 		content : content,
    			 		re_reply_seq: parentCommentSeq}     		 
        	 }).done(function(){
        		 getReplyList();
        	 })
         })
         $(".boards-delete-btn").on("click",function(){
        	 if (!confirm("정말 삭제하시겠습니까?")) {
 				return false;
 			}
        	 location.href = "/boards/delete?seq="+${dto.seq}
         })
         $(document).on("click",".reply-delete-btn",function(){
        	 if (!confirm("정말 삭제하시겠습니까?")) {
  				return false;
  			}
        	 let seq = $(this).closest("[data-seq]").data("seq");
  			$.ajax({
  				url : "/reply/delete",
  				data : {seq : seq},
  				type : "post"
  			}).done(function(){
  				getReplyList();
  			})	
        	 
         })
         
         $(document).on("click", ".update-submit-btn", function() {
    		let item = $(this).closest("[data-seq]");
    		let seq = item.data("seq");
    		let content = item.find(".update-content").val();

   		 $.ajax({
        		url: "/reply/update",
       		 type: "post",
        		data: { seq: seq, content: content }
    		}).done(function() {
        		getReplyList(); // 수정 후 목록 갱신
    		});
		});
         function toggleEdit(el) {
        	    // 1. 다른 수정창이 열려있다면 초기화 (중복 방지)
        	    //getReplyList(); 

        	    // 2. 클릭한 버튼의 부모(댓글 아이템) 찾기
        	    const item = $(el).closest("[data-seq]");
        	    
        	    // 3. 기존 내용 가져오기 (.comment-content 안의 텍스트)
        	    // .html() 대신 .text()를 써야 <br> 태그 등이 텍스트로 꼬이지 않습니다.
        	    const contentBox = item.find(".comment-content").first();
        	    const originalContent = contentBox.text().trim();;

        	    // 4. 기존 내용을 지우고 '수정용 UI' 주입
        	    // 기존 .comment-write 클래스를 활용해 디자인을 통일합니다.
        	    item.find(".comment-content").first().html(`
        	        <div class="comment-write" style="margin-top:10px; display:flex; gap:10px;">
        	            <textarea class="update-content" style="flex:1; height:80px;">`+originalContent+`</textarea>
        	            <div class="edit-btn-group" style="display:flex; flex-direction:column; gap:5px;">
        	                <button class="update-submit-btn" style="width:80px; height:40px; background-color:#2563eb; color:white; border:none; border-radius:8px; cursor:pointer;">저장</button>
        	                <button type="button" onclick="getReplyList()" style="width:80px; height:40px; background-color:#6b7280; color:white; border:none; border-radius:8px; cursor:pointer;">취소</button>
        	            </div>
        	        </div>
        	    `);
        	    
        	    // 5. 버튼들(답글/수정/삭제)은 수정 중에는 안 보이게 숨김
        	    item.find(".comment-actions").hide();
        	}
         
      // 1. 모달 열기 (게시글용)
         $(document).on("click", ".post-detail .report-btn", function () {
        	 let loginId = "${loginId}"
            	 if(loginId == ""){
            		 alert("로그인 후 이용가능합니다.")
            		 return false;
            	 }
             openReportModal("${dto.seq}", "board");
         });

         // 2. 모달 열기 (댓글/대댓글용)
         $(document).on("click", ".comment-item .report-btn", function () {
        	 let loginId = "${loginId}"
            	 if(loginId == ""){
            		 alert("로그인 후 이용가능합니다.")
            		 return false;
            	 }
             let seq = $(this).closest("[data-seq]").data("seq");
             openReportModal(seq, "reply");
         });

         function openReportModal(seq, type) {
             $("#reportTargetSeq").val(seq);
             $("#reportTargetType").val(type);
             $("#reportModal").show();
         }

         function closeReportModal() {
             $("#reportModal").hide();
             $("input[name='reportReason']").prop("checked", false);
             $("#etcReason").hide().val("");
         }

         // "기타" 선택 시 텍스트 영역 보이기
         $(document).on("change", "input[name='reportReason']", function () {
             if ($(this).val() === "etc") {
                 $("#etcReason").show().focus();
             } else {
                 $("#etcReason").hide();
             }
         });

         // 3. 서버로 데이터 전송
         function submitReport() {
             let targetSeq = $("#reportTargetSeq").val();
             let targetType = $("#reportTargetType").val();
             let reason = $("input[name='reportReason']:checked").val();
             let loginId = "${loginId}";

             if (!reason) {
                 alert("신고 사유를 선택해주세요.");
                 return;
             }

             if (reason === "etc") {
                 reason = $("#etcReason").val().trim();
                 if (reason === "") {
                     alert("상세 사유를 입력해주세요.");
                     return;
                 }
             }
             let sendData = {reason : reason,
            		 member_id : loginId}
             if (targetType === "board") {
                 sendData.boards_seq = targetSeq;
             } else {
                 sendData.reply_seq = targetSeq;
                 sendData.boards_seq = "${dto.seq}";
             }

             $.ajax({
                 url: "/report/report", // 서버 컨트롤러 경로
                 type: "POST",
                 data: sendData
                     
                 
             }).done(function (resp) {
            	 if(resp === "success") {
            	        alert("신고가 정상적으로 접수되었습니다.");
            	        closeReportModal(); // 모달 닫기
            	    }else if(resp === "already_reported"){
            	    	alert("이미 신고하신 내역이 존재합니다.");
            	    	closeReportModal();          	        
            	    }else{
            	    	alert("신고 접수에 실패했습니다. 다시 시도해주세요.");
            	    }
             })
         }
         function toggleBookmark(obj) {
        	    // 1. 이벤트 전파 방지 (만약 부모 요소에 클릭 이벤트가 걸려있을 경우를 대비)
        	    if (window.event) window.event.stopPropagation();
        	    
        	    // 2. data-seq 값 가져오기
        	    let boardSeq = $(obj).data("seq");

        	    $.ajax({
        	        url: "/bookmark/toggle",
        	        type: "POST",
        	        data: { board_seq: boardSeq },
        	        success: function(res) {
        	            if (res === "added") {
        	                // 채워진 별로 변경
        	                $(obj).addClass("fa-solid active").removeClass("fa-regular");
        	            } else if (res === "removed") {
        	                // 빈 별로 변경
        	                $(obj).addClass("fa-regular").removeClass("fa-solid active");
        	            } else if (res === "login_required") {
        	                alert("로그인이 필요한 서비스입니다.");
        	                // 필요하다면 로그인 페이지로 유도
        	                // location.href = "/member/login";
        	            }
        	        },
        	        error: function() {
        	            alert("서버 통신 중 오류가 발생했습니다.");
        	        }
        	    });
        	}
     </script>
</body>
</html>