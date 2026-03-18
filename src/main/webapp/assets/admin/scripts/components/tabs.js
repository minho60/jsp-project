/**
 * Tabs 컴포넌트
 *
 * 사용법 1: 클릭 이벤트용
 * ```js
 * const tabs = new Tabs(".tab-list");
 * tabs.tabList.addEventListener("tabchange", (e) => {
 *   console.log(e.detail.value);
 * });
 * ```
 *
 * 사용법 2: 컨텐츠 전환
 * ```html
 * <div class="tab-list" data-tabs-trigger="my-tabs">
 *   <button class="tab active" data-value="tab1">탭 1</button>
 *   <button class="tab" data-value="tab2">탭 2</button>
 * </div>
 *
 * <div data-tabs-content="my-tabs">
 *   <div class="tab-panel active" data-value="tab1">탭 1 내용</div>
 *   <div class="tab-panel" data-value="tab2">탭 2 내용</div>
 * </div>
 * ```
 *
 * ```js
 * const tabs = new Tabs("my-tabs");
 * ```
 */
export class Tabs {
  /**
   * @param {string | HTMLElement} selectorOrName - 셀렉터, 요소, 또는 name값
   */
  constructor(selectorOrName) {
    // name 기반 초기화 시도 (data-tabs-trigger="name" 방식)
    if (typeof selectorOrName === "string") {
      const triggerByName = document.querySelector(
        `[data-tabs-trigger="${selectorOrName}"]`,
      );

      if (triggerByName) {
        // name 기반 초기화
        this.name = selectorOrName;
        this.tabList = triggerByName;
        this.contentContainer = document.querySelector(
          `[data-tabs-content="${selectorOrName}"]`,
        );
      } else {
        // 기존 selector 기반 초기화
        this.name = null;
        this.tabList = document.querySelector(selectorOrName);
        this.contentContainer = null;
      }
    } else {
      // HTMLElement 직접 전달
      this.name = selectorOrName.dataset?.tabsTrigger ?? null;
      this.tabList = selectorOrName;
      this.contentContainer = this.name
        ? document.querySelector(`[data-tabs-content="${this.name}"]`)
        : null;
    }

    if (!this.tabList) {
      console.error("Tabs: 요소를 찾을 수 없습니다.", selectorOrName);
      return;
    }

    this.isDown = false;
    this.startX = 0;
    this.scrollLeft = 0;
    this.isDragging = false;

    this.changeListeners = [];

    this.initTabs();
    this.initDrag();
    this.initControls();
  }

  initTabs() {
    this.tabs = this.tabList.querySelectorAll(".tab");
    this.panels = this.contentContainer
      ? this.contentContainer.querySelectorAll(".tab-panel")
      : [];

    this.tabs.forEach((tab, index) => {
      tab.addEventListener("click", (e) => {
        if (this.isDragging) {
          e.preventDefault();
          e.stopPropagation();
          return;
        }

        this.activateTab(tab, index);
      });
    });

    // 초기 활성 탭에 맞춰 패널 동기화
    if (this.panels.length > 0) {
      const activeTab = this.tabList.querySelector(".tab.active");
      if (activeTab) {
        this.syncPanels(activeTab.dataset.value);
      }
    }
  }

  /**
   * 탭 활성화 및 관련 패널 표시
   * @param {HTMLElement} tab - 활성화할 탭 요소
   * @param {number} index - 탭 인덱스
   */
  activateTab(tab, index) {
    const value = tab.dataset.value ?? null;

    this.tabs.forEach((t) => t.classList.remove("active"));
    tab.classList.add("active");

    this.syncPanels(value);

    const eventDetail = {
      tab,
      index,
      value,
      panels: this.panels,
    };

    for (const cb of this.changeListeners) {
      cb(eventDetail);
    }
    this.tabList.dispatchEvent(
      new CustomEvent("tabchange", {
        bubbles: true,
        detail: eventDetail,
      }),
    );
  }

  syncPanels(value) {
    if (!this.panels || this.panels.length === 0) return;

    this.panels.forEach((panel) => {
      if (panel.dataset.value === value) {
        panel.classList.add("active");
      } else {
        panel.classList.remove("active");
      }
    });
  }

  setActiveTab(valueOrIndex) {
    let targetTab = null;
    let targetIndex = -1;

    if (typeof valueOrIndex === "number") {
      targetIndex = valueOrIndex;
      targetTab = this.tabs[valueOrIndex];
    } else {
      this.tabs.forEach((tab, i) => {
        if (tab.dataset.value === valueOrIndex) {
          targetTab = tab;
          targetIndex = i;
        }
      });
    }

    if (targetTab) {
      this.activateTab(targetTab, targetIndex);
    }
  }

