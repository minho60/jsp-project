<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/includes/init.jsp" %>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>신선한 식탁을 즐기다, 도드람몰입니다.</title>
  <link rel="icon" href="<%=request.getContextPath()%>/assets/img/main/favicon.png" type="image/x-icon" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/layout.css" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/service/qa_new.css">
  <link rel="stylesheet" as="style" crossorigin
    href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
 
</head>

<body>
<%@ include file="/WEB-INF/includes/header.jsp" %>
  <main>
    <div id="minho-qa">
      <div class="location-wrap">
        <div class="location-con"><a href="#">HOME</a>>QA</div>
      </div> <!--//. location-wrap  -->
      <div class="service-container">
        <div class="side-box">
          <div class="side-box-t">
            <h2>고객센터</h2>
            <div class="side-box-menu">
              <ul>
                <li><a href="${ctx}/service/notice/notice_list.jsp">공지사항</a></li>
                <li><a href="${ctx}/service/qa/qa.jsp" class="active">1:1문의</a></li>
                <li><a href="${ctx}/faq/list">FAQ</a></li>
              </ul>
            </div>
          </div>
          <div class="side-box-b">
            <div>
              <h3>고객상담센터</h3>
              <div class="side-info">
                <strong>1551-3349</strong>
                <a href="#">mall@dodram.co.kr</a>
                <p>운영 10:00~17:00<br>
                  점심 12:00~13:00</p>
              </div>
            </div>

            <div>
              <h3>은행계좌 안내</h3>
              <div class="side-info">
                <strong>351-1042-7399-13</strong>
                <p>농협<br>
                  [예금주: 도드람양돈협동조합]</p>
              </div>
            </div>
          </div>
        </div> <!-- //.list-box -->

        <div id="qa-main">
          <div class="qa-tit">
            <h2>1:1문의</h2>
          </div>
          <form action="<%=request.getContextPath()%>/qa/write" method="post" >
          <div class="qa-main-box">
            <div class="qa-table">
              <table>
                <tbody>
                  <tr>
                    <th>말머리</th>
                    <td>
                      <select name="type" id="type">
                        <option value="" disabled selected>문의내용 선택</option>
                        <option value="회원/정보관리">회원/정보관리</option>
                        <option value="주문/결제">주문/결제</option>
                        <option value="배송">배송</option>
                        <option value="반품/환불/교환/AS">반품/환불/교환/AS</option>
                        <option value="영수증/증빙서류">영수증/증빙서류</option>
                        <option value="상품/이벤트">상품/이벤트</option>
                        <option value="기타">기타</option>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th>작성자</th>
                    <td><input type="text" id="guest_name" name="guest_name" required minlength="2" maxlength="20"></td>
                  </tr>
                  <tr>
                    <th>비밀번호</th>
                    <td>
                      <div class="form-group">
                        <label for="password"></label>
                        <input type="password" id="guest_password" name="guest_password" required minlength="4"
                          autocomplete="new-password">
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <th>이메일</th>
                    <td>
                      <div class="table-email">
                        <input type="text" name="email_id">
                        <select name="email_domain" id="email_domain">
                          <option value="">직접입력</option>
                          <option value="naver.com">naver.com</option>
                          <option value="hanmail.net">hanmail.net</option>
                          <option value="daum.net">daum.net</option>
                          <option value="nate.com">nate.com</option>
                          <option value="hotmail.com">hotmail.com</option>
                          <option value="gmail.com">gmail.com</option>
                          <option value="icloud.com">icloud.com</option>
                        </select>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <th>제목</th>
                    <td><input type="text" name="title"></td>
                  </tr>
                  <tr>
                    <th>본문</th>
                    <td>
                      <div class="table-body">
                        <p>해당글은 비밀글로만 작성됩니다.</p><textarea name="content" ></textarea>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <th>첨부파일</th>
                    <td id="qa-upload">
                      <div class="upload-box">
                        <input type="text" class="file-input">
                        <button type="button" class="file-btn">
                          파일 선택
                        </button>
                        <button type="button" class="add-btn">
                          +추가
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <th>자동등록방지</th>
                    <td>
                      <div class="qa-cha">
                        <img src="/assets/img/service/20251224_172731.png" alt="자동방지">
                        <div class="cha-txt">
                          <p>보이는 순서대로 <br>숫자 및 문자를 모두 입력해주세요</p>
                          <input type="text">
                          <button>이미지 새로고침</button>
                        </div>
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div class="qa-box-write">
              <div>
                <h5>비회원 개인정보 수집동의</h5>
                <textarea disabled>
 - 수집항목: 이름, 전화번호, 이메일주소
 - 수집/이용목적: 게시글 접수 및 결과 회신
 - 이용기간: 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.
          단, 관계법령의 규정에 의하여 보전할 필요가 있는 경우 일정기간 동안 개인정보를 보관할 수 있습니다.
그 밖의 사항은 도드람양돈협동조합의 개인정보취급방침을 준수합니다.</textarea>
                <div class="qa-check-box"><input type="checkbox"><label for="">비회원 글작성에 대한 개인정보 수집 및 이용동의 </label><a
                    href="/service/qa/qa_private.html">전체보기></a></div>
                <div class="qa-btn">
                  <button type="button" onclick="history.back()">이전</button>
                  <button type="submit">저장</button>
                </div>
              </div>
            </div><!-- //qa-box-write -->
          </div><!-- //.qa-main-box -->
          </form>
        </div><!-- //# qa-main -->
      </div> <!--//.qa-container  -->
    </div> <!-- //#minho-qa -->
  </main>
  <script src="/assets/js/service/qa_new.js"></script>
<%@ include file="/WEB-INF/includes/footer.jsp" %>
<%@ include file="/WEB-INF/includes/sideMenu.jsp" %>  
</body>

</html>