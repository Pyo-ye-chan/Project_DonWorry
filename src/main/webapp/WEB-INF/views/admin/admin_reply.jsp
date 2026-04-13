<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>관리자 - 회원 댓글 관리</title>

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

.panel {
    background: #fff;
    border: 1px solid #e7eef8;
    border-radius: 18px;
    padding: 22px;

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

.reply-detail-btn {
    height: 34px;
    border: 1px solid #cfe0ff;
    border-radius: 8px;
    padding: 0 12px;
    background: #f8fbff;
    color: #2563eb;
    font-size: 13px;
    font-weight: 700;
}

.reply-del-btn{
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
	table-layout: fixed; /* 너비를 엄격하게 지키도록 설정 */
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
    table-layout: fixed;
    color: #64748b;
    font-weight: 700;
}

/* 댓글 관리  */
.admin-table th:nth-child(1) { width: 8%; }  /* 번호 */
.admin-table th:nth-child(2) { width: 10%; } /* 게시판 번호 */
.admin-table th:nth-child(3) { width: 20%; } /* 작성자 */
.admin-table th:nth-child(4) { width: 12%; } /* 작성일 */
.admin-table th:nth-child(5) { width: 10%; } /* 상태 */
.admin-table th:nth-child(6) { width: 10%; } /* 관리 */

.reply-report th{
	white-space: normal;       /* 기본 줄바꿈 허용 */
    word-break: break-all;     /* 영어/숫자도 너비를 넘어가면 강제 줄바꿈 */
    overflow-wrap: break-word; /* 긴 단어가 있으면 줄바꿈 처리 */
    max-width: 400px;          /* (선택) 특정 너비를 넘어가면 줄바꿈 되도록 너비 제한 */
    line-height: 1.5;          /* 줄 간격을 주면 훨씬 읽기 편합니다. */
}
/* 신고 댓글 관리  */
.reply-report th:nth-child(1) { width: 8%; }  /* 번호 */
/* 신고사유 */
.reply-report th:nth-child(2) { 
	width:20%;
 } 
 .reply-report td:nth-child(2) { 
    white-space: normal;       /* 한 줄 제한 해제 */
    word-break: break-all;     /* 강제 줄바꿈 */
    text-overflow: clip;       /* 생략 제거 */
    overflow: visible;
 }
 /* 글 내용 */
.reply-report th:nth-child(3) {
 	width: auto; 
 	white-space: normal;       /* nowrap 해제: 다음 줄로 넘어가게 함 */
 	word-break: break-all;     /* 긴 영문/숫자 강제 줄바꿈 */
    text-overflow: clip;       /* ... 생략 표시 제거 */
    overflow: visible;         /* 숨김 해제 */
    line-height: 1.5;
 } 
 .reply-report td:nth-child(3) {
    white-space: normal;       /* 한 줄 제한 해제 */
    word-break: break-all;     /* 강제 줄바꿈 */
    text-overflow: clip;       /* 생략 제거 */
    overflow: visible;
}
.reply-report th:nth-child(4) { width: 20%; } /* 작성자 */
.reply-report th:nth-child(5) { width: 15%; } /* 작성일 */
.reply-report th:nth-child(6) { width: 12%; } /* 관리 */

.admin-table td {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
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
                <h2>전체 댓글 관리</h2>
                <p>커뮤니티 게시글 조회, 삭제가 가능합니다.</p>
            </div>
        </div>

         <section class="panel">
            <div class="panel-head">
                <h3>댓글 목록</h3>
            </div>

            <div class="filter-row">
                <select name="category">
                    <option value="all">전체 상태</option>
                    <option value="report">신고</option>
                    <option value="normal">일반</option>
                </select>
                <input name="keyword" class="keyword" type="text" placeholder="작성자 검색">
                <button class="btn-blue reply-search-btn" type="button">검색</button>
                <button class="btn-blue reply-all-btn" type="button">전체</button>
            </div>

            <table class="admin-table">
                <thead>
                    <tr>
                        <th>댓글 번호</th>
                        <th>게시판 번호</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="i" items="${replyList}">
                    <tr>
                        <td>${i.seq}</td>                                              
                        <td>${i.parent_seq}</td>
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
                            <button class="reply-detail-btn" type="button" data-seq="${i.seq}" data-parent="${i.parent_seq}">보기</button>
                            <button class="reply-del-btn" type="button" data-seq="${i.seq}" >삭제</button>
                        </td>
                    </tr>
                </c:forEach>                  
                </tbody>
            </table>

            <div class="pagination-wrap" id="admin_board_navi">
            </div>
        </section>

        <section class="panel">
            <div class="panel-head">
                <h3>신고 댓글 목록</h3>
            </div>

            <table class="admin-table reply-report">
                <thead>
                    <tr>
                        <th>댓글 번호</th>
                        <th>신고 사유</th>
                        <th>글 내용</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="i" items="${report_replyList}">
                    <tr>
                        <td>${i.seq}</td>
                        <td>${i.reason}</td>
                        <td>${i.content}</td>
                        <td>${i.member_id}</td>
                        <td id="write_date">
                        	<fmt:formatDate value="${i.write_date}" pattern="yyyy-MM-dd"/>
                        </td>
                        <td>
                            <button class="reply-del-btn rp_reply-del-btn" type="button"  data-seq="${i.seq}">삭제</button>
                        </td>
                        
                    </tr>
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
		btn.attr("onclick","location.href='"+getPageUrl(startNavi-1) + "'");
		board_navi.append(btn);
	}
	
	for(let i = startNavi; i <= endNavi; i++){
		let btn = $("<button>").addClass("page-btn").html(i);
		btn.attr("onclick","location.href='"+getPageUrl(i) + "'");
		if(i== currentPage){
			btn.addClass("active");//현재 페이지 파란색 처리
		}
		board_navi.append(btn);
	}
	
	//다음 버튼 >
	if(needNext){		 
		let btn = $("<button>").addClass("page-btn").html("&gt;");//구글 라이브러리 > 모양
		btn.attr("onclick","location.href='"+getPageUrl(endNavi+1) + "'");
		board_navi.append(btn);
	}
	
	//검색 버튼 클릭
	$(".reply-search-btn").on("click",function(){
		let cat = $("select[name='category']").val(); // 카테고리 값 가져오기 
		let keyword = $(".keyword").val();
		//검색
		location.href = "/admin/admin_reply?page=1&category=" + cat +"&keyword="+encodeURIComponent(keyword);
	})
	
	$(".keyword").on("keypress", function(e) {
    if(e.keyCode === 13) {
        $(".reply-search-btn").click(); // 엔터 치면 위 클릭 함수를 실행해라
    }
});
	
	//전체 버튼 클릭
	$(".reply-all-btn").on("click",function(){
		$(".keyword").val(""); // 검색창 비우기
		location.href = "/admin/admin_reply?page=1&category=all"//1p로 가고 전체 카테로 함
	})
	
	//카테고리 선택
	$("select[name='category']").on("change", function() {
	    let category = $(this).val();
	    let keyword = $(".keyword").val();
	    
	    let url = "/admin/admin_reply?page=1&category=" + category;
	    
	    // 키워드가 입력되어 있다면 키워드도 같이 보냄
	    if(keyword && keyword.trim() != "") {
	        url += "&keyword=" + encodeURIComponent(keyword);
	    }	    
	    location.href = url;
	});
	
	//검색 키워드 
	function getPageUrl(page){//이동 페이지 값 받아
	 	let cat =  "${category}" || "all";
		let url = "/admin/admin_reply?page="+page+"&category="+cat; //해당 페이지 주소로 만들어줌
		if(keyword && keyword.trim()!= ""){//검색어가 있고 빈 문자열이 아니어야함
			url+="&keyword="+encodeURIComponent(keyword);
		//검색어에 한글이나 특수문자가 섞여 있을 때 브라우저가 주소를 안전하게 인식하도록 변환해주는 장치
		}
		return url;
	}
	
	//카테고리 유지
	$(document).ready(function(){
		let curCategory = "${category}";
		if(curCategory){
			$("select[name='category']").val(curCategory);
		}
	})
	
	//보기 버튼 클릭
	$(".reply-detail-btn").on("click",function(){
		let parentSeq = $(this).data("parent"); 
	    let replySeq = $(this).data("seq");
	    let page = "${currentPage}";
		location.href = '/admin/admin_reply_detail?seq=' + parentSeq + '&page=' + page + 
				'&reply_seq=' +replySeq + '#reply' + replySeq;
	});
	
 	//삭제 버튼 클릭
	$(".reply-del-btn").on("click",function(){
		let seq = $(this).data("seq");
		let page = "${currentPage}";
		location.href='/admin/admin_reply_delete?seq='+seq+'&page='+page;
	}); 
	
 
//====================신고댓글=======================//
	
	//삭제 버튼 클릭
	$(".rp_reply-del-btn").on("click",function(){
		let seq = $(this).data("seq");
		location.href='/admin/admin_reply_delete?seq='+seq+'&page=1';
	});
</script>
</body>
</html>