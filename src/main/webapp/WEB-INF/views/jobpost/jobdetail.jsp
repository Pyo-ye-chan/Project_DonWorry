<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>돈워리 - 공고게시글</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	<link rel="shortcut icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon">
    <link rel="icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon">
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
	flex: 1; /* 컨텐츠가 적을 때 푸터를 아래로 밀어주는 최소한의 장치 */
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

/*관리자 버튼*/
.now-admin {
	width: 60px;
	height: 30px;
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
	width: 60px;
	height: 30px;
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
	width: 60px;
	height: 30px;
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
	border-top: 1px solid #e5e7eb; /* 테두리를 상단에만 */
	background-color: #f9fafb; /* 너무 어두운 회색 대신 밝은 회색 추천 */
	padding: 40px 0; /* % 높이 대신 안쪽 여백으로 높이 확보 */
	margin-top: 80px; /* 컨텐츠와의 간격 */
	text-align: center;
	color: #999;
	font-size: 13px;
	width: 100vw; /* 화면 끝까지 너비 확장 */
	margin-left: calc(-50vw + 50%); /* 컨테이너를 벗어나 화면 꽉 채우기 */
}

/* [1] 기본 레이아웃 */
.detail-container {
	max-width: 1100px;
	margin: 40px auto;
	padding: 0 20px;
}

/* [2] 상단 헤더 섹션 */
.detail-header {
	display: flex;
	justify-content: space-between;
	align-items: flex-start; /* flex-end에서 변경: 제목이 길어지면 위쪽 기준 정렬이 예쁨 */
	padding-bottom: 30px;
	border-bottom: 2px solid #333;
	gap: 30px; /* 제목과 버튼 사이 최소 간격 확보 */
}

.header-left .company-name {
	font-size: 18px;
	color: #666;
	margin-bottom: 10px;
	word-break: break-all;
}

.header-left {
	flex: 1; /* 남는 공간을 다 차지하되 버튼 영역은 침범 안 함 */
	min-width: 0; /* 중요: 내부 텍스트가 길 때 flex 박스가 터지는 걸 방지 */
}

.header-right {
	flex-shrink: 0; /* 중요: 버튼 영역이 좁아지지 않도록 고정 */
	display: flex;
	flex-direction: column; /* 버튼들을 세로로 배치 (이미지처럼) */
	gap: 10px;
}

.header-left h1 {
	font-size: 32px;
	font-weight: 800;
	color: #111;
	margin-bottom: 15px;
	word-break: break-all; /* 영문/숫자도 박스 끝에서 줄바꿈 */
	overflow-wrap: break-word; /* 단어 단위 줄바꿈 시도 */
}

.pay-info {
	font-size: 24px;
	font-weight: 700;
	color: #2563eb; /* 돈워리 블루 */
}

/* [3] 중앙 그리드 정보 섹션 */
.info-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 0 40px;
	margin: 30px 0;
	background: #f8faff;
	padding: 30px;
	border-radius: 15px;
}

.info-item {
	display: flex;
	padding: 15px 0;
	border-bottom: 1px solid #eef2ff;
}

.info-item .label {
	width: 100px;
	color: #888;
	font-weight: 600;
}

.info-item .value {
	flex: 1;
	color: #333;
	font-weight: 500;
}

/* [4] 하단 상세내용 섹션 */
.detail-content {
	margin-top: 50px;
}

.section-title {
	font-size: 22px;
	font-weight: 700;
	margin-bottom: 20px;
	padding-left: 10px;
	border-left: 5px solid #2563eb;
}

.content-body {
	padding: 20px;
	line-height: 1.8;
	min-height: 200px;
	border: 1px solid #eee;
	border-radius: 10px;
	margin-bottom: 40px;
	word-break: break-all;
}

/* 버튼 스타일 */
/* [1] 지원하기 버튼 (btn-apply) 수정 */
.btn-apply {
	width: 120px; /* 가로 길이를 고정해서 두 버튼을 맞춤 */
	height: 48px; /* 세로 길이 고정 */
	background: #2563eb;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 16px; /* 18px에서 조금 줄여서 목록 버튼과 통일 */
	font-weight: 700;
	margin-left: 10px;
	cursor: pointer;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	transition: background 0.2s;
}

.btn-apply:hover {
	background: #1d4ed8; /* 호버 시 약간 어둡게 */
}

/* [2] 목록으로 버튼 (btn-list) 수정 */
.btn-list {
	width: 120px; /* apply 버튼과 동일하게 설정 */
	height: 48px; /* apply 버튼과 동일하게 설정 */
	background: white;
	color: #666;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 16px;
	font-weight: 700;
	margin-left: 10px;
	cursor: pointer;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	transition: all 0.2s;
}

