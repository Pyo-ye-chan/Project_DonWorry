<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>      
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>계정 설정</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 기본 초기화 및 폰트 설정 */
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
            flex: 1;
            /* 컨텐츠가 적을 때 푸터를 아래로 밀어주는 최소한의 장치 */
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
            /* 부드러운 변화를 위해 추가 */
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
            transition: all 0.2s ease;
            /* 부드러운 변화를 위해 추가 */
        }

        /*관리자 버튼*/
        .now-admin {
            width: 60px;
            height: 30px;
            background-color: #2563eb;
            color: white;
            display: flex;
            align-items: center;
            /*세로 중앙 정렬*/
            justify-content: center;
            /* 가로 중앙 정렬 */
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
            align-items: center;
            /*세로 중앙 정렬*/
            justify-content: center;
            /* 가로 중앙 정렬 */
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
            align-items: center;
            /*세로 중앙 정렬*/
            justify-content: center;
            /* 가로 중앙 정렬 */
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
        .my-page.active { color: #2563eb; }

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
            border-top: 1px solid #e5e7eb;
            /* 테두리를 상단에만 */
            background-color: #f9fafb;
            /* 너무 어두운 회색 대신 밝은 회색 추천 */
            padding: 40px 0;
            /* % 높이 대신 안쪽 여백으로 높이 확보 */
            margin-top: 80px;
            /* 컨텐츠와의 간격 */
            text-align: center;
            color: #999;
            font-size: 13px;
            width: 100vw;
            /* 화면 끝까지 너비 확장 */
            margin-left: calc(-50vw + 50%);
            /* 컨테이너를 벗어나 화면 꽉 채우기 */
        }


        /* =========================
   공통 페이지
========================= */
        .page-section {
            padding: 56px 0 72px;
            background: #ffffff;
        }

        .page-inner {
            max-width: 760px;
            margin: 0 auto;
        }

        .page-title {
            font-size: 24px;
            font-weight: 800;
            color: #222;
            margin-bottom: 18px;
        }

        .page-divider {
            border: none;
            border-top: 1px solid #e5e7eb;
            margin: 18px 0;
        }

        /* 카드 */
        .ui-card {
            border: 1px solid #d9dee5;
            border-radius: 14px;
            background: #fff;
            padding: 18px 18px 16px;
            margin-bottom: 14px;
        }

        .ui-card-title {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 17px;
            font-weight: 800;
            color: #222;
            margin-bottom: 12px;
        }

        /* input */
        .ui-input {
            width: 100%;
            height: 38px;
            border: 1px solid #cfd6df;
            border-radius: 8px;
            padding: 0 12px;
            font-size: 14px;
            color: #222;
            outline: none;
            background: #fff;
        }

        .ui-input:focus {
            border-color: #94a3b8;
            box-shadow: 0 0 0 3px rgba(148, 163, 184, 0.10);
        }

        .ui-btn {
            width: 100%;
            height: 38px;
            border: 1px solid #cfd6df;
            border-radius: 8px;
            background: #fff;
            color: #222;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.15s ease;
        }

        .ui-btn:hover {
            background: #f8fafc;
        }

        .ui-btn-danger {
            width: 100%;
            height: 38px;
            border: 1px solid #cfd6df;
            border-radius: 8px;
            background: #fff;
            color: #222;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.15s ease;
        }

        .ui-btn-danger:hover {
            background: #f8fafc;
        }

        /* 계정 설정 전용 */
        .account-form-group {
            margin-bottom: 12px;
        }

        .account-form-group:last-child {
            margin-bottom: 12px;
        }

        .account-form-group label {
            display: block;
            margin-bottom: 6px;
            font-size: 14px;
            color: #333;
            font-weight: 600;
        }

        .account-info-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .account-info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            font-size: 15px;
        }

        .account-info-label {
            color: #444;
            font-weight: 600;
        }

        .account-info-value {
            color: #222;
            text-align: right;
        }

        .account-withdraw-desc {
            color: #777;
            font-size: 14px;
            margin-bottom: 14px;
        }

        /* 푸터 */
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

        /* 반응형 */
        @media (max-width: 768px) {
            .nav-menu {
                gap: 18px;
                flex-wrap: wrap;
            }

            .page-title {
                font-size: 22px;
            }

            .account-info-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 4px;
            }

            .account-info-value {
                text-align: left;
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
                        <a href="/members/toLogin" style="text-decoration: none; color:black">
                            <i class="fa-regular fa-user fa-lg"
                                style="color: rgb(203, 203, 203); margin-right:5px;"></i>로그인
                        </a>
                    </span>
                    <!-- 일단 관리자 빼고 다 숨겨둠 -->
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
            <c:if test="${nickName==null }">
                <a class="my-page active" href="members/toLogin" >
                    <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(36, 99, 235);"></i>
                    마이페이지
                </a>
            </c:if>
            <c:if test="${nickName!=null }">
                <a class="my-page active" href="/mypage/toMypage" >
                     <i class="fa-solid fa-user-gear fa-lg" style="color: rgb(36, 99, 235);"></i>
                    마이페이지
                </a>
            </c:if>
        </nav>

        <div class="page-section">
            <div class="page-inner">
                <div class="page-title">계정 설정</div>
                <hr class="page-divider">

                <!-- 비밀번호 변경 -->
                <section class="ui-card">
                    <div class="ui-card-title">
                        <i class="fa-solid fa-lock"></i>
                        <span>비밀번호 변경</span>
                    </div>

                    <form id="frm" action="/mypage/changePw" method="post">
                        <div class="account-form-group">
                            <label for="currentPw">현재 비밀번호</label>
                            <input type="password" name="pw" id="currentPw" class="ui-input"
                                placeholder="현재 비밀번호를 입력하세요">
                        </div>
                        <div class="currentPwCheckBox"></div><br>

                        <div class="account-form-group">
                            <label for="newPw">새 비밀번호</label>
                            <input type="password" name="newPw" id="newPw" class="ui-input"
                                placeholder="새 비밀번호 (8자 이상)">
                        </div><br>

                        <div class="account-form-group">
                            <label for="newPwCheck">새 비밀번호 확인</label>
                            <input type="password" id="newPwCheck" class="ui-input" placeholder="새 비밀번호를 다시 입력하세요">
                        </div>
                        <div class="newPwCheckBox"></div><br>

                        <button class="ui-btn">비밀번호 변경</button>
                    </form>
                </section>

                <!-- 계정 정보 -->
                <section class="ui-card">
                    <div class="ui-card-title">
                        <span>계정 정보</span>
                    </div>

                    <div class="account-info-list">
                        <div class="account-info-row">
                            <div class="account-info-label">이메일</div>
                            <div class="account-info-value">${dto.email }</div>
                        </div>

                        <div class="account-info-row">
                            <div class="account-info-label">전화번호</div>
                            <div class="account-info-value">
                                <c:set var="hp" value="${dto.phone}" />
                                ${fn:substring(hp, 0, 3)}-${fn:substring(hp, 3, 7)}-${fn:substring(hp, 7, 11)}
                            </div>
                        </div>

                        <div class="account-info-row">
                            <div class="account-info-label">가입일</div>
                            <div class="account-info-value">
                                <fmt:formatDate value="${dto.join_date}" pattern="yyyy.MM.dd" />
                            </div>
                        </div>
                    </div>
                </section>

                <!-- 회원 탈퇴 -->
                <section class="ui-card">
                    <div class="ui-card-title">
                        <i class="fa-regular fa-trash-can"></i>
                        <span>회원 탈퇴</span>
                    </div>

                    <div class="account-withdraw-desc">
                        회원 탈퇴 시 모든 데이터가 삭제되며 복구할 수 없습니다.
                    </div>

                    <a href="/mypage/toWithdraw">
                        <button type="button" class="ui-btn-danger">회원 탈퇴하기</button>
                    </a>
                </section>
            </div>
        </div>


    </div>
    <div class="container-footer">
        <p>© 2026 돈워리. All rights reserved.</p>
        <p style="margin-top: 10px; font-size: 11px; letter-spacing: 0.5px;">개인정보처리방침 | 이용약관 | 고객센터</p>
    </div>
    <script>
        $("#currentPw").on("blur", function () {
            let pw = $(this).val();
            if (pw === "") return;

            $.ajax({
                url: "/mypage/checkPw",
                data: { pw: pw },
                success: function (isMatch) {
                    if (isMatch) {
                        $(".currentPwCheckBox").html("비밀번호가 일치합니다.");
                        $(".currentPwCheckBox").css({ "color": "#2563eb", "display": "block", "margin-top": "10px", "font-size": "14px" });
                    } else {
                        $(".currentPwCheckBox").html("비밀번호가 일치하지 않습니다.");
                        $(".currentPwCheckBox").css({ "color": "#ff0000", "display": "block", "margin-top": "10px", "font-size": "14px" });

                    }
                }
            })
        })

        $("#newPw, #newPwCheck").on("keyup", function () {
            let pw = $("#newPw").val();
            let rePw = $("#newPwCheck").val();

            if (pw == "" && rePw == "") {
                $(".newPwCheckBox").html("비밀번호는 특수문자, 숫자, 대소문자가 최소 한글자씩은 포함되어야 합니다.");
            } else if (pw == rePw) {
                $(".newPwCheckBox").html("비밀번호 일치")
                    .css({ "color": "#2563eb", "display": "block", "margin-top": "10px", "font-size": "14px" });
            } else {
                $(".newPwCheckBox").html("비밀번호 불일치")
                    .css({ "color": "#ff0000", "display": "block", "margin-top": "10px", "font-size": "14px" });
            }
        });

        $("#frm").on("submit", function () {
            if ($("#currentPw").val() == "" || $("#newpw").val() == "" || $("#newPwCheck").val() == "") {
                alert("비밀번호를 입력해주세요.");
                return false;
            }

            if ($("#newPw").val() != $("#newPwCheck").val()) {
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            }
            // 2. 비밀번호 체크
            if (!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{4,16}$/.test($("#newPw").val())) {
                alert("비밀번호는 특수문자, 숫자, 대소문자가 최소 한글자씩 포함된 4~16자여야 합니다.");
                $("#memberPw").focus();
                return false;
            }
        })
        var alertMsg = "${msg}";

        if (alertMsg && alertMsg !== "") {
            alert(alertMsg);
        }
    </script>
</body>

</html>