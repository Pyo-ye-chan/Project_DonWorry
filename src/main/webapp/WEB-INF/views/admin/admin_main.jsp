<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>관리자 메인</title>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

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
    color: #333;
    line-height: 1.6;
}

.container {
    max-width: 1100px;
    margin: 0 auto;
    padding: 0 20px;
}

/* 상단 */
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

/* 관리자 메인 */
.admin-page {
    padding: 36px 0 0;
    min-height: 800px;
}

.admin-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin-bottom: 20px;
    gap: 20px;
}

.admin-title-wrap h2 {
    font-size: 30px;
    font-weight: 800;
    color: #1e293b;
    margin-bottom: 6px;
    margin-left: 10px;
}

.admin-title-wrap p {
    font-size: 14px;
    color: #64748b;
    margin-left: 10px;
}

.admin-date-box {
    background: #fff;
    padding: 12px 16px;
    font-size: 15px;
    color: #475569;
}

/* 상단 툴바 */
.admin-toolbar {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 18px;
    margin-bottom: 22px;
    padding: 0;
}

.admin-tool-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    height: 72px;
    padding: 0 18px;
    border: 1px solid #e7eef8;
    border-radius: 18px;
    background: #fff;
    color: #2563eb;
    text-decoration: none;
    font-size: 16px;
    font-weight: 800;
    box-shadow: 0 0 0px 1px rgba(37, 99, 235, 0.5);
    transition: all 0.2s ease;
}

.admin-tool-btn:hover {
    background: #f8fbff;
    transform: translateY(-2px);
}

.admin-tool-btn.active {
    background: #2563eb;
    color: #fff;
    border-color: #2563eb;
}

/* 카드 */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 18px;
    margin-bottom: 22px;
}

.stat-card {
    background: #fff;
    border: 1px solid #e7eef8;
    border-radius: 18px;
    padding: 22px 22px 18px;
    position: relative;
    overflow: hidden;
}

.stat-card::after {
    content: "";
    position: absolute;
    right: -20px;
    top: -20px;
    width: 90px;
    height: 90px;
    border-radius: 50%;
}

.stat-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 14px;
    position: relative;
    z-index: 1;
}

.stat-label {
    font-size: 14px;
    color: #64748b;
    font-weight: 600;
}

.stat-icon {
    width: 56px;
    height: 56px;
    border-radius: 16px;
    background: #eff6ff;
    color: #2563eb;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
}

.stat-value {
    font-size: 30px;
    font-weight: 800;
    color: #0f172a;
    margin-bottom: 6px;
    position: relative;
    z-index: 1;
}

.stat-desc {
    font-size: 13px;
    color: #2563eb;
    position: relative;
    z-index: 1;
}

/* 대시보드 영역 */
.dashboard-grid {
    display: grid;
    grid-template-columns: 1.45fr 1.1fr;
    gap: 20px;
    margin-bottom: 22px;
}

.dashboard-card {
    background: #fff;
    border: 1px solid #e7eef8;
    border-radius: 18px;
    padding: 22px;
}

.card-head {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 18px;
}

.card-head h3 {
    font-size: 18px;
    font-weight: 800;
    color: #1e293b;
    margin: 0;
}

.card-head a {
    text-decoration: none;
    color: #2563eb;
    font-size: 13px;
    font-weight: 700;
}

.chart-box {
    height: 280px;
}

/* 하단 영역 */
.bottom-grid {
    display: grid;
    grid-template-columns: 1.45fr 1.1fr;
    gap: 20px;
    margin-bottom: 40px;
}

.admin-table {
    width: 100%;
    border-collapse: collapse;
}

.admin-table th,
.admin-table td {
    padding: 14px 10px;
    border-bottom: 1px solid #eef2f7;
    text-align: left;
    font-size: 14px;
}

.admin-table th {
    color: #64748b;
    font-weight: 700;
    background-color: #fafcff;
    
}


