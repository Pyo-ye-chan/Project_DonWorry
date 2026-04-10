<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>내가 작성한 글</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
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

.community-container {
	max-width: 1100px;
	width: 100%;
	margin: 0 auto;
	padding: 0 20px;
	flex: 1;
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
	cursor: pointer;
}

.my-page.active {
	color: #2563eb;
}

.now-business, .now-personal, .now-admin {
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

.page {
	padding: 56px 0 72px;
	width: 78%;
	margin: auto;
}

.comm-header {
	text-align: center;
	margin-bottom: 34px;
}

.comm-header h5 {
	font-size: 24px;
	font-weight: 700;
	color: #333;
	margin-top: 15px;
}

.comm-header p {
	color: #666;
	font-size: 15px;
	margin-top: 8px;
}

.toolbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 12px;
	margin-bottom: 22px;
	flex-wrap: wrap;
}

.search-box {
	flex: 1;
	min-width: 240px;
	position: relative;
}

.search-box input {
	width: 100%;
	height: 46px;
	border: 1px solid #dee2e6;
	border-radius: 12px;
	padding: 0 14px 0 42px;
	font-size: 14px;
	outline: none;
}

.search-box i {
	position: absolute;
	left: 14px;
	top: 50%;
	transform: translateY(-50%);
	color: #adb5bd;
}

.write-btn {
	background-color: #2563eb;
	color: #fff;
	border: none;
	border-radius: 12px;
	padding: 12px 18px;
	font-size: 14px;
	font-weight: 700;
	cursor: pointer;
	transition: all 0.2s ease;
}

.write-btn:hover {
	background-color: #1d4ed8;
	box-shadow: 0 4px 12px rgba(37, 99, 235, 0.18);
}

.tab-menu {
	display: flex;
	background-color: #f1f3f5;
	padding: 6px;
	border-radius: 12px;
	margin-bottom: 28px;
	width: 100%;
}

.tab-item {
	flex: 1;
	border: none;
	padding: 15px;
	background: none;
	cursor: pointer;
	font-size: 15px;
	color: #555;
	border-radius: 10px;
}

.tab-item.active {
	background-color: white;
	font-weight: 800;
	color: #2563eb;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.post-list {
	text-align: left;
	width: 100%;
}

.list-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 14px;
	padding: 0 4px;
	flex-wrap: wrap;
	gap: 10px;
}

.list-count {
	font-size: 14px;
	color: #868e96;
	font-weight: 600;
}

.sort-select {
	height: 38px;
	border: 1px solid #dee2e6;
	border-radius: 10px;
	padding: 0 12px;
	font-size: 13px;
	color: #495057;
	background: #fff;
	outline: none;
}

.post-card {
	background-color: white;
	border: 1px solid #e9ecef;
	border-radius: 18px;
	padding: 26px 28px;
	margin-bottom: 20px;
	width: 100%;
	transition: all 0.2s ease;
	cursor: pointer;
	word-break: break-all;
	
}

.post-card:hover {
	box-shadow: 0 8px 24px rgba(15, 23, 42, 0.06);
	transform: translateY(-2px);
}

.post-top {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	gap: 16px;
	margin-bottom: 12px;
	flex-wrap: wrap;
}

.post-badges {
	display: flex;
	align-items: center;
	gap: 8px;
	flex-wrap: wrap;
	margin-bottom: 10px;
}

.board-tag {
	font-size: 12px;
	padding: 4px 10px;
	border-radius: 8px;
	background-color: #eff6ff;
	color: #2563eb;
	border: 1px solid #dbeafe;
	font-weight: 600;
}

/* 태그 스타일 */
.tag {
	font-size: 11px;
	padding: 2px 8px;
	border-radius: 10px;
	margin-right: auto;
	margin-top: 6px;
}

.tag.question {
	background-color: #e7f3ff;
	color: #007bff;
}

.tag.free {
	background-color: #e6fffa;
	color: #38b2ac;
}

