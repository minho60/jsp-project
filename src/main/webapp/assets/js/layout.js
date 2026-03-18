document.addEventListener("DOMContentLoaded", () => {
  const headerHTML = /*HTML*/ `<!-- header -->
        <header class="woojin">
            <div id="header">
                <div class="inner">
                    <!-- logo -->
                    <h1 class="logo"><a href="/index.html"><img src="/assets/img/layout/0c3d6c35bd0388d73a8ca987211f0061_31100.svg"
                                alt="도드람로고"></a></h1>
                    <!-- top link -->
                    <div class="top_link">
                        <a href="/member/login.html">로그인</a>
                        <a href="/member/register.html">회원가입</a>
                        <a href="/service/service.html">고객센터</a>
                        <a href=""><img src="/assets/img/layout/mu_coupon_icon.svg" alt="쿠폰"></a>
                        <a href="/member/mypage.html"><img src="/assets/img/layout/mu_mypage_icon.svg" alt="마이페이지"></a>
                        <a href="/orders/cart.html"><img src="/assets/img/layout/mu_basket_icon.svg" alt="장바구니"></a>
                    </div> <!-- //top_link -->
                </div> <!-- //inner -->
                <!-- navigation -->
                <nav id="gnb">
                    <ul class="menu_left">
                        <li><a href="/product/product_list_1.html">핫세일</a></li>
                        <li><a href="/product/product_list_2.html">신제품</a></li>
                        <li><a href="/product/product_list_3.html">베스트</a></li>
                    </ul>
                    <ul class="main">
                        <li><a href="/product/product_list_4.html">신선정육</a>
                            <!--<div class="sub-wrapper">
                                <ul class="sub">
                                    <li><a href="">한우</a></li>
                                    <li><a href="">한돈</a></li>
                                    <li><a href="">삼겹살</a></li>
                                    <li><a href="">목심</a></li>
                                    <li><a href="">갈비</a></li>
                                    <li><a href="">등심/안심</a></li>
                                    <li><a href="">앞다리/뒷다리</a></li>
                                    <li><a href="">특수부위/기타</a></li>
                                </ul>
                            </div>-->
                        </li>
                        <li><a href="/product/product_list_5.html">간편식</a>
                            <!--<div class="sub-wrapper">
                                <ul class="sub">
                                    <li><a href="">국/탕/찌개</a></li>
                                    <li><a href="">돈까스/튀김</a></li>
                                    <li><a href="">햄/소시지</a></li>
                                    <li><a href="">양념/볶음</a></li>
                                    <li><a href="">안주/야식</a></li>
                                </ul>
                            </div>-->
                        </li>
                        <li><a href="/product/product_list_6.html">선물세트</a>
                            <!--<div class="sub-wrapper">
                                <ul class="sub">
                                    <li><a href="">한돈</a></li>
                                    <li><a href="">한우</a></li>
                                    <li><a href="">간편식</a></li>
                                </ul>
                            </div>-->
                        </li>
                        <li><a href="/product/product_list_7.html">브랜드관</a>
                            <div class="sub-wrapper">
                                <ul class="sub">
                                    <!--<li><a href="">도드람한돈</a></li>
                                    <li><a href="">THE짙은</a></li>
                                    <li><a href="">캔돈</a></li>-->
                                    <li><a href="/about.html">Dodrammall</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <input class="search" name="message" id="" placeholder="찾으시는 제품이 있으신가요?" required>
                </nav> <!-- //#navigation -->
            </div> <!-- //#header -->
        </header> <!-- header -->
    `;

  const footerHTML = /*HTML*/ `<!-- footer -->
        <footer class="woojin">
            <div id="footer">
                <div class="inner">
                    <div class="inner_info">
                        <a href="index.html"><img src="/assets/img/layout/0c3d6c35bd0388d73a8ca987211f0061_35031.svg" alt="하단 로고"></a>
                        <div class="footer_bottom">
                            <div class="service">
                                <a href="/service/agreement.html">이용약관</a>
                                <a href="/service/qa/qa_private.html">개인정보처리방침</a>
                                <a href="/service/guide.html">쇼핑몰이용안내</a>
                                <a href="/service/service.html">고객센터</a>
                            </div> <!-- //service -->
                            <div class="info">
                                <p>주소:경기도 이천시 부발읍 경충대로 1917 도드람테마파크 상호:도드람양돈협동조합<br>조합장:박광욱 사업자등록번호: 126-82-10806 <a
                                        href="mailto:mall@dodram.co.kr">전자우편:mall@dodram.co.kr</a><br> 개인정보보호책임자:홍은숙<a
                                        herf="tel:1551-3349"> 대표번호:1551-3349</a> 팩스:031-636-0763<br>통신판매업
                                    신고번호:2018-경기이천-0257호<br><br> copyright©dodrammall.com All Right Reserved. Hosting by
                                    NHN고도(주)
                            </div> <!-- //info -->
                        </div> <!-- //footer_bottom -->
                    </div> <!-- //inner_info -->
                    <div class="inner_box">
                        <div class="call_box">
                            <div class="call_center">
                                <h2>CALL CENTER</h2>
                                <h2>1551-3349</h2>
                            </div>
                            <ul class="bank_time">
                                <li>평일 AM 09:00 ~ PM 06:00 </li>
                                <li>점심 PM 12:00 ~ PM 01:00</li>
                                <li>(휴무 토 / 일 / 공휴일)</li>
                            </ul>
                        </div>
                        <div class="bank_box">
                            <div class="bank_info">
                                <h3>BANK INFO</h3>
                                <h3>농협 351-1042-7399-13</h3>
                            </div>
                            <ul class="bank_name">
                                <li>예금주: 도드람양돈협동조합</li>
                            </ul>
                        </div>
                    </div> <!-- //inner_box -->
                </div> <!-- //inner -->
            </div> <!-- //#footer -->
        </footer> <!-- footer -->
    `;

  document.body.insertAdjacentHTML("afterbegin", headerHTML);
  document.body.insertAdjacentHTML("beforeend", footerHTML);
});