.btn-list:hover {
	background: #f8f9fa;
	border-color: #999;
}

img {
	max-width: 100%; /* 부모 너비를 넘지 않음 */
	max-height: 100%; height : auto; /* 비율 유지 */
	display: block; /* 하단 여백 제거 */
	margin: 10px 0;
	height: auto; /* 이미지 위아래 여백 */
}

#btnDeletePost:hover {
	background-color: #fef2f2;
	border-color: #ef4444;
	color: #b91c1c;
}

/* --- 버튼 중앙 정렬을 위한 추가 CSS --- */
.header-right {
    display: flex !important;      /* 가로 정렬 강제 */
    flex-direction: row !important; /* 세로가 아닌 가로로 나열 */
    justify-content: center;       /* 가로 중앙 정렬 */
    align-items: center;           /* 세로 중앙 정렬 */
    gap: 15px;                     /* 버튼 사이 간격 */
    margin: 50px 0;                /* 위아래 여백 넉넉히 */
    width: 100%;                   /* 전체 너비 확보 */
}

/* 기존 버튼의 margin-left가 정렬을 방해할 수 있어서 초기화 */
.header-right .btn-apply, 
.header-right .btn-list {
    margin-left: 0 !important;
}
</style>
</head>
<body>

	<div class="community-container">
		<c:choose>
			<c:when test="${nickName==null}">
				<div class="top-auth">
					<span style="font-size: 13px; color: #666; cursor: pointer;">
						<a href="/members/toLogin"
						style="text-decoration: none; color: black; margin-right: 10px;">
							<i class="fa-regular fa-user fa-lg"
							style="color: rgb(203, 203, 203); margin-right: 5px;"></i>로그인
					</a>
					</span>
				</div>
			</c:when>
			<c:otherwise>
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
						<a href="/admin/admin_main" style="text-decoration: none;"><div
								class="now-admin">관리자</div></a>
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
					<a href="/"> <i class="fa-solid fa-house fa-lg"
						style="color: rgb(203, 203, 203);"></i> 홈
					</a> <a href="/salary/calendar"> <i
						class="fa-regular fa-calendar fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 급여 캘린더</a><a href="/jobposts/jobpost"  class="active"> <i class="fa-solid fa-briefcase fa-lg"
						style="color: rgb(36, 99, 235); margin-right: 5px;"></i> 구인구직
					</a> <a href="/boards/mainboard_list?page=1"> <i
						class="fa-regular fa-message fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 커뮤니티
					</a> <a href="/qna/qna?page=1"> <i
						class="fa-solid fa-question fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 고객지원
					</a>
				</div>
			</div>
			<c:if test="${nickName==null }">
				<a class="my-page" href="/members/toLogin"> <i
					class="fa-solid fa-user-gear fa-lg"
					style="color: rgb(197, 197, 197);"></i> 마이페이지
				</a>
			</c:if>
			<c:if test="${nickName!=null }">
				<a class="my-page" href="/mypage/toMypage"> <i
					class="fa-solid fa-user-gear fa-lg"
					style="color: rgb(197, 197, 197);"></i> 마이페이지
				</a>
			</c:if>
		</nav>

		<!-- 여기까지가 헤더 -->

		<div class="detail-container">
			<div class="detail-header">
				<div class="header-left">
					<div class="company-name">${post.company_name}</div>
					<h1>${post.title}</h1>
					<div class="pay-info">
						시급
						<fmt:formatNumber value="${post.pay}" pattern="#,###" />
						원
					</div>
				</div>

			</div>

			<div id="resumeModal"
				style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 1000;">
				<div
					style="width: 400px; background: #fff; margin: 100px auto; padding: 20px; border-radius: 12px;">
					<h4 style="margin-bottom: 15px;">지원할 이력서를 선택해주세요</h4>
					<ul id="modalResumeList"
						style="list-style: none; padding: 0; max-height: 300px; overflow-y: auto;">
					</ul>
					<div style="text-align: right; margin-top: 20px;">
						<button type="button" onclick="$('#resumeModal').hide()"
							style="padding: 8px 15px; border: none; background: #eee; border-radius: 6px; cursor: pointer;">취소</button>
						<button type="button" id="btnConfirmApply"
							style="padding: 8px 15px; border: none; background: #2563eb; color: #fff; border-radius: 6px; cursor: pointer;">지원하기</button>
					</div>
				</div>
			</div>


			<div class="info-grid">
				<div class="info-item">
					<div class="label">
						<i class="fa-solid fa-location-dot"></i> 근무지
					</div>
					<div class="value">${post.address }</div>
				</div>
				<div class="info-item">
					<div class="label">
						<i class="fa-solid fa-calendar-days"></i> 근무요일
					</div>
					<div class="value">${post.work_days}</div>
				</div>
				<div class="info-item">
					<div class="label">
						<i class="fa-regular fa-clock"></i> 근무시간
					</div>
					<div class="value">${post.work_starttime}~
						${post.work_endtime}</div>
				</div>
				<div class="info-item">
					<div class="label">
						<i class="fa-solid fa-user"></i> 모집인원
					</div>
					<div class="value">${post.count}명</div>
				</div>
			</div>

			<div class="detail-content">
				<div class="section-title">상세 모집요강</div>
				<div class="content-body">${post.content}</div>
			</div>

			<div class="detail-content">
				<div class="section-title">복리후생 🎁</div>
				<div class="content-body" style="background: #fdfdfd;">
					${post.benefit}</div>
			</div>
		</div>

		<%-- 		<c:if test="${loginId == post.member_id}"> --%>
		<!--     <div style="text-align: right; margin-top: 20px; padding-top: 20px; border-top: 1px dashed #eee;"> -->
		<!--         <button type="button" id="btnDeletePost" class="btn-list" style="color: #ef4444; border-color: #fca5a5;"> -->
		<!--             <i class="fa-regular fa-trash-can"></i> 공고 삭제 -->
		<!--         </button> -->
		<!--         </div> -->
		<%-- </c:if> --%>

		<div class="header-right" id="bottom-btn-group">
			<c:if test="${type != '사업자'}">
				<button class="btn-apply" data-seq="${post.seq}">지원하기</button>
			</c:if>
			<button class="btn-list"
				onclick="location.href='/jobposts/jobpost?page=${page}'">목록으로</button>
		</div>
	</div>


	<div class="container-footer">
		<p>© 2026 돈워리. All rights reserved.</p>
		<p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침
			| 이용약관 | 고객센터</p>
	</div>

	<script>
	
	$("#btnDeletePost").on("click", function() {
        if (confirm("정말로 이 공고를 삭제하시겠습니까?\n삭제 후에는 복구가 불가능합니다.")) {
            location.href = `/jobposts/delete?seq=${post.seq}`;
        }
    });
	
