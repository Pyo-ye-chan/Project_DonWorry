<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 회원 관리</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="shortcut icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon">
    <link rel="icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon">	
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

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

.container {
	max-width: 1100px;
	width: 100%;
	margin: 0 auto;
	padding: 0 20px;
	flex: 1;
}

.top-auth {
	display: flex;
	justify-content: flex-end; /* 오른쪽 정렬 핵심 */
	align-items: center;
	gap: 15px; /* 요소 간 간격 */
	padding: 8px 0; /* 위아래 여백 */
}

.logout-btn {
	width: 60px;
	height: 30px;
	background-color: #ffffff;
	color: #868e96;
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

.logout-btn:hover {
	width: 60px;
	height: 30px;
	background-color: #f8f9fa;
	color: #495057;
	border-color: #ced4da;
	border: 1px solid #dee2e6;
	border-radius: 6px;
	font-size: 13px;
	transition: all 0.2s ease; /* 부드러운 변화를 위해 추가 */
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

.summary-value {
	font-size: 28px;
	font-weight: 800;
	color: #0f172a;
}

.panel {
	background: #fff;
	border: 1px solid #e7eef8;
	border-radius: 18px;
	padding: 22px;
	margin-bottom: 22px;
}

.filter-row {
	display: flex;
	gap: 12px;
	flex-wrap: wrap;
	align-items: center;
	margin-bottom: 18px;
}

.filter-row select, .filter-row input {
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

.btn-blue {
	height: 42px;
	border: none;
	border-radius: 10px;
	padding: 0 16px;
	background: #2563eb;
	color: #fff;
	font-size: 14px;
	font-weight: 700;
	cursor: pointer;
}

.admin-table {
	width: 100%;
	border-collapse: collapse;
}

.admin-table th, .admin-table td {
	padding: 14px 10px;
	border-bottom: 1px solid #eef2f7;
	font-size: 14px;
	text-align: center;
	vertical-align: middle;
}

.status-badge {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 6px 10px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 700;
}

.status-normal {
	background: #eaf4ff;
	color: #2563eb;
}

.status-stop {
	background: #ffe9e9;
	color: #dc2626;
	
}

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
	cursor: pointer;
}

.page-btn.active {
	background: #2563eb;
	color: #fff;
	border-color: #2563eb;
}

.container-footer {
	border-top: 1px solid #e5e7eb;
	background: #f9fafb;
	padding: 40px 0;
	margin-top: 80px;
	text-align: center;
	color: #999;
	font-size: 13px;
}

/* 정지 버튼 (연한 파랑) */
.btn-red {
	width: 72px;
	height: 34px;
	background-color: #f8fbff;
	color: #2563eb;
	border: 1px solid #cfe0ff; /* 아주 연한 테두리만 허용 */
	border-radius: 8px;
	font-size: 13px;
	font-weight: 700;
}

.btn-red:hover {
	background-color: #eef4ff;
	border-color: #2563eb;
}

/* 정지해제 버튼 (빨강) */
.btn-light-blue {
	width: 72px;
	height: 34px;
	background-color: #ef4444;
	color: #fff;
	border-radius: 8px;
	font-size: 13px;
	font-weight: 700;
	border: 1px solid #ffa8a8; /* 분홍~빨강 사이의 테두리 */
}

.btn-light-blue:hover {
	background-color: #dc2626;
	box-shadow: 0 2px 4px rgba(255, 255, 255, 0.2);
}

.page-btn {
	display: flex;
	align-items: center;
	justify-content: center;
	min-width: 38px;
	height: 38px;
	padding: 0 10px;
	border: 1px solid #e2e8f0;
	border-radius: 10px;
	background-color: #fff;
	color: #475569;
	font-size: 14px;
	font-weight: 700;
	text-decoration: none !important;
	transition: all 0.2s ease;
}
</style>
</head>
<body>
	<div class="container">
		<div class="top-auth">
			<span style="font-size: 13px; color: #666;"> <i
				class="fa-regular fa-user fa-lg"
				style="color: #cbd5e1; margin-right: 5px;"></i> ${nickName}님 환영합니다.
				<a href="/members/logout"
				style="text-decoration: none; color: black;">
					<button class="logout-btn" type="button" style="margin-left: 10px;">로그아웃</button>
			</a>
			</span>

			<c:if test="${type == '관리자'}">
				<a href="/admin/admin_main" style="text-decoration: none;">
					<div class="now-admin">관리자</div>
				</a>
			</c:if>
		</div>

		<nav class="navbar">
			<div style="display: flex; align-items: center; gap: 40px;">
				<a href="/" class="logo">돈워리</a>

				<div class="nav-menu">
					<a href="/admin/admin_main"> <i
						class="fa-solid fa-wrench fa-lg"
						style="color: rgb(197, 197, 197); margin-right: 6px;"></i> 관리자
						대시보드
					</a> <a href="/admin/admin_boards"> <i
						class="fa-solid fa-file-pen fa-lg"
						style="color: rgb(197, 197, 197); margin-right: 6px;"></i> 게시물 관리
					</a> <a href="/admin/admin_members" class="active"> <i
						class="fa-solid fa-user-shield fa-lg"
						style="color: rgb(36, 99, 235); margin-right: 6px;"></i> 회원 관리
					</a> <a href="/admin/admin_inquiry"> <i
						class="fa-regular fa-circle-question fa-lg"
						style="color: rgb(197, 197, 197); margin-right: 6px;"></i> Q&A 관리
					</a>
				</div>
			</div>
		</nav>

		<main class="admin-page">
			<div class="page-header">
				<div class="page-title">
					<h2>회원 관리</h2>
					<p>전체 회원 조회, 상태 변경, 상세 정보 확인이 가능합니다.</p>
				</div>
				<div class="page-badge">
					<i class="fa-solid fa-users"></i> 총 결과 ${recordTotalCount -1}명
				</div>
			</div>

			<section class="summary-grid">
				<div class="summary-card">
					<div class="summary-label">전체 회원</div>
					<div class="summary-value">${membersCount -1}</div>
				</div>
				<div class="summary-card">
					<div class="summary-label">정지 회원</div>
					<div class="summary-value">${StateCount}</div>
				</div>
			</section>

			<section class="panel">
				<div class="panel-head">
					<h3>회원 목록</h3>
				</div>

				<div class="filter-row">
					<select id="filter-type">
						<option value="">전체 유형</option>
						<option value="개인" ${param.type == '개인' ? 'selected' : ''}>개인</option>
						<option value="사업자" ${param.type == '사업자' ? 'selected' : ''}>사업자</option>
					</select> <select id="filter-state">
						<option value="">전체 상태</option>
						<option value="N" ${param.state == 'N' ? 'selected' : ''}>정상</option>
						<option value="Y" ${param.state == 'Y' ? 'selected' : ''}>정지</option>
					</select> <input type="text" id="keyword" value="${param.keyword}"
						placeholder="이름, 이메일, 아이디 검색">
					<button class="btn-blue" id="search-btn" type="button">검색</button>
				</div>

				<table class="admin-table">
					<thead>
						<tr>
<!-- 							<th>성별</th> -->
							<th>이름</th>
							<th>닉네임</th>
							<th>전화번호</th>
							<th>이메일</th>
							<th>유형</th>
							<th>가입일</th>
							<th>상태</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="member" items="${membersList}">
						<c:if test="${member.type != '관리자' }">
							<tr>
<%-- 								<td>${member.gender}</td> --%>
								<td>${member.name}</td>
								<td>${member.nickname}</td>
								<td>${member.phone}</td>
								<td>${member.email}</td>
								<td><span
									class="badge ${member.type == '관리자' ? 'bg-danger' : 'bg-primary'}">${member.type}</span></td>
								<td><fmt:formatDate value="${member.join_date}"
										pattern="yyyy-MM-dd" /></td>
								<td><c:choose>
										<c:when test="${member.state == 'Y'}">
											<span class="status-badge status-stop">정지</span>
										</c:when>
										<c:otherwise>
											<span class="status-badge status-normal">정상</span>
										</c:otherwise>
									</c:choose></td>
								<td><c:choose>
										<c:when test="${member.state == 'N'}">
											<button class="btn-light-blue btn-suspend"
												data-nickname="${member.nickname}">정지</button>
										</c:when>
										<c:otherwise>
											<button class="btn-red btn-active"
												data-nickname="${member.nickname}">정지해제</button>
										</c:otherwise>
									</c:choose></td>
							</tr>
						</c:if>	
						</c:forEach>
					</tbody>
				</table>

				<div class="pagination-wrap">
					<c:if test="${recordTotalCount > 0}">
						<%-- 1. 전체 페이지 수 계산 --%>
						<fmt:parseNumber var="pageCount"
							value="${(recordTotalCount - 1) / recordCountPerPage + 1}"
							integerOnly="true" />

						<%-- 2. 시작 네비게이터 번호 (10개 단위로 고정) --%>
						<%-- (현재페이지-1) / 10 * 10 + 1 공식이야 --%>
						<fmt:parseNumber var="startNavi"
							value="${((currentPage - 1) / naviCountPerPage)}"
							integerOnly="true" />
						<c:set var="startNavi" value="${startNavi * naviCountPerPage + 1}" />

						<%-- 3. 끝 네비게이터 번호 --%>
						<c:set var="endNavi" value="${startNavi + naviCountPerPage - 1}" />
						<c:if test="${endNavi > pageCount}">
							<c:set var="endNavi" value="${pageCount}" />
						</c:if>

						<%-- [이전] 버튼 --%>
						<c:if test="${currentPage > 1}">
							<a href="/admin/admin_members?page=${currentPage - 1}"
								class="page-btn"> <i class="fa-solid fa-angle-left"></i>
							</a>
						</c:if>

						<%-- [번호] 버튼 --%>
						<c:forEach var="i" begin="${startNavi}" end="${endNavi}">
							<button class="page-btn ${currentPage == i ? 'active' : ''}"
								onclick="goPage(${i})">${i}</button>
						</c:forEach>

						<%-- [다음 묶음] 버튼: 현재 뭉치의 끝번호(endNavi)보다 전체 페이지(pageCount)가 더 클 때만 노출 --%>
						<c:if test="${endNavi < pageCount}">
							<%-- 다음 뭉치의 첫 번째 페이지(endNavi + 1)로 이동 --%>
							<a
								href="/admin/admin_members?page=${endNavi + 1}&type=${param.type}&state=${param.state}&keyword=${param.keyword}"
								class="page-btn"> <i class="fa-solid fa-angle-right"></i>
							</a>
						</c:if>
					</c:if>
				</div>

			</section>
		</main>
	
		
	</div>
		 <div class="container-footer">
     <p>© 2026 돈워리. All rights reserved.</p>
     <p style="margin-top:10px; font-size:11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
     </div>

	<script>
        // 공통 페이지 이동 함수 (필터 정보 유지)
        function goPage(page) {
            const type = $("#filter-type").val();
            const state = $("#filter-state").val();
            const keyword = $("#keyword").val();
            location.href = "/admin/admin_members?page=" + page + "&type=" + type + "&state=" + state + "&keyword=" + encodeURIComponent(keyword);
        }

        $(function() {
            // 유형 또는 상태 변경 시 즉시 검색
            $("#filter-type, #filter-state").on("change", function() {
                goPage(1);
            });

            // 검색 버튼 클릭 시
            $("#search-btn").on("click", function() {
                goPage(1);
            });

            // 엔터키 검색 지원
            $("#keyword").on("keyup", function(e) {
                if(e.keyCode === 13) goPage(1);
            });

            // 정지/해제 AJAX (기존 코드 유지)
            $(document).on('click', '.btn-suspend, .btn-active', function() {
                const targetNickName = $(this).data('nickname');
                const newState = $(this).hasClass('btn-suspend') ? 'Y' : 'N';
                const actionText = (newState === 'Y') ? "정지" : "해제";

                if (confirm(targetNickName + " 회원을 " + actionText + "하시겠습니까?")) {
                    $.ajax({
                        url : "/admin/changeMemberState",
                        type : "post",
                        data : { nickname : targetNickName, state : newState },
                        success : function(res) {
                            if (res === "success") {
                                alert(actionText + " 처리가 완료되었습니다.");
                                location.reload();
                            } else { alert("처리에 실패했습니다."); }
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>