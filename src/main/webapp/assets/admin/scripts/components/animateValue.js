/**
 * 숫자 롤링 애니메이션 컴포넌트
 *
 * 사용법 - HTML data 속성:
 *   <h2 data-animate-value="16777216" data-animate-suffix="원">0원</h2>
 *
 * 옵션 (data-animate-*):
 *   value, prefix, suffix, duration, decimal, comma
 */

const DIGITS = "0123456789";

function formatNumber(value, decimal, useComma) {
  const fixed = Math.abs(value).toFixed(decimal);
  if (!useComma) return fixed;
  const [intPart, decPart] = fixed.split(".");
  const formatted = intPart.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  return decPart !== undefined ? formatted + "." + decPart : formatted;
}

/* 스타일 주입 (1회) */
let injected = false;
function injectStyles() {
  if (injected) return;
  injected = true;
  const s = document.createElement("style");
  s.textContent = `
    .nf{display:inline-flex;align-items:center;overflow:hidden;vertical-align:baseline;
      -webkit-mask-image:linear-gradient(to bottom,transparent,#000 .15em,#000 calc(100% - .15em),transparent);
      mask-image:linear-gradient(to bottom,transparent,#000 .15em,#000 calc(100% - .15em),transparent)}
    .nf-w{display:inline-flex;overflow:visible;white-space:nowrap}
    .nf-d{display:inline-block;overflow:hidden}
    .nf-r{display:flex;flex-direction:column;align-items:center}
    .nf-n{display:flex;align-items:center;justify-content:center;height:var(--h);line-height:1}
    .nf-s{display:inline-block;line-height:1}
  `;
  document.head.appendChild(s);
}

/* 메인 함수 */
export function animateValue(el, options = {}) {
  injectStyles();

  const to = options.to ?? parseFloat(el.dataset.animateValue);
  const prefix = options.prefix ?? (el.dataset.animatePrefix || "");
  const suffix = options.suffix ?? (el.dataset.animateSuffix || "");
  const duration = options.duration ?? (parseInt(el.dataset.animateDuration) || 900);
  const decimal = options.decimal ?? (parseInt(el.dataset.animateDecimal) || 0);
  const useComma = options.comma ?? el.dataset.animateComma !== "false";

  const formatted = formatNumber(to, decimal, useComma);
  const fullText = prefix + formatted + suffix;
  const easing = "cubic-bezier(0.16, 1, 0.3, 1)";

  /* 1. 높이 측정 */
  const h = el.offsetHeight;
  el.textContent = "";
  el.className += " nf";
  el.style.height = h + "px";

  /* 2. inner wrapper (너비 애니메이션용) */
  const inner = document.createElement("span");
  inner.className = "nf-w";
  el.appendChild(inner);

  /* 3. 문자 빌드 */
  const chars = fullText.split("");
  const anims = []; // { target, keyframes, opts }

  chars.forEach((char, i) => {
    if (DIGITS.includes(char)) {
      const target = parseInt(char);

      // wrapper - 한 글자 높이로 클리핑
      const wrap = document.createElement("span");
      wrap.className = "nf-d";
      wrap.style.setProperty("--h", h + "px");
      wrap.style.height = h + "px";

      // reel - 0 ~ target 을 세로로 쌓음
      const reel = document.createElement("span");
      reel.className = "nf-r";
      for (let d = 0; d <= target; d++) {
        const n = document.createElement("span");
        n.className = "nf-n";
        n.textContent = String(d);
        reel.appendChild(n);
      }
      wrap.appendChild(reel);
      inner.appendChild(wrap);

      // 릴 스피닝(아래->위) + 페이드인
      const startY = h; // 0이 viewport 아래
      const endY = -(target * h); // target이 viewport 중앙
      const delay = i * 25;

      anims.push({
        target: reel,
        keyframes: { transform: [`translateY(${startY}px)`, `translateY(${endY}px)`] },
        opts: { duration, easing, delay, fill: "both" },
      });
      anims.push({
        target: wrap,
        keyframes: { opacity: ["0", "1"] },
        opts: { duration: duration * 0.35, easing: "ease-out", delay, fill: "both" },
      });
    } else {
      // 심볼 (콤마, 점, 접미사 등)
      const sym = document.createElement("span");
      sym.className = "nf-s";
      sym.textContent = char;
      sym.style.height = h + "px";
      sym.style.lineHeight = h + "px";
      inner.appendChild(sym);

      const delay = i * 25;
      anims.push({
        target: sym,
        keyframes: { transform: [`translateY(${h * 0.6}px)`, "translateY(0)"], opacity: ["0", "1"] },
        opts: { duration: duration * 0.5, easing, delay, fill: "both" },
      });
    }
  });

  /* 4. 너비 측정 후 너비 애니메이션 */
  const finalW = inner.offsetWidth;
  anims.push({
    target: inner,
    keyframes: { width: ["0px", finalW + "px"] },
    opts: { duration: duration * 0.7, easing, fill: "both" },
  });
  // inner 너비를 확정 (애니메이션 종료 후에도 유지)
  inner.style.width = finalW + "px";

  /* 5. 모든 애니메이션 실행 */
  anims.forEach(({ target, keyframes, opts }) => {
    target.animate(keyframes, opts);
  });
}

/* IntersectionObserver 자동 초기화 */
export function initAnimateValues(root = document) {
  const elements = root.querySelectorAll("[data-animate-value]");
  if (!elements.length) return;

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          animateValue(entry.target);
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.1 },
  );

  elements.forEach((el) => observer.observe(el));
}
