<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>     
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
    background: #fff;
    color: #333;
    line-height: 1.6;
}

.container {
    max-width: 1100px;
    margin: 0 auto;
    padding: 0 20px;
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
    grid-template-columns: repeat(2, 1fr);
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

.btn-light-blue {
    height: 34px;
    border: 1px solid #cfe0ff;
    border-radius: 8px;
    padding: 0 12px;
    background: #f8fbff;
    color: #2563eb;
    font-size: 13px;
    font-weight: 700;
}

.btn-red {
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
    color: #64748b;
    font-weight: 700;
}

.admin-table td {
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
                <div class="summary-value">1,200</div>
                <div class="summary-sub">오늘 신규 27건</div>
            </div>
            <div class="summary-card notice">
                <div class="summary-label">공지 게시글</div>
                <div class="summary-value">6</div>
                <a href="/admin/notice_write" style="color: #2563eb; ">
                	<div class="summary-sub" style="color: #2563eb; ">작성하러 가기</div>
                </a>
            </div>
        </section>

         <section class="panel">
            <div class="panel-head">
                <h3>게시글 목록</h3>
            </div>

            <div class="filter-row">
                <select>
                    <option value="main">전체 게시판</option>
                    <option value="free">자유 게시판</option>
                    <option value="review">후기 게시판</option>
                    <option value="QA">질문 게시판</option>
                </select>
                <select>
                    <option>전체 상태</option>
                    <option>게시중</option>
                    <option>숨김</option>
                </select>
                <input type="text" placeholder="제목, 작성자 검색">
                <button class="btn-blue" type="button">검색</button>
            </div>

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
                    <tr>
                        <td>2001</td>
                        <td>자유</td>
                        <td>급여 계산 관련 질문 있어요</td>
                        <td>Project_Vision</td>
                        <td>2026-04-01</td>
                        <td><span class="state-pill state-show">게시중</span></td>
                        <td>
                            <button class="btn-light-blue" type="button">보기</button>
                            <button class="btn-red" type="button">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>2002</td>
                        <td>자유</td>
                        <td>급여 계산 관련 질문 있어요</td>
                        <td>Project_Vision</td>
                        <td>2026-04-01</td>
                        <td><span class="state-pill state-show">게시중</span></td>
                        <td>
                            <button class="btn-light-blue" type="button">보기</button>
                            <button class="btn-red" type="button">삭제</button>
                        </td>
                    </tr>                    
                </tbody>
            </table>

            <div class="pagination-wrap">
                <button class="page-btn">&lt;</button>
                <button class="page-btn active">1</button>
                <button class="page-btn">2</button>
                <button class="page-btn">3</button>
                <button class="page-btn">&gt;</button>
            </div>
        </section>

        <section class="panel">
            <div class="panel-head">
                <h3>공지글 목록</h3>
            </div>

            <div class="filter-row">
                <select>
                    <option>전체 게시판</option>
                    <option>자유 게시판</option>
                    <option>후기 게시판</option>
                    <option>질문 게시판</option>
                </select>
                <input type="text" placeholder="제목 검색">
                <button class="btn-blue" type="button">검색</button>
            </div>

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
                    <tr>
                        <td>01</td>
                        <td>자유</td>
                        <td>사용자 안내문</td>
                        <td>admin</td>
                        <td>2026-04-01</td>
                        <td><span class="state-pill state-show">게시중</span></td>
                        <td>
                            <button class="btn-light-blue" type="button">보기</button>
                            <button class="btn-red" type="button">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>00</td>
                        <td>후기</td>
                        <td>알바 리뷰게시판 도배 관련 안내문</td>
                        <td>admin</td>
                        <td>2026-03-31</td>
                        <td><span class="state-pill state-show">게시중</span></td>
                        <td>
                            <button class="btn-light-blue" type="button">보기</button>
                            <button class="btn-red" type="button">삭제</button>
                        </td>
                    </tr>

                </tbody>
            </table>

            <div class="pagination-wrap">
                <button class="page-btn">&lt;</button>
                <button class="page-btn active">1</button>
                <button class="page-btn">2</button>
                <button class="page-btn">3</button>
                <button class="page-btn">&gt;</button>
            </div>
        </section>
    </main>

    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top:10px; font-size:11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
</div>
</body>
</html>