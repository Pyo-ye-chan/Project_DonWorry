<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    // 브라우저 캐시를 방지하여 '뒤로 가기' 시 서버를 다시 호출하게 함
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>돈워리 - 구인공고 등록</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<link rel="shortcut icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon">
<link rel="icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon">
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/editor/latest/i18n/ko-kr.js"></script>
<style>
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
	flex: 1; /* 컨텐츠가 적을 때 푸터를 아래로 밀어주는 최소한의 장치 */
}

.logout-btn {
	width: 60px;
	height: 30px;
	background-color: #ffffff;
	color: #868e96;
	border: 1px solid #dee2e6;
	border-radius: 6px;
	font-size: 13px;
	transition: all 0.2s ease; /* 부드러운 변화를 위해 추가 */
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
	transition: all 0.2s ease; /* 부드러운 변화를 위해 추가 */
}

/*관리자 버튼*/
.now-admin {
	width: 60px;
	height: 30px;
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
	width: 60px;
	height: 30px;
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
	width: 60px;
	height: 30px;
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
	border-top: 1px solid #e5e7eb; /* 테두리를 상단에만 */
	background-color: #f9fafb; /* 너무 어두운 회색 대신 밝은 회색 추천 */
	padding: 40px 0; /* % 높이 대신 안쪽 여백으로 높이 확보 */
	margin-top: 80px; /* 컨텐츠와의 간격 */
	text-align: center;
	color: #999;
	font-size: 13px;
	width: 100vw; /* 화면 끝까지 너비 확장 */
	margin-left: calc(-50vw + 50%); /* 컨테이너를 벗어나 화면 꽉 채우기 */
}

.write-container {
	max-width: 900px;
	margin: 0 auto;
	background: white;
	padding: 40px;
	border-radius: 20px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
}

h1 {
	font-size: 24px;
	color: #111;
	margin-bottom: 30px;
	font-weight: 700;
}

/* 섹션 구분 */
.section-title {
	font-size: 18px;
	font-weight: 700;
	padding-bottom: 10px;
	border-bottom: 2px solid #333;
	margin: 30px 0 20px;
}

.form-row {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
	gap: 20px;
}

.form-label {
	width: 120px;
	font-weight: 600;
	font-size: 15px;
	color: #444;
}

.form-label span {
	color: #2563eb;
	margin-left: 3px;
} /* 필수 표시 * */
.form-input-group {
	flex: 1;
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
}

input[type="text"], input[type="number"], select, textarea {
	padding: 12px 15px;
	border: 1px solid var(- -border-color);
	border-radius: 8px;
	font-size: 14px;
	outline: none;
	transition: border-color 0.2s;
}

input:focus, select:focus, textarea:focus {
	border-color: var(- -primary-color);
}

input[type="text"], textarea {
	width: 100%;
}

.short-input {
	width: 150px;
}

textarea {
	height: 150px;
	resize: none;
}

/* 문자 수 제한 안내 */
.char-count {
	text-align: right;
	font-size: 12px;
	color: #999;
	margin-top: 5px;
}

/* 등록 버튼 */
.submit-btn {
	width: 100%;
	padding: 18px;
	background-color: #2563eb; /* 돈워리 메인 블루 컬러 */
	color: white;
	border: none;
	border-radius: 12px; /* 둥근 모서리 유지 */
	font-size: 18px;
	font-weight: 700; /* 굵은 글씨로 강조 */
	cursor: pointer;
	margin-top: 40px;
	/* 부드러운 효과 */
	transition: all 0.2s ease-in-out;
	/* 그림자 효과로 입체감 부여 */
	box-shadow: 0 4px 6px rgba(37, 99, 235, 0.2);
}

/* 마우스 호버 시 효과 */
.submit-btn:hover {
	background-color: #1d4ed8; /* 약간 더 짙은 파란색으로 변함 */
	transform: translateY(-2px); /* 살짝 위로 떠오르는 효과 */
	box-shadow: 0 6px 12px rgba(37, 99, 235, 0.3); /* 그림자 더 짙어짐 */
}

/* 클릭 시 효과 */
.submit-btn:active {
	transform: translateY(1px); /* 눌리는 효과 */
	box-shadow: 0 2px 4px rgba(37, 99, 235, 0.2);
}

/* 에디터 가로 너비를 아래 입력창들과 맞춤 */
#editor {
	max-width: 680px; /* 아래 textarea 너비에 맞춰서 조정해봐 */
	width: 100%;
	margin-bottom: 10px;
	background-color: white;
}

