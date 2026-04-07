<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>관리자 - 회원 게시물 관리</title>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
/* ===== Reset ===== */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* ===== Base ===== */
body {
   font-family: 'Pretendard', sans-serif;
    background-color: #ffffff;
    line-height: 1.6;
    min-height: 105vh;
    display: flex;
    flex-direction: column;
    overflow-x: hidden;
}

.container {
    max-width: 1100px;
    width: 100%; 
    margin: 0 auto;
    padding: 0 20px;
    flex: 1; /* 컨텐츠가 적을 때 푸터를 아래로 밀어주는 최소한의 장치 */
}

/* ===== Header ===== */
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

.nav-menu a.active {
    color: #2563eb;
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
.now-admin{
    width: 60px;
    height: 30px;
    background: #2563eb;
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 6px;
    font-size: 13px;
}

/* ===== Page Layout ===== */
.admin-page {
    padding: 36px 0 0;
    min-height: 800px;
}

.page-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin-bottom: 28px;
    gap: 20px;
}

.page-title h2 {
    font-size: 28px;
    font-weight: 800;
    color: #1e293b;
    margin-bottom: 6px;
    padding-left: 10px;
}

.page-title p {
    font-size: 14px;
    color: #64748b;
    padding-left: 10px;
}

/* ===== Summary Cards ===== */
.summary-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 18px;
    margin-bottom: 22px;
}

.summary-card,
.panel {
    background: #fff;
    border: 1px solid #e7eef8;
    border-radius: 18px;
    padding: 22px;
}

.summary-label {
    font-size: 14px;
    color: #64748b;
    margin-bottom: 8px;
    font-weight: 600;
}

.summary-value {
    font-size: 28px;
    font-weight: 800;
    color: #0f172a;
}

.summary-sub {
    margin-top: 6px;
    font-size: 13px;
    /* color: #2563eb; */
    color: #0f172a;
}

/* ===== Panel ===== */
.panel {
    margin-bottom: 22px;
}

.panel-head {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 18px;
}

.panel-head h3 {
    margin: 0;
    font-size: 18px;
    font-weight: 800;
    color: #1e293b;
}

/* ===== Filter ===== */
.filter-row {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
    align-items: center;
    margin-bottom: 18px;
}

.filter-row select,
.filter-row input {
    height: 42px;
    border: 1px solid #dbe3ef;
    border-radius: 10px;
    padding: 0 12px;
    font-size: 14px;
    outline: none;
}

.filter-row input {
    min-width: 250px;
    flex: 1;
}

/* ===== Buttons ===== */
.btn-blue {
    height: 42px;
    border: none;
    border-radius: 10px;
    padding: 0 16px;
    background: #2563eb;
    color: #fff;
    font-size: 14px;
    font-weight: 700;
}

.board-detail-btn {
    height: 34px;
    border: 1px solid #cfe0ff;
    border-radius: 8px;
    padding: 0 12px;
    background: #f8fbff;
    color: #2563eb;
    font-size: 13px;
    font-weight: 700;
}

.board-del-btn {
    height: 34px;
    border: none;
    border-radius: 8px;
    padding: 0 12px;
    background: #ef4444;
    color: #fff;
    font-size: 13px;
    font-weight: 700;
}

/* ===== Table ===== */
.admin-table {
    width: 100%;
    border-collapse: collapse;
}

.admin-table th,
.admin-table td {
    padding: 14px 10px;
    border-bottom: 1px solid #eef2f7;
    font-size: 14px;
    vertical-align: middle;
}

.admin-table th {
    text-align: center;
    background: #fafcff;
    color: #64748b;
    font-weight: 700;
}

.admin-table td {
    text-align: center;
}

.admin-table tbody tr:hover {
    background: #f8fbff;
}

/* ===== Status ===== */
.state-pill {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 64px;
    padding: 6px 10px;
    border-radius: 999px;
    font-size: 12px;
    font-weight: 700;
}

.state-show {
    background: #eaf4ff;
    color: #2563eb;
}

.state-hide {
    background: #ffe9e9;
    color: #dc2626;
}

/* ===== Pagination ===== */
.pagination-wrap {
    display: flex;
    justify-content: center;
    gap: 8px;
    margin-top: 20px;
}

.page-btn {
    min-width: 34px;
    height: 34px;
    border: 1px solid #dbe3ef;
    border-radius: 8px;
    background: #fff;
    color: #475569;
    font-size: 13px;
}

.page-btn.active {
    background: #2563eb;
    color: #fff;
    border-color: #2563eb;
}

