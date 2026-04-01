<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>돈워리 - 메인(홈)</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 기본 초기화 및 폰트 설정 */
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

        /* 레이아웃 컨테이너 */
        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* 로그인 및 관리자 */
        .top-auth {
            display: flex;
            justify-content: flex-end;
            /* 오른쪽 정렬 핵심 */
            align-items: center;
            gap: 15px;
            /* 요소 간 간격 */
            padding: 8px 0;
            /* 위아래 여백 */
        }

        /* [3] 네비게이션바 */
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
            /* 아이콘과 글자 사이 간격 */
            text-decoration: none;
            color: #666;
            font-size: 14px;
            font-weight: 500;
            /* 중요: 클릭 영역을 확실히 확보 */
            padding: 5px 10px;
            cursor: pointer;

        }

        .nav-menu a.active {
            color: #2563eb;
        }

        /*사용사 식별 표시*/
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

        /* .detail-content {
    white-space: pre-line;
} */
    </style>

<body>
    <div class="container">
        <div class="top-auth">
            <span style="font-size: 13px; color: #666; cursor: pointer;">
                <a href="/members/toLogin" style="text-decoration: none; color:black">
                    <i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>로그인
                </a>
            </span>
            <!-- 일단 관리자 빼고 다 숨겨둠 -->
            <div class="now-admin">관리자</div>
            <div class="now-business" style="display: none;">기업</div>
            <div class="now-personal" style="display: none;">개인</div>
        </div>
        <nav class="navbar">
            <div style="display: flex; align-items: center; gap: 40px;">
                <a href="/" class="logo"> 돈워리</a>
                <div class="nav-menu">
                    <a href="/" class="active">
                        <i class="fa-solid fa-house fa-lg" style="color: rgb(36, 99, 235);"></i>
                        홈
                    </a>
                    <a href="salary/calendar">
                        <i class="fa-regular fa-calendar fa-lg" style="color:rgb(203, 203, 203); margin-right:5px;"></i>
                        급여 캘린더
                    </a>
                    <a href="#">
                        <i class="fa-solid fa-briefcase fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                        구인구직
                    </a>
                    <a href="/boards/mainboard_list?page=1">
                        <i class="fa-regular fa-message fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                        커뮤니티
                    </a>
                </div>
            </div>
            <a class="my-page" href="#">
                <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(197, 197, 197);"></i>
                마이페이지
            </a>
        </nav>

        <div class="post-detail">

            <!-- 카테고리 -->
            <div class="detail-category">${dto.category }</div>

            <!-- 제목 -->
            <h1 class="detail-title">${dto.title }</h1> <br>

            <!-- 작성 정보 -->
            <div class="detail-info">
                <div class="info-left">
                    <span class="writer">${dto.member_id }</span>
                    <span class="divider">|</span>
                    <span class="date"><fmt:formatDate value="${i.write_date }" pattern="yyyy-MM-dd"/></span>
                </div>
                <div>
                    👁 ${dto.view_count }
                </div>
            </div>

            <!-- 본문 -->
            <div class="detail-content">
                ${dto.content }
            </div>

            <!-- 버튼 -->
            <div class="detail-actions">
                <button onclick="location.href='/boards/mainboard_list?page=1'">목록</button>
                <button onclick="location.href='/boards/update?seq=${dto.seq}'">수정</button>
                <button >삭제</button>
            </div>

        </div>


        <div class="container-footer">
            <p>© 2026 돈워리. All rights reserved.</p>
            <p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
        </div>
    </div>
</body>

</html>