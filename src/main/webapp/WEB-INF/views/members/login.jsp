<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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
            justify-content: flex-end; /* 오른쪽 정렬 핵심 */
            align-items: center;
            gap: 15px;                 /* 요소 간 간격 */
            padding: 8px 0;           /* 위아래 여백 */
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
        .my-page{
            justify-content: flex-end; /* 오른쪽 정렬 핵심 */
            margin-left: auto; /* 왼쪽의 모든 공간을 밀어내어 오른쪽 끝으로 이동 */
            text-decoration: none;
            color: #666;
            font-size: 14px;
            font-weight: 500;
        }
        .nav-menu a.active { color: #2563eb; }
        .admin-btn {
            background-color: #2563eb;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            border: none;
            font-size: 13px;
            cursor: pointer;
        }
.container-footer{
            border-top: 1px solid #e5e7eb; /* 테두리를 상단에만 */
            background-color: #f9fafb;     /* 너무 어두운 회색 대신 밝은 회색 추천 */
            padding: 40px 0;               /* % 높이 대신 안쪽 여백으로 높이 확보 */
            margin-top: 80px;              /* 컨텐츠와의 간격 */
            text-align: center;
            color: #999;
            font-size: 13px;
            width: 100vw;                  /* 화면 끝까지 너비 확장 */
            margin-left: calc(-50vw + 50%); /* 컨테이너를 벗어나 화면 꽉 채우기 */
        }
/* 로그인 박스 */
.login-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 70vh;
}

.login-box {
    width: 350px;
    background: white;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.05);
}

.login-title {
    text-align: center;
    font-size: 22px;
    font-weight: 700;
    margin-bottom: 30px;
}

/* input */
.input-group {
    margin-bottom: 15px;
}

.input-group input {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
}

.input-group input:focus {
    outline: none;
    border-color: #2563eb;
}

/* 버튼 */
.login-btn {
    width: 100%;
    padding: 12px;
    background-color: #2563eb;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 15px;
    cursor: pointer;
    margin-top: 10px;
}

.login-btn:hover {
    background-color: #1e4ed8;
}

/* 하단 링크 */
.login-footer {
    text-align: center;
    margin-top: 20px;
    font-size: 13px;
    color: #666;
}

.login-footer a {
    text-decoration: none;
    color: #2563eb;
    margin: 0 5px;
}        


    </style>
</head>
<body>
    <div class="container">
    <div class="top-auth">
        <span style="font-size: 13px; color: #666; cursor: pointer;">
            <a style="text-decoration: none; color:black" href="#">로그인</a>
        </span>
        <button class="admin-btn">관리자</button>
    </div>
    <nav class="navbar">
        <div style="display: flex; align-items: center; gap: 40px;">
            <a href="#" class="logo"> 돈워리</a>
            <div class="nav-menu">
                <a href="#" class="active"> 
                    <i class="fa-solid fa-house fa-lg" style="color: rgb(36, 99, 235);"></i>
                    홈
                </a>
                <a href="#">
                    <i class="fa-regular fa-calendar fa-lg" style="color:rgb(203, 203, 203); margin-right:5px;"></i>
                    급여 캘린더
                    </a>
                <a href="#"> 
                    <i class="fa-solid fa-briefcase fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    구인구직
                </a>
                <a href="#"> 
                    <i class="fa-regular fa-message fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i> 커뮤니티
                </a>               
            </div>           
        </div>   
        <a class="my-page" href="#"> 마이페이지</a>    
    </nav>
    <!-- 로그인 영역 -->
<div class="login-wrapper">
    <div class="login-box">

        <div class="login-title">로그인</div>

        <form action ="members/login" method ="post">
            <div class="input-group">
                <input type="text" placeholder="아이디" name="id">
            </div>

            <div class="input-group">
                <input type="password" placeholder="비밀번호" name="pw">
            </div>

            <button class="login-btn">로그인</button>
        </form>

        <div class="login-footer">
            <a href="/members/toSignUp">회원가입</a> |
            <a href="/members/toIdSearch">아이디 찾기</a> |
            <a href="#">비밀번호 찾기</a>
        </div>

    </div>
</div>
</div>
</body>
</html>