<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
        /* 기존 공통 스타일 유지 */
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

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }

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

        .logout-btn {
            width: 60px;
            height: 30px;
            background-color: #ffffff;
            color: #868e96;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            font-size: 13px;
            transition: all 0.2s ease;
        }

        .logout-btn:hover {
            background-color: #f8f9fa;
            color: #495057;
            border-color: #ced4da;
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
            border: none;
            font-size: 13px;
            cursor: pointer;
        }

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

        .page-title-wrap h2 {
            font-size: 30px;
            font-weight: 800;
            color: #1e293b;
            margin-bottom: 6px;
            padding-left: 10px;
        }

        .page-title-wrap p {
            font-size: 14px;
            color: #64748b;
            padding-left: 10px;
        }

        .page-date-box {
            background: #fff;
            padding: 12px 16px;
            font-size: 15px;
            color: #475569;
        }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-bottom: 22px;
        }

        .summary-card {
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
            font-size: 30px;
            font-weight: 800;
            color: #0f172a;
        }

        .summary-desc {
            font-size: 13px;
            color: #2563eb;
            margin-top: 6px;
        }

        .panel {
            background: #fff;
            border: 1px solid #e7eef8;
            border-radius: 18px;
            padding: 22px;
            margin-bottom: 40px;
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
            min-width: 260px;
            flex: 1;
        }

        .btn-search {
            height: 42px;
            border: none;
            border-radius: 10px;
            padding: 0 16px;
            background: #2563eb;
            color: #fff;
            font-size: 14px;
            font-weight: 700;
        }

        .admin-table {
            width: 100%;
            table-layout: fixed; /* 컬럼 너비를 고정함 */
            border-collapse: collapse;
        }
        /* [2] 제목 셀 말줄임 처리 스타일 */
.ellipsis-cell {
    white-space: nowrap;      /* 줄바꿈 금지 */
    overflow: hidden;         /* 넘치는 부분 숨김 */
    text-overflow: ellipsis;  /* 넘치면 ... 표시 */
    text-align: center; 
    padding-left: 20px !important;
}

