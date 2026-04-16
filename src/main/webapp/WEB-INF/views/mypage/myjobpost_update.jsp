<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    // 브라우저 캐시를 방지하여 '뒤로 가기' 시 서버를 다시 호출하게 함
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>돈워리 - 구인공고 수정</title>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
	<link rel="shortcut icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon">
    <link rel="icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon">
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Pretendard', sans-serif;
	background-color: #ffffff;
	line-height: 1.6;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
	overflow-x: hidden;
	color: #334155;
}

.community-container {
	max-width: 1100px;
	width: 100%;
	margin: 0 auto;
	padding: 0 20px;
	flex: 1;
}

.logout-btn {
	width: 60px;
	height: 30px;
	background-color: #ffffff;
	color: #868e96;
	border: 1px solid #dee2e6;
	border-radius: 6px;
	font-size: 13px;
	transition: all 0.2s ease;
	cursor: pointer;
}

.logout-btn:hover {
	background-color: #f8fafc;
	color: #475569;
	border-color: #cbd5e1;
}

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
	border-bottom: 1px solid #e5e7eb;
}

.logo {
	color: #4f67e8;
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
	color: #4f67e8;
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

.my-page.active {
	color: #4f67e8;
}

.now-admin, .now-business, .now-personal {
	width: 60px;
	height: 30px;
	background-color: #4f67e8;
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 6px;
	border: none;
	font-size: 13px;
	cursor: pointer;
}

.page {
	padding: 56px 0 72px;
	width: 70%;
	margin: auto;
}

.comm-header {
	text-align: center;
	margin-bottom: 34px;
}

.comm-header i {
	color: #dbe2ea;
	margin-bottom: 16px;
}

.comm-header h5 {
	font-size: 24px;
	font-weight: 700;
	color: #1e293b;
	margin-top: 8px;
}

.comm-header p {
	color: #64748b;
	font-size: 15px;
	margin-top: 10px;
}

.edit-wrap {
	display: flex;
	flex-direction: column;
	gap: 22px;
}

.edit-card {
	background-color: #ffffff;
	border: 1px solid #e5e7eb;
	border-radius: 20px;
	padding: 28px;
	box-shadow: 0 2px 10px rgba(15, 23, 42, 0.03);
}

.section-title {
	font-size: 20px;
	font-weight: 800;
	color: #1e293b;
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.section-title::before {
	content: "";
	width: 5px;
	height: 22px;
	border-radius: 999px;
	background-color: #4f67e8;
	display: inline-block;
}

.form-row {
	display: flex;
	align-items: flex-start;
	gap: 20px;
	margin-bottom: 20px;
}

.form-row:last-child {
	margin-bottom: 0;
}

.form-label {
	width: 120px;
	min-width: 120px;
	padding-top: 12px;
	font-weight: 700;
	font-size: 15px;
	color: #475569;
}

.form-label span {
	color: #4f67e8;
	margin-left: 3px;
}

.form-input-group {
	flex: 1;
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
}

input[type="text"], input[type="number"], select, textarea {
	width: 100%;
	padding: 12px 15px;
	border: 1px solid #dbe2ea;
	border-radius: 12px;
	font-size: 14px;
	outline: none;
	transition: all 0.2s ease;
	color: #334155;
	background: #fff;
}

input[type="text"]:focus, input[type="number"]:focus, select:focus,
	textarea:focus {
	border-color: #c7d2fe;
	box-shadow: 0 0 0 3px rgba(79, 103, 232, 0.08);
}

.short-input {
	width: 160px !important;
}

textarea {
	height: 150px;
	resize: none;
}

.helper-text {
	width: 100%;
	font-size: 12px;
	color: #94a3b8;
	margin-top: -2px;
}

.char-count {
	width: 100%;
	text-align: right;
	font-size: 12px;
	color: #94a3b8;
	margin-top: 4px;
}

.inline-select {
	flex: 1;
	min-width: 160px;
}

.inline-time {
	width: 170px;
}

.address-btn {
	height: 46px;
	padding: 0 18px;
	border: none;
	border-radius: 12px;
	background-color: #f1f5f9;
	color: #475569;
	font-size: 14px;
	font-weight: 700;
	cursor: pointer;
	transition: all 0.2s ease;
	white-space: nowrap;
}

.address-btn:hover {
	background-color: #e2e8f0;
}

#editor {
	width: 100%;
	background: #fff;
	border-radius: 12px;
	overflow: hidden;
	width: 544px;
}

.bottom-action-row {
	display: flex;
	justify-content: center;
	gap: 12px;
	margin-top: 10px;
	flex-wrap: wrap;
}

.line-btn {
	background-color: #ffffff;
	color: #64748b;
	border: 1px solid #dbe2ea;
	padding: 12px 22px;
	border-radius: 12px;
	font-weight: 600;
	cursor: pointer;
	font-size: 14px;
	transition: all 0.2s ease;
}

.line-btn:hover {
	background-color: #f8fafc;
	color: #475569;
	border-color: #cbd5e1;
}

.blue-btn {
	background-color: #4f67e8;
	color: #ffffff;
	border: none;
	padding: 12px 24px;
	border-radius: 12px;
	font-weight: 700;
	cursor: pointer;
	font-size: 15px;
	transition: all 0.2s ease;
	box-shadow: 0 4px 10px rgba(79, 103, 232, 0.18);
}

.blue-btn:hover {
	background-color: #4258cf;
}

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

@media ( max-width : 900px) {
	.page {
		width: 100%;
	}
	.form-row {
		flex-direction: column;
		gap: 10px;
	}
	.form-label {
		width: 100%;
		min-width: auto;
		padding-top: 0;
	}
	.inline-time, .short-input, .inline-select {
		width: 100%;
	}
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
					</span> <a href="/admin/admin_main" style="text-decoration: none;">
						<div class="now-admin">관리자</div>
					</a>
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
				<a href="/" class="logo">돈워리</a>
				<div class="nav-menu">
					<a href="/"> <i class="fa-solid fa-house fa-lg"
						style="color: rgb(203, 203, 203);"></i> 홈
					</a> <a href="/salary/calendar"> <i
						class="fa-regular fa-calendar fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 급여 캘린더
					</a> <a href="/jobposts/jobpost" class="active"> <i
						class="fa-solid fa-briefcase fa-lg"
						style="color: rgb(79, 103, 232); margin-right: 5px;"></i> 구인구직
					</a> <a href="/boards/mainboard_list?page=1"> <i
						class="fa-regular fa-message fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 커뮤니티
					</a> <a href="/qna/qna?page=1"> <i
						class="fa-solid fa-question fa-lg"
						style="color: rgb(203, 203, 203); margin-right: 5px;"></i> 고객지원
					</a>
				</div>
			</div>

			<c:if test="${nickName==null}">
				<a class="my-page" href="/members/toLogin"> <i
					class="fa-solid fa-user-gear fa-lg"
					style="color: rgb(197, 197, 197);"></i> 마이페이지
				</a>
			</c:if>
			<c:if test="${nickName!=null}">
				<a class="my-page active" href="/mypage/toMypage"> <i
					class="fa-solid fa-user-gear fa-lg"
					style="color: rgb(79, 103, 232);"></i> 마이페이지
				</a>
			</c:if>
		</nav>

		<div class="page">
			<div class="comm-header">
				<i class="fa-solid fa-file-pen fa-4x"></i>
				<h5>구인공고 수정</h5>
				<p>등록한 공고 정보를 수정하고 다시 저장할 수 있어요</p>
			</div>

			<form action="/mypage/jobpost_update?seq=+${post.seq}" method="post" id="jobUpdateForm">
				<input type="hidden" name="seq" value="${post.seq}"> <input
					type="hidden" id="sido" name="sido" value="${post.sido}"> <input
					type="hidden" id="gugun" name="gugun" value="${post.gugun}">
				<input type="hidden" id="dong" name="dong" value="${post.dong}">
				<input type="hidden" name="content" id="content">

				<div class="edit-wrap">

					<div class="edit-card">
						<div class="section-title">기본 정보</div>

						<div class="form-row">
							<div class="form-label">
								공고제목<span>*</span>
							</div>
							<div class="form-input-group">
								<input type="text" name="title" value="${post.title}" required>
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								상호명<span>*</span>
							</div>
							<div class="form-input-group">
								<input type="text" name="company_name"
									value="${post.company_name}" required>
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								연락처<span>*</span>
							</div>
							<div class="form-input-group">
								<input type="text" name="phone" value="${post.phone}" required>
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								카테고리<span>*</span>
							</div>
							<div class="form-input-group">
								<select id="mainCategory" name="main_category"
									class="inline-select" required>
									<option value="">대분류 선택</option>
									<c:forEach var="cat" items="${upperList}">
										<option value="${cat.cat_id}"
											<c:if test="${post.main_category == cat.cat_id}">selected</c:if>>
											${cat.cat_name}</option>
									</c:forEach>
								</select> <select id="subCategory" name="sub_category"
									class="inline-select" required>
									<option value="">소분류 선택</option>
								</select>
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								위치<span>*</span>
							</div>
							<div class="form-input-group">
								<input type="text" id="address" name="address"
									value="${post.address}" readonly
									style="flex: 3; background-color: #f8fafc; cursor: default;">
								<button type="button" class="address-btn"
									onclick="execDaumPostcode()">주소 찾기</button>
							</div>
						</div>

						<div class="form-row">
							<div class="form-label"></div>
							<div class="form-input-group">
								<input type="text" id="address_detail" name="address_detail"
									value="${post.address_detail}"
									placeholder="상세 주소를 입력해주세요 (건물명, 호수 등)">
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								모집 인원<span>*</span>
							</div>
							<div class="form-input-group">
								<input type="number" name="count" class="short-input"
									value="${post.count}" required> <span
									style="align-self: center;">명</span>
							</div>
						</div>
					</div>

					<div class="edit-card">
						<div class="section-title">상세 정보</div>

						<div class="form-row">
							<div class="form-label">
								급여 (시급)<span>*</span>
							</div>
							<div class="form-input-group">
								<input type="text" name="pay" class="short-input"
									value="${post.pay}" required> <span
									style="align-self: center;">원</span>
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								근무일/시간<span>*</span>
							</div>
							<div class="form-input-group">
								<select name="work_days" class="inline-select short-input">
									<option value="평일"
										<c:if test="${post.work_days == '평일'}">selected</c:if>>평일</option>
									<option value="주말"
										<c:if test="${post.work_days == '주말'}">selected</c:if>>주말</option>
									<option value="요일협의"
										<c:if test="${post.work_days == '요일협의'}">selected</c:if>>요일협의</option>
								</select>

								<c:set var="startTimeText" value="${post.work_starttime}" />
								<c:set var="endTimeText" value="${post.work_endtime}" />

								<select name="work_starttime" class="inline-time">
									<c:forEach var="h" begin="0" end="23">
										<fmt:formatNumber value="${h}" pattern="00" var="hourText" />
										<c:set var="ampm" value="${h < 12 ? '오전' : '오후'}" />
										<c:set var="displayHour" value="${h <= 12 ? h : h - 12}" />
										<c:if test="${displayHour == 0}">
											<c:set var="displayHour" value="12" />
										</c:if>

										<option value="${hourText}:00"
											<c:if test="${startTimeText eq hourText.concat(':00')}">selected</c:if>>
											${ampm} ${displayHour}:00</option>

										<option value="${hourText}:30"
											<c:if test="${startTimeText eq hourText.concat(':30')}">selected</c:if>>
											${ampm} ${displayHour}:30</option>
									</c:forEach>
								</select> 
								<span style="align-self: center;">~</span> 
								<select name="work_endtime" class="inline-time">
									<c:forEach var="h" begin="0" end="23">
										<fmt:formatNumber value="${h}" pattern="00" var="hourText" />
										<c:set var="ampm" value="${h < 12 ? '오전' : '오후'}" />
										<c:set var="displayHour" value="${h <= 12 ? h : h - 12}" />
										<c:if test="${displayHour == 0}">
											<c:set var="displayHour" value="12" />
										</c:if>

										

										<option value="${hourText}:00"
											<c:if test="${endTimeText eq hourText.concat(':00')}">selected</c:if>>
											${ampm} ${displayHour}:00</option>

										<option value="${hourText}:30"
											<c:if test="${endTimeText eq hourText.concat(':30')}">selected</c:if>>
											${ampm} ${displayHour}:30</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								근무 조건<span>*</span>
							</div>
							<div class="form-input-group">
								<div id="editor"></div>
								<div class="helper-text">업무 내용, 자격 요건, 우대사항 등을 수정해주세요.</div>
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								복리후생<span>*</span>
							</div>
							<div class="form-input-group">
								<textarea name="benefit" id="benefit"
									placeholder="제공되는 복지 혜택이나 우대사항을 입력해주세요">${post.benefit}</textarea>
								<div class="char-count">
									<span id="benefitCount">0</span> / 1000
								</div>
							</div>
						</div>
					</div>

					<div class="bottom-action-row">
						<button type="button" class="line-btn"
							onclick="location.href='/mypage/myjobpost?seq=${post.seq}'">취소</button>
						<button type="submit" class="blue-btn">수정 완료</button>
					</div>
				</div>
			</form>
		</div>
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
			var addr = '';

			if (data.userSelectedType === 'R') {
				addr = data.roadAddress;
			} else {
				addr = data.jibunAddress;
			}

			document.getElementById("address").value = addr;
			document.getElementById("sido").value = data.sido;
			document.getElementById("gugun").value = data.sigungu;

			let dongName = data.bname;
			if (data.bname1 !== '') {
				dongName = data.bname1;
			}
			document.getElementById("dong").value = dongName;
			document.getElementById("address_detail").focus();
		}
	}).open();
}

