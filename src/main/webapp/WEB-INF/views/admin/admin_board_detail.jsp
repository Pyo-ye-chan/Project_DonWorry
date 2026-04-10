<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  
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

    </style>

<body>
    <div class="community-container">
        <div class="top-auth">  
        <span style="font-size: 13px; color: #666; cursor: pointer;">
        	<i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
            	${nickName}님 환영합니다.
            <a href="/members/logout" style="text-decoration: none; color:black">
            <button class="logout-btn" style="margin-left:10px;">로그아웃</button>              
            </a>
        </span>
		<c:if test="${type=='관리자'}">
            <a href="/admin/admin_main" style="text-decoration:none;"><div class="now-admin">관리자</div></a>
		</c:if>
    </div>
   <nav class="navbar">
        <div style="display: flex; align-items: center; gap: 40px;">
            <a href="/" class="logo">돈워리</a>

            <div class="nav-menu">
                <a href="/admin/admin_main" >
                   <i class="fa-solid fa-wrench fa-lg" style="color: rgb(197, 197, 197); margin-right:6px;"></i>
                    관리자 대시보드
                </a> 
                <a href="/admin/admin_boards"  class="active">
                   <i class="fa-solid fa-file-pen fa-lg" style="color: rgb(36, 99, 235); margin-right:6px;"></i>
                    게시물 관리
                </a>  
                <a href="/admin/admin_members">
                   <i class="fa-solid fa-user-shield fa-lg" style="color: rgb(197, 197, 197);  margin-right:6px;"></i>
                    회원 관리
                </a> 
                <a href="/admin/admin_inquiry">
                   <i class="fa-regular fa-circle-question fa-lg" style="color: rgb(197, 197, 197); margin-right:6px;"></i>
                    Q&A 관리
                </a>               
            </div>
        </div>
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
                <button onclick="location.href='/admin/admin_boards?page=${currentPage}'">목록</button>
                <button type="button" class="board-del-btn" data-seq="${dto.seq}">삭제</button>
            </div>

        </div>

    </div>

    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
     
<script>
	//삭제 버튼 클릭
	$(document).on("click",".board-del-btn",function(){
		let seq = $(this).data("seq");
		let page = "${currentPage}" || "1";
		location.href='/admin/admin_board_delete?seq='+seq+'&page='+page;
	});
</script>
</body>
</html>