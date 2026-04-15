<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>돈워리 - 아이디찾기</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">    
<link rel="shortcut icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon">
<link rel="icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon">
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
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
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

        /* 아이디 찾기 */
        /* [수정] 아이디 찾기 영역 컨테이너 */
.find-wrapper {
    display: flex;
    justify-content: center;
    align-items: flex-start; /* [중요] center에서 flex-start로 변경: 위에서부터 배치 */
    min-height: 60vh;        /* 고정 높이가 아닌 최소 높이로 변경 */
    padding: 80px 0;         /* 상하 여백을 충분히 주어 헤더/푸터와 격리 */
}

.find-box {
    width: 350px;
    background: white;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
    /* 박스가 너무 길어질 경우를 대비해 위치 고정 */
    margin-top: 0; 
}

        .find-title {
            text-align: center;
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 30px;
        }

        .find-btn {
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

        .find-btn:hover {
            background-color: #1e4ed8;
        }

/* 결과 영역 전체 컨테이너 */
.find-result {
    margin-top: 20px;
    max-height: 300px;    /* 아이디 리스트 최대 높이 제한 */
    overflow-y: auto;     /* 넘치면 박스 안에서 스크롤 */
    padding-right: 5px;
}

/* 개별 아이디 결과 항목 (스크립트에서 추가되는 div) */
.id-item-display {
    display: block;               /* 한 줄에 하나씩 점유 */
    width: 100%;                  /* 부모 너비에 맞춤 */
    margin-bottom: 8px;           /* 아이디 사이 간격 */
    padding: 12px 15px;           /* 안쪽 여백 */
    
    background-color: #f8fafc;    /* 연한 회색 배경 */
    border: 1px solid #e2e8f0;    /* 연한 테두리 */
    border-radius: 8px;           /* 모서리 둥글게 */
    
    color: #334155;               /* 기본 글자색 */
    font-size: 15px !important;    /* 글자 크기 강제 고정 */
    font-weight: 500;             /* 중간 굵기 */
    text-align: center;           /* 중앙 정렬 */
    
    /* 결과가 나타날 때 부드러운 효과 */
    animation: slideIn 0.3s ease-out;
}

/* 강조 텍스트 (아이디 부분만 색상 변경하고 싶을 때) */
.id-item-display strong {
    color: #2563eb;               /* 강조 파란색 */
    font-weight: 700;
    margin-left: 5px;
}

/* 결과창 애니메이션 */
@keyframes slideIn {
    from { opacity: 0; transform: translateY(5px); }
    to { opacity: 1; transform: translateY(0); }
}

/* 결과가 없을 때 출력되는 메시지 스타일 */
.no-result-msg {
    font-size: 14px;
    color: #ef4444;               /* 빨간색 계열 */
    padding: 10px 0;
    text-align: center;
}
        /* 하단 */
        .find-footer {
            text-align: center;
            margin-top: 20px;
            font-size: 13px;
            color: #666;
        }

        .find-footer a {
            text-decoration: none;
            color: #2563eb;
            margin: 0 5px;
        }
        /* style 태그 안에 추가 */
.found-id {
    background: #f1f5f9;
    border-radius: 4px;
    padding: 8px;
    margin: 5px 0;
    font-size: 14px;
}

    </style>
</head>

<body>
   <div class="community-container">
    <div class="top-auth">
        <span style="font-size: 13px; color: #666; cursor: pointer;">
            <a href="/members/toLogin" style="text-decoration: none; color:black; margin-right:10px;">
                <i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>로그인
            </a>
        </span>
    </div>
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
                <a href="/boards/mainboard_list?page=1">
                    <i class="fa-regular fa-message fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    커뮤니티</a>   
                 <a href="/qna/qna"> 
                    <i class="fa-solid fa-question fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>
                    고객지원
                </a>           
            </div>          
        </div>   
        <a class="my-page" href="/members/toLogin">
            <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(197, 197, 197);"></i>
            마이페이지
        </a>    
    </nav>


        <!-- 아이디 찾기 영역 -->
        <div class="find-wrapper">
            <div class="find-box">

                <div class="find-title">아이디 찾기</div>

              
                    <div class="input-group">
                        <input type="text" placeholder="이름" class = "name">
                    </div>

                    <div class="input-group">
                        <input type="email" placeholder="이메일" class ="email">
                    </div>

                    <button class="find-btn" type ="button">아이디 찾기</button>
                 

                <div class="find-result">
                    <!-- 결과 출력 영역 -->
                    
                </div>

                <div class="find-footer">
                    <a href="/members/toLogin">로그인</a> |
                    <a href="/members/toPwSearch">비밀번호 찾기</a>
                </div>

            </div>
        </div>

    </div>
    <div class="container-footer">
    <p>© 2026 돈워리. All rights reserved.</p>
    <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침 | 이용약관 | 고객센터</p>
</div>

</body>
<script>
$(".find-btn").on("click", function() {
    // 1. 새로운 검색을 위해 기존 결과창을 비웁니다.
    $(".find-result").empty(); 

    $.ajax({
        url: "/members/idSearch",
        data: {
            name: $(".name").val(),
            email: $(".email").val()
        },
        dataType: "json"
    }).done(function(resp) {
        // 1. 기존 결과 영역 완전히 비우기
        $(".find-result").empty(); 

        if (resp && resp.length > 0) {
            for (let i = 0; i < resp.length; i++) {
                // 2. 새로운 div 생성 및 위에서 만든 클래스 부여
                let idDiv = $("<div>");
                idDiv.addClass("id-item-display"); 
                
                // 3. 텍스트 삽입 
                idDiv.text("가입된 아이디 : " + resp[i].id);
                
                // 4. 결과창에 추가
                $(".find-result").append(idDiv);
            }
        } else {
            $(".find-result").html("<p style='font-size:14px; color:#666; text-align:center;'>일치하는 정보가 없습니다.</p>");
        }
    });
});

</script>
</html>