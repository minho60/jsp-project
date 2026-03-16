/**
 * Pagination 컴포넌트
 * 페이지네이션 UI를 관리하는 컴포넌트
 *
 * @example
 * const pagination = new Pagination({
 *   infoSelector: '#pagination-info',
 *   controlsSelector: '#pagination-controls',
 *   limit: 10,
 *   onPageChange: (page) => { renderTable(); }
 * });
 *
 * // 데이터 업데이트 시
 * pagination.update(totalCount);
 */
export class Pagination {
  /**
   * @param {Object} options - 설정 객체
   * @param {string} options.infoSelector - 정보 표시 영역 선택자
   * @param {string} options.controlsSelector - 컨트롤 영역 선택자
   * @param {number} [options.limit=10] - 페이지당 항목 수
   * @param {number} [options.maxButtons=5] - 표시할 최대 페이지 버튼 수
   * @param {Function} options.onPageChange - 페이지 변경 콜백
   */
  constructor(options) {
    this.infoEl = document.querySelector(options.infoSelector);
    this.controlsEl = document.querySelector(options.controlsSelector);
    this.limit = options.limit || 10;
    this.maxButtons = options.maxButtons || 5;
    this.onPageChange = options.onPageChange || (() => {});

    this.currentPage = 1;
    this.totalCount = 0;
    this.totalPages = 0;
  }

  /**
   * 현재 페이지 반환
   * @returns {number}
   */
  getPage() {
    return this.currentPage;
  }

  /**
   * 페이지당 항목 수 반환
   * @returns {number}
   */
  getLimit() {
    return this.limit;
  }

  /**
   * 현재 페이지의 시작 인덱스 반환
   * @returns {number}
   */
  getStartIndex() {
    return (this.currentPage - 1) * this.limit;
  }

  /**
   * 현재 페이지의 끝 인덱스 반환
   * @returns {number}
   */
  getEndIndex() {
    return this.getStartIndex() + this.limit;
  }

  /**
   * 페이지 변경
   * @param {number} page - 이동할 페이지 번호
   */
  goToPage(page) {
    if (page < 1 || page > this.totalPages) return;
    if (page === this.currentPage) return;

    this.currentPage = page;
    this.render();
    this.onPageChange(page);
  }

  /**
   * 첫 페이지로 리셋
   */
  reset() {
    this.currentPage = 1;
  }

  /**
   * 총 개수 업데이트 및 렌더링
   * @param {number} totalCount - 전체 항목 수
   */
  update(totalCount) {
    this.totalCount = totalCount;
    this.totalPages = Math.ceil(totalCount / this.limit);

    // 현재 페이지가 범위를 벗어나면 조정
    if (this.currentPage > this.totalPages && this.totalPages > 0) {
      this.currentPage = this.totalPages;
    }

    this.render();
  }

  /**
   * UI 렌더링
   */
  render() {
    this.renderInfo();
    this.renderControls();
  }

  /**
   * 정보 텍스트 렌더링
   */
  renderInfo() {
    if (!this.infoEl) return;

    const startNum =
      this.totalCount > 0 ? (this.currentPage - 1) * this.limit + 1 : 0;
    const endNum = Math.min(this.currentPage * this.limit, this.totalCount);
    this.infoEl.textContent = `총 ${this.totalCount}개 중 ${startNum}-${endNum}`;
  }

  /**
   * 컨트롤 버튼 렌더링
   */
  renderControls() {
    if (!this.controlsEl) return;

    this.controlsEl.innerHTML = "";

    // 이전 버튼
    const prevBtn = document.createElement("button");
    prevBtn.className = "btn sm secondary icon-only";
    prevBtn.innerHTML = `<i data-lucide="chevron-left" width="14"></i>`;
    prevBtn.disabled = this.currentPage === 1;
    prevBtn.addEventListener("click", () =>
      this.goToPage(this.currentPage - 1),
    );
    this.controlsEl.appendChild(prevBtn);

    // 페이지 번호 버튼
    const { startPage, endPage } = this.getPageRange();

    for (let i = startPage; i <= endPage; i++) {
      const btn = document.createElement("button");
      btn.className = `btn sm ${i === this.currentPage ? "primary" : "secondary"} icon-only`;
      btn.textContent = i;
      btn.addEventListener("click", () => this.goToPage(i));
      this.controlsEl.appendChild(btn);
    }

    // 다음 버튼
    const nextBtn = document.createElement("button");
    nextBtn.className = "btn sm secondary icon-only";
    nextBtn.innerHTML = `<i data-lucide="chevron-right" width="14"></i>`;
    nextBtn.disabled =
      this.currentPage === this.totalPages || this.totalPages === 0;
    nextBtn.addEventListener("click", () =>
      this.goToPage(this.currentPage + 1),
    );
    this.controlsEl.appendChild(nextBtn);

    // Lucide 아이콘 렌더링
    if (typeof lucide !== "undefined") {
      lucide.createIcons({ root: this.controlsEl });
    }
  }

  /**
   * 표시할 페이지 범위 계산
   * @returns {{ startPage: number, endPage: number }}
   */
  getPageRange() {
    const half = Math.floor(this.maxButtons / 2);
    let startPage = Math.max(1, this.currentPage - half);
    let endPage = Math.min(this.totalPages, startPage + this.maxButtons - 1);

    // 끝 페이지가 부족하면 시작 페이지 조정
    if (endPage - startPage < this.maxButtons - 1) {
      startPage = Math.max(1, endPage - this.maxButtons + 1);
    }

    return { startPage, endPage };
  }

  free() {
    if (this.controlsEl) {
      this.controlsEl.innerHTML = "";
    }
    if (this.infoEl) {
      this.infoEl.textContent = "";
    }
  }
}