.admin-table tbody tr:hover {
    background-color: #f8fbff;
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

.status-wait {
    background: #fff4db;
    color: #d97706;
}

.status-stop {
    background: #ffe9e9;
    color: #dc2626;
}

/* 회원 비율 카드 */
.member-ratio-wrap {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

.ratio-chart-box {
    width: 240px;
    height: 240px;
    margin: 10px auto 20px;
}

.ratio-legend {
    width: 100%;
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.ratio-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    border: 1px solid #edf2f7;
    border-radius: 12px;
    padding: 12px 14px;
    background: #fbfdff;
}

.ratio-left {
    display: flex;
    align-items: center;
    gap: 10px;
}

.ratio-dot {
    width: 12px;
    height: 12px;
    border-radius: 50%;
}

.ratio-dot.personal {
    background: #1677ff;
}

.ratio-dot.business {
    background: #93c5fd;
}

.ratio-name {
    font-size: 14px;
    color: #334155;
    font-weight: 600;
}

.ratio-value {
    font-size: 14px;
    color: #0f172a;
    font-weight: 700;
}

/* footer */
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




</style>
</head>
<body>

<div class="container">
    <div class="top-auth">  
        <span style="font-size: 13px; color: #666; cursor: pointer;">
        	<i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
            	${nickName}님 환영합니다.
            <a href="members/logout" style="text-decoration: none; color:black">
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
                <a href="/admin/admin_main"  class="active">
                   <i class="fa-solid fa-wrench fa-lg" style="color: rgb(36, 99, 235); margin-right:6px;"></i>
                    관리자 대시보드
                </a> 
                <a href="/admin/admin_boards">
                   <i class="fa-solid fa-file-pen fa-lg" style="color: rgb(197, 197, 197); margin-right:6px;"></i>
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

        <div class="admin-header">
            <div class="admin-title-wrap">
                <h2>관리자 대시보드</h2>
                <p>회원, 게시글, 문의 현황을 한눈에 확인할 수 있습니다.</p>
            </div>

            <div class="admin-date-box">
                <i class="fa-regular fa-calendar-check" style="margin-right:6px;"></i>
                2026-04-01 기준 운영 현황
            </div>
        </div>

        <!-- 이동 툴바 -->
        <div class="admin-toolbar">
            <a href="/admin/admin_members" class="admin-tool-btn">
                <i class="fa-solid fa-users"></i>
                회원 관리
            </a>
            <a href="/admin/admin_boards" class="admin-tool-btn">
                <i class="fa-regular fa-clipboard"></i>
                게시글 관리
            </a>
            <a href="/admin/admin_inquiry" class="admin-tool-btn">
                <i class="fa-regular fa-envelope-open"></i>
                고객 문의 관리
            </a>
        </div>

        <section class="stats-grid">
            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-label">전체 사용자</div>
                    <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
                </div>
                <div class="stat-value">3,300</div>
                <div class="stat-desc">전월 대비 +8.4%</div>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-label">전체 게시글</div>
                    <div class="stat-icon"><i class="fa-regular fa-pen-to-square"></i></div>
                </div>
                <div class="stat-value">1,200</div>
                <div class="stat-desc">오늘 신규 게시글 27건</div>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-label">미답변 문의</div>
                    <div class="stat-icon"><i class="fa-regular fa-envelope"></i></div>
                </div>
                <div class="stat-value">23</div>
                <div class="stat-desc">24시간 이상 경과 6건</div>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-label">기업 회원</div>
                    <div class="stat-icon"><i class="fa-solid fa-building"></i></div>
                </div>
                <div class="stat-value">323</div>
                <div class="stat-desc">이번 주 신규 12곳</div>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-label">구인 공고 수</div>
                    <div class="stat-icon"><i class="fa-solid fa-briefcase"></i></div>
                </div>
                <div class="stat-value">132</div>
                <div class="stat-desc">현재 모집중 98건</div>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-label">신고 접수</div>
                    <div class="stat-icon"><i class="fa-regular fa-bell"></i></div>
                </div>
                <div class="stat-value">13</div>
                <div class="stat-desc">즉시 확인 필요 4건</div>
            </div>
        </section>

        <section class="dashboard-grid">
            <div class="dashboard-card">
                <div class="card-head">
                    <h3>방문자 추이</h3>
                </div>
                <div class="chart-box">
                    <canvas id="visitorChart"></canvas>
                </div>
            </div>

            <div class="dashboard-card">
                <div class="card-head">
                    <h3>게시글 / 문의 현황</h3>
                </div>
                <div class="chart-box">
                    <canvas id="postChart"></canvas>
                </div>
            </div>
        </section>

        <section class="bottom-grid">
            <div class="dashboard-card">
                <div class="card-head">
                    <h3>최근 가입 회원</h3>
                </div>

                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>유형</th>
                            <th>가입일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Project_Vision</td>
                            <td>vision@email.com</td>
                            <td>개인</td>
                            <td>2026-04-01</td>
                        </tr>
                        <tr>
                            <td>UX_Design_Pro</td>
                            <td>design@email.com</td>
                            <td>기업</td>
                            <td>2026-04-01</td>
                        </tr>
                        <tr>
                            <td>Tech_Specialist</td>
                            <td>tech@email.com</td>
                            <td>개인</td>
                            <td>2026-03-31</td>
                        </tr>
                        <tr>
                            <td>Risk_Assessment</td>
                            <td>risk@email.com</td>
                            <td>기업</td>
                            <td>2026-03-31</td>                
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- 빠른 관리 메뉴 대신 회원 비율 원형 그래프 -->
            <div class="dashboard-card">
                <div class="card-head">
                    <h3>회원 유형 비율</h3>
                </div>

                <div class="member-ratio-wrap">
                    <div class="ratio-chart-box">
                        <canvas id="memberRatioChart"></canvas>
                    </div>

                    <div class="ratio-legend">
                        <div class="ratio-item">
                            <div class="ratio-left">
                                <span class="ratio-dot personal"></span>
                                <span class="ratio-name">개인 회원</span>
                            </div>
                            <span class="ratio-value">2,977명 (90.2%)</span>
                        </div>

                        <div class="ratio-item">
                            <div class="ratio-left">
                                <span class="ratio-dot business"></span>
                                <span class="ratio-name">기업 회원</span>
                            </div>
                            <span class="ratio-value">323명 (9.8%)</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </main>

    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>

</div>

<script>
const visitorCtx = document.getElementById('visitorChart');

new Chart(visitorCtx, {
    type: 'line',
    data: {
        labels: ['18일', '20일', '22일', '24일', '26일', '28일', '30일'],
        datasets: [
            {
                label: '이번 주',
                data: [100, 122, 170, 166, 180, 176, 160],
                borderColor: '#1677ff',
                backgroundColor: 'rgba(22,119,255,0.08)',
                fill: true,
                tension: 0.35,
                pointRadius: 4,
                pointBackgroundColor: '#1677ff'
            },
            {
                label: '지난 주',
                data: [60, 80, 70, 68, 80, 78, 100],
                borderColor: '#b8c2cc',
                backgroundColor: 'rgba(184,194,204,0.05)',
                fill: true,
                tension: 0.35,
                pointRadius: 3,
                pointBackgroundColor: '#b8c2cc'
            }
        ]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                position: 'bottom'
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                grid: {
                    color: '#eef3f8'
                }
            },
            x: {
                grid: {
                    display: false
                }
            }
        }
    }
});

const postCtx = document.getElementById('postChart');

new Chart(postCtx, {
    type: 'bar',
    data: {
        labels: ['6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        datasets: [
            {
                label: '게시글',
                data: [120, 180, 240, 210, 230, 220, 260],
                backgroundColor: '#1677ff',
                borderRadius: 8
            },
            {
                label: '문의',
                data: [80, 130, 180, 160, 170, 150, 190],
                backgroundColor: '#d6dee8',
                borderRadius: 8
            }
        ]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                position: 'bottom'
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                grid: {
                    color: '#eef3f8'
                }
            },
            x: {
                grid: {
                    display: false
                }
            }
        }
    }
});

const memberRatioCtx = document.getElementById('memberRatioChart');

new Chart(memberRatioCtx, {
    type: 'doughnut',
    data: {
        labels: ['개인 회원', '기업 회원'],
        datasets: [{
            data: [2977, 323],
            backgroundColor: ['#1677ff', '#93c5fd'],
            borderWidth: 0,
            hoverOffset: 6
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        cutout: '68%',
        plugins: {
            legend: {
                display: false
            }
        }
    }
});
</script>

</body>
</html>