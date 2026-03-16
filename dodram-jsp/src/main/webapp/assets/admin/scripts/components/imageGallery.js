/**
 * ImageGallery - 다중 이미지 갤러리 컴포넌트
 *
 * @example
 * const gallery = new ImageGallery('detail-images-container', {
 *   maxImages: 10,
 *   onChange: (images) => console.log('이미지 목록:', images)
 * });
 * gallery.setImages(existingUrls); // 수정 모드
 * const urls = gallery.getImages(); // 저장 시
 */
export class ImageGallery {
  /**
   * @param {string} containerId - 컨테이너 요소 ID
   * @param {Object} options - 설정 옵션
   * @param {string} options.accept - 허용 파일 타입
   * @param {number} options.maxImages - 최대 이미지 개수
   * @param {number} options.maxSize - 최대 파일 크기 (bytes)
   * @param {Function} options.onChange - 이미지 변경 시 콜백
   */
  constructor(containerId, options = {}) {
    this.container = document.getElementById(containerId);
    if (!this.container) {
      console.warn(`ImageGallery: Container #${containerId} not found`);
      return;
    }

    this.options = {
      accept: "image/jpeg,image/png,image/gif,image/webp",
      maxImages: 10,
      maxSize: 5 * 1024 * 1024, // 5MB
      onChange: null,
      ...options,
    };

    this.images = [];
    this.fileInput = null;
    this.addButton = null;

    this.init();
  }

  init() {
    // 추가 버튼 찾기 또는 생성
    this.addButton = this.container.querySelector(".image-gallery-add");
    if (!this.addButton) {
      this.addButton = document.createElement("div");
      this.addButton.className = "image-gallery-add";
      this.addButton.innerHTML = `<i data-lucide="plus" class="image-gallery-add-icon"></i>`;
      this.container.appendChild(this.addButton);

      if (typeof lucide !== "undefined") {
        lucide.createIcons({ root: this.addButton });
      }
    }

    // 숨겨진 파일 입력 생성
    this.fileInput = document.createElement("input");
    this.fileInput.type = "file";
    this.fileInput.accept = this.options.accept;
    this.fileInput.multiple = true;
    this.fileInput.style.display = "none";
    this.addButton.appendChild(this.fileInput);

    // 이벤트 바인딩
    this.bindEvents();
  }

  bindEvents() {
    // 추가 버튼 클릭
    this.addButton.addEventListener("click", (e) => {
      if (e.target.closest("input")) return;
      this.fileInput.click();
    });

    // 파일 선택 시
    this.fileInput.addEventListener("change", () => {
      if (this.fileInput.files.length > 0) {
        this.handleFiles(this.fileInput.files);
        this.fileInput.value = "";
      }
    });

    // 드래그 앤 드롭
    this.addButton.addEventListener("dragover", (e) => {
      e.preventDefault();
      this.addButton.classList.add("dragover");
    });

    this.addButton.addEventListener("dragleave", () => {
      this.addButton.classList.remove("dragover");
    });

    this.addButton.addEventListener("drop", (e) => {
      e.preventDefault();
      this.addButton.classList.remove("dragover");
      const files = Array.from(e.dataTransfer.files).filter((f) =>
        f.type.startsWith("image/"),
      );
      if (files.length > 0) {
        this.handleFiles(files);
      }
    });

    // 이미지 아이템 이벤트 (이벤트 위임)
    this.container.addEventListener("click", (e) => {
      const item = e.target.closest(".image-gallery-item");
      if (!item) return;

      const actionBtn = e.target.closest(".image-action-btn");
      if (actionBtn) {
        e.stopPropagation();

        if (actionBtn.classList.contains("delete")) {
          this.removeImageByElement(item);
        } else if (actionBtn.classList.contains("view")) {
          const imageUrl = item.querySelector("img")?.src;
          if (imageUrl) this.openLightbox(imageUrl);
        }
        return;
      }

      // 이미지 클릭 시 오버레이 토글 (터치 기기용)
      this.container
        .querySelectorAll(".image-gallery-item.active")
        .forEach((activeItem) => {
          if (activeItem !== item) {
            activeItem.classList.remove("active");
          }
        });
      item.classList.toggle("active");
    });
  }

