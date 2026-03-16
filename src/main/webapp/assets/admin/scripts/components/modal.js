export class Modal {
  constructor(name) {
    this.name = name;
    this.triggerSelector = `[data-modal-trigger="${name}"]`;
    this.contentSelector = `[data-modal-content="${name}"]`;
    this.triggers = document.querySelectorAll(this.triggerSelector);
    this.content = document.querySelector(this.contentSelector);
    this.isOpen = false;

    this.openListeners = [];
    this.closeListeners = [];

    this.bindToggle = this.toggle.bind(this);
    this.bindHandleOutsideClick = this.handleOutsideClick.bind(this);
    this.bindHandleEscKey = this.handleEscKey.bind(this);
    this.bindHandleCloseBtn = this.handleCloseBtn.bind(this);

    this.init();
  }

  init() {
    if (!this.content) return;

    // 다중 트리거 지원
    this.triggers.forEach((trigger) => {
      trigger.addEventListener("click", this.bindToggle);
    });

    // 배경 클릭으로 닫기
    this.content.addEventListener("click", this.bindHandleOutsideClick);

    // data-modal-close 버튼들 지원
    const closeButtons = this.content.querySelectorAll("[data-modal-close]");
    closeButtons.forEach((btn) => {
      btn.addEventListener("click", this.bindHandleCloseBtn);
    });
  }

  handleOutsideClick(e) {
    if (!this.isOpen) return;
    // 모달 배경(content) 직접 클릭 시에만 닫기
    if (e.target === this.content) {
      this.close();
    }
  }

  handleCloseBtn(e) {
    e.preventDefault();
    this.close();
  }

  handleEscKey(e) {
    if (!this.isOpen) return;
    if (e.key === "Escape") {
      this.close();
    }
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
      triggers: this.triggers,
      content: this.content,
    };

    for (let cb of this.openListeners) {
      cb(eventData);
    }

    this.content.classList.add("show");
    document.body.style.overflow = "hidden";
    window.addEventListener("keydown", this.bindHandleEscKey);

    this.isOpen = true;
  }

  close() {
    if (!this.isOpen) return;

    const eventData = {
      triggers: this.triggers,
      content: this.content,
    };

    for (let cb of this.closeListeners) {
      cb(eventData);
    }

    this.content.classList.remove("show");
    document.body.style.overflow = "";
    window.removeEventListener("keydown", this.bindHandleEscKey);

    this.isOpen = false;
  }

  /** @param {Function} callback */
  addOpenEvent(callback) {
    this.openListeners.push(callback);
  }

  /** @param {Function} callback */
  addCloseEvent(callback) {
    this.closeListeners.push(callback);
  }

  free() {
    this.triggers.forEach((trigger) => {
      trigger.removeEventListener("click", this.bindToggle);
    });

    if (this.content) {
      this.content.removeEventListener("click", this.bindHandleOutsideClick);
      const closeButtons = this.content.querySelectorAll("[data-modal-close]");
      closeButtons.forEach((btn) => {
        btn.removeEventListener("click", this.bindHandleCloseBtn);
      });
    }

    window.removeEventListener("keydown", this.bindHandleEscKey);

    this.triggers = null;
    this.content = null;
    this.openListeners = null;
    this.closeListeners = null;
  }
}
