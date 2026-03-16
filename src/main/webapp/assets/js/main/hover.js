/**
 * @author 차우진
 */

document.querySelectorAll(".pork img").forEach((img) => {
  const original = img.src;
  const hover = img.dataset.hover;

  img.addEventListener("mouseover", () => (img.src = hover));
  img.addEventListener("mouseout", () => (img.src = original));
});
