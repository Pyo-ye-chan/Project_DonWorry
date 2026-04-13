<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 브라우저 캐시를 방지하여 '뒤로 가기' 시 서버를 다시 호출하게 함
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>돈워리 - 지원자 이력서 보기</title>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
        font-family: 'Pretendard', sans-serif;
        background-color: #ffffff;
        line-height: 1.6;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        overflow-x: hidden;
        color: #1e293b;
    }

    .community-container {
        max-width: 1100px;
        width: 100%;
        margin: 0 auto;
        padding: 0 20px;
        flex: 1;
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
    
    .my-page.active {
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

    .now-business,
    .now-personal,
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

    .page {
        padding: 56px 0 72px;
        width: 78%;
        margin: auto;
    }

    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 16px;
        margin-bottom: 18px;
    }

    .page-title {
        font-size: 28px;
        font-weight: 800;
        color: #222;
        text-align: left;
    }

    .title-line {
        border: none;
        border-top: 1px solid #e5e7eb;
        margin: 18px 0 30px;
    }

    .resume-view-card {
        background-color: #ffffff;
        border: 1px solid #e9ecef;
        border-radius: 20px;
        padding: 40px;
        width: 100%;
        box-shadow: 0 4px 12px rgba(0,0,0,0.02);
    }

    .top-summary {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 20px;
        padding-bottom: 24px;
        border-bottom: 1px solid #eef2f7;
        margin-bottom: 28px;
    }

    .summary-left {
        flex: 1;
    }

    .resume-main-title {
        font-size: 24px;
        font-weight: 800;
        color: #111827;
        margin-bottom: 10px;
        word-break: break-all;
    }

    .summary-meta {
        display: flex;
        flex-wrap: wrap;
        gap: 10px 22px;
        font-size: 14px;
        color: #64748b;
    }

    .summary-meta span i {
        margin-right: 6px;
        color: #94a3b8;
    }

    .summary-right {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .status-badge {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 90px;
        height: 38px;
        padding: 0 16px;
        border-radius: 999px;
        font-size: 14px;
        font-weight: 700;
        background-color: #dbeafe;
        color: #1d4ed8;
        white-space: nowrap;
    }

    .info-section {
        margin-bottom: 28px;
    }

    .section-title {
        font-size: 17px;
        font-weight: 800;
        color: #334155;
        margin-bottom: 14px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .section-title i {
        color: #2563eb;
    }

    .info-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 16px;
    }

    .info-box {
        background: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 14px;
        padding: 18px 20px;
        min-height: 86px;
    }

    .info-label {
        font-size: 13px;
        color: #64748b;
        margin-bottom: 8px;
        font-weight: 600;
    }

    .info-value {
        font-size: 15px;
        color: #0f172a;
        font-weight: 600;
        word-break: break-word;
    }

    .full-box {
        background: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 14px;
        padding: 20px;
    }

    .full-value {
    font-size: 15px;
    color: #1e293b;
    line-height: 1.9;      
    white-space: pre-wrap;
    word-break: break-word;
    min-height: 120px;
    /* 추가된 부분 */
    text-align: left;       /* 왼쪽 정렬 */
    display: block;         /* 블록 요소로 지정 */
    width: 100%;            /* 너비 꽉 채우기 */
}

    .empty-text {
        color: #94a3b8;
    display: block;
    text-align: left;
    }

    .status-edit-wrap {
        display: flex;
        align-items: center;
        gap: 12px;
        flex-wrap: wrap;
    }

    .status-select {
        min-width: 160px;
        height: 42px;
        border: 1px solid #dbe2ea;
        border-radius: 10px;
        padding: 0 14px;
        font-size: 14px;
        color: #334155;
        background-color: #fff;
        outline: none;
    }

    .status-select:focus {
        border-color: #2563eb;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.08);
    }

    .mini-save-btn {
        height: 42px;
        padding: 0 18px;
        border: none;
        border-radius: 10px;
        background-color: #2563eb;
        color: #fff;
        font-size: 14px;
        font-weight: 700;
        cursor: pointer;
    }

    .mini-save-btn:hover {
        background-color: #1d4ed8;
    }

    .post-footer {
        padding-top: 32px;
        display: flex;
        justify-content: center;
        gap: 15px;
    }

    .apply-cancel-btn {
        background-color: #ffffff;
        color: #868e96;
        border: 1px solid #dee2e6;
        padding: 12px 40px;
        border-radius: 10px;
        font-weight: 600;
        cursor: pointer;
        font-size: 15px;
        transition: all 0.2s ease;
    }

    .apply-detail-btn {
        background-color: #2563eb;
        color: #ffffff;
        border: none;
        padding: 12px 40px;
        border-radius: 10px;
        font-weight: 600;
        cursor: pointer;
        font-size: 15px;
        transition: all 0.2s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }

    .apply-detail-btn:hover {
        background-color: #1d4ed8;
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
    }

    .apply-cancel-btn:hover {
        background-color: #f8f9fa;
        color: #495057;
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

    @media (max-width: 900px) {
        .page { width: 100%; }
        .resume-view-card { padding: 28px 20px; }
        .top-summary {
            flex-direction: column;
            align-items: flex-start;
        }
        .info-grid { grid-template-columns: 1fr; }
        .nav-menu {
            gap: 18px;
            flex-wrap: wrap;
        }
    }
</style>
</head>
<body>

<div class="community-container">

    <c:choose>
        <c:when test="${nickName==null}">
            <div class="top-auth">
                <span style="font-size: 13px; color: #666; cursor: pointer;">
                    <a href="/members/toLogin" style="text-decoration: none; color:black; margin-right:10px;">
                        <i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>로그인
                    </a>
                </span>
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
                    <a href="/admin/admin_main" style="text-decoration:none;"><div class="now-admin">관리자</div></a>
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
					</a> <a href="/boards/mainboard_list?page=1"> <i
						class="fa-regular fa-message fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 커뮤니티
					</a> <a href="/qna/qna?page=1"> <i
						class="fa-solid fa-question fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 고객지원
					</a>
            </div>
        </div>

        <c:if test="${nickName==null}">
			<a class="my-page active" href="/mypage/toMypage"> <i
				class="fa-solid fa-user-gear fa-lg"
				style="color: rgb(79, 103, 232);"></i> 마이페이지
			</a>
        </c:if>
        <c:if test="${nickName!=null}">
			<a class="my-page active" href="/mypage/toMypage"> <i
				class="fa-solid fa-user-gear fa-lg"
				style="color: rgb(79, 103, 232);"></i> 마이페이지
			</a>
        </c:if>
    </nav>

    <div class="page">
        <div class="page-header">
            <div class="page-title">지원자 관리</div>
        </div>
        <hr class="title-line">

        <div class="resume-view-card">

            <div class="top-summary">
                <div class="summary-left">
                    <div class="resume-main-title">${applicant.resume_title}</div>

                    <div class="summary-meta">
                        <span><i class="fa-regular fa-user"></i>지원자 ${applicant.name}</span>
                        <span><i class="fa-solid fa-phone"></i>연락처 <c:set var="hp" value="${applicant.phone}" />
                                ${fn:substring(hp, 0, 3)}-${fn:substring(hp, 3, 7)}-${fn:substring(hp, 7, 11)}</span>
                    </div>
                </div>

                <div class="summary-right">
                    <c:if test="${not empty applicant.apply_status}">
                        <span class="status-badge">${applicant.apply_status}</span>
                    </c:if>
                </div>
            </div>

            <form action="/mypage/updateApplyStatus" method="post">
                <input type="hidden" name="apply_seq" value="${applicant.apply_seq}">
                <input type="hidden" name="resume_num" value="${applicant.resume_num}">
                <input type="hidden" name="job_post_num" value="${applicant.job_post_num}">

                <div class="info-section">
                    <div class="section-title">
                        지원 상태 관리
                    </div>

                    <div class="info-box">
                        <div class="info-label">지원 상태 수정</div>
                        <div class="status-edit-wrap">
                            <select name="apply_status" class="status-select">
                                <option value="${applicant.apply_status}">상태 선택</option>
                                <option value="지원 완료" ${applicant.apply_status == '지원 완료' ? 'selected' : ''}>지원 완료</option>
                                <option value="면접 예정" ${applicant.apply_status == '면접 예정' ? 'selected' : ''}>면접 예정</option>
                                <option value="최종 합격" ${applicant.apply_status == '최종 합격' ? 'selected' : ''}>최종 합격</option>
                                <option value="불합격" ${applicant.apply_status == '불합격' ? 'selected' : ''}>불합격</option>
                            </select>

                            <button type="submit" class="mini-save-btn">상태 저장</button>
                        </div>
                    </div>
                </div>
            </form>

            <div class="info-section">
                <div class="section-title">
                    지원자 정보
                </div>

                <div class="info-grid">
                    <div class="info-box">
                        <div class="info-label">이름</div>
                        <div class="info-value">${applicant.name}</div>
                    </div>

                    <div class="info-box">
                        <div class="info-label">연락처</div>
                        <div class="info-value"><c:set var="hp" value="${applicant.phone}" />
                                ${fn:substring(hp, 0, 3)}-${fn:substring(hp, 3, 7)}-${fn:substring(hp, 7, 11)}</div>
                    </div>
                </div>
            </div>

            <div class="info-section">
                <div class="section-title">

                    이력서 정보
                </div>

                <div class="info-grid">
                    <div class="info-box">
                        <div class="info-label">이력서 제목</div>
                        <div class="info-value">${applicant.resume_title}</div>
                    </div>

                    <div class="info-box">
                        <div class="info-label">희망 업종</div>
                        <div class="info-value">${applicant.preferred_job}</div>
                    </div>

                    <div class="info-box">
                        <div class="info-label">희망 근무 조건</div>
                        <div class="info-value">${applicant.working_condition}</div>
                    </div>

                    <div class="info-box">
                        <div class="info-label">경력 여부</div>
                        <div class="info-value">${applicant.career}</div>
                    </div>
                </div>
            </div>

            <div class="info-section">
                <div class="section-title">
                    경력 사항
                </div>
                <div class="full-box">
    <div class="full-value"><c:choose><c:when test="${not empty applicant.career_write}">${applicant.career_write}</c:when><c:otherwise><span class="empty-text">입력된 경력 사항이 없습니다.</span></c:otherwise></c:choose></div>
</div>
            </div>

            <div class="info-section" style="margin-bottom: 0;">
                <div class="section-title">
                    자기소개
                </div>
                <div class="full-box">
    
                <div class="full-value"><c:choose><c:when test="${not empty applicant.introduction}">${applicant.introduction}</c:when><c:otherwise><span class="empty-text">작성된 자기소개가 없습니다.</span></c:otherwise></c:choose></div>
</div>
            </div>

            <div class="post-footer">           
                <a href="/mypage/employ_activity?page=1" class="apply-detail-btn">목록으로</a>
            </div>
        </div>
    </div>
</div>

<div class="container-footer">
    <p>© 2026 돈워리. All rights reserved.</p>
    <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">
        개인정보처리방침 | 이용약관 | 고객센터
    </p>
</div>
<script>
$(document).ready(function() {
	const loginUser = "${nickName}";
    if (!loginUser || loginUser === "") {
        alert("잘못된 접근입니다.");
        location.replace("/members/toLogin"); // 기록을 남기지 않고 이동
    }
})

</script>
</body>
</html>