/**
 * @author 김민호
 */

const lis = document.querySelectorAll('.minho-wrapper .sale ul li');

lis.forEach(li => {
  const img = li.querySelector('img');
  const originalSrc = img.src;
  // hover용 이미지 경로를 data-hover 속성에서 가져오기
  const hoverSrc = img.getAttribute('data-hover');

  li.addEventListener("mouseover", () => {
     img.src = hoverSrc;
  });

  li.addEventListener("mouseout", () => {
    img.src = originalSrc;
  });
});

const reco = document.querySelectorAll('.minho-wrapper .reco-left ul li');

reco.forEach(li => {
  const img = li.querySelector('img');
  const originalSrc = img.src;
  // hover용 이미지 경로를 data-hover 속성에서 가져오기
  const hoverSrc = img.getAttribute('reco-data');

  li.addEventListener("mouseover", () => {
     img.src = hoverSrc;
  });

  li.addEventListener("mouseout", () => {
    img.src = originalSrc;
  });
});
 