  handleFiles(files) {
    const remainingSlots = this.options.maxImages - this.images.length;

    if (remainingSlots <= 0) {
      alert(
        `이미지는 최대 ${this.options.maxImages}개까지 추가할 수 있습니다.`,
      );
      return;
    }

    const filesToProcess = Array.from(files).slice(0, remainingSlots);

    filesToProcess.forEach((file) => {
      if (file.size > this.options.maxSize) {
        console.warn(`파일 크기 초과: ${file.name}`);
        return;
      }

      const reader = new FileReader();
      reader.onload = (e) => {
        const dataUrl = e.target.result;
        this.addImage(dataUrl);
      };
      reader.readAsDataURL(file);
    });
  }

  /**
   * 이미지 추가
   * @param {string} url - 이미지 URL 또는 Data URL
   */
  addImage(url) {
    if (this.images.length >= this.options.maxImages) {
      return;
    }

    this.images.push(url);

    const item = document.createElement("div");
    item.className = "image-gallery-item";
    item.innerHTML = `
      <img src="${this.escapeHtml(url)}" alt="이미지">
      <div class="image-overlay">
        <button type="button" class="image-action-btn view" title="크게 보기">
          <i data-lucide="maximize-2" width="14"></i>
        </button>
        <button type="button" class="image-action-btn delete" title="이미지 삭제">
          <i data-lucide="trash-2" width="14"></i>
        </button>
      </div>
    `;

    // 추가 버튼 앞에 삽입
    this.container.insertBefore(item, this.addButton);

    if (typeof lucide !== "undefined") {
      lucide.createIcons({ root: item });
    }

    // 콜백 호출
    if (this.options.onChange) {
      this.options.onChange([...this.images]);
    }
  }

  /**
   * 요소로 이미지 삭제
   * @param {HTMLElement} item
   */
  removeImageByElement(item) {
    const img = item.querySelector("img");
    if (img) {
      const index = this.images.indexOf(img.src);
      if (index > -1) {
        this.images.splice(index, 1);
      }
    }

    item.remove();

    if (this.options.onChange) {
      this.options.onChange([...this.images]);
    }
  }

  /**
   * 이미지 목록 설정
   * @param {string[]} urls - 이미지 URL 배열
   */
  setImages(urls) {
    this.clear();

    if (!urls || !Array.isArray(urls)) return;

    urls.forEach((url) => {
      this.addImage(url);
    });
  }

  /**
   * 현재 이미지 목록 반환
   * @returns {string[]}
   */
  getImages() {
    // DOM에서 직접 읽어서 반환 (동기화 보장)
    return Array.from(
      this.container.querySelectorAll(".image-gallery-item img"),
    ).map((img) => img.src);
  }

  /**
   * 모든 이미지 제거
   */
  clear() {
    this.images = [];
    this.container
      .querySelectorAll(".image-gallery-item")
      .forEach((item) => item.remove());

    if (this.options.onChange) {
      this.options.onChange([]);
    }
  }

  /**
   * 라이트박스 열기
   * @param {string} imageUrl
   */
  openLightbox(imageUrl) {
    // 기존 라이트박스 제거
    const existing = document.querySelector(".image-lightbox");
    if (existing) existing.remove();

    const lightbox = document.createElement("div");
    lightbox.className = "image-lightbox";
    lightbox.innerHTML = `
      <img src="${this.escapeHtml(imageUrl)}" alt="확대 이미지">
      <button type="button" class="lightbox-close" title="닫기">
        <i data-lucide="x" width="24"></i>
      </button>
    `;

    document.body.appendChild(lightbox);

    if (typeof lucide !== "undefined") {
      lucide.createIcons({ root: lightbox });
    }

    // 활성화 애니메이션
    requestAnimationFrame(() => {
      lightbox.classList.add("active");
    });

    // 닫기 이벤트
    const close = () => {
      lightbox.classList.remove("active");
      setTimeout(() => lightbox.remove(), 200);
      document.removeEventListener("keydown", escHandler);
    };

    lightbox.querySelector(".lightbox-close")?.addEventListener("click", close);
    lightbox.addEventListener("click", (e) => {
      if (e.target === lightbox) close();
    });

    const escHandler = (e) => {
      if (e.key === "Escape") close();
    };
    document.addEventListener("keydown", escHandler);
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
    this.addButton = null;
    this.fileInput = null;
    this.images = [];
  }
}