  /**
   * 현재 활성 탭 정보 반환
   * @returns {{
   *  tab: HTMLElement | null,
   *  index: number,
   *  value: string | null
   * }}
   */
  getActiveTab() {
    let activeTab = null;
    let activeIndex = -1;

    this.tabs.forEach((tab, i) => {
      if (tab.classList.contains("active")) {
        activeTab = tab;
        activeIndex = i;
      }
    });

    return {
      tab: activeTab,
      index: activeIndex,
      value: activeTab?.dataset.value ?? null,
    };
  }

  /**
   * 탭 변경 이벤트 리스너 추가
   * @param {Function} callback - 콜백 함수
   */
  addChangeEvent(callback) {
    this.changeListeners.push(callback);
  }

  /**
   * 탭 변경 이벤트 리스너 제거
   * @param {Function} callback - 제거할 콜백 함수
   */
  removeChangeEvent(callback) {
    const index = this.changeListeners.indexOf(callback);
    if (index > -1) {
      this.changeListeners.splice(index, 1);
    }
  }

  initDrag() {
    this.tabList.addEventListener("mousedown", this.onMouseDown);
  }

  onMouseDown = (e) => {
    this.isDown = true;
    this.isDragging = false;
    this.startX = e.pageX;
    this.scrollLeft = this.tabList.scrollLeft;

    this.tabList.style.cursor = "grabbing";
    this.tabList.style.scrollBehavior = "auto";
    this.tabList.style.userSelect = "none";

    window.addEventListener("mousemove", this.onMouseMove);
    window.addEventListener("mouseup", this.onMouseUp);
  };

  onMouseMove = (e) => {
    if (!this.isDown) return;
    e.preventDefault();

    const x = e.pageX;
    const walk = x - this.startX;

    if (!this.isDragging && Math.abs(walk) > 5) {
      this.isDragging = true;
      this.tabList.style.pointerEvents = "none"; // 탭 hover 방지
    }

    if (this.isDragging) {
      this.tabList.scrollLeft = this.scrollLeft - walk;
    }
  };

  onMouseUp = () => {
    this.isDown = false;

    this.tabList.style.cursor = "";
    this.tabList.style.removeProperty("scroll-behavior");
    this.tabList.style.removeProperty("user-select");
    this.tabList.style.removeProperty("pointer-events");

    window.removeEventListener("mousemove", this.onMouseMove);
    window.removeEventListener("mouseup", this.onMouseUp);

    setTimeout(() => {
      this.isDragging = false;
    }, 10);
  };

  initControls() {
    const container = this.tabList.parentElement.classList.contains(
      "tab-container",
    )
      ? this.tabList.parentElement
      : undefined;

    if (!container) return;

    container.insertAdjacentHTML(
      "beforeend",
      `
        <div class="tab-scroll-btn prev hidden">
          <i data-lucide="chevron-left"></i>
        </div>
        <div class="tab-scroll-btn next hidden">
          <i data-lucide="chevron-right"></i>
        </div>
      `,
    );

    lucide.createIcons({
      root: container,
    });

    this.prevBtn = container.querySelector(".tab-scroll-btn.prev");
    this.nextBtn = container.querySelector(".tab-scroll-btn.next");
    const SCROLL_AMOUNT = 150;

    this.updateBtns = () => {
      if (this.tabList.scrollLeft <= 0) {
        this.prevBtn.classList.add("hidden");
      } else {
        this.prevBtn.classList.remove("hidden");
      }

      if (
        this.tabList.scrollLeft + this.tabList.clientWidth >=
        this.tabList.scrollWidth - 1
      ) {
        this.nextBtn.classList.add("hidden");
      } else {
        this.nextBtn.classList.remove("hidden");
      }
    };

    this.updateBtns();
    window.addEventListener("resize", this.updateBtns);
    this.tabList.addEventListener("scroll", this.updateBtns);

    this.prevBtn.addEventListener("click", () => {
      this.tabList.scrollBy({ left: -SCROLL_AMOUNT, behavior: "smooth" });
    });

    this.nextBtn.addEventListener("click", () => {
      this.tabList.scrollBy({ left: SCROLL_AMOUNT, behavior: "smooth" });
    });
  }
}
