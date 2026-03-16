<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><!-- header -->
    <header class="woojin">
        <div id="header">
            <div class="inner">
                <!-- logo -->
                <h1 class="logo"><a href="${ctx}/"><img
                            src="${ctx}/assets/img/layout/0c3d6c35bd0388d73a8ca987211f0061_31100.svg" alt="도드람로고"></a>
                </h1>
                <!-- top link -->
                <div class="top_link">
                    <c:choose>
                        <c:when test="${not empty sessionScope.DD_MEMBER_AUTH}">
                            <span class="member-greeting">${sessionScope.DD_MEMBER_AUTH.name}님</span>
                            <a href="${ctx}/member/logout">로그아웃</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${ctx}/member/login">로그인</a>
                            <a href="${ctx}/member/register">회원가입</a>
                        </c:otherwise>
                    </c:choose>
                    <a href="${ctx}/service/service">고객센터</a>
                    <a href=""><img src="${ctx}/assets/img/layout/mu_coupon_icon.svg" alt="쿠폰"></a>
                    <a href="${ctx}/member/mypage"><img src="${ctx}/assets/img/layout/mu_mypage_icon.svg"
                            alt="마이페이지"></a>
                    <a href="${ctx}/orders/cart"><img src="${ctx}/assets/img/layout/mu_basket_icon.svg" alt="장바구니"></a>
                </div> <!-- //top_link -->
            </div> <!-- //inner -->
            <!-- navigation -->
            <nav id="gnb">
                <ul class="menu_left">
                    <li><a href="${ctx}/product/product_list_1">핫세일</a></li>
                    <li><a href="${ctx}/product/product_list_2">신제품</a></li>
                    <li><a href="${ctx}/product/product_list_3">베스트</a></li>
                </ul>
                <ul class="main">
                    <li><a href="${ctx}/product/product_list_4">신선정육</a>
                    </li>
                    <li><a href="${ctx}/product/product_list_5">간편식</a>
                    </li>
                    <li><a href="${ctx}/product/product_list_6">선물세트</a>
                    </li>
                    <li><a href="${ctx}/product/product_list_7">브랜드관</a>
                        <div class="sub-wrapper">
                            <ul class="sub">
                                <li><a href="${ctx}/about">Dodrammall</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
                <input class="search" name="message" id="" placeholder="찾으시는 제품이 있으신가요?" required>
            </nav> <!-- //#navigation -->
        </div> <!-- //#header -->
    </header> <!-- header -->