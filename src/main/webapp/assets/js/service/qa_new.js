/**
 * @author 김민호
 */

  const upload = document.getElementById("qa-upload");
  const addBtn = document.getElementById("add-btn");

  addBtn.addEventListener("click", () => {
    const box = document.createElement("div");
    box.className = "upload-box";
    box.innerHTML = `
      <input type="text">
      <button type="button" class="file-btn" >파일 선택</button>
      <button type="button" class="remove-btn">- 제거 </button>
    `;

    const removeBtn = box.querySelector(".remove-btn");


    // 제거 버튼
    removeBtn.addEventListener("click", () => box.remove());

    upload.append(box);
  });

