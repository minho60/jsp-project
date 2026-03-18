<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
<%@ include file="/WEB-INF/includes/init.jsp" %>
    <meta charset="UTF-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"
    />
    <title>Dodram 결제</title>
    <link rel="stylesheet" href="${ctx}/assets/css/orders/payment_popup.css" />
  </head>
  <body>
    <main>
      <div class="payment-container">
        <div id="payment-status">
          <div id="status-icon">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="70"
              height="70"
              viewBox="0 0 70 70"
            >
              <!-- 배경 원 -->
              <circle cx="35" cy="35" r="35" fill="currentColor" />
              <!-- 좌우로 움직이는 도트들 -->
              <circle cx="20" cy="35" r="4" fill="white">
                <animate
                  attributeName="opacity"
                  values="0;1;0"
                  dur="1s"
                  repeatCount="indefinite"
                  begin="0s"
                />
              </circle>
              <circle cx="35" cy="35" r="4" fill="white">
                <animate
                  attributeName="opacity"
                  values="0;1;0"
                  dur="1s"
                  repeatCount="indefinite"
                  begin="0.33s"
                />
              </circle>
              <circle cx="50" cy="35" r="4" fill="white">
                <animate
                  attributeName="opacity"
                  values="0;1;0"
                  dur="1s"
                  repeatCount="indefinite"
                  begin="0.66s"
                />
              </circle>
            </svg>
          </div>
          <p class="status-info">
            <b id="status-title">결제 요청 완료!</b>
            <br />
            <span class="status-content">10분 이내 미입금 시</span>
            <br />
            <span class="status-content">취소 처리됩니다.</span>
          </p>
        </div>
        <div class="payment-info">
          <p>입금 하는 분</p>
          <p>입금자명</p>
        </div>
        <div class="payment-info">
          <p>입금계좌</p>
          <div class="account">
            <p>국민은행 <span id="copy-target">123456-01-123456</span></p>
            <svg
              id="copy-btn"
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 16 16"
              fill="none"
            >
              <g clip-path="url(#clip0_97_59)">
                <path
                  d="M9 14H2V7H4V5H2C0.896875 5 0 5.89687 0 7V14C0 15.1031 0.896875 16 2 16H9C10.1031 16 11 15.1031 11 14V12H9V14ZM7 11H14C15.1031 11 16 10.1031 16 9V2C16 0.896875 15.1031 0 14 0H7C5.89687 0 5 0.896875 5 2V9C5 10.1031 5.89687 11 7 11Z"
                  fill="#171717"
                ></path>
              </g>
              <defs>
                <clipPath id="clip0_97_59">
                  <rect width="16" height="16" fill="white"></rect>
                </clipPath>
              </defs>
            </svg>
            <svg
              class="check-mark"
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 16 16"
              fill="none"
            >
              <!-- 체크 표시 모양 -->
              <path
                d="M4 8L7 11L12 5"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
            </svg>
          </div>
        </div>
        <div class="payment-info">
          <p>예금주</p>
          <p>사업자 이름</p>
        </div>
        <button class="payment-cancel-btn">결제 취소</button>
      </div>
    </main>
    <script>
      let formData = {};
      function receiveData(data) {
        formData = data;
      }

      function confirmAndClose() {
        if (window.opener && !window.opener.closed) {
          // window.opener.goNextPage();
          window.opener.location.href = (contextPath || '') + '/orders/order_success';
        }
        window.close();
      }

      const cancelTime = 1000 * 60 * 10;
      let cancelExpireAt = Date.now() + cancelTime;
      let cancelTimeoutId = setTimeout(setStatusCancelTimeout, cancelTime);

      document.addEventListener("visibilitychange", () => {
        if (!cancelTimeoutId) return;
        if (document.visibilityState != "visible") return;
        if (Date.now() < cancelExpireAt) return;
        setStatusCancelTimeout();
      });

      function stopCancelTimer() {
        clearTimeout(cancelTimeoutId);
        cancelTimeoutId = null;
      }

      const main = document.querySelector("main");
      const payStatus = document.getElementById("payment-status");
      const statusIcon = document.getElementById("status-icon");
      const statusTitle = document.getElementById("status-title");
      const statusContentList = document.querySelectorAll(".status-content");
      const paymentInfoContentList = document.querySelectorAll(
        ".payment-info p, .payment-info svg"
      );
      const copyTarget = document.getElementById("copy-target");
      const btnCopy = document.getElementById("copy-btn");
      const btnCancel = document.querySelector(".payment-cancel-btn");

      function hideAllDisappear() {
        document.querySelectorAll(".payment-disappear").forEach((e, i) => {
          if (e.classList.contains("hide")) return;
          setTimeout(() => {
            e.classList.add("hide");
          }, i * 50);
        });
      }

      function swapIcon(newHtml, afterSwapCallback) {
        statusIcon.classList.remove("icon-enter");
        statusIcon.classList.add("icon-exit");

        setTimeout(() => {
          statusIcon.innerHTML = newHtml;
          // 강제 reflow로 enter 애니메이션 트리거
          void statusIcon.offsetWidth;

          statusIcon.classList.remove("icon-exit");
          statusIcon.classList.add("icon-enter");

          if (afterSwapCallback) afterSwapCallback();
        }, 300);
      }

      function getCheckSvg() {
        return `
        <svg xmlns="http://www.w3.org/2000/svg" width="70" height="70" viewBox="0 0 70 70" fill="none">
          <rect width="70" height="70" rx="15" fill="white" />
          <circle cx="35" cy="35" r="35" fill="currentColor" />
          <path d="M22 36.5L30.5 45L48 27.5" stroke="white" stroke-width="5" stroke-linecap="round" stroke-linejoin="round" />
        </svg>
      `;
      }

      function getWarningSvg() {
        return `
        <svg xmlns="http://www.w3.org/2000/svg" width="70" height="70" viewBox="0 0 24 24" fill="none">
          <circle cx="12" cy="12" r="12" fill="currentColor" />
          <path d="M12 6.5V13" stroke="white" stroke-width="2" stroke-linecap="round" />
          <circle cx="12" cy="17" r="1.2" fill="white" />
        </svg>
      `;
      }

      function setStatusComplete() {
        stopCancelTimer();
        const status = "complete";
        payStatus.classList = status;
        swapIcon(getCheckSvg());
        btnCancel.classList.add("payment-disappear");
        statusContentList.forEach((e, i) => {
          e.classList.add("payment-disappear");
        });
        hideAllDisappear();
        paymentInfoContentList.forEach((e, i) => {
          e.classList.remove("hide");
        });
        setTimeout(() => {
          // statusIcon.innerHTML = getCheckSvg();
          statusTitle.innerText = "결제 완료!";
          statusTitle.classList = status;
          statusContentList[0].innerText = "잠시 후 주문 상세로 이동됩니다.";
          statusContentList[0].classList.remove("hide");

          setTimeout(confirmAndClose, 5000);
        }, 400);
      }

      function setStatusCancel(msg1 = "", msg2 = "") {
        stopCancelTimer();
        const status = "cancel";
        payStatus.classList = status;
        swapIcon(getWarningSvg());
        btnCancel.classList.add("payment-disappear");
        paymentInfoContentList.forEach((e, i) => {
          e.classList.add("payment-disappear");
        });
        statusContentList.forEach((e, i) => {
          e.classList.add("payment-disappear");
        });
        hideAllDisappear();
        setTimeout(() => {
          // statusIcon.innerHTML = getWarningSvg();
          statusTitle.innerText = "결제 실패";
          statusTitle.classList = status;
          statusContentList[0].innerText = msg1;
          statusContentList[1].innerText = msg2;
          statusContentList[0].classList.remove("hide");
          statusContentList[1].classList.remove("hide");
        }, 400);
      }

      function setStatusCancelTimeout() {
        setStatusCancel("10분 이내 입금이", "확인되지 않았습니다.");
      }

      function setStatusCancelUser() {
        setStatusCancel("취소되었습니다.", "");
      }

      function copyText(text) {
        const textArea = document.createElement("textarea");
        textArea.value = text;
        document.body.appendChild(textArea);
        textArea.select();
        try {
          document.execCommand("copy");
        } catch (err) {}
        document.body.removeChild(textArea);
      }

      btnCopy.addEventListener("click", () => {
        if (btnCopy.classList.contains("clicked")) return;
        btnCopy.classList.add("clicked");
        copyText(copyTarget.innerText);
        setTimeout(() => {
          btnCopy.classList.remove("clicked");
        }, 2000);
      });

      btnCancel.addEventListener("click", () => {
        setStatusCancelUser();
      });

      main.addEventListener("click", (e) => {
        if ([btnCopy, btnCancel].some((ig) => ig.contains(e.target))) return;
        setStatusComplete();
      });
    </script>
  </body>
</html>
