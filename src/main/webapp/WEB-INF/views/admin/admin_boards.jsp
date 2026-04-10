<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
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
    grid-template-columns: repeat(3, 1fr);
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
    table-layout: fixed;/*내용 길이 달라도 칸 크기 안 변함  */
    border-collapse: collapse; /* 내용 길면 .처리  */
}
/*게시글 관리 */
.admin-table th:nth-child(1) { width: 8%; }  /* 번호 */
.admin-table th:nth-child(2) { width: 10%; } /* 게시판 */
.admin-table th:nth-child(3) { width: 25%; } /* 제목 (가장 넓게) */
.admin-table th:nth-child(4) { width: 15%; } /* 작성자 */
.admin-table th:nth-child(5) { width: 12%; } /* 작성일 */
.admin-table th:nth-child(6) { width: 10%; } /* 상태 */
.admin-table th:nth-child(7) { width: 20%; } /* 관리 */

/*신고 게시글 관리 */
.board-report th:nth-child(1) { width: 8%; }  /* 번호 */
/*신고 사유  */
.board-report th:nth-child(2) { 
	width: 25%; 
} 
.board-report td:nth-child(2) { 
    white-space: pre-wrap !important;
    word-break: break-all !important; /* 긴 단어 강제 줄바꿈 */
    text-overflow: clip !important;   /* ... 표시 제거 */
    overflow: visible !important;     /* 넘치는 내용 보이기 */
    height: auto;                     /* 높이 제한 해제 */
 }
/* 제목 */
.board-report th:nth-child(3) {
 	width: auto; 
 	white-space: normal;       /* nowrap 해제: 다음 줄로 넘어가게 함 */
 	word-break: break-all;     /* 긴 영문/숫자 강제 줄바꿈 */
    text-overflow: clip;       /* ... 생략 표시 제거 */
    overflow: visible;         /* 숨김 해제 */
    line-height: 1.5;
 } 
 .board-report td:nth-child(3) {
	white-space: normal;       /* 한 줄 제한 해제 */
    word-break: break-all;     /* 강제 줄바꿈 */
    text-overflow: clip;       /* 생략 제거 */
    overflow: visible;
 }
 /* 작성자 */
.board-report th:nth-child(4) { width: 12%; }
 /* 작성일 */
.board-report th:nth-child(5) { width: 10%; }
.board-report th:nth-child(6) { width: 20%; } /* 관리 */