/* 라벨이랑 에디터가 가로로 나란히 있게 하려면 부모 class에 적용 */
.form-row-editor {
	display: flex;
	align-items: flex-start;
	margin-bottom: 20px;
	gap: 20px;
}
</style>
</head>
<body>

	<div class="community-container">
		<c:choose>
			<c:when test="${nickName==null}">
				<div class="top-auth">
					<span style="font-size: 13px; color: #666; cursor: pointer;">
						<a href="/members/toLogin"
						style="text-decoration: none; color: black"> <i
							class="fa-regular fa-user fa-lg"
							style="color: rgb(203, 203, 203); margin-right: 5px;"></i>로그인
					</a>
					</span>
					<!-- 일단 관리자 빼고 다 숨겨둠 -->
<!-- 					<a href="/admin/admin_main" style="text-decoration: none;"><div -->
<!-- 							class="now-admin">관리자</div></a> -->
				</div>
			</c:when>
			<c:otherwise>
				<div class="top-auth">
					<span style="font-size: 13px; color: #666; cursor: pointer;">
						<i class="fa-regular fa-user fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i>
						${nickName}님 환영합니다. <a href="/members/logout"
						style="text-decoration: none; color: black">
							<button class="logout-btn" style="margin-left: 10px;">로그아웃</button>
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
				<a href="/" class="logo"> 돈워리</a>
				<div class="nav-menu">
					<a href="/"> <i class="fa-solid fa-house fa-lg"
						style="color: rgb(203, 203, 203);"></i> 홈
					</a> <a href="/salary/calendar"> <i
						class="fa-regular fa-calendar fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 급여 캘린더
					</a> 
					
					<a href="/jobposts/jobpost" class="active"> <i
						class="fa-solid fa-briefcase fa-lg"
						style="color: rgb(36, 99, 235); margin-right: 5px;"></i> 구인구직
					</a> <a href="/boards/mainboard_list"> <i
						class="fa-regular fa-message fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 커뮤니티
					</a>
					<a href="/qna/qna?page=1"> <i
						class="fa-solid fa-question fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 고객지원
					</a>
				</div>
			</div>
			<c:if test="${nickName==null }">
				<a class="my-page" href="members/toLogin"> <i
					class="fa-solid fa-user-gear fa-lg"
					style="color: rgb(197, 197, 197);"></i> 마이페이지
				</a>
			</c:if>
			<c:if test="${nickName!=null }">
				<a class="my-page" href="/mypage/toMypage"> <i
					class="fa-solid fa-user-gear fa-lg"
					style="color: rgb(197, 197, 197);"></i> 마이페이지
				</a>
			</c:if>
		</nav>


		<div class="write-container">
			<h1 style="color: #2563eb;">
				<i class="fa-solid fa-file-pen"
					style="color: var(- -primary-color);"></i> 구인공고 등록
			</h1>

			<form action="/jobposts/insert" method="post">

				<div class="section-title">기본 정보</div>

				<div class="form-row">
					<div class="form-label">
						공고제목<span>*</span>
					</div>
					<div class="form-input-group">
						<input type="text" name="title" placeholder="예: 우리 가게 인재를 찾습니다."
							required>
					</div>
				</div>

				<div class="form-row">
					<div class="form-label">
						상호명<span>*</span>
					</div>
					<div class="form-input-group">
						<input type="text" name="company_name" placeholder="예: 스타벅스 강남점"
							required>
					</div>
				</div>

				<div class="form-row">
					<div class="form-label">
						연락처<span>*</span>
					</div>
					<div class="form-input-group">
						<input type="text" name="phone" placeholder="010-XXXX-XXXX"
							required>
					</div>
				</div>

				<div class="form-input-group"
					style="display: flex; gap: 10px; margin-top: 15px; margin-bottom: 15px;">
					<div class="form-label">
						카테고리<span>*</span>
					</div>
					<select id="mainCategory" name="main_category" required
						style="flex: 1; padding: 10px; border: 1px solid #ddd; border-radius: 8px; margin-left: 10px">
						<option value="">대분류 선택</option>
						<c:forEach var="cat" items="${upperList}">
							<option value="${cat.cat_id}">${cat.cat_name}</option>
						</c:forEach>
					</select> <select id="subCategory" name="sub_category" required
						style="flex: 1; padding: 10px; border: 1px solid #ddd; border-radius: 8px;">
						<option value="">소분류 선택</option>
						
					</select>
				</div>

				<div class="form-row">
					<div class="form-label">
						위치<span>*</span>
						
					</div>
					<div class="form-input-group">
						<input type="text" id="address" name="address"
							placeholder="주소 찾기 버튼을 눌러주세요" readonly
							style="flex: 3; background-color: #f8f9fa; cursor: default;">
						<button type="button" onclick="execDaumPostcode()"
							class="btn-detail"
							style="flex: 1; height: 45px; border-radius: 8px; white-space: nowrap;">주소
							찾기</button>
					</div>
				</div>

				<div class="form-row">
					<div class="form-label"></div>
					<div class="form-input-group">
						<input type="text" id="address_detail" name="address_detail"
							placeholder="상세 주소를 입력해주세요 (건물명, 호수 등)" style="flex: 1;">
					</div>
				</div>

				<input type="hidden" id="sido" name="sido"> <input
					type="hidden" id="gugun" name="gugun"> <input type="hidden"
					id="dong" name="dong">