/* [3] 각 컬럼별 너비 지정 (합계 100% 혹은 px) */
.col-seq { width: 80px; }
.col-title { width: auto; } /* 제목이 남은 공간 다 차지 */
.col-author { width: 120px; }
.col-date { width: 150px; }
.col-status { width: 120px; }

        .admin-table th,
        .admin-table td {
            padding: 14px 10px;
            border-bottom: 1px solid #eef2f7;
            font-size: 14px;
            text-align: center;
        }

        .admin-table th {
            background-color: #fafcff;
            color: #64748b;
            font-weight: 700;
        }

        .admin-table tbody tr:hover {
            background-color: #f8fbff;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 72px;
            padding: 6px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 700;
        }

        .status-wait {
            background: #fff4db;
            color: #d97706;
        }

        .status-done {
            background: #eaf4ff;
            color: #2563eb;
        }

        .pagination-wrap {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin-top: 22px;
        }

        .page-btn {
            min-width: 34px;
            height: 34px;
            border: 1px solid #dbe3ef;
            border-radius: 8px;
            background: #fff;
            color: #475569;
            font-size: 13px;
            cursor: pointer;
        }

        .page-btn.active {
            background: #2563eb;
            color: #fff;
            border-color: #2563eb;
        }

        .container-footer {
            border-top: 1px solid #e5e7eb;
            background-color: #f9fafb;
            padding: 40px 0;
            margin-top: 80px;
            text-align: center;
            color: #999;
            font-size: 13px;
            width: 100vw;
            margin-left: calc(-50vw + 50%);
        }

        /* FAQ 등록 전용 스타일 - 파란색 선 제거 및 panel 스타일 통일 */
        .faq-panel {
            margin-bottom: 24px;
        }

        .faq-quick-form {
            display: none;
            background: #f8fafc;
            border-top: 1px dashed #cbd5e1;
            padding: 20px;
            margin-top: 15px;
            border-radius: 12px;
        }

        .faq-input-group {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .faq-input-item {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .faq-input-item label {
            font-size: 13px;
            font-weight: 700;
            color: #475569;
        }

        .faq-input-item input,
        .faq-input-item textarea {
            width: 100%;
            border: 1px solid #dbe3ef;
            border-radius: 8px;
            padding: 10px 12px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }

        .faq-input-item input:focus,
        .faq-input-item textarea:focus {
            border-color: #2563eb;
        }

        .faq-form-btns {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 15px;
        }

        .btn-save {
            background: #2563eb;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 13px;
            cursor: pointer;
        }

        .btn-cancel {
            background: #fff;
            color: #64748b;
            border: 1px solid #dbe3ef;
            padding: 8px 16px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
        }

        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .nav-menu {
                gap: 16px;
                flex-wrap: wrap;
            }

            .filter-row {
                flex-direction: column;
                align-items: stretch;
            }

            .filter-row select,
            .filter-row input,
            .btn-search {
                width: 100%;
            }
        }
        .sort-input {
            width: 50px;
            text-align: center;
            border: 1px solid #dbe3ef;
            border-radius: 4px;
        }

        .btn-sm-delete {
            padding: 4px 8px;
            font-size: 12px;
            background: #fff1f2;
            color: #e11d48;
            border: 1px solid #fecdd3;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-sm-delete:hover {
            background: #ffe4e6;
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
                   <i class="fa-solid fa-wrench fa-lg" style="color:  rgb(197, 197, 197); margin-right:6px;"></i>
                    관리자 대시보드
                </a> 
                <a href="/admin/admin_boards">
                   <i class="fa-solid fa-file-pen fa-lg" style="color: rgb(197, 197, 197); margin-right:6px;"></i>
                    게시물 관리
                </a>  
                <a href="/admin/admin_members">
                   <i class="fa-solid fa-user-shield fa-lg" style="color: rgb(197, 197, 197);  margin-right:6px;"></i>
                    회원 관리
                </a> 
                <a href="/admin/admin_inquiry"  class="active">
                   <i class="fa-regular fa-circle-question fa-lg" style="color: rgb(36, 99, 235); margin-right:6px;"></i>
                    Q&A 관리
                </a>               
            </div>
        </div>
    </nav>

    <main class="admin-page">

        <div class="page-header">
            <div class="page-title-wrap">
                <h2>고객 문의 관리</h2>
                <p>문의 내역을 조회하고 답변 상태를 관리할 수 있습니다.</p>
            </div>

            <div class="page-date-box">
                <i class="fa-regular fa-envelope-open" style="margin-right:6px;"></i>
                미처리 문의 ${waitCount }건
            </div>
        </div>

        <section class="summary-grid">
            <div class="summary-card">
                <div class="summary-label">전체 문의</div>
                <div class="summary-value">${allCount }</div>
                <div class="summary-desc">이번 주 신규 ${weekNewCount }건</div>
            </div>

            <div class="summary-card">
                <div class="summary-label">답변 대기</div>
                <div class="summary-value">${waitCount }</div>
                <div class="summary-desc">24시간 이상 경과 ${overwaitCount }건</div>
            </div>

            <div class="summary-card">
                <div class="summary-label">답변 완료</div>
                <div class="summary-value">${completeCount }</div>
                <div class="summary-desc">평균 처리 시간 <fmt:formatNumber value="${replyTime}" pattern="0.0"/>일</div>
            </div>
        </section>
        
        <section class="panel faq-panel">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <h3 style="margin: 0; font-size: 18px; font-weight: 800; color: #1e293b;">
                            <i class="fa-solid fa-circle-info" style="color: #2563eb; margin-right: 8px;"></i>자주 묻는
                            질문(FAQ) 간편 등록
                        </h3>
                        <p style="margin: 5px 0 0 28px; font-size: 13px; color: #64748b;">문의가 많은 내용은 여기서 바로 FAQ로 등록하세요.
                        </p>
                    </div>
                    <button type="button" class="btn-search" id="btnToggleFaq"
                        style="background: #1e293b; display: flex; align-items: center; gap: 8px;">
                        <i class="fa-solid fa-pen-to-square"></i> 작성하기
                    </button>
                </div>

                <div id="faqForm" class="faq-quick-form">
                    <form id="faqSubmitForm">
                        <div class="faq-input-group">
                            <div class="faq-input-item">
                                <label>질문 제목</label>
                                <input type="text" name="title" placeholder="예: 비밀번호를 잊어버렸어요.">
                            </div>
                            <div class="faq-input-item">
                                <label>답변 내용</label>
                                <textarea name="content" rows="3" placeholder="간결하고 명확하게 답변을 작성해 주세요."></textarea>
                            </div>
                        </div>
                        <div class="faq-form-btns">
                            <button type="button" class="btn-cancel" id="btnCancelFaq">취소</button>
                            <button type="submit" class="btn-save">등록하기</button>
                        </div>
                    </form>
                </div>
            </section>
            
            <section class="panel">
                <div class="panel-head">
                    <h3>등록된 FAQ 목록</h3>
                </div>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th style="width: 80px;">순서</th>
                            <th>질문 제목</th>
                            <th style="width: 100px;">노출</th>
                            <th style="width: 100px;">관리</th>
                        </tr>
                    </thead>
                    <tbody id="faqTableBody">
                    </tbody>
                </table>
                <div class="pagination-wrap" id="faqPaginationBox"></div>
            </section>
            
        

        <section class="panel">
            <div class="panel-head">
                <h3>문의 목록</h3>
            </div>

            <div class="filter-row">
                    <select id="statusFilter">
                        <option value="all">전체 상태</option>
                        <option value="status-waiting">답변 대기</option>
                        <option value="status-complete">답변 완료</option>
                    </select>

                    <input type="text" id="searchInput" placeholder="문의 제목, 작성자 검색">

                    <button type="button" class="btn-search" id="searchBtn">검색</button>
                </div>

                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>문의번호</th>
                            <th colspan='2'>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th colspan='2'>상태</th>
                        </tr>
                    </thead>
                    <tbody id="inquiryTableBody"></tbody>
                </table>

                <div class="pagination-wrap" id="paginationBox"></div>
        </section>

    </main>

    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>

</div>
<script>
$(document).ready(function() {
    // 1. 처음 페이지 로드 시 1페이지 목록 불러오기
    loadInquiryList(1);
    loadAdminFaqList(1);

    // 2. 검색 버튼 클릭 이벤트
    $("#searchBtn").on("click", function() {
        loadInquiryList(1);
    });

    // 3. 상태 필터 변경 시 즉시 검색
    $("#statusFilter").on("change", function() {
        loadInquiryList(1);
    });

    // 4. 엔터키 검색 지원
    $("#searchInput").on("keyup", function(e) {
        if (e.key === "Enter") loadInquiryList(1);
    });

    // 5. 페이지 번호 클릭 이벤트 (동적 생성이므로 document 위임)
    $(document).on("click", ".page-btn", function() {
        const targetPage = $(this).data("page");
        if(targetPage) loadInquiryList(targetPage);
    });
    
 	// FAQ 폼 토글 (열기/닫기)
    $("#btnToggleFaq, #btnCancelFaq").on("click", function () {
        $("#faqForm").slideToggle(300);
    });

    // FAQ 등록 Ajax
    $("#faqSubmitForm").on("submit", function (e) {
        e.preventDefault();
        const title = $("input[name='title']").val();
        const content = $("textarea[name='content']").val();

        if (!title || !content) {
            alert("질문과 답변을 모두 입력해주세요.");
            return;
        }

        $.ajax({
            url: "/admin/api/faq_register",
            type: "POST",
            data: { title: title, content: content },
            success: function (res) {
                alert("FAQ가 성공적으로 등록되었습니다.");
                $("#faqSubmitForm")[0].reset();
                $("#faqForm").slideUp();
                loadAdminFaqList(1); // 등록 후 첫 페이지 갱신
            },
            error: function () {
                alert("등록 중 오류가 발생했습니다.");
            }
        });
    });
});

//FAQ 리스트 불러오기 (페이징 포함)
function loadAdminFaqList(page) {
    $.ajax({
        url: "/admin/api/faq_list",
        type: "GET",
        dataType:"json",
        data: { page: page },
        success: function(res) {
            // 1. 테이블 렌더링
            let html = "";
            if (res.list.length === 0) {
                html = '<tr><td colspan="4" style="padding:40px 0; color:#94a3b8;">등록된 FAQ가 없습니다.</td></tr>';
            } else {
                res.list.forEach(item => {
                	// 상태값에 따른 클래스 미리 계산
                    var statusClass = (item.is_show === 'Y') ? 'status-done' : 'status-wait';
                    
                    html += '<tr>';
                    // 1. 순서 수정 (입력창으로 변경)
                    html += '    <td><input type="number" class="sort-input" min="1" value="' + item.sort_order + '" onchange="updateSort(' + item.seq + ', this.value)"></td>';
                    html += '    <td style="text-align:left; padding-left:20px;">' + item.title + '</td>';
                    // 2. 노출 여부 수정 (배지 클릭 시 토글)
                    html += '    <td><span class="status-badge ' + statusClass + '" style="cursor:pointer" onclick="toggleShow(' + item.seq + ', \'' + item.is_show + '\')">' + item.is_show + '</span></td>';
                    html += '    <td><button class="btn-sm-delete" onclick="deleteFaq(' + item.seq + ')">삭제</button></td>';
                    html += '</tr>';
                });
            }
            $("#faqTableBody").html(html);

            // 2. 페이징 렌더링 (인자로 호출할 함수명을 던짐)
            renderFaqPagination(res.currentPage, res.totalCount, 'loadAdminFaqList');
        }
    });
}

//FAQ 전용 페이징 출력
function renderFaqPagination(currentPage, totalCount, funcName) {
    var recordPerPage = 5;  // 한 페이지에 5개씩 보여주기로 했으므로 5로 수정
    var naviPerPage = 5;
    var totalPage = Math.ceil(totalCount / recordPerPage);
    
    if(totalPage <= 0) {
        $("#faqPaginationBox").html(""); // 데이터 없으면 페이징 삭제
        return;
    }

    var startNavi = Math.floor((currentPage - 1) / naviPerPage) * naviPerPage + 1;
    var endNavi = startNavi + naviPerPage - 1;
    if (endNavi > totalPage) endNavi = totalPage;

    var html = "";
    
    // [이전] 버튼
    if (startNavi > 1) {
        html += '<button class="page-btn" onclick="' + funcName + '(' + (startNavi - 1) + ')">&lt;</button>';
    }
    
    // 숫자 버튼
    for (var i = startNavi; i <= endNavi; i++) {
        var activeClass = (i === currentPage) ? 'active' : '';
        html += '<button class="page-btn ' + activeClass + '" onclick="' + funcName + '(' + i + ')">' + i + '</button>';
    }
    
    // [다음] 버튼
    if (endNavi < totalPage) {
        html += '<button class="page-btn" onclick="' + funcName + '(' + (endNavi + 1) + ')">&gt;</button>';
    }
    
    $("#faqPaginationBox").html(html);
}

//노출 상태 변경 (Y <-> N)
function toggleShow(seq, currentStatus) {
    const nextStatus = (currentStatus === 'Y') ? 'N' : 'Y';
    
    $.ajax({
        url: "/admin/api/faq_toggle_show",
        type: "POST",
        data: { seq: seq, is_show: nextStatus },
        success: function() {
            loadAdminFaqList(1); // 상태 변경 후 목록 갱신
        },
        error: function() {
            alert("상태 변경 중 오류가 발생했습니다.");
        }
    });
}

// 순서 변경 (숫자 입력 시 즉시 반영)
function updateSort(seq, newOrder) {
	
	if (newOrder < 1) {
        alert("순서는 1 이상의 숫자여야 합니다.");
        loadAdminFaqList(1); // 원상복구를 위해 목록 새로고침
        return;
    }
	
    $.ajax({
        url: "/admin/api/faq_update_sort",
        type: "POST",
        data: { seq: seq, sort_order: newOrder },
        success: function() {
            loadAdminFaqList(1); // 순서 변경 후 재정렬을 위해 갱신
        },
        error: function() {
            alert("순서 변경 중 오류가 발생했습니다.");
            loadAdminFaqList(1);
        }
    });
}

// FAQ 삭제
function deleteFaq(seq) {
    if(!confirm("이 FAQ를 삭제하시겠습니까?\n삭제 후 순서는 자동으로 재정렬됩니다.")) return;
    
    $.ajax({
        url: "/admin/api/faq_delete",
        type: "POST",
        data: { seq: seq },
        success: function(res) {
            if(res === "success") {
                alert("삭제되었습니다.");
                loadAdminFaqList(1); // 리스트 새로고침
            }
        }
    });
}

/**
 * 서버로부터 데이터를 받아와 화면을 그리는 핵심 함수
 */
function loadInquiryList(page) {
    const status = $("#statusFilter").val();
    const keyword = $("#searchInput").val();

    $.ajax({
        url: "/admin/api/inquiry_list", // 아까 만든 컨트롤러 주소
        type: "GET",
        data: {
            page: page,
            status: status,
            keyword: keyword
        },
        dataType: "json",
        success: function(res) {
            // 테이블 그리기
            renderTable(res.mainList);
            // 페이징 그리기
            renderPagination(res.currentPage, res.recordTotalCount, res.recordCountPerPage, res.naviCountPerPage);
        },
        error: function(err) {
            console.error("데이터 로드 실패:", err);
            alert("목록을 불러오는 중 오류가 발생했습니다.");
        }
    });
}

/**
 * 테이블 렌더링
 */
function renderTable(list) {
    let html = "";
    if (!list || list.length === 0) {
        html = '<tr><td colspan="6" style="padding:50px 0; color:#94a3b8;">검색 결과가 없습니다.</td></tr>';
    } else {
        list.forEach(item => {
            // 상태에 따른 클래스와 텍스트 분기
            const isWait = item.status === 'status-waiting';
            const badgeClass = isWait ? 'status-wait' : 'status-done';
            const statusText = isWait ? '답변 대기' : '답변 완료';

            html += `
            	<tr onclick="location.href='/admin/qnaDetail?seq=`+item.seq+`'" style="cursor:pointer;">
                    <td>`+item.seq+`</td>
                    <td colspan="2" class="ellipsis-cell" title = item.title>`+item.title+`</td>
                    <td>`+item.member_id+`</td>
                    <td>`+item.write_date_str+`</td>
                    <td colspan="2">`;
                    html += "<span class='status-badge " + badgeClass + "'>" + statusText + "</span>";
                        //<span class="status-badge ${badgeClass}">`+statusText+`</span>
                      html +=`  
                    </td>
                </tr>
            `;
        });
    }
    $("#inquiryTableBody").html(html);
}

/**
 * 페이징 버튼 렌더링
 */
function renderPagination(currentPage, totalCount, recordPerPage, naviPerPage) {
    if (totalCount === 0) {
        $("#paginationBox").empty();
        return;
    }

    const totalPage = Math.ceil(totalCount / recordPerPage);
    const startNavi = Math.floor((currentPage - 1) / naviPerPage) * naviPerPage + 1;
    let endNavi = startNavi + naviPerPage - 1;
    if (endNavi > totalPage) endNavi = totalPage;

    let html = "";

    // 이전 버튼 (<)
    if (startNavi > 1) {
    html += "<button class='page-btn' data-page='" + (startNavi - 1) + "'>&lt;</button>";
}

    // 숫자 버튼
    for (let i = startNavi; i <= endNavi; i++) {
        const activeClass = (i === currentPage) ? "active" : "";
        html += "<button class='page-btn " +activeClass+"' data-page='"+i+"'>"+i+"</button>";
    }

    // 다음 버튼 (>)
    if (endNavi < totalPage) {
        html += "<button class='page-btn' data-page='"+(endNavi + 1)+"'>&gt;</button>";
    }

    $("#paginationBox").html(html);
}


</script>
</body>
</html>