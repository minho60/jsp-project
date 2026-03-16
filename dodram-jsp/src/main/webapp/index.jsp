<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/includes/init.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신선한 식탁을 즐기다, 도드람몰입니다.</title>
    <link rel="icon" href="${ctx}/assets/img/main/favicon.png" type="image/x-icon" />
    <link rel="stylesheet" href="${ctx}/assets/css/layout.css">
    <link rel="stylesheet" href="${ctx}/assets/css/main/minho.css">
    <link rel="stylesheet" href="${ctx}/assets/css/main/seongwoo.css">
    <link rel="stylesheet" href="${ctx}/assets/css/main/woojin.css">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/includes/header.jsp" %>
    <main>
        <div class="seongwoo">
            <section class="top-image ">
                <div class="left-banner left-slider ">
                    <ul class="content-box left-slides">
                        <li><img src="${ctx}/assets/img/main/636df30c3aef1cd9391a65bab9dec200_67572.png" alt="케이크 이미지"></li>
                        <li><img src="${ctx}/assets/img/main/636df30c3aef1cd9391a65bab9dec200_67572.png" alt="케이크 이미지"></li>
                        <li><img src="${ctx}/assets/img/main/636df30c3aef1cd9391a65bab9dec200_67572.png" alt="케이크 이미지"></li>
                        <li><img src="${ctx}/assets/img/main/636df30c3aef1cd9391a65bab9dec200_67572.png" alt="케이크 이미지"></li>
                        <li><img src="${ctx}/assets/img/main/636df30c3aef1cd9391a65bab9dec200_67572.png" alt="케이크 이미지"></li>
                    </ul>
                </div>
                <!-- 오른쪽 이미지 -->
                <div class="left-banner right-slider">
                    <ul class="content-box right-slides">
                        <li><img src="${ctx}/assets/img/main/b01c2ce25e34f80d499f0488d034b00b_90109.png" alt="올해의브랜드상"></li>
                        <li><img src="${ctx}/assets/img/main/65180321a1d6b8c518cecd83b2d5f95b_62703.jpg" alt="택배사고접수"></li>
                        <li><img src="${ctx}/assets/img/main/154940ff7b76c7f146eb5e3c00af7757_89428.png" alt="이름짓기콘테스트"></li>
                        <li><img src="${ctx}/assets/img/main/1091334089b9e1d9e591e75602b54106_10073.png" alt="선착순리뷰이벤트"></li>
                        <li><img src="${ctx}/assets/img/main/b01c2ce25e34f80d499f0488d034b00b_90109.png" alt="올해의브랜드상"></li>
                    </ul>
                </div>
            </section>
        </div>
        <!-- section#1 -->
        <section></section>
        <!-- section#2 -->
        <section></section>
        <!-- section#3 -->
        <section></section>
        <div class="minho-wrapper">
            <div class="minho sale">
             <ul>
                <li><a href="#"><img src="${ctx}/assets/img/main/69b52eb44fab41a0080073fbb084203b_85625.png"
                    data-hover="${ctx}/assets/img/main/69b52eb44fab41a0080073fbb084203b_85625.png" alt="핫세일">
                        <p>핫세일</p>
                    </a></li>
                <li><a href="#"><img src="${ctx}/assets/img/main/ab3e97850d7e355fe0a8b8d9d7390561_81715.png"
                    data-hover="${ctx}/assets/img/main/main_sub_btns_hover_img02_new.png" alt="삼겹살">
                        <p>삼겹살</p>
                    </a></li>
                <li><a href="#"><img src="${ctx}/assets/img/main/05e82c90b92ba34280e367d16fdfac7f_52900.png"
                     data-hover="${ctx}/assets/img/main/main_sub_btns_hover_img03_new.png" alt="목심">
                        <p>목심</p>
                    </a></li>
                <li><a href="#"><img src="${ctx}/assets/img/main/94ed8a31d0f4128a7f81d2a1a87f576c_29685.png" 
                     data-hover="${ctx}/assets/img/main/main_sub_btns_hover_img04_new.png" alt="갈비">
                        <p>갈비</p>
                    </a></li>
                <li><a href="#"><img src="${ctx}/assets/img/main/316445296ef3356177186c4c6b0ac27d_78682.png"
                     data-hover="${ctx}/assets/img/main/main_sub_btns_hover_img05_new.png" alt=" 등심">
                        <p>등심/안심</p>
                    </a></li>
                <li><a href="#"><img src="${ctx}/assets/img/main/99fe3347fe4e837182d5075a00d4e267_32540.png" 
                     data-hover="${ctx}/assets/img/main/main_sub_btns_hover_img06_new.png" alt="앞다리">
                        <p>앞다리/뒷다리</p>
                    </a></li>
                <li><a href="#"><img src="${ctx}/assets/img/main/670b04c1a8bbd47b349c30506a914a37_56604.png" 
                     data-hover="${ctx}/assets/img/main/main_sub_btns_hover_img07_new.png" alt="특수부위">
                        <p>특수부위/기타</p>
                    </a></li>
                <li><a href="#"><img src="${ctx}/assets/img/main/f6511638a2d21cc259b8fc4c8e9219d4_51117.png" 
                     data-hover="${ctx}/assets/img/main/main_sub_btns_hover_img08_new.png" alt="짙은">
                        <p>THE짙은</p>
                    </a></li>
             </ul>
            </div> <!-- //.sale -->
        </div>
        <div class="minho-wrapper">
            <div class="minho recommend">
            <h2 class="title"><img src="${ctx}/assets/img/main/main_title_icon_recommend.png" alt="title">추천상품</h2>
            <div class="reco-inner">
                <div class="reco-left">
                    <ul>
                        <li><img src="${ctx}/assets/img/main/recomend_tab_icon01.png" reco-data="${ctx}/assets/img/main/recomend_tab_icon_active01.png" alt="원기">
                            <p>원기회복</p>
                        </li>
                        <li><img src="${ctx}/assets/img/main/recomend_tab_icon02.png" reco-data="${ctx}/assets/img/main/recomend_tab_icon_active02.png" alt="캠핑">
                            <p>캠핑엔 역시 고기</p>
                        </li>
                        <li><img src="${ctx}/assets/img/main/recomend_tab_icon03.png" reco-data="${ctx}/assets/img/main/recomend_tab_icon_active03.png" alt="품격">
                            <p>고기의 품격, 한우로</p>
                        </li>
                        <li><img src="${ctx}/assets/img/main//recomend_tab_icon04.png" reco-data="${ctx}/assets/img/main/recomend_tab_icon_active04.png" alt="한끼">
                            <p>든든한 한끼!</p>
                        </li>
                        <li><img src="${ctx}/assets/img/main//recomend_tab_icon05.png" reco-data="${ctx}/assets/img/main/recomend_tab_icon_active05.png" alt="저녁">
                            <p>오늘저녁 뭐 먹지?</p>
                        </li>
                    </ul>
                    <div class="btn">
                        <div class="swipe-btn-pre"></div>
                        <div class="swipe-btn-next"></div>
                    </div>
                </div>
                <div class="reco-right">
                    <!-- 컴포넌트 이용해서 UI카드 4장 -->
                    <div id="recomend-card"></div>
                </div>
            </div>
        </div><!-- //.recommend -->
        </div>
        <div class="minho-wrapper">
            <div class="minho gift">
            <div class="gift-left"><img src="${ctx}/assets/img/main/b8dae3d3ac630c8978afba3e7c95366a_91537.svg" alt=""></div>
            <div class="gift-right">
                <div class="gift-top">
                    <h2 class="title"><img src="${ctx}/assets/img/main/main_title_icon_gift.png" alt="">선물세트</h2>
                    <div class="gift-wrap">
                        <ul>
                            <li>
                                <div class="gift-ico"><img src="${ctx}/assets/img/main/gift_tab_icon01.png" alt="한돈">
                                </div>
                                <p>한돈</p>
                            </li>
                            <li>
                                <div class="gift-ico"><img src="${ctx}/assets/img/main/gift_tab_icon02.png" alt="한우"></div>
                                <p>한우</p>
                            </li>
                            <li>
                                <div class="gift-ico"><img src="${ctx}/assets/img/main/gift_tab_icon03.png" alt="가공품"></div>
                                <p>가공품</p>
                            </li>
                        </ul>
                        <div class="btn">
                            <div class="swipe-btn-pre"></div>
                            <div class="swipe-btn-next"></div>
                        </div>
                    </div>
                </div>
                <div class="gift-bottom">
                    <div id="gift-card"></div>
                </div>
            </div>
        </div><!-- //.gift -->
        </div>
        <div class="minho-wrapper">
            <div class="minho news">
            <div class="news-title">
                <div>
                    <h2 class="title"><img src="${ctx}/assets/img/main/main_title_icon_recommend.png" alt="title">도드람소식</h2>
                </div>
                <div class="news-btn-wrap">
                    <a href="#"><img src="${ctx}/assets/img/main/sns_icon_instagram_link.svg" alt="인스타"></a>
                    <a href="#"><img src="${ctx}/assets/img/main/sns_icon_youtube_link.svg" alt="유튜브"></a>
                    <a href="#"><img src="${ctx}/assets/img/main/sns_icon_facebook_link.svg" alt="페이스북"></a>
                </div>
            </div>
            <div class="news-wrap">
                <div class="news-left">
                    <h3><img src="${ctx}/assets/img/main/sns_icon_youtube.svg" alt="유튜브">도드람한돈 Dodram</h3>
                            <iframe src="https://www.youtube.com/embed/bvFNU4IYHQk" frameborder="0"></iframe>
                </div>
                <div class="news-right">
                    <h3><img src="${ctx}/assets/img/main/sns_icon_youtube_shorts.svg" alt="쇼츠">도드람한돈 Dodram</h3>
                    <div class="btn">
                        <div class="swipe-btn-pre"></div>
                        <div class="swipe-btn-next"></div>
                    </div>
                    <div class="news-right-wrap">
                        <iframe src="https://www.youtube.com/embed/uDTxHc3-aO8" frameborder="0"></iframe>
                        <iframe src="https://www.youtube.com/embed/Nn-qDz_2VX0" frameborder="0"></iframe>
                        <iframe src="https://www.youtube.com/embed/T0aTIfGyFW8" frameborder="0"></iframe>
                        <iframe src="https://www.youtube.com/embed/v0kYZ3AH2RU" frameborder="0"></iframe>
                    </div>
                </div>
            </div>
        </div> <!-- //.news -->
        </div>
        <div class="woojin">
            <div class="sec3">
                <div class="qna">
                    <a href="https://dodrammall.com/service/qa.php"><img class="atoz" src="${ctx}/assets/img/main/6337f528cec8aec082b7cf72e4013d1d_18934.svg" alt=""></a>
                    <div class="sec3_right">
                        <div class="notice">
                            <p><span>공지사항</span><br>
                            도드람몰 업데이트 소식, 여기서 확인!</p>
                        </div>
                        <div class="faq">
                            <p><span>FAQ</span><br>
                            처음 방문하셨나요? 도드람몰을 200% 활용하는 꿀팁</p>
                        </div>
                    </div>
                </div>
                <img class="temper" src="${ctx}/assets/img/main/b9057f38a6d6c303c3e027ecea3f1137_14398.svg" alt="">
            </div>
        </div>
    </main>
    <script src="${ctx}/assets/js/main/card-data.js"></script>
    <script src="${ctx}/assets/js/main/sale-hover.js"></script>
    <script src="${ctx}/assets/js/main/card-gift.js"></script>
    <script src="${ctx}/assets/js/main/card-recomend.js"></script>
    <script src="${ctx}/assets/js/main/section.js"></script>
<%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
</body>

</html>