<!-- 					<input type="hidden" id="input-hidden" name="address"> -->

				<div class="form-row">
					<div class="form-label">
						모집 인원<span>*</span>
					</div>
					<div class="form-input-group">
						<input type="number" name="count" class="short-input"
							placeholder="0" required> <span
							style="align-self: center;">명</span>
					</div>
				</div>

				<div class="section-title">상세 정보</div>

				<div class="form-row">
					<div class="form-label">
						급여 (시급)<span>*</span>
					</div>
					<div class="form-input-group">
						<input type="text" name="pay" class="short-input"
							placeholder="10,320" required> <span
							style="align-self: center;">원</span>
					</div>
				</div>

				<div class="form-row">
					<div class="form-label">
						근무일/시간<span>*</span>
					</div>
					<div class="form-input-group" style="display: flex; gap: 10px;">
						<select name="work_days"
							style="padding: 8px; border-radius: 4px; border: 1px solid #ccc;">
							<option value="평일">평일</option>
							<option value="주말">주말</option>
							<option value="요일협의">요일협의</option>
						</select> <select name="work_starttime"
							style="padding: 8px; border-radius: 4px; border: 1px solid #ccc;">
							<c:forEach var="h" begin="0" end="23">
								<c:set var="hourStr" value="${h < 10 ? '0' : ''}${h}" />
								<c:set var="ampm" value="${h < 12 ? '오전' : '오후'}" />
								<c:set var="displayHour" value="${h <= 12 ? h : h - 12}" />
								<c:if test="${displayHour == 0}">
									<c:set var="displayHour" value="12" />
								</c:if>

								<option value="${hourStr}:00"
									<c:if test="${post.work_starttime == hourStr.concat(':00')}">selected</c:if>>
									${ampm} ${displayHour}:00</option>
								<option value="${hourStr}:30"
									<c:if test="${post.work_starttime == hourStr.concat(':30')}">selected</c:if>>
									${ampm} ${displayHour}:30</option>
							</c:forEach>
						</select> <span style="align-self: center;">~</span> <select
							name="work_endtime"
							style="padding: 8px; border-radius: 4px; border: 1px solid #ccc;">
							<c:forEach var="h" begin="0" end="23">
								<c:set var="hourStr" value="${h < 10 ? '0' : ''}${h}" />
								<c:set var="ampm" value="${h < 12 ? '오전' : '오후'}" />
								<c:set var="displayHour" value="${h <= 12 ? h : h - 12}" />
								<c:if test="${displayHour == 0}">
									<c:set var="displayHour" value="12" />
								</c:if>

								<option value="${hourStr}:00"
									<c:if test="${post.work_endtime == hourStr.concat(':00')}">selected</c:if>>
									${ampm} ${displayHour}:00</option>
								<option value="${hourStr}:30"
									<c:if test="${post.work_endtime == hourStr.concat(':30')}">selected</c:if>>
									${ampm} ${displayHour}:30</option>
							</c:forEach>
						</select>
					</div>
				</div>


				<div class="form-row" style="align-items: flex-start;">
					<div class="form-label" style="padding-top: 10px;">
						근무 조건<span>*</span>
					</div>
					<div class="form-input-group">
						<!-- 에디터 영역 -->
						<div id="editor"></div>

						<!-- hidden (에디터 값 담기) -->
						<input type="hidden" name="content" id="content">
					</div>
					
				</div>


				<div class="form-row" style="align-items: flex-start;">
					<div class="form-label" style="padding-top: 10px;">
						복리후생<span>*</span>
					</div>
					<div class="form-input-group">
						<textarea name="benefit" placeholder="제공되는 복지 혜택이나 우대사항을 입력해주세요"></textarea>