.status-tag {
	font-size: 12px;
	padding: 4px 10px;
	border-radius: 8px;
	background-color: #f8f9fa;
	color: #868e96;
	border: 1px solid #e9ecef;
	font-weight: 600;
}

.post-title {
	font-size: 20px;
	font-weight: 800;
	color: #222;
	margin-bottom: 8px;
}

.post-meta {
	font-size: 13px;
	color: #adb5bd;
}

.post-content {
	font-size: 15px;
	color: #495057;
	margin: 18px 0 20px;
	line-height: 1.7;
}

.post-info-row {
	display: flex;
	gap: 18px;
	flex-wrap: wrap;
	color: #868e96;
	font-size: 13px;
	margin-bottom: 18px;
}

.post-info-row span {
	display: inline-flex;
	align-items: center;
	gap: 6px;
}

.post-footer {
	border-top: 1px solid #f1f3f5;
	padding-top: 18px;
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	flex-wrap: wrap;
}

.ghost-btn {
	background-color: #ffffff;
	color: #868e96;
	border: 1px solid #dee2e6;
	padding: 10px 18px;
	border-radius: 10px;
	font-weight: 600;
	cursor: pointer;
	font-size: 13px;
	transition: all 0.2s ease;
}

.ghost-btn:hover {
	background-color: #f8f9fa;
	color: #495057;
	border-color: #ced4da;
}

.primary-btn {
	background-color: #2563eb;
	color: #ffffff;
	border: none;
	padding: 10px 18px;
	border-radius: 10px;
	font-weight: 600;
	cursor: pointer;
	font-size: 13px;
	transition: all 0.2s ease;
}

.primary-btn:hover {
	background-color: #1d4ed8;
	box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
}

.page-nav {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 10px;
	margin-top: 38px;
}

.page-num {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 40px;
	height: 40px;
	border: 1px solid #dee2e6;
	background-color: white;
	color: #495057;
	text-decoration: none;
	border-radius: 10px;
	font-size: 14px;
}

.page-num.active {
	background-color: #2563eb;
	color: white;
	border-color: #2563eb;
}

