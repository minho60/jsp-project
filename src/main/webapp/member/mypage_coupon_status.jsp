<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="ko">

  <head>
    <%@ include file="/WEB-INF/includes/init.jsp" %>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>신선한 식탁을 즐기다, 도드람몰입니다.</title>
      <link rel="icon" href="${ctx}/assets/img/main/favicon.png" type="image/x-icon" />
      <link rel="stylesheet" href="${ctx}/assets/css/layout.css" />
      <link rel="stylesheet" href="${ctx}/assets/css/mypage/mypage_claim.css">
      <link rel="stylesheet" as="style" crossorigin
        href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
      <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>

  <body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
      <main>
        <h1 style="text-align: center">마이페이지</h1>

        <div class="main-container">
          <div class="left-title">
            <a href="${ctx}/member/index">HOME></a>
            <h3>쇼핑정보</h3>
            <a href="${ctx}/member/mypage_orderlist_diliversearch">
              <p>- 주문목록/배송조회</p>
            </a>
            <a href="${ctx}/member/mypage_claim_list">
              <p>- 취소/반품/교환내역</p>
            </a>
            <a href="${ctx}/member/mypage_refund_list">
              <p>- 환불/입금 내역</p>
            </a>
            <a href="${ctx}/member/mypage_wishlist">
              <p>- 찜리스트</p>
            </a>
            <h3>혜택관리</h3>
            <a href="${ctx}/member/mypage_coupon_list">
              <p>- 쿠폰</p>
            </a>
            <a href="${ctx}/member/mypage_deposit">
              <p>- 예치금</p>
            </a>
            <a href="${ctx}/member/mypage_mileage">
              <p>- 마일리지</p>
            </a>
            <h3>고객센터</h3>
            <a href="${ctx}/member/mypage1_1faq">
              <p>- 1:1문의</p>
            </a>
            <h3>회원정보</h3>
            <a href="${ctx}/member/mypage_change_info">
              <p>- 회원정보 변경</p>
            </a>
            <a href="${ctx}/member/delete_account">
              <p>- 회원탈퇴</p>
            </a>
            <a href="${ctx}/member/mypage_dilivery_addr">
              <p>- 배송지 관리</p>
            </a>
            <h3>나의 상품문의</h3>
            <a href="${ctx}/member/mypage_product_faq">
              <p>- 나의 상품문의</p>
            </a>
            <h3>나의 상품후기</h3>
            <a href="${ctx}/member/mypage_product_review">
              <p>- 나의 상품후기</p>
            </a>
          </div>
          <div class="right-container">
            <div class="right-top-title">
              <div class="grade">
                <img src="${ctx}/assets/img/mypage/ico_member01.gif" alt="">
                <p>홍길동님의 </p>
                <p>회원등급은 회원등급입니다.</p>
              </div>
              <!-- 팝업시작 -->
              <div class="grade-wrap">
                <button class="grade-btn" id="gradeBtn">
                  등급혜택보기 ▾
                </button>

                <div class="grade-popup" id="gradePopup">
                  <div class="popup-header">
                    <h4>등급혜택 안내</h4>
                    <button class="close" id="popupClose">✕</button>
                  </div>

                  <div class="popup-content">
                    <div class="row">
                      <p class="title">회원 등급</p>
                      <p class="desc">회원등급</p>
                    </div>
                    <div class="row">
                      <p class="title">추가 할인</p>
                      <p class="desc"><b>0원 이상 구매 시 상품 판매금액의</b><br><b> 0.0% 추가 할인</b></p>
                    </div>
                    <div class="row">
                      <p class="title">중복 할인</p>
                      <p class="desc"><b>0원 이상 구매 시 상품 판매금액의</b><br><b> 0.0% 추가 할인</b></p>
                    </div>
                    <div class="row rowl">
                      <p class="title">추가 적립</p>
                      <p class="desc">0원 이상 구매 시 구매금액당 3.0% <br><br>추가 적립</p>
                    </div>
                  </div>
                </div>
              </div>

              <!-- 팝업끝 -->
              <div class="cu">
                <p><img src="${ctx}/assets/img/mypage/icon_coupon.png" alt=""><b>쿠폰</b></p>
                <span>0</span><span>장</span>
              </div>
              <div class="mi">
                <p><img src="${ctx}/assets/img/mypage/icon_mileage.png" alt=""><b>마일리지</b></p>
                <span>0</span><span>원</span>
              </div>
              <div class="bl">
                <p><img src="${ctx}/assets/img/mypage/icon_balance.png" alt=""><b>예치금</b></p>
                <span>0</span><span>원</span>
              </div>
            </div><!-- right-top-title -->
            <div class="order-search">
              <h3 class="title">쿠폰</h3>

              <div class="search-box">
                <span class="label">조회기간</span>

                <div class="btn-group">
                  <button>오늘</button>
                  <button class="active">7일</button>
                  <button>15일</button>
                  <button>1개월</button>
                  <button>3개월</button>
                  <button>1년</button>
                </div>

                <input type="date" value="2025-12-22">
                <span class="tilde">~</span>
                <input type="date" value="2025-12-29">

                <button class="search-btn">
                  조회 <i class="fa-solid fa-magnifying-glass"></i>
                </button>
              </div><!-- //search-box -->
            </div><!--// order-search -->
            <!-- 탭버튼시작 -->
            <nav class="claim-tabs">
              <a href="${ctx}/member/mypage_coupon_list" class="tab ">
                사용 가능
              </a>
              <a href="${ctx}/member/mypage_coupon_status" class="tab active">
                사용 불가
              </a>
            </nav>
            <!-- 탭버튼끝 -->
            <p class="date-range-text" id="dateRangeText"></p>
            <!-- <div class="middle-title" >
                        <h3>쿠폰내역 </h3>
                        
                    </div> -->
            <table class="middle-content">
              <tr>
                <th>쿠폰명</th>
                <th>혜택</th>
                <th>사용조건</th>
                <th>제한조건</th>
                <th>유효기간</th>
                <th>발급일</th>
              </tr>

              <tr>
                <td colspan="6">조회내역이 없습니다</td>
              </tr>

            </table>

          </div>
        </div><!-- main-container -->
      </main>
      <script>
        const gradeBtn = document.getElementById("gradeBtn");
        const gradePopup = document.getElementById("gradePopup");
        const popupClose = document.getElementById("popupClose");

        // 화살표(버튼) 클릭 -> 열기/닫기
        gradeBtn.addEventListener("click", () => {
          gradePopup.classList.toggle("active");
        });

        // X 클릭 -> 닫기
        popupClose.addEventListener("click", () => {
          gradePopup.classList.remove("active");
        });
        //주문조회시작
        // =========================
        // 1. 요소 선택
        // =========================
        const periodButtons = document.querySelectorAll(".btn-group button");
        const startDateInput = document.querySelectorAll('input[type="date"]')[0];
        const endDateInput = document.querySelectorAll('input[type="date"]')[1];

        // 오늘 날짜
        const today = new Date();

        // yyyy-mm-dd 형태로 변환 함수
        function formatDate(date) {
          const year = date.getFullYear();
          const month = String(date.getMonth() + 1).padStart(2, "0");
          const day = String(date.getDate()).padStart(2, "0");
          return `${year}-${month}-${day}`;
        }

        // =========================
        // 2. 버튼 클릭 이벤트
        // =========================
        periodButtons.forEach(btn => {
          btn.addEventListener("click", () => {

            // ① active 처리
            periodButtons.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");

            // ② 날짜 계산
            const text = btn.innerText;
            const startDate = new Date(today);

            if (text === "오늘") {
              // 그대로
            } else if (text === "7일") {
              startDate.setDate(today.getDate() - 7);
            } else if (text === "15일") {
              startDate.setDate(today.getDate() - 15);
            } else if (text === "1개월") {
              startDate.setMonth(today.getMonth() - 1);
            } else if (text === "3개월") {
              startDate.setMonth(today.getMonth() - 3);
            } else if (text === "1년") {
              startDate.setFullYear(today.getFullYear() - 1);
            }

            // input에 반영
            startDateInput.value = formatDate(startDate);
            endDateInput.value = formatDate(today);
            updatePeriodTextByButton(text);
          });
        });
        //주문조회 끝
        // 초기 표시 (페이지 로드시)
        // 7일 전 날짜 계산
        const defaultStartDate = new Date(today);
        defaultStartDate.setDate(today.getDate() - 7);

        // input 값 설정
        startDateInput.value = formatDate(defaultStartDate);
        endDateInput.value = formatDate(today);

        dateRangeText.innerText =
          `${startDateInput.value} ~ ${endDateInput.value} 까지의 쿠폰내역`;
      </script>
      <%@ include file="/WEB-INF/includes/footer.jsp" %>
        <%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
  </body>

  </html>