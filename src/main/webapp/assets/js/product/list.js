window.addEventListener('DOMContentLoaded', () => {

  // 1. HTML 구조 생성 함수
  const createMeatHTML = (item, isPork = false) => {
    const title = isPork ? `도드람한돈 ${item.title}` : item.title;
    return `
      <div class="meat">
        <a class="link" href="${item.link}">
          <img class="preview" src="${item.preview}" alt="사진">
          <div class="meat_text">
            <h3 class="title">${title}</h3>
          </div>
        </a>
        <p class="price">
          ${item.price}원
          <span class="weight"><br>(100g당 판매가 : ${item.weight}원)</span>
        </p>
      </div>
    `;
  };

  // 2. 렌더링 설정
  const renderConfigs = [
    { sel: ".new_container", list: typeof new_list !== 'undefined' ? new_list : [] },
    { sel: ".brand_container", list: typeof brand_list !== 'undefined' ? brand_list : [] },
    { sel: ".giftset_container", list: typeof giftset_list !== 'undefined' ? giftset_list : [] },
    { sel: ".simple_container", list: typeof simple_list !== 'undefined' ? simple_list : [] },
    { sel: ".best_container", list: typeof best_list !== 'undefined' ? best_list : [] },
    { sel: ".sale_container", list: typeof sale_list !== 'undefined' ? sale_list : [] },
    { sel: ".beef_container", list: typeof beef_list !== 'undefined' ? beef_list : [] },
    { sel: ".pork_container", list: typeof pork_list !== 'undefined' ? pork_list : [], isPork: true }
  ];

  // 3. 실행 (콘솔 로그 제거 버전)
  renderConfigs.forEach(({ sel, list, isPork }) => {
    const container = document.querySelector(sel);
    
    // 요소가 있고 데이터가 있을 때만 실행 (없으면 그냥 넘어감)
    if (container && list.length > 0) {
      container.innerHTML = list.map(item => createMeatHTML(item, isPork)).join('');
    }
  });
});