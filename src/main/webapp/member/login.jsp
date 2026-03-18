<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <%@ include file="/WEB-INF/includes/init.jsp" %>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>로그인 | 도드람몰</title>
            <link rel="icon" href="${ctx}/assets/img/main/favicon.png" type="image/x-icon" />
            <link rel="stylesheet" href="${ctx}/assets/css/layout.css" />
            <link rel="stylesheet" href="${ctx}/assets/css/mypage/mypage_claim.css">
            <link rel="stylesheet" href="${ctx}/assets/css/mypage/login.css">
            <link rel="stylesheet" as="style" crossorigin
                href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
            <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    </head>

    <body>
        <%@ include file="/WEB-INF/includes/header.jsp" %>

            <main>
                <div class="login-wrap">
                    <h1>로그인</h1>

                    <div class="login-box">
                        <h2>회원 로그인</h2>

                        <form class="login-form" action="${ctx}/member/login" method="post">
                            <div class="input-area">
                                <input type="text" name="id" id="loginId" placeholder="아이디" value="${savedId}" />
                                <input type="password" name="pw" id="loginPw" placeholder="비밀번호" />

                                <label class="save-id">
                                    <input type="checkbox" id="saveId" /> 아이디 저장
                                </label>
                            </div>

                            <div><button type="submit" class="btn-login">로그인</button></div>
                        </form>

                        <c:if test="${not empty loginError}">
                            <p class="login-error">${loginError}</p>
                        </c:if>

                        <div class="login-links">
                            <a href="${ctx}/member/register">회원가입</a>
                        </div>
                    </div>
                </div>
            </main>

            <script>
                // 아이디 저장 기능 (쿠키 기반)
                $(function () {
                    var savedId = getCookie("savedMemberId");
                    if (savedId) {
                        $("#loginId").val(savedId);
                        $("#saveId").prop("checked", true);
                    }
                });

                // 폼 제출 시 아이디 저장 처리
                $(".login-form").on("submit", function () {
                    if ($("#saveId").is(":checked")) {
                        setCookie("savedMemberId", $("#loginId").val(), 30);
                    } else {
                        deleteCookie("savedMemberId");
                    }
                });

                // Enter 키로 로그인
                $("#loginPw").on("keydown", function (e) {
                    if (e.key === "Enter") {
                        $(".login-form").submit();
                    }
                });

                function setCookie(name, value, days) {
                    var expires = "";
                    if (days) {
                        var date = new Date();
                        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                        expires = "; expires=" + date.toUTCString();
                    }
                    document.cookie = name + "=" + (value || "") + expires + "; path=/";
                }

                function getCookie(name) {
                    var nameEQ = name + "=";
                    var ca = document.cookie.split(';');
                    for (var i = 0; i < ca.length; i++) {
                        var c = ca[i];
                        while (c.charAt(0) === ' ') c = c.substring(1);
                        if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length);
                    }
                    return null;
                }

                function deleteCookie(name) {
                    document.cookie = name + '=; Max-Age=-99999999; path=/';
                }
            </script>

            <%@ include file="/WEB-INF/includes/footer.jsp" %>
                <%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
    </body>

    </html>