<!-- 						<div class="char-count">0 / 1000</div> -->
					</div>
				</div>

				<button type="submit" class="submit-btn">등 록</button>
				
			</form>
			</div>
			<div class="container-footer">
				<p>© 2026 돈워리. All rights reserved.</p>
				<p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침
					| 이용약관 | 고객센터</p>
			</div>
			

			<script
				src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

			<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                var addr = ''; // 주소 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("address").value = addr;
                
                // [참고] 나중에 시/도, 구/군별로 검색 기능을 만들고 싶다면 아래 값들을 활용해!
                document.getElementById("sido").value = data.sido;   // 예: 경기도
                document.getElementById("gugun").value = data.sigungu; // 예: 부천시 소사구
//                 $("#input-hidden").val(addr);
                let dongName = data.bname; 

             // 만약 '동' 뒤에 '가'가 붙는 경우 (예: 을지로1가)
             if(data.bname1 !== '') {
                 dongName = data.bname1;
             }

             // 추출한 동 이름을 input에 넣어주기
             document.getElementById("dong").value = dongName; // 예: 옥길동
                
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address_detail").focus();
            }
        }).open();
    }
    
    $(function() {
    	
    	// 1. 에디터 초기화
        const editor = new toastui.Editor({
            el: document.querySelector('#editor'),
            height: '400px',
            initialEditType: 'wysiwyg',
            previewStyle: 'vertical',
            hideModeSwitch: true,
            language: 'ko-KR',
            placeholder: '근무 조건(업무 내용, 자격 요건 등)을 상세히 입력해주세요.',
            hooks: {
                addImageBlobHook: async (blob, callback) => {
                    const formData = new FormData();
                    formData.append("image", blob);

                    const resp = await fetch("/files/upload", {
                        method: "POST",
                        body: formData
                    });

                    const data = await resp.json();
                    callback(data.url, "image");
                }
            }
        });

        // 2. 폼 전송 시 에디터 내용 가로채기
        $('form').on('submit', function() {
            // 에디터에 적힌 HTML 내용을 가져와서 hidden input(#content)에 넣음
            const contentHtml = editor.getHTML();
            
            if(contentHtml === "<p><br></p>" || contentHtml === "") {
                alert("근무 조건을 입력해주세요.");
                return false;
            }
            
            $('#content').val(contentHtml);
            
            return true; 
        });
    	
        // 대분류 선택 박스가 변경될 때 실행
        $('#mainCategory').on('change', function() {
            let parentId = $(this).val(); // 선택된 대분류의 cat_id
            let $subSelect = $('#subCategory'); // 소분류 셀렉트 박스

            // 대분류를 다시 '선택'으로 돌렸을 경우 소분류 초기화
            if (parentId == "") {
                $subSelect.html('<option value="">소분류 선택</option>');
                return;
            }

            $.ajax({
                url: "/jobposts/getSub",
                type: "get",
                data: { parentId: parentId },
                dataType: "json",
                success: function(data) {
                    // 기존 옵션 제거하고 초기값 넣기
                    $subSelect.empty();
                    $subSelect.append('<option value="">소분류 선택</option>');

                    // 받아온 데이터로 옵션 추가
                    if (data.length > 0) {
                        data.forEach(function(cat) {
                            $subSelect.append('<option value="' + cat.cat_id + '">' + cat.cat_name + '</option>');
                        });
                    } else {
                        $subSelect.append('<option value="">세부 카테고리 없음</option>');
                    }
                },
                error: function() {
                    alert("카테고리를 불러오는 데 실패했습니다.");
                }
            });
        });
        
//         const loginUser = "${nickName}";
//         if (!loginUser || loginUser === "") {
//             alert("로그인이 필요한 서비스입니다.");
//             location.replace("/members/toLogin"); // 기록을 남기지 않고 이동
//         }

//         $('textarea[name="benefit"]').on('input', function() {
//             let content = $(this).val();
//             let count = content.length;
//             const maxCount = 1000;

//             // 1. 글자 수가 제한을 넘으면 자르기
//             if (count > maxCount) {
//                 alert("최대 1000자까지 입력 가능합니다.");
//                 $(this).val(content.substring(0, maxCount)); // 1000자까지만 남김
//                 count = maxCount; // 카운트도 1000으로 고정
//             }

//             // 2. 카운트 표시 업데이트 (.char-count 클래스를 가진 div 찾기)
//             $(this).next('.char-count').text(count + " / " + maxCount);
//         });
        
    });
    

    

</script>
</body>
</html>