$(function() {
    // [1] 페이지 로드 시 서버로부터 온 알림 메시지 처리
    // 컨트롤러에서 RedirectAttributes로 보낸 메시지는 여기서 딱 한 번만 띄운다.
    const errorMsg = "${error}";
    const successMsg = "${message}";
    const resumeMsg = "${resume}";

    if (errorMsg !== "") alert(errorMsg);
    if (successMsg !== "") alert(successMsg);
    if (resumeMsg !== "") alert(resumeMsg);

    // [2] 지원하기 버튼 클릭 시 (이력서 목록 가져오기)
    let selectedJobSeq = null; 

    $(".btn-apply").on("click", function() {
        const loginId = "${loginId}";
        selectedJobSeq = $(this).attr("data-seq");

        if (!loginId || loginId === "" || loginId === "null") {
            alert("로그인이 필요한 서비스입니다.");
            location.href = "/members/toLogin";
            return;
        }

        $.ajax({
            url: "/jobapplys/getMyResumes",
            type: "get",
            success: function(resumes) {
                if (!resumes || resumes.length === 0) {
                    alert("등록된 이력서가 없습니다. 이력서를 먼저 작성해주세요!");
                    location.href = "/mypage/resume";
                    return;
                }

                let html = "";
                resumes.forEach(r => {
                    html += `
                        <li style="padding:10px; border-bottom:1px solid #eee;">
                            <label style="cursor:pointer; display:block;">
                                <input type="radio" name="resumeIdx" value="\${r.seq}"> \${r.title}
                            </label>
                        </li>`;
                });
                
                $("#modalResumeList").html(html);
                $("#resumeModal").fadeIn(200);
            },
            error: function() {
                alert("이력서 목록을 가져오는 데 실패했습니다.");
            }
        });
    });

    // [3] 모달 내 '최종 지원하기' 버튼 클릭 시
    $("#btnConfirmApply").on("click", function() {
        const resumeNum = $("input[name='resumeIdx']:checked").val();
        
        if (!resumeNum) {
            alert("지원하실 이력서를 선택해주세요.");
            return;
        }

        // 서버로 전송 (여기서는 알림 메시지 체크를 하지 않음!)
        location.href = `/jobapplys/insert?jobPostNum=\${selectedJobSeq}&resumeNum=\${resumeNum}`;
    });

    // [4] 모달 외부나 취소 버튼 클릭 시 닫기 기능 (추가 권장)
    $(document).on("click", function(e) {
        if ($(e.target).is("#resumeModal")) {
            $("#resumeModal").fadeOut(200);
        }
    });
});
</script>


</body>
</html>