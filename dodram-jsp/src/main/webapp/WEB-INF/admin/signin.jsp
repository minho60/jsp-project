<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>${pageTitle}</title>
            <link rel="stylesheet" href="${resPath}/admin/styles/globals.css" />
            <link rel="stylesheet" as="style" crossorigin
                href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
            <script src="https://unpkg.com/lucide@latest"></script>
            <script>
                (function () {
                    var theme = localStorage.getItem("theme");
                    if (theme) {
                        document.documentElement.setAttribute("data-theme", theme);
                    } else if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
                        document.documentElement.setAttribute("data-theme", "dark");
                    }
                })();
            </script>
        </head>

        <body>
            <style>
                main {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100%;
                    position: relative;
                }

                .form-signin {
                    display: flex;
                    justify-content: center;
                    flex-grow: 1;
                }

                .signin-theme-toggle {
                    position: fixed;
                    top: 1rem;
                    right: 1rem;
                    z-index: 100;
                }

                .signin-theme-toggle .theme-icon-dark {
                    display: none;
                }

                [data-theme="dark"] .signin-theme-toggle .theme-icon-light {
                    display: none;
                }

                [data-theme="dark"] .signin-theme-toggle .theme-icon-dark {
                    display: block;
                }

                .login-error {
                    color: var(--color-red-500, #ef4444);
                    font-size: var(--text-sm, 0.875rem);
                    margin-top: var(--spacing-2, 0.5rem);
                }
            </style>
            <main>
                <button class="btn ghost sm icon-only signin-theme-toggle" id="theme-toggle">
                    <i data-lucide="sun" class="theme-icon-light"></i>
                    <i data-lucide="moon" class="theme-icon-dark"></i>
                </button>
                <form method="POST" action="${ctx}/admin/signin" class="form-signin">
                    <div class="card">
                        <div class="card-content">
                            <h2>관리자 로그인</h2>
                            <input name="username" id="username" type="text" placeholder="아이디" class="input" required />
                            <input name="password" id="password" type="password" placeholder="비밀번호" class="input"
                                required />
                            <c:if test="${not empty loginError}">
                                <p class="login-error">${loginError}</p>
                            </c:if>
                            <button class="btn primary md">로그인</button>
                        </div>
                    </div>
                </form>
            </main>
            <script>lucide.createIcons();</script>
            <script>
                var params = new URLSearchParams(window.location.search);
                var redirect = params.get("redirect");
                if (redirect) {
                    var form = document.querySelector(".form-signin");
                    form.action = "${ctx}/admin/signin?redirect=" + encodeURIComponent(redirect);
                }
                // 테마 토글
                document.getElementById("theme-toggle").addEventListener("click", function () {
                    var html = document.documentElement;
                    var current = html.getAttribute("data-theme");
                    var next = current === "dark" ? "light" : "dark";
                    html.setAttribute("data-theme", next);
                    localStorage.setItem("theme", next);
                });
            </script>
        </body>

        </html>