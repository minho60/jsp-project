<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>${pageTitle}</title>
            <link rel="stylesheet" href="${resPath}/admin/styles/globals.css" />
            <link rel="stylesheet" crossorigin
                href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
            <script src="https://unpkg.com/lucide@latest"></script>
            <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
            <script>
                window.ctx = "${ctx}";
                window.resPath = "${resPath}";
                window.pagePath = "${ctx}${currentPath}";
                window.adminBase = "${ctx}/admin";
            </script>
        </head>

        <body>
            <div class="sidebar-wrapper">
                <div class="sidebar show">
                    <ul class="sidebar-menu">
                        <div class="sidebar-menu-title">
                            <h4>사이트 관리</h4>
                        </div>
                        <li>
                            <a href="${ctx}/admin">
                                <button
                                    class="sidebar-menu-item btn ghost sm ${currentPath == '/admin' ? 'active' : ''}">대시보드</button>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx}/admin/users">
                                <button
                                    class="sidebar-menu-item btn ghost sm ${currentPath == '/admin/users' ? 'active' : ''}">사용자
                                    목록</button>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx}/admin/products">
                                <button
                                    class="sidebar-menu-item btn ghost sm ${currentPath == '/admin/products' ? 'active' : ''}">상품
                                    관리</button>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx}/admin/orders">
                                <button
                                    class="sidebar-menu-item btn ghost sm ${currentPath == '/admin/orders' ? 'active' : ''}">주문
                                    내역</button>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx}/admin/inquiries">
                                <button
                                    class="sidebar-menu-item btn ghost sm ${currentPath == '/admin/inquiries' ? 'active' : ''}">1대1
                                    문의</button>
                            </a>
                        </li>
                    </ul>
                    <ul class="sidebar-menu">
                        <div class="sidebar-menu-title">
                            <h4>기타</h4>
                        </div>
                        <li>
                            <a href="${ctx}/admin/404">
                                <button class="sidebar-menu-item btn ghost sm">404</button>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx}/admin/soon">
                                <button class="sidebar-menu-item btn ghost sm">준비중</button>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="sidebar-overlay"></div>
                <div class="sidebar-inset">
                    <header>
                        <div class="left">
                            <button class="btn outline sm icon-only sidebar-toggle"><i
                                    data-lucide="panel-left"></i></button>
                        </div>
                        <div class="header-right">
                            <button class="btn ghost sm icon-only" id="theme-toggle">
                                <i data-lucide="sun" class="theme-icon-light"></i>
                                <i data-lucide="moon" class="theme-icon-dark"></i>
                            </button>
                            <button class="btn outline sm icon-only" data-popover-trigger="userMenu">
                                <i data-lucide="user"></i>
                            </button>
                        </div>
                        <div class="popover" data-popover-content="userMenu"></div>
                    </header>
                    <main>
                        <c:choose>
                            <c:when test="${not empty contentPage}">
                                <jsp:include page="${contentPage}" />
                            </c:when>
                            <c:otherwise>
                                <jsp:include page="/WEB-INF/admin/pages/main.jsp" />
                            </c:otherwise>
                        </c:choose>
                    </main>
                </div>
            </div>
            <script src="https://unpkg.com/lucide@latest"></script>
            <script>try { lucide.createIcons(); } catch (e) { }</script>
            <script src="${resPath}/admin/scripts/layout.js" type="module"></script>
        </body>

        </html>