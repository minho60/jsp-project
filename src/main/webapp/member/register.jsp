<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!doctype html>
  <html lang="ko">

  <head>
    <%@ include file="/WEB-INF/includes/init.jsp" %>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>회원가입 | 도드람몰</title>
      <link rel="icon" href="${ctx}/assets/img/main/favicon.png" type="image/x-icon" />
      <link rel="stylesheet" href="${ctx}/assets/css/layout.css" />
      <link rel="stylesheet" href="${ctx}/assets/css/mypage/register.css" />
      <link rel="stylesheet" as="style" crossorigin
        href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
      <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>

  <body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
      <main>
        <div class="register-wrap">
          <h1>회원가입</h1>
          <!-- 단계 표시 -->
          <div class="step-indicator">
            <div
              class="step <c:choose><c:when test='${registerSuccess}'>completed</c:when><c:otherwise>active</c:otherwise></c:choose>"
              id="step1-indicator">
              <span class="step-num">1</span>
              <span class="step-text">약관동의</span>
            </div>
            <div class="step-line"></div>
            <div class="step <c:if test='${registerSuccess}'>completed</c:if>" id="step2-indicator">
              <span class="step-num">2</span>
              <span class="step-text">정보입력</span>
            </div>
            <div class="step-line"></div>
            <div class="step <c:if test='${registerSuccess}'>active</c:if>" id="step3-indicator">
              <span class="step-num">3</span>
              <span class="step-text">가입완료</span>
            </div>
          </div>
          <!-- STEP 1: 이용약관 동의 -->
          <div class="step-content" id="step1" <c:if test="${registerSuccess}">style="display: none"</c:if>>
            <div class="terms-section">
              <h3>이용약관 동의</h3>

              <div class="all-agree">
                <label>
                  <input type="checkbox" id="agreeAll" onchange="toggleAllAgree()" />
                  전체 동의합니다.
                </label>
                <p class="all-agree-desc">아래 이용약관에 모두 동의합니다.</p>
              </div>
              <div class="terms-box">
                <h4>
                  이용약관 동의 <span class="required-text">(필수)</span>
                  <a href="${ctx}/service/agreement" target="_blank" class="terms-link">자세히 보기</a>
                </h4>
                <div class="terms-content">
                  제1조 (목적)<br />
                  이 약관은 도드람양돈협동조합(전자거래 사업자)이 운영하는
                  도드람몰(이하 "몰"이라 한다)에서 제공하는 인터넷 관련
                  서비스(이하 "서비스"라 한다)를 이용함에 있어 도드람몰과 이용자의
                  권리·의무 및 책임사항을 규정함을 목적으로 합니다.<br /><br />
                  제2조 (정의)<br />
                  ① "몰"이란 도드람양돈협동조합 회사가 재화 또는 용역을 이용자에게
                  제공하기 위하여 컴퓨터등 정보통신설비를 이용하여 재화 또는
                  용역을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러
                  사이버몰을 운영하는 사업자의 의미로도 사용합니다.<br />
                  ② "이용자"란 "몰"에 접속하여 이 약관에 따라 "몰"이 제공하는
                  서비스를 받는 회원 및 비회원을 말합니다.<br />
                  ③ '회원'이라 함은 "몰"에 개인정보를 제공하여 회원등록을 한
                  자로서, "몰"의 정보를 지속적으로 제공받으며, "몰"이 제공하는
                  서비스를 계속적으로 이용할 수 있는 자를 말합니다.<br />
                  ④ '비회원'이라 함은 회원에 가입하지 않고 "몰"이 제공하는
                  서비스를 이용하는 자를 말합니다.<br /><br />
                  <a href="${ctx}/service/agreement" target="_blank" class="terms-content-link">전체 이용약관 자세히 보기 →</a>
                </div>
                <div class="terms-agree">
                  <input type="checkbox" id="agreeTerms" class="agree-check" />
                  <label for="agreeTerms">이용약관에 동의합니다.</label>
                </div>
              </div>
              <div class="terms-box">
                <h4>
                  개인정보 수집 및 이용에 대한 동의
                  <span class="required-text">(필수)</span>
                  <a href="${ctx}/service/qa/qa_private" target="_blank" class="terms-link">자세히 보기</a>
                </h4>
                <div class="terms-content">
                  도드람몰은 이용자의 개인정보를 보호하고 이와 관련한 고충을
                  신속하고 원활하게 처리할 수 있도록 다음과 같이 개인정보
                  처리방침을 수립·공개합니다.<br /><br />
                  1. 수집하는 개인정보 항목<br />
                  - 필수항목: 이름, 이메일 주소, 휴대전화 번호, 아이디,
                  비밀번호<br />
                  - 선택항목: 주소, 성별, 생년월일<br /><br />
                  2. 개인정보의 수집 및 이용 목적<br />
                  - 회원관리: 회원제 서비스 이용에 따른 본인확인, 개인 식별,
                  불량회원의 부정 이용 방지와 비인가 사용 방지<br />
                  - 서비스 제공: 주문 및 결제처리, 배송처리<br /><br />
                  3. 개인정보의 보유 및 이용기간<br />
                  - 회원 탈퇴 시까지 (단, 관계법령에 따라 보존이 필요한 경우 해당
                  기간까지 보존)<br /><br />
                  <a href="${ctx}/service/qa/qa_private" target="_blank" class="terms-content-link">전체 개인정보처리방침 자세히 보기
                    →</a>
                </div>
                <div class="terms-agree">
                  <input type="checkbox" id="agreePrivacy" class="agree-check" />
                  <label for="agreePrivacy">개인정보 수집 및 이용에 동의합니다.</label>
                </div>
              </div>
            </div>
            <div class="btn-area">
              <button type="button" class="btn-cancel" onclick="cancel()">
                취소
              </button>
              <button type="button" class="btn-submit" onclick="goToStep2()">
                다음
              </button>
            </div>
          </div>
          <!-- STEP 2: 기본정보 입력 -->
          <div class="step-content" id="step2" style="display: none">
            <c:if test="${not empty registerError}">
              <div class="register-error-box">
                <p class="register-error">${registerError}</p>
              </div>
            </c:if>
            <form id="registerForm" action="${ctx}/member/register" method="post">
              <p class="required-info"><span>*</span> 필수입력사항</p>
              <h3 class="section-title">기본정보</h3>
              <table class="register-table">
                <tr>
                  <th class="required">아이디</th>
                  <td>
                    <div class="input-with-btn">
                      <input type="text" id="userId" name="id" placeholder="영문소문자/숫자/언더바/하이픈, 4~16자" />
                      <button type="button" class="btn-check" onclick="checkDuplicate()">
                        중복확인
                      </button>
                    </div>
                    <p class="input-desc" id="idCheckMsg">
                      영문소문자/숫자/언더바(_)/하이픈(-), 4~16자, 첫 글자는 영문
                    </p>
                  </td>
                </tr>
                <tr>
                  <th class="required">비밀번호</th>
                  <td>
                    <input type="password" id="password" name="pw" placeholder="비밀번호를 입력해주세요" />
                    <p class="input-desc">
                      영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8~16자
                    </p>
                  </td>
                </tr>
                <tr>
                  <th class="required">비밀번호 확인</th>
                  <td>
                    <input type="password" id="passwordConfirm" placeholder="비밀번호를 한번 더 입력해주세요" />
                    <p class="input-desc" id="pwConfirmMsg"></p>
                  </td>
                </tr>
                <tr>
                  <th class="required">이름</th>
                  <td>
                    <input type="text" id="userName" name="name" placeholder="이름을 입력해주세요" />
                  </td>
                </tr>
                <tr>
                  <th class="required">휴대폰번호</th>
                  <td>
                    <div class="input-with-btn">
                      <input type="tel" id="phone" name="phone" placeholder="숫자만 입력해주세요" />
                      <button type="button" class="btn-check" disabled style="opacity: 0.5; cursor: default;">
                        인증번호 발송 (준비중)
                      </button>
                    </div>
                  </td>
                </tr>
                <tr>
                  <th class="required">이메일</th>
                  <td>
                    <input type="email" id="email" name="email" placeholder="예: example@dodram.co.kr" />
                  </td>
                </tr>
              </table>
              <div class="btn-area">
                <button type="button" class="btn-cancel" onclick="goToStep1()">
                  이전
                </button>
                <button type="button" class="btn-submit" onclick="submitRegister()">
                  회원가입
                </button>
              </div>
            </form>
          </div>
          <!-- STEP 3: 가입완료 -->
          <div class="step-content" id="step3" <c:if test="${!registerSuccess}">style="display: none"</c:if>>
            <div class="complete-section">
              <div class="complete-icon">✓</div>
              <h2>회원가입이 완료되었습니다!</h2>
              <p class="complete-msg">도드람몰의 회원이 되신 것을 환영합니다.</p>
              <p class="complete-id">
                아이디: <strong id="registeredId">
                  <c:out value="${registeredId}" />
                </strong>
              </p>
              <div class="btn-area">
                <button type="button" class="btn-cancel" onclick="location.href = contextPath + '/'">
                  메인으로
                </button>
                <button type="button" class="btn-submit" onclick="location.href = contextPath + '/member/login'">
                  로그인
                </button>
              </div>
            </div>
          </div>
        </div>
      </main>
      <script>
        // 아이디 중복확인 여부
        var isIdChecked = false;

        // 전체 동의
        function toggleAllAgree() {
          const isChecked = $("#agreeAll").is(":checked");
          $(".agree-check").prop("checked", isChecked);
        }

        // 개별 체크박스 변경시 전체동의 상태 업데이트
        $(document).on("change", ".agree-check", function () {
          const allChecked =
            $(".agree-check").length === $(".agree-check:checked").length;
          $("#agreeAll").prop("checked", allChecked);
        });

        // 아이디 변경 시 중복확인 초기화
        $("#userId").on("input", function () {
          isIdChecked = false;
          $("#idCheckMsg")
            .text("영문소문자/숫자/언더바(_)/하이픈(-), 4~16자, 첫 글자는 영문")
            .css("color", "");
        });

        // 비밀번호 확인 실시간 일치 검사
        $("#passwordConfirm, #password").on("input", function () {
          var pw = $("#password").val();
          var pwConfirm = $("#passwordConfirm").val();
          if (!pwConfirm) {
            $("#passwordConfirm").css("border-color", "#ccc");
            $("#pwConfirmMsg").text("");
            return;
          }
          if (pw === pwConfirm) {
            $("#passwordConfirm").css("border-color", "#2e7d32");
            $("#pwConfirmMsg").text("비밀번호가 일치합니다.").css("color", "#2e7d32");
          } else {
            $("#passwordConfirm").css("border-color", "#e83828");
            $("#pwConfirmMsg").text("비밀번호가 일치하지 않습니다.").css("color", "#e83828");
          }
        });

        // STEP 1에서 STEP 2로 이동
        function goToStep2() {
          // 필수 약관 동의 체크
          if (!$("#agreeTerms").is(":checked")) {
            alert("이용약관에 동의해주세요.");
            return;
          }

          if (!$("#agreePrivacy").is(":checked")) {
            alert("개인정보 수집 및 이용에 동의해주세요.");
            return;
          }

          // 화면 전환
          $("#step1").fadeOut(300, function () {
            $("#step2").fadeIn(300);
          });

          // 단계 표시 업데이트
          $("#step1-indicator").removeClass("active").addClass("completed");
          $("#step2-indicator").addClass("active");

          // 스크롤 맨 위로
          window.scrollTo(0, 0);
        }

        // STEP 2에서 STEP 1로 이동
        function goToStep1() {
          $("#step2").fadeOut(300, function () {
            $("#step1").fadeIn(300);
          });

          // 단계 표시 업데이트
          $("#step2-indicator").removeClass("active");
          $("#step1-indicator").removeClass("completed").addClass("active");

          window.scrollTo(0, 0);
        }

        // STEP 3 (가입완료) 화면으로 이동
        function goToStep3() {
          $("#step2").fadeOut(300, function () {
            $("#step3").fadeIn(300);
          });

          // 단계 표시 업데이트
          $("#step2-indicator").removeClass("active").addClass("completed");
          $("#step3-indicator").addClass("active");

          window.scrollTo(0, 0);
        }

        // 아이디 중복확인 (AJAX)
        function checkDuplicate() {
          const userId = $("#userId").val();
          if (!userId) {
            alert("아이디를 입력해주세요.");
            return;
          }

          // 아이디 규칙: 영문소문자/숫자/언더바/하이픈, 4~16자, 첫 글자 영문
          const userIdRegex = /^[a-z][a-z0-9_-]{3,15}$/;
          if (!userIdRegex.test(userId)) {
            alert("아이디는 영문소문자/숫자/언더바/하이픈 조합, 4~16자, 첫 글자는 영문이어야 합니다.");
            $("#userId").focus();
            return;
          }

          // 서버에서 중복확인
          $.ajax({
            url: contextPath + "/member/check-id",
            data: { id: userId },
            dataType: "json",
            success: function (res) {
              if (res.available) {
                isIdChecked = true;
                $("#idCheckMsg").text(res.message).css("color", "#2e7d32");
              } else {
                isIdChecked = false;
                $("#idCheckMsg").text(res.message).css("color", "#e83828");
              }
              alert(res.message);
            },
            error: function () {
              alert("중복확인 중 오류가 발생했습니다.");
            }
          });
        }


        // 취소
        function cancel() {
          if (confirm("회원가입을 취소하시겠습니까?")) {
            history.back();
          }
        }

        // 유효성 검사 함수들
        function validateUserId(userId) {
          const regex = /^[a-z][a-z0-9_-]{3,15}$/;
          return regex.test(userId);
        }

        function validatePassword(password) {
          if (password.length < 8 || password.length > 16) {
            return false;
          }
          let count = 0;
          if (/[a-zA-Z]/.test(password)) count++;
          if (/[0-9]/.test(password)) count++;
          if (/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)) count++;
          return count >= 2;
        }

        function validatePhone(phone) {
          const regex = /^01[016789]\d{7,8}$/;
          return regex.test(phone);
        }

        function validateEmail(email) {
          const regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
          return regex.test(email);
        }

        // 회원가입 제출 (서버 전송)
        function submitRegister() {
          const userId = $("#userId").val();
          const password = $("#password").val();
          const passwordConfirm = $("#passwordConfirm").val();
          const userName = $("#userName").val();
          const phone = $("#phone").val();
          const email = $("#email").val();

          // 아이디 검사
          if (!userId) {
            alert("아이디를 입력해주세요.");
            $("#userId").focus();
            return;
          }
          if (!validateUserId(userId)) {
            alert("아이디는 영문소문자/숫자/언더바/하이픈 조합, 4~16자, 첫 글자는 영문이어야 합니다.");
            $("#userId").focus();
            return;
          }
          if (!isIdChecked) {
            alert("아이디 중복확인을 해주세요.");
            $("#userId").focus();
            return;
          }

          // 비밀번호 검사
          if (!password) {
            alert("비밀번호를 입력해주세요.");
            $("#password").focus();
            return;
          }
          if (!validatePassword(password)) {
            alert(
              "비밀번호는 영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8~16자로 입력해주세요.",
            );
            $("#password").focus();
            return;
          }

          // 비밀번호 확인
          if (password !== passwordConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            $("#passwordConfirm").focus();
            return;
          }

          // 이름 검사
          if (!userName) {
            alert("이름을 입력해주세요.");
            $("#userName").focus();
            return;
          }
          if (userName.length < 2) {
            alert("이름은 2자 이상 입력해주세요.");
            $("#userName").focus();
            return;
          }

          // 휴대폰번호 검사
          if (!phone) {
            alert("휴대폰번호를 입력해주세요.");
            $("#phone").focus();
            return;
          }
          if (!validatePhone(phone)) {
            alert(
              "올바른 휴대폰번호 형식이 아닙니다.\n예: 01012345678 (숫자만 입력)",
            );
            $("#phone").focus();
            return;
          }

          // 이메일 검사
          if (!email) {
            alert("이메일을 입력해주세요.");
            $("#email").focus();
            return;
          }
          if (!validateEmail(email)) {
            alert("올바른 이메일 형식이 아닙니다.\n예: example@dodram.co.kr");
            $("#email").focus();
            return;
          }

          // 서버로 폼 전송
          $("#registerForm").submit();
        }

        // 서버에서 에러가 있으면 Step2를 바로 표시
        $(function () {
          <c:if test="${not empty registerError}">
            $("#step1").hide();
            $("#step2").show();
            $("#step1-indicator").removeClass("active").addClass("completed");
            $("#step2-indicator").addClass("active");
          </c:if>
        });
      </script>
      <%@ include file="/WEB-INF/includes/footer.jsp" %>
        <%@ include file="/WEB-INF/includes/sideMenu.jsp" %>
  </body>

  </html>