/**
 * ImageUpload - 단일 이미지 업로드 컴포넌트
 *
 * @example
 * const uploader = new ImageUpload('thumbnail-zone', {
 *   onChange: (url) => console.log('변경됨:', url)
 * });
 * uploader.setImage(existingUrl); // 수정 모드
 * const url = uploader.getImage(); // 저장 시
 */
export class ImageUpload {
  /**
   * @param {string} containerId - 컨테이너 요소 ID
   * @param {Object} options - 설정 옵션
   * @param {string} options.accept - 허용 파일 타입
   * @param {number} options.maxSize - 최대 파일 크기 (bytes)
   * @param {Function} options.onChange - 이미지 변경 시 콜백
   */
  constructor(containerId, options = {}) {
    this.container = document.getElementById(containerId);
    if (!this.container) {
      console.warn(`ImageUpload: Container #${containerId} not found`);
      return;
    }

    this.options = {
      accept: "image/jpeg,image/png,image/gif,image/webp",
      maxSize: 5 * 1024 * 1024, // 5MB
      onChange: null,
      ...options,
    };

    this.imageUrl = null;
    this.fileInput = null;
    this.previewEl = null;

    this.init();
  }

  init() {
    // 숨겨진 파일 입력 생성
    this.fileInput = document.createElement("input");
    this.fileInput.type = "file";
    this.fileInput.accept = this.options.accept;
    this.fileInput.style.display = "none";
    this.container.appendChild(this.fileInput);

    // 미리보기 요소 찾기 또는 생성
    this.previewEl =
      this.container.querySelector(".image-upload-preview") || this.container;

    // 초기 상태 렌더링
    this.renderEmpty();

    // 이벤트 바인딩
    this.bindEvents();
  }

  bindEvents() {
    // 컨테이너 클릭 시 파일 선택 (이미지 없을 때만)
    this.container.addEventListener("click", (e) => {
      if (this.container.classList.contains("has-image")) return;
      this.fileInput.click();
    });

    // 파일 선택 시
    this.fileInput.addEventListener("change", () => {
      if (this.fileInput.files.length > 0) {
        this.handleFile(this.fileInput.files[0]);
      }
    });

    // 드래그 앤 드롭
    this.container.addEventListener("dragover", (e) => {
      e.preventDefault();
      this.container.classList.add("dragover");
    });

    this.container.addEventListener("dragleave", () => {
      this.container.classList.remove("dragover");
    });

    this.container.addEventListener("drop", (e) => {
      e.preventDefault();
      this.container.classList.remove("dragover");
      const files = e.dataTransfer.files;
      if (files.length > 0 && files[0].type.startsWith("image/")) {
        this.handleFile(files[0]);
      }
    });
  }

  handleFile(file) {
    // 파일 크기 체크
    if (file.size > this.options.maxSize) {
      alert(
        `파일 크기가 너무 큽니다. 최대 ${Math.round(this.options.maxSize / 1024 / 1024)}MB까지 가능합니다.`,
      );
      return;
    }

    const reader = new FileReader();
    reader.onload = (e) => {
      const dataUrl = e.target.result;
      this.setImage(dataUrl);
    };
    reader.readAsDataURL(file);
  }

  /**
   * 이미지 설정 (미리보기 표시)
   * @param {string} url - 이미지 URL 또는 Data URL
   */
  setImage(url) {
    if (!url) {
      this.clear();
      return;
    }

    this.imageUrl = url;
    this.container.classList.add("has-image");
    this.previewEl.classList.remove("active");

    this.previewEl.innerHTML = `
      <img src="${this.escapeHtml(url)}" alt="미리보기">
      <div class="image-overlay">
        <button type="button" class="image-action-btn change" title="이미지 변경">
          <i data-lucide="refresh-cw" width="18"></i>
        </button>
        <button type="button" class="image-action-btn delete" title="이미지 삭제">
          <i data-lucide="trash-2" width="18"></i>
        </button>
      </div>
    `;

    // Lucide 아이콘 렌더링
    if (typeof lucide !== "undefined") {
      lucide.createIcons({ root: this.previewEl });
    }

    // 오버레이 이벤트 설정
    this.setupOverlayEvents();

    // 콜백 호출
    if (this.options.onChange) {
      this.options.onChange(this.imageUrl);
    }
  }

  setupOverlayEvents() {
    // 이미지 클릭 시 오버레이 토글 (터치 기기용)
    this.previewEl.addEventListener("click", (e) => {
      if (e.target.closest(".image-action-btn")) return;
      this.previewEl.classList.toggle("active");
    });

    // 변경 버튼
    this.previewEl
      .querySelector(".image-action-btn.change")
      ?.addEventListener("click", (e) => {
        e.stopPropagation();
        this.previewEl.classList.remove("active");
        this.fileInput.click();
      });

    // 삭제 버튼
    this.previewEl
      .querySelector(".image-action-btn.delete")
      ?.addEventListener("click", (e) => {
        e.stopPropagation();
        this.clear();
      });
  }

  /**
   * 현재 이미지 URL 반환
   * @returns {string|null}
   */
  getImage() {
    return this.imageUrl;
  }

  /**
   * 이미지 초기화
   */
  clear() {
    this.imageUrl = null;
    this.fileInput.value = "";
    this.container.classList.remove("has-image");
    this.previewEl.classList.remove("active");

    this.renderEmpty();

    // 콜백 호출
    if (this.options.onChange) {
      this.options.onChange(null);
    }
  }

  renderEmpty() {
    this.previewEl.innerHTML = `
      <i data-lucide="image-plus" class="image-upload-icon"></i>
      <span class="image-upload-text">클릭하거나 드래그하여 이미지 업로드</span>
      <span class="image-upload-hint">JPEG, PNG, GIF, WebP (최대 5MB)</span>
    `;

    if (typeof lucide !== "undefined") {
      lucide.createIcons({ root: this.previewEl });
    }
  }

  escapeHtml(str) {
    if (!str) return "";
    const div = document.createElement("div");
    div.textContent = str;
    return div.innerHTML;
  }

  /**
   * 컴포넌트 정리
   */
  destroy() {
    if (this.fileInput) {
      this.fileInput.remove();
    }
    this.container = null;
    this.previewEl = null;
    this.fileInput = null;
    this.imageUrl = null;
  }
}
