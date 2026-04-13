<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 브라우저 캐시를 방지하여 '뒤로 가기' 시 서버를 다시 호출하게 함
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>     
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>돈워리 - 게시물작성</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/editor/latest/i18n/ko-kr.js"></script>
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
		
		.top-auth {
			display: flex;
			justify-content: flex-end;
			align-items: center;
			gap: 15px;
			padding: 8px 0;
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
            display: flex;
            align-items: center;
            gap: 8px; /* 아이콘과 글자 사이 간격 */
            text-decoration: none;
            color: #666;
            font-size: 14px;
            font-weight: 500;
            /* 중요: 클릭 영역을 확실히 확보 */
            padding: 5px 10px; 
            cursor: pointer;

        }
        .nav-menu a.active { color: #2563eb; }
        .my-page.active { color: #2563eb; }
/*사용사 식별 표시*/
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
        
        /* 글쓰기 전체 */
.write-wrapper {
    display: flex;
    justify-content: center;
    margin-top: 50px;
}

/* 박스 */
.write-box {
    width: 800px;
    background: white;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.05);
}

/* 타이틀 */
.write-title {
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

/* 에디터 */
#editor {
    margin-top: 10px;
}

/* 버튼 */
.btn-group {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 20px;
}

.cancel-btn {
    padding: 10px 18px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 6px;
    cursor: pointer;
}

.submit-btn {
    padding: 10px 18px;
    background-color: #2563eb;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.submit-btn:hover {
    background-color: #1e4ed8;
}

.category-select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    background-color: white;
    cursor: pointer;
}

.category-select:focus {
    outline: none;
    border-color: #2563eb;
}
.writer{
	width : 40%
}
/* 파일 첨부 */
            .file-upload-wrap {
                display: flex;
                align-items: center;
                gap: 14px;
                padding: 14px 16px;
                border: 1px solid #e5e7eb;
                border-radius: 10px;
                background: #f7f9fc;
                transition: border-color 0.2s ease, box-shadow 0.2s ease, background-color 0.2s ease;
            }

            /* .file-upload-wrap:hover {
                border-color: #bfd3ff;
                background: #f4f8ff;
            } */

            .file-upload-wrap input[type="file"] {
                display: none;
            }

            .file-upload-btn {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 10px 16px;
                background: linear-gradient(135deg, #2563eb, #3b82f6);
                color: #fff;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                white-space: nowrap;
                box-shadow: 0 6px 14px rgba(37, 99, 235, 0.18);
                transition: transform 0.15s ease, box-shadow 0.15s ease, opacity 0.15s ease;
            }

            .file-upload-btn:hover {
                transform: translateY(-1px);
                box-shadow: 0 10px 18px rgba(37, 99, 235, 0.22);
            }

            .file-upload-btn:active {
                transform: translateY(0);
            }

            .file-upload-text {
                font-size: 13px;
                color: #6b7280;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                max-width: 500px;
            }

            /* 반응형 */
            @media (max-width: 768px) {
                .file-upload-wrap {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .file-upload-text {
                    max-width: 100%;
                    white-space: normal;
                    word-break: break-all;
                }
            }
</style>
<body>
<div class="container">
		<div class="top-auth">
			<span style="font-size: 13px; color: #666; cursor: pointer;">
				<i class="fa-regular fa-user fa-lg"
				style="color: rgb(203, 203, 203); margin-right: 5px;"></i>
				${nickName}님 환영합니다. <a href="/members/logout"
				style="text-decoration: none; color: black">
					<button class="logout-btn" style="margin-left: 10px;">로그아웃</button>
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
                <a href="/" >
                    <i class="fa-solid fa-house fa-lg" style="color: rgb(203, 203, 203);"></i>
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
        <a class="my-page active" href="/mypage/toMypage"> 
            <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(36, 99, 235);"></i>
            마이페이지
        </a>    
    </nav>
    
    
    <div class="write-wrapper">
    <div class="write-box">

        <div class="write-title">게시글 작성</div>

        <form action="/mypage/write" method="post" id = "frm" enctype="multipart/form-data">
        
        	
    		<!-- 카테고리 -->
			<div class="input-group">
    			<select name="category" class="category-select">
        			<option value="">카테고리 선택</option>
        			<!--  <option value="main">메인게시판</option>-->
        			<option value="free">자유게시판</option>		
        			<option value="qna">질문게시판</option>
        			<option value="review">리뷰게시판</option>
    			</select>
			</div>

            <!-- 제목 -->
            <div class="input-group">
                <input type="text" name="title" placeholder="제목을 입력하세요" id="title" maxlength="100">
            </div>

            <!-- 작성자 -->
            <div class="input-group writer">
                <input type="text" readonly value="${nickName }">
                <input type = "hidden" value = "${loginId }" name = "member_id">
                 
            </div>
            <div class="input-group">
                            <div class="file-upload-wrap">
                                <input type="file" id="boardFiles" name="files" multiple>
                                <label for="boardFiles" class="file-upload-btn">
                                    <i class="fa-solid fa-paperclip"></i>
                                    파일첨부
                                </label>
                                <span class="file-upload-text" id="fileNameText">선택된 파일 없음</span>
                            </div>
                        </div>

            <!-- 에디터 영역 -->
            <div id="editor"></div>

            <!-- hidden (에디터 값 담기) -->
            <input type="hidden" name="content" id="content">

            <!-- 버튼 영역 -->
            <div class="btn-group">
                <button type="button" class="cancel-btn" onclick="location.href='/mypage/mypost?page=1'">취소</button>
                <button type="submit" class="submit-btn">등록</button>
            </div>

        </form>

    </div>
</div>
    
    
    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
</div>
<script>
	
	
	
	const editor = new toastui.Editor({
    	el: document.querySelector('#editor'),
    	height: '400px',
    	initialEditType: 'wysiwyg', // markdown / wysiwyg
    	previewStyle: 'vertical',
    	hideModeSwitch: true,
    	language: 'ko-KR',
    	
    		hooks: {
    	        addImageBlobHook: async (blob, callback) => {

    	            const formData = new FormData();
    	            formData.append("image", blob);

    	            const resp = await fetch("/files/upload", {
    	                method: "POST",
    	                body: formData
    	            });

    	            const data = await resp.json();

    	            // ⭐ 이게 핵심 (에디터에 이미지 넣기)
    	            callback(data.url, "image");
    	        }
    	    }
	});
	$("#frm").on("submit",function(){
		$("#content").val(editor.getHTML());
		console.log($("#content").val());
		if($(".category-select").val() == ""){
			alert("카테고리를 선택해주세요.");
			return false;
		}
		if($("#title").val() == ""){
			alert("제목을 입력해주세요.");
			return false;
		}
		if($("#content").val()=="<p><br></p>"){
			alert("내용을 입력해주세요.");
			return false;
		}
	})
	$("#boardFiles").on("change", function () {
                const files = this.files;

                if (!files || files.length === 0) {
                    $("#fileNameText").text("선택된 파일 없음");
                } else if (files.length === 1) {
                    $("#fileNameText").text(files[0].name);
                } else {
                    $("#fileNameText").text(files[0].name + " 외 " + (files.length - 1) + "개");
                }
            });
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