/* ===== Footer ===== */
.container-footer {
    border-top: 1px solid #e5e7eb;
    background: #f9fafb;
    padding: 40px 0;
    margin-top: 80px;
    text-align: center;
    color: #999;
    font-size: 13px;
    width: 100vw;
    margin-left: calc(-50vw + 50%);
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
        .btn-red {
    background-color: #fff;
    color: #ef4444;
    border: 1px solid #fee2e2;
    padding: 5px 12px;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.2s;
    font-weight: 600; /* 글자 두께 통일 */
}

.btn-red:hover {
    background-color: #ef4444;
    color: #fff;
    border-color: #ef4444;
}
/* 수정 버튼 (노란색/엠버 계열) */
.btn-yellow {
    background-color: #fff;
    color: #f59e0b; /* 따뜻한 노란색 */
    border: 1px solid #fef3c7;
    padding: 5px 12px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 12px;
    font-weight: 600;
    transition: all 0.2s;
    margin-right: 5px; /* 삭제 버튼과의 간격 */
}

.btn-yellow:hover {
    background-color: #f59e0b;
    color: #fff;
    border-color: #f59e0b;
}



</style>
</head>
<body>
<div class="container">
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
                <a href="/admin/admin_boards"  >
                   <i class="fa-solid fa-file-pen fa-lg" style="color: rgb(197, 197, 197); margin-right:6px;"></i>
                    게시물 관리
                </a>  
                <a href="/admin/admin_members">
                   <i class="fa-solid fa-user-shield fa-lg" style="color: rgb(197, 197, 197);  margin-right:6px;"></i>
                    회원 관리
                </a> 
                <a href="/admin/admin_inquiry" class="active">
                   <i class="fa-regular fa-circle-question fa-lg" style="color: rgb(36, 99, 235); margin-right:6px;"></i>
                    Q&A 관리
                </a>               
            </div>
        </div>
    </nav>
    <main class="admin-page">
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
                    <span id = "status" class="status-badge ${dto.status == 'status-complete' ? 'status-complete' : 'status-waiting'}">
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
                <button onclick="location.href='/admin/admin_inquiry'">목록</button>
                <c:if test="${loginId == dto.member_id }">
                    <button onclick="location.href='/qna/toUpdate?seq=${dto.seq}'">수정</button>
                    <button type="button" class="qna-delete-btn">삭제</button>
                </c:if>
            </div>

        </div>

        <!-- 댓글 영역 -->
        <div class="comment-section">

            <h3 class="comment-title">답변</h3>

            <!-- 댓글 작성 -->
			<c:if test="${type=='관리자'}">
            <div class="comment-write">

                <textarea placeholder="답변할 내용을 입력하세요" name="content" class="content"></textarea>
                <button class="reply-insert-btn">등록</button>
            </div>
			</c:if>
            <!-- 댓글 리스트 -->
            <div class="comment-list"></div>
        </div>

    </main>
</div>

    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top:10px; font-size:11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
<script>
$(document).ready(function() {
    getReplyList();
});

// 1. 답변 등록
$(".reply-insert-btn").on("click", function() {
	
	
    let content = $(".content").val().trim();
    if(content === "") { alert("내용을 입력해주세요."); return; }

    $.ajax({
        url: "/qna_reply/insert",
        type: "post",
        data: {
            qna_num: "${dto.seq}", // 원본 문의글 번호
            content: content
        }
    }).done(function(resp) {
        if(resp === "success") {
            $(".reply-content").val("");
            getReplyList(); // 목록 갱신
            // 관리자 답변은 보통 1개이므로 입력창을 숨기기도 함
            $(".comment-write").hide();
            $("#status").removeClass("status-waiting").addClass("status-complete");
        } else {
            alert("권한이 없거나 등록에 실패했습니다.");
        }
    });
});

// 2. 답변 목록 불러오기
function getReplyList() {
    $.ajax({
        url: "/qna_reply/list",
        data: { qna_num: "${dto.seq}" }, // 이건 JSP 데이터니까 그대로 둡니다.
        dataType: "json"
    }).done(function(list) {
        var html = "";
        var loginId = "${loginId}"; // JSP 세션 데이터
        
        if (!list || list.length === 0) {
            html = '<p style="padding:20px; color:#94a3b8; text-align:center;">등록된 답변이 없습니다.</p>';
        } else {
        	$(".comment-write").hide();
            for (var i = 0; i < list.length; i++) {
                var comment = list[i];
                
                html += '<div class="comment-item" style="background:#f8fafc; padding:20px; margin-bottom:15px; border-left:5px solid #2563eb; border-radius:8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">';
                
                // 헤더 영역
                html += '  <div class="comment-header" style="display:flex; justify-content:space-between; align-items:center; margin-bottom:12px;">';
                html += '    <strong style="color:#1e293b;"><i class="fa-solid fa-headset" style="margin-right:6px; color:#2563eb;"></i>관리자 답변</strong>';
                html += '    <span style="font-size:13px; color:#94a3b8;">' + comment.write_date_str + '</span>';
                html += '  </div>';
                
                // 내용 영역
                html += '  <div class="comment-content" style="color:#334155; line-height:1.6; white-space:pre-wrap;">' + comment.content + '</div>';
                
                // 버튼 영역 (삭제 등)
                html += '  <div class="comment-actions" style="text-align:right; margin-top:15px;">';
                if (loginId === comment.member_id) {
                	// 수정 버튼 (필요하다면 data-seq 추가)
                    html += '    <button class="btn-yellow" data-seq="' + comment.seq + '" style="padding:4px 10px; font-size:12px;">수정</button>';
                    // 삭제 버튼 (data-seq 추가)
                    html += '    <button class="btn-red" data-seq="' + comment.seq + '" style="padding:4px 10px; font-size:12px;">삭제</button>';
                }
                html += '  </div>';
                
                html += '</div>';
            }
        }
        $(".comment-list").html(html);
    });
}
$(document).on("click", ".btn-red", function() {
    if (!confirm("정말 삭제하시겠습니까?")) {
        return false;
    }

    // 클릭된 버튼의 data-seq 값을 가져옴
    let seq = $(this).attr("data-seq");
    let qna_num = "${dto.seq}"; // 현재 상세 페이지의 부모 글 번호

    $.ajax({
        url: "/qna_reply/delete", // Q&A 답변 전용 컨트롤러
        type: "post",
        data: { 
            seq: seq,
            qna_num: qna_num // 상태 변경(접수중으로 복구)을 위해 부모 번호도 함께 보냄
        }
    }).done(function(resp) {
        if(resp === "success") {
            alert("답변이 삭제되었습니다.");
            getReplyList(); // 목록 새로고침
            
            // 답변이 삭제되었으므로 상태를 '접수중'으로 변경
            $("#status").removeClass("status-complete").addClass("status-waiting").text("접수중");
            // 관리자라면 다시 답변을 달 수 있게 입력창 표시
            $(".comment-write").show();
        } else {
            alert("삭제에 실패했습니다.");
        }
    });
});
//1. 수정 버튼 클릭 시 (입력창으로 변환)
$(document).on("click", ".btn-yellow", function() {
    let parent = $(this).closest(".comment-item"); // 현재 댓글 컨테이너
    let content = parent.find(".comment-content").text(); // 기존 내용 추출
    let seq = $(this).attr("data-seq"); // 댓글 번호

    // 기존 내용을 textarea와 저장/취소 버튼으로 교체
    let editHtml = '<div class="edit-box">';
    editHtml += '  <textarea class="form-control edit-content" style="width:100%; height:80px; margin-bottom:10px;">' + content + '</textarea>';
    editHtml += '  <div style="text-align:right;">';
    editHtml += '    <button class="btn-blue update-submit-btn" data-seq="' + seq + '" style="height:30px; padding:0 10px; font-size:12px;">저장</button>';
    editHtml += '    <button class="btn-gray update-cancel-btn" style="height:30px; padding:0 10px; font-size:12px; background:#94a3b8; color:white; border:none; border-radius:6px; margin-left:5px;">취소</button>';
    editHtml += '  </div>';
    editHtml += '</div>';

    parent.find(".comment-content").hide(); // 기존 텍스트 숨기기
    parent.find(".comment-actions").hide(); // 기존 버튼 숨기기
    parent.append(editHtml); // 수정 창 추가
});

// 2. 수정 취소 시
$(document).on("click", ".update-cancel-btn", function() {
    let parent = $(this).closest(".comment-item");
    parent.find(".edit-box").remove(); // 수정창 제거
    parent.find(".comment-content").show(); // 원본 텍스트 표시
    parent.find(".comment-actions").show(); // 원본 버튼 표시
});

// 3. 수정 완료(저장) 버튼 클릭 시
$(document).on("click", ".update-submit-btn", function() {
    let seq = $(this).attr("data-seq");
    let content = $(this).closest(".edit-box").find(".edit-content").val();

    if(content.trim() === "") {
        alert("내용을 입력해주세요.");
        return;
    }

    $.ajax({
        url: "/qna_reply/update",
        type: "post",
        data: {
            seq: seq,
            content: content
        }
    }).done(function(resp) {
        if(resp === "success") {
            alert("수정되었습니다.");
            getReplyList(); // 목록 새로고침
        } else {
            alert("수정에 실패했습니다.");
        }
    });
});
</script>
</body>
</html>