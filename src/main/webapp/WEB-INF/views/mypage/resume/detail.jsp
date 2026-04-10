<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
     <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>돈워리- 구직 활동 관리</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 기본 초기화 및 폰트 설정 */
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
        .my-page.active { color: #2563eb; }

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

        /* 공통 버튼 베이스 */
        .btn-base {
            width: 60px;
            height: 30px;
            border-radius: 6px;
            font-size: 13px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: none;
        }

        .now-business,
        .now-personal {
            background-color: #2563eb;
            color: white;
        }

        .logout-btn {
            background-color: #fff;
            color: #868e96;
            border: 1px solid #dee2e6;
        }

        .logout-btn:hover {
            background-color: #f8f9fa;
            color: #495057;
        }

        /* [3] 이력서 본문 (불필요한 margin/padding 조정) */
        .page {
            padding: 60px 0 100px;
            width: 65%;
            margin: auto;
        }

        .resume-header {
            margin-bottom: 30px;
            border-bottom: 1px solid #f1f5f9;
            padding-bottom: 15px;
        }

        .page-title {
            font-size: 26px;
            font-weight: 800;
            margin-bottom: 5px;
        }

        .resume-date {
            font-size: 14px;
            color: #94a3b8;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* 카드 섹션 */
        .resume-form-card {
            background: #fff;
            border: 1px solid #f1f5f9;
            border-radius: 20px;
            padding: 40px;
            shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 14px;
            font-weight: 700;
            color: #64748b;
            margin-bottom: 12px;
        }

        .form-label span i {
            color: #2563eb;
            margin-right: 8px;
        }

        /* 정보 출력 박스 */
        .info-display {
            background: #f8fafc;
            border-radius: 12px;
            padding: 16px 20px;
            font-size: 15px;
            color: #1e293b;
            min-height: 52px;
            display: flex;
            align-items: center;
            border: 1px solid #f1f5f9;
            word-break: break-all;
        }

        .info-display.textarea {
            align-items: flex-start;
            min-height: 150px;
            white-space: pre-wrap;
            line-height: 1.7;
        }

        /* 배지 */
        .status-badge {
            padding: 4px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 700;
        }

        .badge-career {
            background: #e0f2fe;
            color: #0369a1;
        }

        .badge-new {
            background: #f1f5f9;
            color: #64748b;
        }

        /* [4] 푸터 버튼 그룹 */
        .post-footer {
            padding-top: 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn-action {
            height: 50px;
            padding: 0 30px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            border: 1px solid transparent;
            transition: 0.2s;
        }

        .btn-list {
            background: #fff;
            color: #868e96;
            border-color: #dee2e6;
        }

        .btn-update {
            background: #2563eb;
            color: #fff;
        }

        .btn-delete {
            background: #fff;
            color: #ef4444;
            border-color: #fecaca;
        }

        .btn-action:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        /* [5] 푸터 하단 */
        .container-footer {
            border-top: 1px solid #f1f5f9;
            background: #f9fafb;
            padding: 40px 0;
            margin-top: 80px;
            text-align: center;
            color: #999;
            font-size: 12px;
            width: 100vw;
            margin-left: calc(-50vw + 50%);
        }

        /* 상태 배지 공통 */
        .status-toggle {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 700;
        }

        /* 공개 상태: 초록 계열 또는 브랜드 컬러 */
        .status-public {
            background-color: #ecfdf5;
            color: #10b981;
            border: 1px solid #d1fae5;
        }

        /* 비공개 상태: 회색 계열 */
        .status-private {
            background-color: #f1f5f9;
            color: #64748b;
            border: 1px solid #e2e8f0;
        }
    </style>
</head>

<body>

    <div class="community-container">
        <c:choose>
            <c:when test="${nickName==null}">
                <div class="top-auth">
                    <span style="font-size: 13px; color: #666; cursor: pointer;">
                        <a href="members/toLogin" style="text-decoration: none; color:black; margin-right:10px;">
                            <i class="fa-regular fa-user fa-lg"
                                style="color: rgb(203, 203, 203); margin-right:5px;"></i>로그인
                        </a>
                    </span>
                </div>
            </c:when>
            <c:otherwise>
                <div class="top-auth">
                    <span style="font-size: 13px; color: #666; cursor: pointer;">
                        <i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                        ${nickName}님 환영합니다.
                        <a href="members/logout" style="text-decoration: none; color:black">
                            <button class="logout-btn" style="margin-left:10px;">로그아웃</button>
                        </a>
                    </span>
                    <c:if test="${type=='관리자'}">
                        <a href="/admin/admin_main" style="text-decoration:none;">
                            <div class="now-admin">관리자</div>
                        </a>
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
                    <a href="/" class="active">
                        <i class="fa-solid fa-house fa-lg" style="color: rgb(36, 99, 235);"></i>
                        홈
                    </a>
                    <a href="/salary/calendar">
                        <i class="fa-regular fa-calendar fa-lg" style="color:rgb(203, 203, 203); margin-right:5px;"></i>
                        급여 캘린더
                    </a>
                    <a href="/jobposts/jobpost">
                        <i class="fa-solid fa-briefcase fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                        구인구직
                    </a>
                    <a href="/boards/mainboard_list">
                        <i class="fa-regular fa-message fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                        커뮤니티</a>
                    <a href="/qna/qna?page=1">
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

        <div class="community-container">
            <div class="page">
                <div class="resume-header">
                    <h2 class="page-title">내 이력서 상세 정보</h2>
                    <div class="resume-date"><i class="fa-regular fa-clock"></i> 작성일: 2026-04-09</div>
                </div>

                <form action="/mypage/toUpdateResume" method="get">
                <input type="hidden" name = "seq" value="${dto.seq }">
                    <div class="resume-form-card">


                        <div class="form-group">
                            <label class="form-label">
                                <span><i class="fa-solid fa-quote-left"></i>이력서 제목</span>

                               <!--   <c:choose>
                                    <c:when test="${dto.is_show == 'Y'}">
                                        <span class="status-toggle status-public">
                                            <i class="fa-solid fa-eye"></i> 공개 중
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-toggle status-private">
                                            <i class="fa-solid fa-eye-slash"></i> 비공개
                                        </span>
                                    </c:otherwise>
                                </c:choose>-->
                            </label>
                            <div class="info-display" style="color:#2563eb; font-weight:800;">${dto.title}</div>
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 25px;">
                            <div class="form-group" style="margin-bottom: 0;">
                                <label class="form-label"><span><i class="fa-solid fa-envelope"></i>이메일</span></label>
                                <div class="info-display">${dto.email}</div>
                            </div>
                            <div class="form-group" style="margin-bottom: 0;">
                                <label class="form-label"><span><i class="fa-solid fa-phone"></i>전화번호</span></label>
                                <div class="info-display"><c:set var="hp" value="${dto.phone}" />
                                ${fn:substring(hp, 0, 3)}-${fn:substring(hp, 3, 7)}-${fn:substring(hp, 7, 11)}</div>
                            </div>
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                            <div class="form-group">
                                <label class="form-label"><span><i class="fa-solid fa-briefcase"></i>희망
                                        업종</span></label>
                                <div class="info-display">${dto.preferred_job}</div>
                            </div>
                            <div class="form-group">
                                <label class="form-label"><span><i class="fa-solid fa-clock"></i>희망 근무 조건</span></label>
                                <div class="info-display">${dto.working_condition}</div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <span><i class="fa-solid fa-star"></i>경력 사항</span>
                                <span
                                    class="status-badge ${dto.career == '경력' ? 'badge-career' : 'badge-new'}">${dto.career}</span>
                            </label>
                            <div class="info-display ${dto.career != '경력' ? 'empty' : ''}">
                                ${dto.career == '경력' ? dto.career_write : '신입 지원자입니다.'}
                            </div>
                        </div>

                        <div class="form-group" style="margin-bottom:0;">
                            <label class="form-label"><span><i class="fa-solid fa-user-pen"></i>자기소개</span></label>
                            <div class="info-display textarea">${dto.introduction}</div>
                        </div>
                    </div>

                    <div class="post-footer">
                        <button type="button" class="btn-action btn-list" onclick="location.href='/mypage/myresume'"><i
                                class="fa-solid fa-list"></i>목록</button>
                        <div style="display:flex; gap:10px;">
                            <button type="button" class="btn-action btn-delete" id="deleteBtn"><i
                                    class="fa-regular fa-trash-can"></i>삭제</button>
                            <button type="submit" class="btn-action btn-update"><i
                                    class="fa-solid fa-pen"></i>수정</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="container-footer">
            <p>© 2026 돈워리. All rights reserved.</p>
            <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침 | 이용약관 | 고객센터</p>
        </div>
        <script>
        
        $("#deleteBtn").on("click",function(){
        	 if (!confirm("정말 삭제하시겠습니까?")) {
        			return false;
        		}
        		 location.href = "/mypage/resume_delete?seq="+${dto.seq};
        })

        </script>
</body>

</html>