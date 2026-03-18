<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><!-- side-menu -->
        <div id="layout-side-menu">
            <div class="btn-toggle">
                <img src="${ctx}/assets/img/main/scl_bt.gif" alt="우측 클릭 버튼">
            </div>
            <div class="menu-list">
                <a href="${ctx}/service/notice/notice_list" class="icon-box">
                    <img src="${ctx}/assets/img/main/scl_icon01.png">
                    <span>공지사항</span>
                </a>
                <a href="${ctx}/service/service" class="icon-box">
                    <img src="${ctx}/assets/img/main/scl_icon02.png">
                    <span>고객센터</span>
                </a>
                <a class="icon-box">
                    <img src="${ctx}/assets/img/main/scl_icon03.png">
                    <span>배송조회</span>
                </a>
                <a class="icon-box">
                    <img src="${ctx}/assets/img/main/scl_icon04.png">
                    <span>마이쇼핑</span>
                </a>
                <a href="${ctx}/orders/cart" class="icon-box">
                    <img src="${ctx}/assets/img/main/scl_icon05.png">
                    <span>장바구니</span>
                </a>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var sideMenu = document.querySelector("#layout-side-menu");
                var btnToggle = sideMenu.querySelector(".btn-toggle");
                btnToggle.addEventListener("click", function () {
                    sideMenu.classList.toggle("open");
                });
            });
        </script>