import { Popover } from "./components/popover.js";

document.addEventListener("DOMContentLoaded", () => {
  // 다크모드 토글 기능
  const themeToggle = document.getElementById("theme-toggle");

  function updateThemeIcon() {
    const isDark =
      document.documentElement.getAttribute("data-theme") === "dark";
    const lightIcon = document.querySelector(".theme-icon-light");
    const darkIcon = document.querySelector(".theme-icon-dark");

    if (lightIcon && darkIcon) {
      lightIcon.style.display = isDark ? "none" : "block";
      darkIcon.style.display = isDark ? "block" : "none";
    }
  }

  if (themeToggle) {
    // 초기 아이콘 상태 설정
    updateThemeIcon();

    themeToggle.addEventListener("click", () => {
      const currentTheme = document.documentElement.getAttribute("data-theme");
      const newTheme = currentTheme === "dark" ? "light" : "dark";

      document.documentElement.setAttribute("data-theme", newTheme);
      localStorage.setItem("theme", newTheme);
      updateThemeIcon();
    });
  }

  // 시스템 테마 변경 감지
  window
    .matchMedia("(prefers-color-scheme: dark)")
    .addEventListener("change", (e) => {
      if (!localStorage.getItem("theme")) {
        document.documentElement.setAttribute(
          "data-theme",
          e.matches ? "dark" : "light",
        );
        updateThemeIcon();
      }
    });

  const sidebar = document.querySelector(".sidebar");
  const sidebarOverlay = document.querySelector(".sidebar-overlay");

  if (sidebar && sidebarOverlay) {
    const mediaQuery = window.matchMedia("(max-width: 768px)");

    sidebar.querySelector(".sidebar-menu-title").insertAdjacentHTML(
      "beforeend",
      `
        <button class="btn outline sm icon-only sidebar-toggle"><i data-lucide="panel-left"></i></button>
      `,
    );
    lucide.createIcons({
      root: sidebar,
    });

    const toggleBtns = document.querySelectorAll(".sidebar-toggle");

    toggleBtns.forEach((btn) => {
      btn.addEventListener("click", () => {
        sidebar.classList.toggle("show");
      });
    });

    sidebarOverlay.addEventListener("click", () => {
      sidebar.classList.remove("show");
    });

    function handleResize(e) {
      if (e.matches) {
        sidebar.classList.remove("show");
        return;
      }
      sidebar.classList.add("show");
    }

    handleResize(mediaQuery);
    mediaQuery.addEventListener("change", handleResize);
  }

  // 사용자 메뉴 팝오버 (로그인 페이지에서는 실행되지 않음)
  const userMenuTrigger = document.querySelector(
    '[data-popover-trigger="userMenu"]',
  );

  if (userMenuTrigger) {
    const popover = new Popover("userMenu");

    popover.addOpenEvent((e) => {
      e.trigger.classList.add("active");

      const content = e.content;

      if (content.innerHTML) return;

      const logoutUrl = (window.adminBase || '/admin') + '/logout';
      content.innerHTML = `
        <a href="${logoutUrl}">
          <button class="btn ghost sm">
            <i data-lucide="log-out"></i>
            <span>로그아웃</span>
          </button>
        </a>
      `;

      lucide.createIcons({
        root: content,
      });

      const btns = content.querySelectorAll(`button`);

      for (let btn of btns) {
        btn.addEventListener("click", (ev) => {
          const btn = ev.target.closest("button");
          if (!btn) return;
          popover.close();
        });
      }
    });

    popover.addCloseEvent((e) => {
      e.trigger.classList.remove("active");
    });
  }
});
