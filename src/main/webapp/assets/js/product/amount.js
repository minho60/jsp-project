document.querySelectorAll('.amount').forEach(control => {
  const itemPrice = parseInt(control.dataset.price);

  const input = control.querySelector('.number');
  const delBtn = control.querySelector('.del');
  const addBtn = control.querySelector('.add');


function updateAll() {
    const count = parseInt(input.value) || 1;
    const total = count * itemPrice; 
    const formattedPrice = itemPrice.toLocaleString() + "원";

    const originalPriceDisplay = document.querySelector('.original-price');
    const salePriceDisplay = document.querySelector('.sale-price');
    
    if (originalPriceDisplay) originalPriceDisplay.innerText = formattedPrice;
    if (salePriceDisplay) salePriceDisplay.innerText = formattedPrice;

    const infoText = document.querySelector('.info_text span');
    if (infoText) {
      infoText.innerText = `${count}`;
    }

    const totalDisplay = document.querySelector('.total');
    if (totalDisplay) {
      totalDisplay.innerText = total.toLocaleString();
    }
  };

  delBtn.addEventListener('click', () => {
    let value = parseInt(input.value);
    if (value > 1) {
      input.value = value - 1;
      updateAll();
    }
  });

  addBtn.addEventListener('click', () => {
    let value = parseInt(input.value);
    input.value = value + 1;
    updateAll();
  });

  updateAll();
});