document.addEventListener("DOMContentLoaded", () => {
  const sideMenuHTML = /*HTML*/ `<!-- side-menu -->
        <div id="layout-side-menu">
            <div class="btn-toggle">
                <img src="/assets/img/main/scl_bt.gif" alt="우측 클릭 버튼">
            </div>
            <div class="menu-list">
                <a href="/service/notice/notice_list.html" class="icon-box">
                    <img src="/assets/img/main/scl_icon01.png">
                    <span>공지사항</span>
                </a>
                <a href="/service/service.html" class="icon-box">
                    <img src="/assets/img/main/scl_icon02.png">
                    <span>고객센터</span>
                </a>
                <a class="icon-box">
                    <img src="/assets/img/main/scl_icon03.png">
                    <span>배송조회</span>
                </a>
                <a class="icon-box">
                    <img src="/assets/img/main/scl_icon04.png">
                    <span>마이쇼핑</span>
                </a>
                <a href="/orders/cart.html" class="icon-box">
                    <img src="/assets/img/main/scl_icon05.png">
                    <span>장바구니</span>
                </a>
                <!-- <a class="icon-box">
                    <img src="https://dodrammall.com/data/skin/front/mo_designart/img/da_image/scl_icon_cou.png">
                    <span>상품권/쿠폰등록하기</span>
                </a> -->
            </div>
        </div>
    `;

  document.body.insertAdjacentHTML("beforeend", sideMenuHTML);

  const sideMenu = document.querySelector("#layout-side-menu");
  const btnToggle = sideMenu.querySelector(".btn-toggle");

  btnToggle.addEventListener("click", () => {
    sideMenu.classList.toggle("open");
  });
});