.empty-box {
	border: 1px dashed #dbe4f0;
	border-radius: 18px;
	padding: 56px 20px;
	text-align: center;
	color: #94a3b8;
	background: #fbfdff;
	display: none;
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

@media ( max-width : 900px) {
	.page {
		width: 100%;
	}
	.summary-row {
		grid-template-columns: 1fr;
	}
	.nav-menu {
		gap: 20px;
		flex-wrap: wrap;
	}
}
</style>
</head>
<body>

	<div class="community-container">
		<c:if test="${nickName!=null}">
			<div class="top-auth">
				<span style="font-size: 13px; color: #666; cursor: pointer;">
					<i class="fa-regular fa-user fa-lg"
					style="color: rgb(203, 203, 203); margin-right: 5px;"></i>
					${nickName}님 환영합니다. <a href="/members/logout"
					style="text-decoration: none; color: black">
						<button class="logout-btn" style="margin-left: 10px;">로그아웃</button>
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
		</c:if>

		<nav class="navbar">
			<div style="display: flex; align-items: center; gap: 40px;">
				<a href="/" class="logo">돈워리</a>
				<div class="nav-menu">
					<a href="/"> <i class="fa-solid fa-house fa-lg"
						style="color: rgb(203, 203, 203);"></i> 홈
					</a> <a href="/salary/calendar"> <i
						class="fa-regular fa-calendar fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 급여 캘린더
					</a> <a href="/jobposts/jobpost"> <i
						class="fa-solid fa-briefcase fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 구인구직
					</a> <a href="/boards/mainboard_list"> <i
						class="fa-regular fa-message fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 커뮤니티
					</a> <a href="/qna/qna"> <i class="fa-solid fa-question fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 고객지원
					</a>
				</div>
			</div>
			<a class="my-page active" href="/mypage/toMypage"> <i
				class="fa-solid fa-user-gear fa-lg" style="color: rgb(36, 99, 235);"></i>
				마이페이지
			</a>
		</nav>

		<div class="page">
			<div class="comm-header">
				<i class="fa-regular fa-pen-to-square fa-4x" style="color: #e9ecef;"></i>
				<h5>내 이력서</h5>
				<p>내가 작성한 이력서를 한눈에 확인하고 관리해보세요</p>
			</div>

			<div class="toolbar">
				<div></div>
				<a href="/mypage/resume"><button class="write-btn">
						<i class="fa-solid fa-pen" style="margin-right: 6px;"></i> 이력서등록
					</button></a>
			</div>

			<section class="post-list">
				<div class="list-top">
					<div class="list-count">전체 이력서 ${count }개</div>

				</div>

				<div class="post-container" id="postContainer">
					<c:forEach var="a" items="${list }">
					
						<div class="post-card" data-type="community"
							onclick="location.href='/mypage/resume_detail?seq=${a.seq }'">
							<div class="post-top">
								<div class="post-title">${a.title }</div>
								<span class="tag free"> 
										${a.career }
									
								</span>
								<div class="post-meta"">
									<fmt:formatDate value="${a.resume_date}"
										pattern="yyyy-MM-dd HH:mm" />
								</div>
							</div>
	  
							${empty a.preferred_job ? '희망직종 없음' : a.preferred_job} / ${a.working_condition}
						</div>
					</c:forEach>
				</div>

				<div class="empty-box" id="emptyBox">
					<i class="fa-regular fa-file-lines fa-2x"
						style="margin-bottom: 12px;"></i>
					<div>검색 결과가 없어요.</div>
				</div>
			</section>

			<div class="page-nav">
			</div>
		</div>
	</div>

	<div class="container-footer">
		<p>© 2026 돈워리. All rights reserved.</p>
		<p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침
			| 이용약관 | 고객센터</p>
	</div>

	<script>

	//let recordTotalCount = ${recordTotalCount}; // 총 개수
	//let recordCountPerPage = ${recordCountPerPage}; // 한페이지에 몇개 (10)
	//let naviCountPerPage  = ${naviCountPerPage }; // navi 몇개 (10)
	//let currentPage = ${currentPage}; // 현재 페이지
	l//et pageTotalCount = Math.ceil(recordTotalCount/recordCountPerPage); 
	
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
		a.attr("href","/mypage/mypost?page="+ (startNavi-1));
		a.append(span);
		$(".page-nav").append(a);
	}
	
	for(let i = startNavi; i <= endNavi; i++){
		let a = $("<a>")
		a.attr("href" , "/mypage/mypost?page="+i);
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
			a.attr("href","/mypage/mypost?page="+(endNavi+1));
			a.append(span);
			$(".page-nav").append(a);
	}		
			
    $(".tab-item").on("click", function () {
        $(".tab-item").removeClass("active");
        $(this).addClass("active");

        const filter = $(this).data("filter");
        let visibleCount = 0;

        $(".post-card").each(function () {
            const type = $(this).data("type");

            if (filter === "all" || filter === type) {
                $(this).show();
                visibleCount++;
            } else {
                $(this).hide();
            }
        });

        $(".list-count").text("전체 게시글 " + visibleCount + "개");
        $("#emptyBox").toggle(visibleCount === 0);
    });

    $("#searchInput").on("keyup", function () {
        const keyword = $(this).val().toLowerCase().trim();
        let visibleCount = 0;

        $(".post-card").each(function () {
            const text = $(this).text().toLowerCase();
            const isTabVisible = $(this).css("display") !== "none";

            if (text.includes(keyword)) {
                $(this).show();
                visibleCount++;
            } else {
                $(this).hide();
            }
        });

        $(".list-count").text("전체 게시글 " + visibleCount + "개");
        $("#emptyBox").toggle(visibleCount === 0);
    });
    
</script>

</body>
</html>