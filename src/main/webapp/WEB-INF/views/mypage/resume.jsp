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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>돈워리- 구직 활동 관리</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">    
<style>
    /* [1] 원본 초기화 및 레이아웃 유지 */
    * { margin: 0; padding: 0; box-sizing: border-box; }
    
    body {
        font-family: 'Pretendard', sans-serif;
        background-color: #ffffff;
        line-height: 1.6;
        min-height: 100vh;
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
    
    /* [3] 상단바 스타일 (보내주신 원본과 100% 일치) */
    .top-auth { display: flex; justify-content: flex-end; align-items: center; gap: 15px; padding: 8px 0; }
    .navbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 0; border-bottom: 1px solid #f0f0f0; }
    .logo { color: #2563eb; font-weight: 800; font-size: 20px; text-decoration: none; }
    .nav-menu { display: flex; gap: 40px; }
    .nav-menu a { text-decoration: none; color: #666; font-size: 14px; font-weight: 500; }
    .my-page { display: flex; align-items: center; gap: 8px; text-decoration: none; color: #666; font-size: 14px; font-weight: 500; padding: 5px 10px; cursor: pointer; }
    .nav-menu a.active { color: #2563eb; }
        .my-page.active { color: #2563eb; }
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
/* [3] 이력서 폼 스타일 */
    .page { padding: 56px 0 72px; width: 70%; margin:auto; }
    .page-title { font-size: 24px; font-weight: 800; color: #222; text-align: left; margin-bottom: 18px; }
    .title-line { border: none; border-top: 1px solid #e5e7eb; margin: 18px 0 40px; }

    .resume-form-card { background-color: white; border: 1px solid #e9ecef; border-radius: 18px; padding: 40px; width: 100%; box-shadow: 0 4px 12px rgba(0,0,0,0.02); }
    
    .form-group { margin-bottom: 25px; }
    .form-label { display: block; font-size: 15px; font-weight: 700; color: #334155; margin-bottom: 10px; }
    
    /* 입력창 공통 스타일 */
    .form-input { 
        width: 100%; padding: 12px 16px; border: 1px solid #e2e8f0; border-radius: 10px; 
        font-size: 15px; color: #1e293b; transition: all 0.2s ease; outline: none;
    }
    .form-input:focus { border-color: #2563eb; box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1); }
    
    textarea.form-input { min-height: 180px; resize: none; line-height: 1.8; }
	
	/*희망 근무 요일*/
	/* 근무 요일 & 경력 선택용 라디오 그룹 스타일 */
	.radio-group {
	    display: flex;
	    gap: 10px;
	    margin-bottom: 15px;
	}
	
	.radio-group input[type="radio"] {
	    position: absolute;
    opacity: 0;
    width: 0;
    height: 0;
    pointer-events: none;
	}
	
	.radio-label {
	    flex: 1;
	    text-align: center;
	    padding: 12px;
	    border: 1px solid #e2e8f0;
	    border-radius: 10px;
	    cursor: pointer;
	    font-size: 14px;
	    background: #fff;
	    transition: all 0.2s;
	    color: #64748b;
	}
	
	.radio-group input[type="radio"]:checked + .radio-label {
	    background-color: #eff6ff;
	    border-color: #2563eb;
	    color: #2563eb;
	    font-weight: 700;
	}
	
/* [직종 선택 레이어 전용 스타일] */
.filter-btn {
    width: 100%; display: flex; justify-content: space-between; align-items: center;
    background-color: #ffffff; color: #475569; border: 1px solid #e2e8f0;
    padding: 12px 16px; border-radius: 10px; font-size: 15px; cursor: pointer;
}

#categoryLayer {
    display: none; position: absolute; top: 85px; left: 0; width: 100%;
    max-width: 500px; height: 350px; background: white; border: 1px solid #e2e8f0;
    border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); z-index: 100;
    overflow: hidden; flex-direction: column;
}

.category-lists { display: flex; flex: 1; overflow: hidden; }
#mainCatList, #subCatList { flex: 1; list-style: none; overflow-y: auto; padding: 10px 0; }
#mainCatList { background-color: #f8fafc; border-right: 1px solid #f1f5f9; }

#mainCatList li, #subCatList li {
    padding: 12px 20px; font-size: 14px; color: #475569; cursor: pointer;
}
#mainCatList li.active { background-color: #e2e8f0; color: #2563eb; font-weight: 700; }
#subCatList li:hover { background-color: #eff6ff; color: #2563eb; }

.list-header { font-weight: 800; font-size: 12px; color: #94a3b8; padding: 5px 20px !important; }

.categoryLayerFooter {
    padding: 10px; border-top: 1px solid #f1f5f9; text-align: right;
}
.categoryLayerClose { background: none; border: none; color: #64748b; cursor: pointer; font-size: 13px; }


    /* 푸터 버튼 */
    .post-footer { padding-top: 30px; display: flex; justify-content: center; gap: 15px; }
    .apply-cancel-btn { 
        background-color: #ffffff; color: #868e96; border: 1px solid #dee2e6; 
        padding: 12px 40px; border-radius: 10px; font-weight: 600; cursor: pointer; font-size: 15px; transition: all 0.2s ease;
    }
    .apply-detail-btn { 
        background-color: #2563eb; color: #ffffff; border: none; 
        padding: 12px 40px; border-radius: 10px; font-weight: 600; cursor: pointer; font-size: 15px; transition: all 0.2s ease;
    }
    .apply-detail-btn:hover { background-color: #1d4ed8; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2); }
    .apply-cancel-btn:hover { background-color: #f8f9fa; color: #495057; }
    .page-nav { display: flex; justify-content: center; align-items: center; gap: 10px; margin-top: 40px; }
    .page-num { display: flex; justify-content: center; align-items: center; width: 40px; height: 40px; border: 1px solid #dee2e6; background-color: white; color: #495057; text-decoration: none; border-radius: 10px; font-size: 14px; }
    .page-num.active { background-color: #2563eb; color: white; border-color: #2563eb; }

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
</style>
</head>
<body>

<div class="community-container">
    <c:choose>
	<c:when test="${nickName==null}">
	    <div class="top-auth">
	        <span style="font-size: 13px; color: #666; cursor: pointer;">
	            <a href="members/toLogin" style="text-decoration: none; color:black; margin-right:10px;">
	                <i class="fa-regular fa-user fa-lg" style="color: rgb(203, 203, 203); margin-right:5px;"></i>로그인
	            </a>
	        </span>
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
	            <a href="/admin/admin_main" style="text-decoration:none;"><div class="now-admin">관리자</div></a>
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
					</a> <a href="/jobposts/jobpost"> <i
						class="fa-solid fa-briefcase fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 구인구직
					</a> <a href="/boards/mainboard_list?page=1"> <i
						class="fa-regular fa-message fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 커뮤니티
					</a> <a href="/qna/qna?page=1"> <i
						class="fa-solid fa-question fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 고객지원
					</a>
				</div>
			</div>   
        <c:if test="${nickName==null }">   
			<a class="my-page active" href="/mypage/toMypage"> <i
				class="fa-solid fa-user-gear fa-lg"
				style="color: rgb(79, 103, 232);"></i> 마이페이지
			</a>
        </c:if> 
        <c:if test="${nickName!=null }">   
			<a class="my-page active" href="/mypage/toMypage"> <i
				class="fa-solid fa-user-gear fa-lg"
				style="color: rgb(36, 99, 235);"></i> 마이페이지
			</a>
        </c:if>   
    </nav>

    <div class="page">
        <div class="page-title">이력서 등록</div>
        <hr class="title-line">

        <form action="/mypage/insert_resume" method="post">
            <div class="resume-form-card">
                <div class="form-group">
                    <label class="form-label">이력서 제목</label>
                    <input type="text" name="title" class="form-input count-input" maxlength="100" 
                     placeholder="나를 표현하는 한 줄 제목을 입력하세요 (예: 성실함이 강점인 신입입니다!)" required>
                     <div class="char_count" style="font-size: 12px; color: #999; text-align: right;">
                     	0 / 100
                     </div>
                </div>

                <div class="form-group" style="position: relative;">
                    <label class="form-label">희망 업종</label>
                    <button type="button" class="filter-btn" id="btnCategory">
                        <span><i class="fa-solid fa-briefcase" style="margin-right:8px;"></i> <span id="selectedCategory">직종 선택</span></span>
                        <i class="fa-solid fa-chevron-down" style="font-size: 12px; color: #ccc;"></i>
                    </button>
                    <input type="hidden" name="preferred_job" id="preferred_job">

                    <div id="categoryLayer">
                        <div class="category-lists">
                            <ul id="mainCatList">
                            <li class="list-header">직종 대분류</li>
						    <c:forEach var="cat" items="${main_jobCateList}">
						        <li class="category-item" data-id="${cat.main_category}">
						            ${cat.main_category_name}
						        </li>
						    </c:forEach>
                            </ul>
                            <ul id="subCatList"><li class="list-header">소분류</li></ul>
                        </div>
                        <div class="categoryLayerFooter">
                            <button type="button" class="categoryLayerClose">닫기</button>
                        </div>
                    </div>
                </div>

                <div class="form-group">
				    <label class="form-label">희망 근무 조건</label>
				    <div class="radio-group">
				        <input type="radio" name="working_condition" id="day_weekday"  class="form-input" value="평일">
				        <label for="day_weekday" class="radio-label">평일</label>
				
				        <input type="radio" name="working_condition" id="day_weekend" class="form-input" value="주말">
				        <label for="day_weekend" class="radio-label">주말</label>
				
				        <input type="radio" name="working_condition" id="day_none" class="form-input" value="요일무관">
				        <label for="day_none" class="radio-label">요일무관</label>
				    </div>
				</div>

				<div class="form-group">
				    <label class="form-label">경력 여부</label>
				    <div class="radio-group">
				        <input type="radio" name="career" id="career_new" value="신입" class="rdo-career" checked>
				        <label for="career_new" class="radio-label">신입</label>
				
				        <input type="radio" name="career" id="career_old" value="경력" class="rdo-career">
				        <label for="career_old" class="radio-label">경력</label>
				    </div>

				</div>
                <div class="form-group">
                    <label class="form-label">경력 사항</label>
                    <input type="text" name="career_write" class="form-input count-input" id="career_input" disabled 
                    placeholder="예: 스타벅스 강남점 6개월 근무 (경력이 없다면 '신입' 기재)" maxlength="100">
                    <div class="char_count" style="font-size: 12px; color: #999; text-align: right;">
                     	0 / 100
                     </div>
                </div>

                <div class="form-group" style="margin-bottom: 0;">
                    <label class="form-label">간단 자기소개</label>
                    <textarea name="introduction" class="form-input count-input" maxlength="500" placeholder="자신의 강점이나 근무 태도 등을 자유롭게 작성해 주세요."></textarea>
                    <div class="char_count" style="font-size: 12px; color: #999; text-align: right;" >
                     	0 / 500
                     </div>
                </div>
            </div>

            <div class="post-footer">
                <button type="button" class="apply-cancel-btn" onclick="history.back();">취소</button>
                <button type="submit" class="apply-detail-btn">등록하기</button>
            </div>
        </form>
    </div>
</div>
<div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
<script>
    $(".tab-item").on("click", function(){
        $(".tab-item").removeClass("active");
        $(this).addClass("active");
    });

    $(document).ready(function() {
    	const loginUser = "${nickName}";
        if (!loginUser || loginUser === "") {
            alert("잘못된 접근입니다.");
            location.replace("/members/toLogin"); // 기록을 남기지 않고 이동
        }
    // [1] 직종 선택 버튼 클릭 시 레이어 열기/닫기
    $('#btnCategory').on('click', function(e) {
        e.stopPropagation(); // 부모 요소로 클릭 이벤트 전파 방지
        $('#categoryLayer').stop().slideToggle(200); // 0.2초 동안 부드럽게 열림/닫힘
        
        // 만약 대분류가 비어있다면 서버에서 데이터를 가져옴
        if($('#mainCatList').is(':empty')) {
            loadMainCategory(); 
        }
    });
  

    // 닫기 버튼 클릭 시 레이어 숨기기
    $('.categoryLayerClose').on('click', function() {
        $('#categoryLayer').slideUp(200);
    });

 // 대분류 로드 함수
    function loadMainCategory() {
        $.ajax({
            // 현재 컨트롤러가 @RequestMapping("/mypage") 이므로 앞에 /mypage를 붙입니다.
            url: "/mypage/resume", // 혹은 대분류만 따로 가져오는 별도 URL이 있다면 그곳으로 설정
            success: function(data) {
            }
        });
    }

    // 대분류 클릭 -> 소분류 로드 (핵심 수정 부분!)
    $(document).on('click', '#mainCatList li:not(.list-header)', function() {
        const pId = $(this).attr('data-id');
        $(this).addClass('active').siblings().removeClass('active');

        $.ajax({
            // [중요] 컨트롤러의 @RequestMapping("/mypage") + 메서드의 "/getSubCategories"
            url: "/mypage/getSubCategories", 
            data: { parentId: pId },
            success: function(data) {
                let html = '<li class="list-header">소분류</li>';
                data.forEach(item => {
                    // 팀원 코드는 cat_id였지만, 우리는 DTO 필드명인 sub_category를 사용합니다.
                    html += `<li class="sub-item" data-id="\${item.sub_category}">\${item.sub_category_name}</li>`;
                });
                $('#subCatList').html(html);
            }
        });
    });

    // 소분류 최종 선택 시
    $(document).on('click', '#subCatList li:not(.list-header)', function() {
    	//선택시 색 변경
    	$(this).addClass('active').siblings().removeClass('active');
    	//값 공백 빼고 저장
        const selectedText = $(this).text();
        $('#selectedCategory').text(selectedText); // 버튼 텍스트 변경
        $('#preferred_job').val(selectedText);    // hidden input에 값 저장
        //토글 닫음
        $('#categoryLayer').slideUp(200);         // 선택 후 닫기
    });

    // 레이어 외부 클릭 시 자동으로 닫기
    $(document).on('click', function(e) {
        if (!$(e.target).closest('.form-group').length) {
            $('#categoryLayer').slideUp(200);
        }
    });
});
    
    //경력 여부 조건식
    $(".rdo-career").on("change",function(){
    	if($(this).val()== "경력"){//===은 데이터 타입까지 같아야 함
    		$("#career_input").prop("disabled",false).focus();
    	}else{
    		$("#career_input").prop("disabled",true).val("");
    	}
    })
    
    // 등록 버튼을 누를 때 실행되는 함수
	$("form").on("submit", function(e) {
		// 요일 선택 체크
	    if (!$("input[name='working_condition']:checked").val()) {
	        alert("희망 근무 요일을 선택해 주세요!");
	        e.preventDefault(); // 전송 중단
	        return false;
	    }
	    // 전송 직전에 disabled를 풀어줘야 서버로 데이터가 전송
	    $("#career_input").attr("disabled", false); 
	});
    
    /*글자 수 제한*/
    function updateCount(input){
    	const maxLength = input.getAttribute('maxlength');//max값 가자ㅕ옴
    	// [핵심 고칠 부분] 입력된 값이 maxLength를 넘으면 강제로 잘라버립니다.
        if (input.value.length > maxLength) {
            input.value = input.value.substring(0, maxLength);
        }
       	const currentLength = input.value.length;
       	//현재 입력창과 가까운 c- 찾음
       	const display = input.parentElement.querySelector('.char_count');
    	if(display){
       		display.textContent=currentLength + " / " + maxLength;
       		if(currentLength >=maxLength){
       			display.style.color = 'red';
       		}else{
       			display.style.color = '#999';
       		}
       	}
    }
    const inputs = document.querySelectorAll('.count-input');//.count-input들이 담겨 있는 커다란 상자
    inputs.forEach(input => {
    	updateCount(input);
    	input.addEventListener('input',() =>{
    		updateCount(input);
    	});
    });
   	
   	
   	
    
/*    jquery 문법
$('.count-input').on('input', function() {
    const maxLength = $(this).attr('maxlength');
    const currentLength = $(this).val().length;
    const $display = $(this).parent().find('.char-count');
    
    $display.text(`${currentLength} / ${maxLength}`);
    $display.css('color', currentLength >= maxLength ? 'red' : '#999');
}); */

</script>
</body>
</html>