/**
 * @author 김민호
 */

{const tabs = document.querySelectorAll(".reco-left ul li");

// 각 탭에 대응하는 배열
const tabArrays = [
    carda,   // 0번 탭: 원기회복
    cardb,  // 1번 탭: 캠핑엔 역시 고기
    cardc,   // 2번 탭: 고기의 품격, 한우로
    cardd,  // 3번 탭: 든든한 한끼!
    carde    // 4번 탭: 오늘저녁 뭐 먹지?
];

// 카드 렌더링 함수
function renderCard(array) {
    const container = document.getElementById("recomend-card");
    container.innerHTML = ""; // 기존 카드 초기화

    array.forEach((data) => {
        const el = document.createElement("div");

        const spanHtml = data.span && data.span.trim() !== "" ? `<span>${data.span}</span>` : "";
        const delHtml = data.del && data.del.trim() !== "" ? `<del>${data.del}</del>` : "";

        el.innerHTML = `
            <a href="#">
                <div class="card-img">
                    <img src="${data.img}" alt="${data.title}">
                </div>

                <div class="info-box">
                    <div class="card-tit">
                        <p>${data.title}</p>
                    </div>

                    <div class="card-price">
                        ${spanHtml}
                        <strong>${data.price}</strong>
                        ${delHtml}
                    </div>

                    <div class="weight">${data.weight}</div>
                </div>
            </a>
        `;

        container.appendChild(el);
    });
}

// 초기 렌더링
renderCard(carda);

// 탭 클릭 이벤트
tabs.forEach((tab, index) => {
    tab.addEventListener("click", () => {
        renderCard(tabArrays[index]); // 클릭된 탭에 맞는 배열 렌더링

    });
});
}