/*공지글 관리 */
.notice-table th:nth-child(1) { width: 8%; }  /* 번호 */
.notice-table th:nth-child(2) { width: 30%; } /* 제목 */
.notice-table th:nth-child(3) { width: 20%; } /* 작성자 */
.notice-table th:nth-child(4) { width: 12%; } /* 작성일 */
.notice-table th:nth-child(5) { width: 10%; } /* 상태 */
.notice-table th:nth-child(6) { width: 20%; } /* 관리 */

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
    white-space: normal;
    overflow: hidden;
    text-overflow: ellipsis;/*내용길면 ..처리 */
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
/* 신고 상태: 눈에 띄는 빨간색 */
.state-report {
    background-color: #ffe3e3;
    color: #e03131;
    border: 1px solid #ffc9c9;
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
    <main class="admin-page">
        <div class="page-header">
            <div class="page-title">
                <h2>게시물 관리</h2>
                <p>커뮤니티 게시글 조회, 삭제가 가능합니다.</p>
            </div>
        </div>

        <section class="summary-grid">
            <div class="summary-card">
                <div class="summary-label">전체 게시글</div>
                <div class="summary-value">${recordTotalCount}</div>
                <div class="summary-sub">오늘 신규 ${getRecordCountToday}건</div>
            </div>
            <div class="summary-card notice">
                <div class="summary-label">공지 게시글</div>
                <div class="summary-value">6</div>
                <a href="/admin/notice_Towrite" style="color: #2563eb; ">
                	<div class="summary-sub" style="color: #2563eb; ">작성하러 가기</div>
                </a>
            </div>
            <div class="summary-card notice">
                <div class="summary-label">댓글 관리</div>
                <div class="summary-value">${replyCount}</div>
                <a href="/admin/admin_reply" style="color: #2563eb; ">
                	<div class="summary-sub" style="color: #2563eb; ">관리페이지 이동</div>
                </a>
            </div>
        </section>

         <section class="panel">
            <div class="panel-head">
                <h3>게시글 목록</h3>
            </div>
		<form action="/admin/admin_boards" method="get" id="board-searchForm">
            <div class="filter-row">
                <select name="category" class="category-select">
                    <option value="all">전체 상태</option>
                    <option value="report">신고</option>
                    <option value="normal">일반</option>
                </select>
                <input type="text" name="keyword" placeholder="작성자 검색" class="keyword">
                <button class="btn-blue board-search-btn" type="button">검색</button>
                <button class="btn-blue board-all-btn" type="button">전체</button>
            </div>
		</form>
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>게시판</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="i" items="${board_mainList}">
                <c:if test="${i.member_id!='관리자'}">
                    <tr>
                        <td>${i.seq}</td>                       
                        <c:choose>
	                        <c:when test="${i.category =='free'}"><td>자유</td></c:when>
	                        <c:when test="${i.category =='qna'}"><td>질문</td></c:when>
	                        <c:when test="${i.category =='review'}"><td>리뷰</td></c:when>
	                        <c:when test="${i.category =='main'}"><td>메인</td></c:when>
                        </c:choose>                       
                        <td>${i.title}</td>
                        <td>${i.member_id}</td>
                        <td id="write_date">
                        	<fmt:formatDate value="${i.write_date}" pattern="yyyy-MM-dd"/>
                        </td>
                        <c:choose>
                        <c:when test="${i.report_count>0}">
	                        <td>
	                        	<span class="state-pill state-report">
	                        		신고
	                        	</span>
	                        </td>
                        </c:when>
                        <c:otherwise>
	                        <td>
	                        	<span class="state-pill state-show">
	                        		일반
	                        	</span>
	                        </td>
	                    </c:otherwise>
                        </c:choose>
                        <td>
                            <button class="board-detail-btn" type="button" data-seq="${i.seq}">보기</button>
                            <button class="board-del-btn" type="button" data-seq="${i.seq}">삭제</button>
                        </td>
                    </tr>
                    </c:if>
                </c:forEach>                  
                </tbody>
            </table>

            <div class="pagination-wrap" id="admin_board_navi">
            </div>
        </section>
<!-- 게시글 신고 목록 -->
       <section class="panel">
            <div class="panel-head">
                <h3>신고 게시글 목록</h3>
            </div>

            <div class="filter-row">
                <input type="text" name="keyword" placeholder="작성자 검색" class="keyword">
                <button class="btn-blue board-search-btn" type="button">검색</button>
                <button class="btn-blue board-all-btn" type="button">전체</button>
            </div>

            <table class="admin-table board-report">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>신고 사유</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="i" items="${admin_report_boardList}">
                <c:if test="${i.member_id!='관리자'}">
                    <tr>
                        <td>${i.seq}</td>                       
                        <td>${i.reason}<br></td>                      
                        <td>${i.title}</td>
                        <td>${i.member_id}</td>
                        <td id="write_date">
                        	<fmt:formatDate value="${i.write_date}" pattern="yyyy-MM-dd"/>
                        </td>
                        <td>
                            <button class="board-del-btn" type="button" data-seq="${i.seq}">삭제</button>
                        </td>
                    </tr>
                    </c:if>
                </c:forEach>                  
                </tbody>
            </table>

            <div class="pagination-wrap" id="admin_report_navi">
            </div>
        </section>

        <section class="panel">
            <div class="panel-head">
                <h3>공지글 목록</h3>
            </div>

            <table class="admin-table notice-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="i" items="${notice_mainList}">
                <c:if test="${fn:contains(i.member_id,'관리자')}">
                    <tr>
                        <td>${i.seq}</td>
                        <td >${i.title}</td>
                        <td>${i.member_id}</td>
                        <td id="write_date">
                        	<fmt:formatDate value="${i.write_date}" pattern="yyyy-MM-dd"/>
                        </td>
                        <td><span class="state-pill state-show">게시중</span></td>
                        <td>
                            <button class="board-detail-btn notice-detail-btn" type="button"  data-seq="${i.seq}">보기</button>
                            <button class="board-del-btn notice-del-btn" type="button"  data-seq="${i.seq}">삭제</button>
                        </td>
                    </tr>
                </c:if>
                </c:forEach>

                </tbody>
            </table>
        </section>
    </main>
</div>
 <div class="container-footer">
     <p>© 2026 돈워리. All rights reserved.</p>
     <p style="margin-top:10px; font-size:11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
  </div>
<script>
//일반 게시글
	let keyword = "${keyword}";
	let category = "${category}";
	let recordTotalCount = ${recordTotalCount}; // 총 개수
	let recordCountPerPage = ${recordCountPerPage}; // 한페이지에 몇개 (5)
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
	
	/*게시물 관리 id = admin_board_navi*/
	let board_navi = $("#admin_board_navi");
	
	//이전 버튼 <
	if(needPrev){	
		let btn = $("<button>").addClass("page-btn").html("&lt;");
		//btn.attr("onclick","location.href='/admin/admin_boards?page="+ (startNavi-1)+"'");
		btn.attr("onclick","location.href='"+getPageUrl(startNavi-1) + "'");
		board_navi.append(btn);
	}
	
	for(let i = startNavi; i <= endNavi; i++){
		let btn = $("<button>").addClass("page-btn").html(i);
		//btn.attr("onclick","location.href='/admin/admin_boards?page="+ i +"'");
		btn.attr("onclick","location.href='"+getPageUrl(i)+"'");
		if(i== currentPage){
			btn.addClass("active");//현재 페이지 파란색 처리
		}
		board_navi.append(btn);
	}
	
	//다음 버튼 >
	if(needNext){		 
		let btn = $("<button>").addClass("page-btn").html("&gt;");//구글 라이브러리 > 모양
		//btn.attr("onclick","location.href='/admin/admin_boards?page="+ (endNavi+1) +"'");
		btn.attr("onclick","location.href='"+getPageUrl(endNavi+1) + "'");
		board_navi.append(btn);
	}
	
	//검색 키워드 
	function getPageUrl(page){//이동 페이지 값 받아
		let cat = /*$("select[name='category']").val() ||*/ "${category}" || "all";
		let url = "/admin/admin_boards?page="+page+"&category="+cat; //해당 페이지 주소로 만들어줌
		if(keyword && keyword.trim()!= ""){//검색어가 있고 빈 문자열이 아니어야함
			url+="&keyword="+encodeURIComponent(keyword);
		//검색어에 한글이나 특수문자가 섞여 있을 때 브라우저가 주소를 안전하게 인식하도록 변환해주는 장치
		}
		return url;
	}
	
	//검색 버튼 클릭
	$(".board-search-btn").on("click",function(){
		let category = $("select[name='category']").val(); // 카테고리 값 가져오기
		let keyword = $(".keyword").val();
		location.href = "/admin/admin_boards?page=1&category=" + category +"&keyword="+encodeURIComponent(keyword);
	})
	
	//전체 버튼 클릭
	$(".board-all-btn").on("click",function(){
		location.href = "/admin/admin_boards?page=1&category=all";
	})
	//카테고리 선택
	$("select[name='category']").on("change", function() {
	    let category = $(this).val();
	    let keyword = $(".keyword").val();
	    
	    let url = "/admin/admin_boards?page=1&category=" + category;
	    
	    // 키워드가 입력되어 있다면 키워드도 같이 보냄
	    if(keyword && keyword.trim() != "") {
	        url += "&keyword=" + encodeURIComponent(keyword);
	    }
	    
	    location.href = url;
	});
	//카테고리 유지
	$(document).ready(function(){
		let curCategory = "${category}";
		if(curCategory){
			$("select[name='category']").val(curCategory);
		}
	})
	
	//보기 버튼 클릭
	$(".board-detail-btn").on("click",function(){
		let seq = $(this).data("seq");
		let page = "${currentPage}" || "1";//page 비었을 경우 대비
		location.href='/admin/admin_board_detail?seq='+seq+'&page='+page;
	});
	
	//삭제 버튼 클릭
	$(".board-del-btn").on("click",function(){
		let seq = $(this).data("seq");
		let page = "${currentPage}";
		location.href='/admin/admin_board_delete?seq='+seq+'&page='+page;
	});
	
//====================신고게시글=======================//
	
 	let rTotalCount = ${rTotalCount}; //신고글 총 개수
	let rCurrentPage = ${rCurrentPage}; // 신고 현재 페이지
	let rRecordCountPerPage = 5; // 한 페이지당 5개
	let rNaviCountPerPage = 10; 
	let rPageTotalCount = Math.ceil(rTotalCount / rRecordCountPerPage);
	
	let rStartNavi = Math.floor((rCurrentPage - 1) / rNaviCountPerPage) * rNaviCountPerPage + 1;
	let rEndNavi = rStartNavi + rNaviCountPerPage - 1;
	
	if (rEndNavi > rPageTotalCount) { 
		rEndNavi = rPageTotalCount; 
	}
	
	let rNeedPrev = true;
	let rNeedNext = true;
	
	if(rStartNavi == 1){
		rNeedPrev = false;
	}
	if(rEndNavi == rPageTotalCount){
		rNeedNext = false;
	}
	
	/*게시물 관리 id = admin_board_navi*/
	let report_navi = $("#admin_report_navi");
	
	//이전 버튼 <
	if(rNeedPrev){	
		let btn = $("<button>").addClass("page-btn").html("&lt;");
		btn.attr("onclick","location.href='"+getReportPageUrl(rStartNavi - 1) + "'");
		report_navi.append(btn);
	}	
	// 페이지 번호
	for (let i = rStartNavi; i <= rEndNavi; i++) {
	    let btn = $("<button>").addClass("page-btn").html(i);
	    btn.attr("onclick", "location.href='" + getReportPageUrl(i) + "'");
	    if (i == rCurrentPage) {
	        btn.addClass("active");
	    }
	    report_navi.append(btn);
	}
	
	//다음 버튼 >
	if(rNeedNext){		 
		let btn = $("<button>").addClass("page-btn").html("&gt;");//구글 라이브러리 > 모양
		btn.attr("onclick","location.href='"+getReportPageUrl(rEndNavi + 1) + "'");
		report_navi.append(btn);
	}
	
	// 신고 전용 URL 생성 함수
	function getReportPageUrl(targetRPage) {
	    // 일반 게시글의 현재 페이지(${currentPage})를 같이 보내야 상단 목록이 유지됨
	    let url = "/admin/admin_boards?page=${currentPage}&rPage=" + targetRPage;
	    url += "&category=${category}&keyword=" + encodeURIComponent("${keyword}");
	    return url;
	}
 
//====================공지글=======================//

	//보기 버튼 클릭
	$(".notice-detail-btn").on("click",function(){
		let seq = $(this).data("seq");
		location.href='/admin/admin_board_detail?seq='+seq+'&page=1';
	});
	
	//삭제 버튼 클릭
	$(".notice-del-btn").on("click",function(){
		let seq = $(this).data("seq");
		location.href='/admin/admin_board_delete?seq='+seq+'&page=1';
	});
</script>
</body>
</html>