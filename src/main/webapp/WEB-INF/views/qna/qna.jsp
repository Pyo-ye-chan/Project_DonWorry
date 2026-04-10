<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>     
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>돈워리 - 고객지원</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
         /* [1] 원본 초기화 및 레이아웃 유지 */
    * { margin: 0; padding: 0; box-sizing: border-box; }
    
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
		
		 /*관리자 버튼*/
        .now-admin {
            width:60px;
            height:30px;
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
            width:60px;
            height:30px;
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
            width:60px;
            height:30px;
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
    .top-auth { display: flex; justify-content: flex-end; align-items: center; gap: 15px; padding: 8px 0; }
    .navbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 0; border-bottom: 1px solid #f0f0f0; }
    .logo { color: #2563eb; font-weight: 800; font-size: 20px; text-decoration: none; }
    .nav-menu { display: flex; gap: 40px; }
    .nav-menu a { text-decoration: none; color: #666; font-size: 14px; font-weight: 500; }
    .my-page { display: flex; align-items: center; gap: 8px; text-decoration: none; color: #666; font-size: 14px; font-weight: 500; padding: 5px 10px; cursor: pointer; }
    .nav-menu a.active { color: #2563eb; }
    .now-admin { width:60px; height:30px; background-color: #2563eb; color: white; display: flex; align-items: center; justify-content: center; border-radius: 6px; font-size: 13px; cursor: pointer; }

    /* [5] 푸터 (상단바와 무관하게 하단 고정 설정) */
    .container-footer {
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

        /* [3] 고객지원 헤더 (글씨색 수정 및 상단 여백) */
        .qna-section {
            margin-top: 20px;
        }

        .qna-header {
            padding: 40px 0 20px;
            border-bottom: 2px solid #2563eb;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 30px;
        }

        .qna-header h2 {
            font-size: 28px;
            color: #1a1a1a;
            font-weight: 700;
        }

        .qna-header p {
            color: #adb5bd;
            margin-top: 8px;
            font-size: 14px;
        }

        /* 요청하신 색상 적용 */

        .write-btn {
            background-color: #2563eb;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: background 0.2s;
        }

        .write-btn:hover {
            background-color: #1d4ed8;
        }

        /* [4] FAQ 스타일 (여백 조정) */
        .faq-container {
            margin-top: 30px;
            margin-bottom: 60px;
            background-color: #f8f9fa;
            border-radius: 12px;
            padding: 30px;
        }

        .faq-title {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .faq-item {
            background-color: white;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            margin-bottom: 10px;
            overflow: hidden;
        }

        .faq-question {
            padding: 15px 20px;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 500;
            font-size: 15px;
            word-break: break-all;
        }

        .faq-question:hover {
            background-color: #f1f3f5;
        }

        .faq-answer {
            padding: 0 20px;
            max-height: 0;
            overflow: hidden;
            transition: all 0.3s ease-out;
            background-color: #fff;
            font-size: 14px;
            color: #666;
            line-height: 1.8;
            word-break: break-all;
        }

        .faq-item.active .faq-answer {
            padding: 15px 20px;
            max-height: 500px;
            border-top: 1px solid #f1f3f5;
        }

        .faq-item.active .fa-chevron-down {
            transform: rotate(180deg);
        }

        .fa-chevron-down {
            transition: transform 0.3s;
            font-size: 12px;
            color: #adb5bd;
        }

        /* [5] 리스트 테이블 스타일 (카테고리 컬럼 제거 대응) */
        .qna-list {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 50px;
        }

        .qna-list th {
            background-color: #f8f9fa;
            padding: 15px;
            border-bottom: 1px solid #dee2e6;
            font-size: 14px;
            color: #495057;
        }

        .qna-list td {
            padding: 18px 15px;
            border-bottom: 1px solid #f1f3f5;
            font-size: 15px;
            color: #333;
            text-align: center;
        }

        .qna-list tr:hover {
            background-color: #fcfcfc;
            cursor: pointer;
        }

        .qna-list .title-cell {
            /*text-align: left;*/
            text-align:center;
              
           /* padding-left: 30px;*/
        }
        

        .status-badge {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-waiting {
            background-color: #e9ecef;
            color: #868e96;
        }

        .status-complete {
            background-color: #e7f5ff;
            color: #228be6;
        }

        .no-data {
            padding: 80px 0;
            text-align: center;
            color: #adb5bd;
        }

        /* [6] 푸터 */
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
        /* [7] 페이징 내비게이션 스타일 */
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 5px;
    margin: 40px 0;
}

.pagination a, .pagination span {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 36px;
    height: 36px;
    border-radius: 6px;
    text-decoration: none;
    font-size: 14px;
    color: #495057;
    border: 1px solid #dee2e6;
    transition: all 0.2s;
}

.pagination a:hover {
    background-color: #f8f9fa;
    border-color: #ced4da;
}

.pagination .active {
    background-color: #2563eb;
    color: white;
    border-color: #2563eb;
    font-weight: 600;
}

.pagination .nav-btn {
    background-color: #ffffff;
}

.pagination .disabled {
    color: #dee2e6;
    cursor: default;
    pointer-events: none;
}
.qna-list .title-cell {
    
    padding-left: 20px;
    
    /* 핵심: 말줄임표 처리 */
    max-width: 0;           /* 너비 계산을 위한 기초값 */
    white-space: nowrap;    /* 줄바꿈 방지 */
    overflow: hidden;       /* 넘치는 부분 숨김 */
    text-overflow: ellipsis; /* 넘치는 부분 "..." 표시 */
}
    </style>
</head>

<body>
    <div class="community-container">
        <c:choose>
            <c:when test="${nickName==null}">
                <div class="top-auth">
                    <span style="font-size: 13px; color: #666; cursor: pointer;">
                        <a href="/members/toLogin" style="text-decoration: none; color:black">
                            <i class="fa-regular fa-user fa-lg"
                                style="color: rgb(203, 203, 203); margin-right:5px;"></i>로그인
                        </a>
                    </span>
                    <a href="/admin/admin_main" style="text-decoration:none;">
                        <div class="now-admin">관리자</div>
                    </a>
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
                        <div class="now-admin">관리자</div>
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
                    <a href="/"><i class="fa-solid fa-house fa-lg" style="color: rgb(203, 203, 203);"></i> 홈</a>
                    <a href="/salary/calendar"><i class="fa-regular fa-calendar fa-lg"
                            style="color:rgb(203, 203, 203); margin-right:5px;"></i> 급여 캘린더</a>
                    <a href="/jobposts/jobpost"><i class="fa-solid fa-briefcase fa-lg"
                            style="color: rgb(203, 203, 203); margin-right:5px;"></i> 구인구직</a>
                    <a href="/boards/mainboard_list?page=1"><i class="fa-regular fa-message fa-lg"
                            style="color: rgb(203, 203, 203); margin-right:5px;"></i> 커뮤니티</a>
                    <a href="/qna/qna?page=1" class="active"><i class="fa-solid fa-question fa-lg"
                            style="color: rgb(36, 99, 235); margin-right:5px;"></i> 고객지원</a>
                </div>
            </div>
            <a class="my-page" href="${nickName==null ? 'members/toLogin' : '/mypage/toMypage'}">
                <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(197, 197, 197);"></i> 마이페이지
            </a>
        </nav>

        <div class="qna-section">
            <div class="qna-header">
                <div>
                    <h2>고객지원</h2>
                    <p>궁금하신 점을 남겨주시면 관리자가 순차적으로 답변해 드립니다.</p>
                </div>
                <c:if test="${nickName != null }">
                <a href="/qna/toWrite" class="write-btn">
                    <i class="fa-solid fa-pen-to-square"></i> 1:1 문의하기
                </a>
                </c:if>
            </div>

            <div class="faq-container">
                <div class="faq-title">
                    <i class="fa-solid fa-circle-question" style="color: #2563eb;"></i> 자주 묻는 질문
                </div>
                
                <c:forEach var = "i" items = "${faqList }">
                	<div class="faq-item">
                    	<div class="faq-question"><span>${i.title }</span><i
                            class="fa-solid fa-chevron-down"></i></div>
                    	<div class="faq-answer">${i.content }</div>
                	</div>
                </c:forEach>
                
            </div>

            <h3 style="font-size: 18px; margin-bottom: 15px; font-weight: 700;">내 문의 내역</h3>
            <table class="qna-list">
                <colgroup>
                    <col style="width: 10%;">
                    <col style="width: auto;">
                    <col style="width: 20%;">
                    <col style="width: 15%;">
                </colgroup>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성일</th>
                        <th>답변상태</th>
                    </tr>
                </thead>
                <tbody>
                	<c:choose>
                		<c:when test="${nickName ==null }">
                			<tr>
                                <td colspan="4" class="no-data">
                                    
                                    <p>로그인 이후 이용가능합니다.</p>
                                </td>
                            </tr>
                		</c:when>
                		<c:otherwise>
                			<c:choose>
                        <c:when test="${empty list}">
                            <tr>
                                <td colspan="4" class="no-data">
                                    <i class="fa-regular fa-face-smile fa-3x"
                                        style="margin-bottom: 15px; color: #adb5bd;"></i>
                                    <p>문의 내역이 없습니다.</p>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="dto" items="${list}" varStatus="status">
                                <tr onclick="location.href='/qna/detail?seq=${dto.seq}'">
                                    <td>${((currentPage - 1) * 10) + status.count}</td>
                                    <td class="title-cell" >${dto.title }</td>
                                    <td>
                                        <fmt:formatDate value="${dto.write_date}" pattern="yyyy-MM-dd" />
                                    </td>
                                    <td>
                                        <span
                                            class="status-badge ${dto.status == 'status-complete' ? 'status-complete' : 'status-waiting'}">
                                            ${dto.status == 'status-complete' ? '답변완료' : '접수중'}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                		
                		</c:otherwise>
                	</c:choose>
                    
                </tbody>
            </table>
            <c:if test="${not empty list}">
    <div class="pagination">
        <c:choose>
            <c:when test="${needPrev}">
                <a href="/qna/qna?page=${startNavi - 1}" class="nav-btn">
                    <i class="fa-solid fa-chevron-left"></i>
                </a>
            </c:when>
            
        </c:choose>

        <c:forEach var="i" begin="${startNavi}" end="${endNavi}">
            <a href="/qna/qna?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
        </c:forEach>

        <c:choose>
            <c:when test="${needNext}">
                <a href="/qna/qna?page=${endNavi + 1}" class="nav-btn">
                    <i class="fa-solid fa-chevron-right"></i>
                </a>
            </c:when>
            
        </c:choose>
    </div>
</c:if>
        </div>
    </div>

    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>

    <script> 
    
    console.log(${needNext})
    
    
    $(document).ready(function () {
        $(".faq-question").click(function () {
            $(this).parent(".faq-item").toggleClass("active");
        });
    });
    </script>
</body>

</html>