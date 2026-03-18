/**
 * @author 김민호
 */

const tabs = document.querySelectorAll(".gift-wrap ul li");

// 각 탭에 대응하는 배열
const tabArrays = [
    giftcard1,   // 0번 탭: 한돈
    giftcard2,  // 1번 탭: 한우
    giftcard3   // 2번 탭: 가공품
];

// 카드 렌더링 함수
function render(array) {
    const container = document.getElementById("gift-card");
    container.innerHTML = " "; // 기존 카드 초기화

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
render(giftcard1);

// 탭 클릭 이벤트
tabs.forEach((tab, index) => {
    tab.addEventListener("click", () => {
        render(tabArrays[index]); // 클릭된 탭에 맞는 배열 렌더링

    });
});

