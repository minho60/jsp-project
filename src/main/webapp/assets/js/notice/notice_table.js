/**
 * @author 박성우
 * 12-29 수정 페이지이동시 url변경
 */

// =========================
// 1. 테이블 생성
// =========================
let tableHTML = "<table class='notice-table'>";
tableHTML += `
<thead>
  <tr>
    <th>번호</th>
    <th>제목</th>
    <th>날짜</th>
    <th>작성자</th>
    <th>조회</th>
  </tr>
</thead>
`;

noticeData.forEach(notice => {
  tableHTML += `
  <tbody>
    <tr>
      <td>${notice.id}</td>
      <td><a href="${notice.addr}">${notice.title}</a></td>
      <td>${notice.date}</td>
      <td>${notice.writer}</td>
      <td>${notice.checkNum}</td>
    </tr>
  </tbody>
  `;
});

tableHTML += "</table>";

// 화면 출력
document.getElementById("notice-area").innerHTML = tableHTML;


// =========================
// 2. 페이지네이션 기본 설정
// =========================
const rows = document.querySelectorAll('.notice-table tbody tr');
const rowsPerPage = 10;
const totalRows = rows.length;
const pageCount = Math.ceil(totalRows / rowsPerPage);

const pagination = document.querySelector('.pagination');

// 페이지 번호 생성
for (let i = 1; i <= pageCount; i++) {
  pagination.innerHTML += `<a href="#">${i}</a>`;
}

const numberBtn = pagination.querySelectorAll('a');


// =========================
// 3. URL에서 page 값 읽기
// =========================
const params = new URLSearchParams(location.search);
let page = parseInt(params.get("page")) || 1;

if (page < 1) page = 1;
if (page > pageCount) page = pageCount;


// =========================
// 4. 현재 페이지 목록 출력
// =========================
function displayRow(idx) {
  const start = idx * rowsPerPage;
  const end = start + rowsPerPage;

  rows.forEach(row => row.style.display = "none");

  [...rows].slice(start, end).forEach(row => {
    row.style.display = "";
  });
}

displayRow(page - 1);


// =========================
// 5. active 페이지 표시
// =========================
numberBtn.forEach((btn, idx) => {
  if (idx === page - 1) {
    btn.classList.add('active');
  } else {
    btn.classList.remove('active');
  }
});


// =========================
// 6. 페이지 버튼 클릭 -> URL 변경
// =========================
numberBtn.forEach((btn, idx) => {
  btn.addEventListener('click', (e) => {
    e.preventDefault();
    const nextPage = idx + 1;
    location.href = `notice_list?page=${nextPage}`;
  });
});