$(function() {
	const editor = new toastui.Editor({
		el: document.querySelector('#editor'),
		height: '400px',
		initialEditType: 'wysiwyg',
		previewStyle: 'vertical',
		hideModeSwitch: true,
		language: 'ko-KR',
		initialValue: `${post.content}`,
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

	function updateBenefitCount() {
		const len = $("#benefit").val().length;
		$("#benefitCount").text(len);
	}

	updateBenefitCount();
	$("#benefit").on("input", updateBenefitCount);

	$("#jobUpdateForm").on("submit", function() {

		const contentHtml = editor.getHTML();

		if (contentHtml === "<p><br></p>" || contentHtml === "") {
			alert("근무 조건을 입력해주세요.");
			return false;
		}

		$("#content").val(contentHtml);
		return true;
	});

	$("#mainCategory").on("change", function() {
		let parentId = $(this).val();
		let $subSelect = $("#subCategory");

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
				$subSelect.empty();
				$subSelect.append('<option value="">소분류 선택</option>');

				if (data.length > 0) {
					data.forEach(function(cat) {
						let selected = ("${post.sub_category}" == cat.cat_id) ? "selected" : "";
						$subSelect.append('<option value="' + cat.cat_id + '" ' + selected + '>' + cat.cat_name + '</option>');
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

	if ($("#mainCategory").val() !== "") {
		$("#mainCategory").trigger("change");
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