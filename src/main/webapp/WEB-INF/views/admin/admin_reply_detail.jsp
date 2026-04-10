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
            word-break: break-all;
            margin-top: 30px;
            font-size: 17px;
            /* 기존 15 → 크게 */
            line-height: 1.9;
            /* 가독성 핵심 */
            color: #333;
            min-height: 300px;
            word-break: break-all;
        }
        .detail-content img{
	        max-width: 100%;    /* 부모 너비를 넘지 않음 */
		    height: auto;       /* 비율 유지 */
		    display: block;     /* 하단 여백 제거 */
		    margin: 10px 0;    /* 이미지 위아래 여백 */
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


        /* 리스트 */
        .comment-list {
        word-break: break-all;
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
        .highlight {
		    background-color: #eef6ff !important; /* 연한 파랑 */
		    /* border: 2px solid dodgerblue !important; /* 강조 테두리 */
		    border-radius: 5px;
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
                <button onclick="location.href='/admin/admin_reply?page=${currentPage}'">목록</button>
            </div>

        </div>

        <!-- 댓글 영역 -->
        <div class="comment-section">

            <h3 class="comment-title">댓글 3</h3>

            <!-- 댓글 작성 -->

            <!-- 댓글 리스트 -->
            <div class="comment-list">
			    <c:forEach var="comment" items="${replyList}">
			        <div class="comment-item ${comment.seq eq reply_seq ? 'highlight' : ''}" 
			             id="reply${comment.seq}" data-seq="${comment.seq}">
			            
			            <div class="comment-header">
			                <div class="comment-left">
			                    <span class="comment-writer">${comment.member_id}</span>
			                    <span class="divider">|</span>
			                    <span class="comment-date">${comment.write_date_str}</span>
			                </div>
			            </div>
			            <div class="comment-content">${comment.content}</div>
			
			            <div class="reply-list">
			                <c:forEach var="reply" items="${comment.replies}">
			                    <div class="reply-item ${reply.seq eq reply_seq ? 'highlight' : ''}" 
			                         id="reply${reply.seq}" data-seq="${reply.seq}">
			                        <div class="comment-header">
			                            <div class="comment-left">
			                                <span class="comment-writer">${reply.member_id}</span>
			                                <span class="divider">|</span>
			                                <span class="comment-date">${reply.write_date_str}</span>
			                            </div>
			                        </div>
			                        <div class="comment-content">${reply.content}</div>
			                    </div>
			                </c:forEach>
			            </div>
			        </div>
			    </c:forEach>
			</div>
        </div>
    </div>

    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
  
     <script>
      	$(document).ready(function(){
      	// 강조할 댓글 번호가 있다면
      	    let targetSeq = "${reply_seq}";
      	    if(targetSeq && targetSeq !== "") {
      	        let targetElement = $("#reply" + targetSeq);
      	        if(targetElement.length>0) {
      	        	targetElement.addClass("highlight");
      	            // 해당 위치로 부드럽게 스크롤 이동
      	            $('html, body').animate({
      	                scrollTop: targetElement.offset().top - 150 
      	            }, 500);
      	        }
      	    }
      	});
     </script>
</body>
</html>