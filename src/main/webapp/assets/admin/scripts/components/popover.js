export class Popover {
  constructor(name) {
    this.name = name;
    this.triggerSelector = `[data-popover-trigger="${name}"]`;
    this.contentSelector = `[data-popover-content="${name}"]`;
    this.trigger = document.querySelector(this.triggerSelector);
    this.content = document.querySelector(this.contentSelector);
    this.isOpen = false;

    this.openListeners = [];
    this.closeListeners = [];

    this.bindToggle = this.toggle.bind(this);
    this.bindHandleOutsideClick = this.handleOutsideClick.bind(this);
    this.bindAdjustPosition = this.adjustPosition.bind(this);
    this.bindClose = this.close.bind(this);

    this.init();
  }

  init() {
    if (!this.trigger || !this.content) return;
    this.trigger.addEventListener("click", this.bindToggle);
  }

  handleOutsideClick(e) {
    if (e.target.closest(this.triggerSelector)) return;
    if (e.target.closest(this.contentSelector)) return;
    if (!this.isOpen) return;

    this.close();
  }

  toggle() {
    if (this.isOpen) {
      this.close();
    } else {
      this.open();
    }
  }

  open() {
    if (this.isOpen) return;

    const eventData = {
      trigger: this.trigger,
      content: this.content,
    };

    for (let cb of this.openListeners) {
      cb(eventData);
    }

    const prevVisibility = this.content.style.visibility;
    this.content.style.visibility = "hidden";
    this.content.classList.add("show");

    this.adjustPosition();

    this.content.style.visibility = prevVisibility || "";

    // 이벤트 바인딩 (다음 틱에 바깥 클릭 리스너 추가해 바로 닫히는 것 방지)
    setTimeout(() => {
      window.addEventListener("click", this.bindHandleOutsideClick); // 바깥 클릭으로 닫기
    }, 0);

    window.addEventListener("resize", this.bindAdjustPosition);
    window.addEventListener("scroll", this.bindClose, true); // 스크롤 시 닫기

    this.isOpen = true;
  }

  close() {
    if (!this.isOpen) return;

    const eventData = {
      trigger: this.trigger,
      content: this.content,
    };

    for (let cb of this.closeListeners) {
      cb(eventData);
    }

    window.removeEventListener("click", this.bindHandleOutsideClick);
    window.removeEventListener("resize", this.bindAdjustPosition);
    window.removeEventListener("scroll", this.bindClose, true);

    this.content.classList.remove("show");
    this.isOpen = false;
  }

  adjustPosition() {
    if (!this.trigger || !this.content) return;

    const EDGE_MARGIN = 16; // 화면 끝과의 여백

    const triggerRect = this.trigger.getBoundingClientRect();
    const contentW = this.content.offsetWidth;
    const contentH = this.content.offsetHeight;

    // 뷰포트 크기
    const vw = window.innerWidth;
    const vh = window.innerHeight;

    // fixed 포지셔닝 사용
    this.content.style.position = "fixed";

    // 기본: 트리거 바로 아래
    let top = triggerRect.bottom;
    let left = triggerRect.left;

    // 가로: 화면 밖으로 나가면 조정 (여백 포함)
    if (left + contentW > vw - EDGE_MARGIN) {
      left = vw - contentW - EDGE_MARGIN;
    }
    if (left < EDGE_MARGIN) left = EDGE_MARGIN;

    // 세로: 아래 공간이 부족하면 위에 배치 (여백 포함)
    const spaceBelow = vh - triggerRect.bottom - EDGE_MARGIN;
    const spaceAbove = triggerRect.top - EDGE_MARGIN;

    if (spaceBelow < contentH && spaceAbove > spaceBelow) {
      // 위에 배치
      top = triggerRect.top - contentH;
    }

    this.content.style.left = `${left}px`;
    this.content.style.top = `${top}px`;
  }

  /** @param {OpenEventCallback} callback */
  addOpenEvent(callback) {
    this.openListeners.push(callback);
  }

  /** @param {OpenEventCallback} callback */
  addCloseEvent(callback) {
    this.closeListeners.push(callback);
  }

  free() {
    this.trigger.removeEventListener("click", this.bindToggle);
    window.removeEventListener("click", this.bindHandleOutsideClick);
    window.removeEventListener("resize", this.bindAdjustPosition);
    window.removeEventListener("scroll", this.bindClose, true);
    this.trigger = null;
    this.content = null;
    this.openListeners = null;
    this.closeListeners = null;
  }
}
