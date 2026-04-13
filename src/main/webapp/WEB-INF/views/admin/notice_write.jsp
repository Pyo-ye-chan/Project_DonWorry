<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>관리자 - 공지글 작성</title>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/editor/latest/i18n/ko-kr.js"></script>

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

/* ===== Panel ===== */
.panel {
    background: #fff;
    border: 1px solid #e7eef8;
    border-radius: 18px;
    padding: 22px;
    width: 800px;
    height:90%;
    padding: 40px; 
    margin-bottom: 22px;
    margin:auto;
}

.panel-head h3 {
    margin: 0;
    font-size: 18px;
    font-weight: 800;
    color: #1e293b;
}

/* 타이틀- 공지글 작성*/
.write-title {
    font-size: 22px;
    font-weight: 700;
    margin-bottom: 30px;
    text-align: center;
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
                transition: border-color 0.2s ease, background-color 0.2s ease;
            }

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
        <div class="panel">
            <div class="write-box">
                <div class="write-title">공지글 작성</div>
                <form action="/admin/notice_write" method="post" id = "frm" enctype="multipart/form-data">
			        <!-- 카테고리 -->
		    		<input type="hidden" name="category" value="notice">
	                <!-- 제목 -->
	                <div class="input-group">
	                    <input type="text" name="title" placeholder="제목을 입력하세요" id="title" maxlength="100">
	                </div>
	
	                <!-- 작성자 -->
	                <div class="input-group writer">
	                    <input type="text" readonly value="${nickName }">
	                    <input type = "hidden" value = "${loginId }" name = "member_id">      
	                </div>
	
	                <!-- 파일첨부 -->
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
	                    <button type="button" class="cancel-btn" onclick="location.href='/boards/mainboard_list?page=1'">취소</button>
	                    <button type="submit" class="submit-btn">등록</button>
	                </div>
                </form>
            </div>
        </div>
    </main>

    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top:10px; font-size:11px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
</div>
<script>
    // editor 생성 코드
    const editor = new toastui.Editor({
    	el: document.querySelector('#editor'),
    	height: '400px',
    	initialEditType: 'wysiwyg', // markdown / wysiwyg
    	previewStyle: 'vertical',
    	hideModeSwitch: true,
    	language: 'ko-KR', //에디터 메뉴 한국어 표시
    	
    		hooks: {
    	        addImageBlobHook: async (blob, callback) => {

    	            const formData = new FormData();
    	            formData.append("image", blob);

    	            const resp = await fetch("/files/upload", {
    	                method: "POST",
    	                body: formData
    	            });

    	            const data = await resp.json();

    	            //(에디터에 이미지 넣기)
    	            callback(data.url, "image");
    	        }
    	    }
	});

    $("#frm").on("submit",function(){
		$("#content").val(editor.getHTML());//editor 객체에서 글 가ㅏ져와 값 대입함
		console.log($("#content").val());
		if($("#title").val() == ""){
			alert("제목을 입력해주세요.");
			return false;
		}
		if($("#content").val()=="<p><br></p>"){//기본 태그값들
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
</script>
</body>
</html>