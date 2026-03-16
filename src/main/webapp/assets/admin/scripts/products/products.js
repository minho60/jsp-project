/**
 * 상품 관리 페이지 스크립트
 */

import { Tabs } from "../components/tabs.js";
import { Popover } from "../components/popover.js";
import { Modal } from "../components/modal.js";
import { Pagination } from "../components/pagination.js";
import { ImageUpload } from "../components/imageUpload.js";
import { ImageGallery } from "../components/imageGallery.js";

// 상태 레이블 매핑
const STATUS_LABELS = {
  ACTIVE: "판매중",
  INACTIVE: "판매중지",
  SOLD_OUT: "품절",
  DISCONTINUED: "단종",
};

// 상태별 뱃지 색상 매핑
const STATUS_BADGE_COLORS = {
  ACTIVE: "green",
  INACTIVE: "gray",
  SOLD_OUT: "amber",
  DISCONTINUED: "red",
};

// 페이지네이션 설정
const ITEMS_PER_PAGE = 10;

// 상태 관리
let filteredProducts = [...window.productsData];
let sortKey = "productNumber";
let sortOrder = "desc";

// 팝오버 인스턴스 관리
let productPopovers = [];
let headerPopovers = [];

// 모달 인스턴스
let productModal = null;
let categoryModal = null;

// 이미지 컴포넌트 인스턴스
let thumbnailUpload = null;
let detailImageGallery = null;

// 페이지네이션 인스턴스
let productPagination = null;

// DOM 요소
const productsTableBody = document.getElementById("products-table-body");
const categoriesGrid = document.getElementById("categories-grid");

// 초기화
document.addEventListener("DOMContentLoaded", () => {
  initTabs();
  initHeaderPopovers();
  initPagination();
  initProductTable();
  initCategoryGrid();
  initModals();
  initFilters();
  lucide.createIcons();
});

/**
 * 페이지네이션 초기화
 */
function initPagination() {
  productPagination = new Pagination({
    infoSelector: "#products-pagination-info",
    controlsSelector: "#products-pagination-controls",
    limit: ITEMS_PER_PAGE,
    onPageChange: () => {
      renderProductTable();
    },
  });
}

/**
 * 탭 초기화 (기존 Tabs 컴포넌트 사용)
 */
function initTabs() {
  new Tabs("products-view");
}

/**
 * 헤더 정렬 팝오버 초기화
 */
function initHeaderPopovers() {
  const headerButtons = document.querySelectorAll(".header-sort-btn");

  headerButtons.forEach((btn) => {
    const key = btn.dataset.sortKey;
    const type = btn.dataset.sortType || "string";

    const popover = new Popover(key);
    headerPopovers.push(popover);

    popover.addOpenEvent((e) => {
      e.trigger.classList.add("active");
      const content = e.content;

      content.innerHTML = `
        <button data-dir="asc" class="btn sm ghost">
          <i data-lucide="arrow-up${type === "number" ? "-0-1" : ""}"></i>
          <span>오름차순</span>
        </button>
        <button data-dir="desc" class="btn sm ghost">
          <i data-lucide="arrow-down${type === "number" ? "-1-0" : ""}"></i>
          <span>내림차순</span>
        </button>
      `;

      lucide.createIcons({ root: content });

      const dirBtns = content.querySelectorAll("button[data-dir]");
      for (let dirBtn of dirBtns) {
        dirBtn.addEventListener("click", (ev) => {
          const btn = ev.target.closest("button");
          if (!btn) return;
          const dir = btn.dataset.dir;
          applySort(key, dir, type);
          popover.close();
        });
      }
    });

    popover.addCloseEvent((e) => {
      e.trigger.classList.remove("active");
      e.content.innerHTML = "";
    });
  });
}

/**
 * 정렬 적용
 */
function applySort(key, dir, type) {
  sortKey = key;
  sortOrder = dir;
  productPagination.reset();
  sortProducts(key, dir, type);
  renderProductTable();

  // 헤더 아이콘 업데이트
  const headerButtons = document.querySelectorAll(".header-sort-btn");
  headerButtons.forEach((btn) => {
    const icon = btn.querySelector(".header-icon");
    if (!icon) return;
    if (btn.dataset.sortKey === key) {
      icon.setAttribute(
        "data-lucide",
        dir === "asc" ? "arrow-up" : "arrow-down",
      );
    } else {
      icon.setAttribute("data-lucide", "chevrons-up-down");
    }
  });
  lucide.createIcons();
}

/**
 * 상품 테이블 초기화
 */
function initProductTable() {
  // 초기 정렬 적용
  sortProducts(
    sortKey,
    sortOrder,
    sortKey === "productNumber" || sortKey === "price" || sortKey === "weight"
      ? "number"
      : "string",
  );
  renderProductTable();
}

/**
 * 상품 테이블 렌더링
 */
function renderProductTable() {
  // 기존 팝오버 해제
  productPopovers.forEach((p) => p.free());
  productPopovers = [];

  const startIndex = productPagination.getStartIndex();
  const endIndex = productPagination.getEndIndex();
  const pageProducts = filteredProducts.slice(startIndex, endIndex);

  if (pageProducts.length === 0) {
    productsTableBody.innerHTML = `
      <tr>
        <td colspan="9" class="table-cell">
          <div class="empty-state">
            <i data-lucide="package-x" class="empty-state-icon"></i>
            <div class="empty-state-title">상품이 없습니다</div>
            <div class="empty-state-description">새 상품을 추가해보세요</div>
          </div>
        </td>
      </tr>
    `;
    lucide.createIcons();
    renderProductPagination();
    return;
  }

  // 빈 행 채우기
  const blankCount = ITEMS_PER_PAGE - pageProducts.length;

  productsTableBody.innerHTML = "";

  pageProducts.forEach((product) => {
    const category = window.categoriesData.find(
      (c) => c.categoryNumber === product.categoryNumber,
    ) || { name: "미분류", icon: "📦" };
    const statusBadgeColor = STATUS_BADGE_COLORS[product.status];

    const tr = document.createElement("tr");
    tr.className = "table-row";
    tr.dataset.productId = product.productNumber;

    tr.innerHTML = `
      <td class="table-cell">
        <div class="table-cell-wrapper">${product.productNumber}</div>
      </td>
      <td class="table-cell">
        <div class="product-thumbnail">
          ${product.thumbnailImage
        ? `<img src="${escapeHtml(resolveImagePath(product.thumbnailImage))}" alt="${escapeHtml(product.name)}" onerror="this.parentElement.innerHTML='<i data-lucide=\\'image\\' class=\\'product-thumbnail-placeholder\\'></i>'">`
        : '<i data-lucide="image" class="product-thumbnail-placeholder"></i>'
      }
        </div>
      </td>
      <td class="table-cell">
        <span class="badge gray">
          <span class="category-icon">${category.icon}</span>
          <span>${category.name}</span>
        </span>
      </td>
      <td class="table-cell product-name-cell">
        <div class="table-cell-wrapper">
          <div class="product-name">${escapeHtml(product.name)}</div>
          <div class="product-description">${escapeHtml(product.description || "")}</div>
        </div>
      </td>
      <td class="table-cell">
        <div class="table-cell-wrapper price-cell">${formatPrice(product.price)}</div>
      </td>
      <td class="table-cell">
        <div class="table-cell-wrapper">${formatWeight(product.weight)}</div>
      </td>
      <td class="table-cell">
        <div class="table-cell-wrapper">${escapeHtml(product.origin || "-")}</div>
      </td>
      <td class="table-cell">
        <span class="badge ${statusBadgeColor}">${STATUS_LABELS[product.status]}</span>
      </td>
      <td class="table-cell">
        <div class="btn ghost icon-only" data-popover-trigger="pm-${product.productNumber}">
          <i data-lucide="ellipsis" width="16"></i>
        </div>
        <div class="popover" data-popover-content="pm-${product.productNumber}"></div>
      </td>
    `;

    productsTableBody.appendChild(tr);

    // 팝오버 생성
    const popover = new Popover(`pm-${product.productNumber}`);
    productPopovers.push(popover);

    popover.addOpenEvent((e) => {
      e.trigger.classList.add("active");
      const content = e.content;

      content.innerHTML = `
        <button class="btn sm ghost" data-action="edit">
          <i data-lucide="pencil"></i>
          <span>수정</span>
        </button>
        <button class="btn sm ghost" style="color: var(--color-destructive-foreground);" data-action="delete">
          <i data-lucide="trash-2"></i>
          <span>삭제</span>
        </button>
      `;

      lucide.createIcons({ root: content });

      // 수정 버튼
      content
        .querySelector('[data-action="edit"]')
        .addEventListener("click", () => {
          popover.close();
          editProduct(product.productNumber);
        });

      // 삭제 버튼
      content
        .querySelector('[data-action="delete"]')
        .addEventListener("click", () => {
          popover.close();
          deleteProduct(product.productNumber);
        });
    });

    popover.addCloseEvent((e) => {
      e.trigger.classList.remove("active");
      e.content.innerHTML = "";
    });
  });

  // 부족한 행을 빈 행으로 채우기
  for (let i = 0; i < blankCount; i++) {
    const tr = document.createElement("tr");
    tr.className = "table-row";
    tr.innerHTML = `
      <td class="table-cell"><div class="table-cell-wrapper">&nbsp;</div></td>
      <td class="table-cell"><div class="product-thumbnail" style="visibility:hidden"></div></td>
      <td class="table-cell"></td>
      <td class="table-cell product-name-cell"><div class="table-cell-wrapper">&nbsp;</div></td>
      <td class="table-cell"><div class="table-cell-wrapper">&nbsp;</div></td>
      <td class="table-cell"><div class="table-cell-wrapper">&nbsp;</div></td>
      <td class="table-cell"><div class="table-cell-wrapper">&nbsp;</div></td>
      <td class="table-cell"></td>
      <td class="table-cell"></td>
    `;
    productsTableBody.appendChild(tr);
  }

  renderProductPagination();
  lucide.createIcons();
}

/**
 * 상품 페이지네이션 렌더링
 */
function renderProductPagination() {
  productPagination.update(filteredProducts.length);
}

/**
 * 상품 정렬
 */
function sortProducts(key, order, type) {
  filteredProducts.sort((a, b) => {
    let valA = a[key];
    let valB = b[key];

    if (type === "number") {
      valA = Number(valA) || 0;
      valB = Number(valB) || 0;
    } else {
      valA = String(valA).toLowerCase();
      valB = String(valB).toLowerCase();
    }

    if (valA < valB) return order === "asc" ? -1 : 1;
    if (valA > valB) return order === "asc" ? 1 : -1;
    return 0;
  });
}

/**
 * 필터 초기화
 */
function initFilters() {
  const categoryFilter = document.getElementById("category-filter");
  const statusFilter = document.getElementById("status-filter");
  const searchInput = document.getElementById("search-product");
  const categorySearchInput = document.getElementById("search-category");

  categoryFilter?.addEventListener("change", applyFilters);
  statusFilter?.addEventListener("change", applyFilters);
  searchInput?.addEventListener("input", debounce(applyFilters, 300));
  categorySearchInput?.addEventListener(
    "input",
    debounce(applyCategoryFilter, 300),
  );
}

/**
 * 상품 필터 적용
 */
function applyFilters() {
  const categoryFilter = document.getElementById("category-filter");
  const statusFilter = document.getElementById("status-filter");
  const searchInput = document.getElementById("search-product");

  const categoryNumber = categoryFilter?.value
    ? parseInt(categoryFilter.value)
    : null;
  const status = statusFilter?.value || null;
  const searchTerm = searchInput?.value.toLowerCase().trim() || "";

  filteredProducts = window.productsData.filter((product) => {
    const matchCategory =
      !categoryNumber || product.categoryNumber === categoryNumber;
    const matchStatus = !status || product.status === status;
    const matchSearch =
      !searchTerm || product.name.toLowerCase().includes(searchTerm);

    return matchCategory && matchStatus && matchSearch;
  });

  productPagination.reset();
  sortProducts(
    sortKey,
    sortOrder,
    sortKey === "productNumber" || sortKey === "price" || sortKey === "weight"
      ? "number"
      : "string",
  );
  renderProductTable();
}

/**
 * 카테고리 필터 적용
 */
function applyCategoryFilter() {
  const searchInput = document.getElementById("search-category");
  const searchTerm = searchInput?.value.toLowerCase().trim() || "";

  renderCategoryGrid(searchTerm);
}

/**
 * 카테고리 그리드 초기화
 */
function initCategoryGrid() {
  renderCategoryGrid();
}

/**
 * 카테고리 그리드 렌더링
 */
function renderCategoryGrid(searchTerm = "") {
  let categories = [...window.categoriesData];

  if (searchTerm) {
    categories = categories.filter((cat) =>
      cat.name.toLowerCase().includes(searchTerm),
    );
  }

  if (categories.length === 0) {
    categoriesGrid.innerHTML = `
      <div class="empty-state">
        <i data-lucide="folder-x" class="empty-state-icon"></i>
        <div class="empty-state-title">카테고리가 없습니다</div>
        <div class="empty-state-description">새 카테고리를 추가해보세요</div>
      </div>
    `;
    lucide.createIcons();
    return;
  }

  categoriesGrid.innerHTML = categories
    .map((category) => {
      const productCount = window.productsData.filter(
        (p) => p.categoryNumber === category.categoryNumber,
      ).length;

      return `
      <div class="category-card" data-category-number="${category.categoryNumber}">
        <div class="category-card-header">
          <span class="category-card-icon">${category.icon}</span>
          <div class="category-card-actions">
            <button class="btn ghost sm icon-only" data-edit-category="${category.categoryNumber}">
              <i data-lucide="pencil" width="14"></i>
            </button>
            <button class="btn ghost sm icon-only" data-delete-category="${category.categoryNumber}">
              <i data-lucide="trash-2" width="14"></i>
            </button>
          </div>
        </div>
        <div class="category-card-name">${escapeHtml(category.name)}</div>
        <div class="category-card-description">${escapeHtml(category.description || "설명 없음")}</div>
        <div class="category-card-meta">
          <span class="category-product-count">
            <i data-lucide="package" width="14"></i>
            <span>상품 ${productCount}개</span>
          </span>
        </div>
      </div>
    `;
    })
    .join("");

  // 카테고리 편집/삭제 버튼 이벤트 바인딩
  categoriesGrid.querySelectorAll("[data-edit-category]").forEach((btn) => {
    btn.addEventListener("click", () => {
      const id = parseInt(btn.dataset.editCategory);
      editCategory(id);
    });
  });

  categoriesGrid.querySelectorAll("[data-delete-category]").forEach((btn) => {
    btn.addEventListener("click", () => {
      const id = parseInt(btn.dataset.deleteCategory);
      deleteCategory(id);
    });
  });

  lucide.createIcons();
}

/**
 * 모달 초기화
 */
function initModals() {
  // 상품 모달 초기화
  productModal = new Modal("product-modal");

  // 상품 추가 버튼 (모달 트리거 대신 직접 열기)
  document.getElementById("add-product-btn")?.addEventListener("click", () => {
    openProductModal();
  });

  // 카테고리 모달 초기화
  categoryModal = new Modal("category-modal");

  // 카테고리 추가 버튼
  document.getElementById("add-category-btn")?.addEventListener("click", () => {
    openCategoryModal();
  });

  // 상품 폼 제출
  document.getElementById("product-form")?.addEventListener("submit", (e) => {
    e.preventDefault();
    saveProduct();
  });

  // 카테고리 폼 제출
  document.getElementById("category-form")?.addEventListener("submit", (e) => {
    e.preventDefault();
    saveCategory();
  });

  // 이미지 컴포넌트 초기화
  initImageComponents();

  // 다른 곳 클릭 시 이미지 오버레이 닫기
  document.addEventListener("click", (e) => {
    if (
      !e.target.closest(".image-upload-preview") &&
      !e.target.closest(".image-gallery-item") &&
      !e.target.closest(".image-lightbox") &&
      !e.target.closest(".image-gallery-add")
    ) {
      closeAllImageOverlays();
    }
  });
}

/**
 * 이미지 컴포넌트 초기화
 */
function initImageComponents() {
  // 썸네일 이미지 업로드 컴포넌트
  thumbnailUpload = new ImageUpload("thumbnail-upload-zone");

  // 상세 이미지 갤러리 컴포넌트
  detailImageGallery = new ImageGallery("detail-images-container", {
    maxImages: 10,
  });
}

/**
 * 모든 이미지 오버레이 닫기
 */
function closeAllImageOverlays() {
  // 썸네일 미리보기 오버레이 닫기
  document
    .querySelector(".image-upload-preview.active")
    ?.classList.remove("active");

  // 갤러리 이미지 오버레이 닫기
  document.querySelectorAll(".image-gallery-item.active").forEach((item) => {
    item.classList.remove("active");
  });
}

/**
 * 상품 모달 열기
 */
function openProductModal(product = null) {
  const form = document.getElementById("product-form");
  const title = document.getElementById("product-modal-title");

  form.reset();

  // 이미지 컴포넌트 초기화
  thumbnailUpload?.clear();
  detailImageGallery?.clear();

  if (product) {
    title.textContent = "상품 수정";
    document.getElementById("product-number").value = product.productNumber;
    document.getElementById("product-category").value = product.categoryNumber;
    document.getElementById("product-name").value = product.name;
    document.getElementById("product-description").value =
      product.description || "";
    document.getElementById("product-price").value = product.price;
    document.getElementById("product-weight").value = product.weight;
    document.getElementById("product-origin").value = product.origin || "";
    document.getElementById("product-status").value = product.status;

    // 썸네일 이미지 설정
    if (product.thumbnailImage) {
      thumbnailUpload?.setImage(resolveImagePath(product.thumbnailImage));
    }

    // 상세 이미지 설정
    if (product.detailImages && product.detailImages.length > 0) {
      detailImageGallery?.setImages(product.detailImages.map(resolveImagePath));
    }
  } else {
    title.textContent = "상품 추가";
    document.getElementById("product-number").value = "";
  }

  productModal.open();
  lucide.createIcons();
}

/**
 * 카테고리 모달 열기
 */
function openCategoryModal(category = null) {
  const form = document.getElementById("category-form");
  const title = document.getElementById("category-modal-title");

  form.reset();

  if (category) {
    title.textContent = "카테고리 수정";
    document.getElementById("category-number").value = category.categoryNumber;
    document.getElementById("category-icon").value = category.icon || "";
    document.getElementById("category-name").value = category.name;
    document.getElementById("category-description").value =
      category.description || "";
  } else {
    title.textContent = "카테고리 추가";
    document.getElementById("category-number").value = "";
  }

  categoryModal.open();
}

/**
 * 모달 닫기
 */
function closeModals() {
  productModal?.close();
  categoryModal?.close();
}

/**
 * 상품 저장 (서버 API 호출)
 */
function saveProduct() {
  const form = document.getElementById("product-form");
  const productNumber = document.getElementById("product-number").value;
  const name = document.getElementById("product-name").value.trim();

  if (!name) {
    alert("필수 항목을 모두 입력해주세요.");
    return;
  }

  const params = new URLSearchParams();
  params.set("action", "saveProduct");
  if (productNumber) params.set("productNumber", productNumber);
  params.set("categoryNumber", document.getElementById("product-category").value);
  params.set("name", name);
  params.set("description", document.getElementById("product-description").value);
  params.set("price", document.getElementById("product-price").value);
  params.set("weight", document.getElementById("product-weight").value);
  params.set("origin", document.getElementById("product-origin").value);
  params.set("status", document.getElementById("product-status").value);

  // 썸네일: ImageUpload 컴포넌트에서 직접 가져오기
  const thumbnailUrl = thumbnailUpload ? thumbnailUpload.getImage() : null;
  params.set("thumbnailImage", unresolveImagePath(thumbnailUrl) || "");

  // 상세 이미지: ImageGallery 컴포넌트에서 직접 가져오기
  if (detailImageGallery) {
    const images = detailImageGallery.getImages ? detailImageGallery.getImages() : [];
    const relativePaths = images.map((url) => unresolveImagePath(url) || url);
    params.set("detailImages", relativePaths.join("|||"));
  }

  const body = params.toString();

  // 전송 크기 체크 (서버 제한 20MB, 여유 두고 15MB)
  if (body.length > 15 * 1024 * 1024) {
    alert("전송 데이터가 너무 큽니다. 이미지 크기를 줄여주세요.");
    return;
  }

  fetch(window.ctx + "/admin/products", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
    body,
  })
    .then((res) => res.json())
    .then((data) => {
      alert(data.message);
      if (data.success) location.reload();
    })
    .catch(() => alert("요청 중 오류가 발생했습니다."));
}

/**
 * 카테고리 저장 (서버 API 호출)
 */
function saveCategory() {
  const categoryNumber = document.getElementById("category-number").value;
  const name = document.getElementById("category-name").value.trim();

  if (!name) {
    alert("카테고리명을 입력해주세요.");
    return;
  }

  const params = new URLSearchParams();
  params.set("action", "saveCategory");
  if (categoryNumber) params.set("categoryNumber", categoryNumber);
  params.set("name", name);
  params.set("description", document.getElementById("category-description").value);
  params.set("icon", document.getElementById("category-icon").value);

  fetch(window.ctx + "/admin/products", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
    body: params.toString(),
  })
    .then((res) => res.json())
    .then((data) => {
      alert(data.message);
      if (data.success) location.reload();
    })
    .catch(() => alert("요청 중 오류가 발생했습니다."));
}

/**
 * 상품 수정
 */
function editProduct(productNumber) {
  const product = window.productsData.find(
    (p) => p.productNumber === productNumber,
  );
  if (product) {
    openProductModal(product);
  }
}

/**
 * 상품 삭제 (서버 API 호출)
 */
function deleteProduct(id) {
  if (!confirm("이 상품을 삭제하시겠습니까?")) return;

  const params = new URLSearchParams();
  params.set("action", "deleteProduct");
  params.set("productNumber", id);

  fetch(window.ctx + "/admin/products", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
    body: params.toString(),
  })
    .then((res) => res.json())
    .then((data) => {
      alert(data.message);
      if (data.success) location.reload();
    })
    .catch(() => alert("요청 중 오류가 발생했습니다."));
}

/**
 * 카테고리 수정
 */
function editCategory(categoryNumber) {
  const category = window.categoriesData.find(
    (c) => c.categoryNumber === categoryNumber,
  );
  if (category) {
    openCategoryModal(category);
  }
}

/**
 * 카테고리 삭제 (서버 API 호출)
 */
function deleteCategory(id) {
  if (!confirm("이 카테고리를 삭제하시겠습니까?")) return;

  const params = new URLSearchParams();
  params.set("action", "deleteCategory");
  params.set("categoryNumber", id);

  fetch(window.ctx + "/admin/products", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
    body: params.toString(),
  })
    .then((res) => res.json())
    .then((data) => {
      alert(data.message);
      if (data.success) location.reload();
    })
    .catch(() => alert("요청 중 오류가 발생했습니다."));
}

/**
 * 카테고리 필터 옵션 업데이트
 */
function updateCategoryFilters() {
  const categoryFilter = document.getElementById("category-filter");
  const productCategorySelect = document.getElementById("product-category");

  const options = window.categoriesData
    .map(
      (cat) =>
        `<option value="${cat.categoryNumber}">${cat.icon} ${cat.name}</option>`,
    )
    .join("");

  if (categoryFilter) {
    categoryFilter.innerHTML =
      `<option value="">전체 카테고리</option>` + options;
  }

  if (productCategorySelect) {
    productCategorySelect.innerHTML =
      `<option value="">카테고리 선택</option>` + options;
  }
}

/**
 * 유틸리티: HTML 이스케이프
 */
function escapeHtml(str) {
  if (!str) return "";
  const div = document.createElement("div");
  div.textContent = str;
  return div.innerHTML;
}

/**
 * 유틸리티: 리소스 이미지 경로 조합
 * resPath(로컬: /assets, 배포: CDN URL) + 상대 경로를 결합
 */
function resolveImagePath(path) {
  if (!path) return "";
  if (path.startsWith("data:")) return path;
  return `${window.resPath}${path}`;
}

/**
 * 유틸리티: 절대 이미지 URL을 원래 상대 경로로 복원
 * resolveImagePath의 역변환. Data URL은 그대로 반환.
 */
function unresolveImagePath(url) {
  if (!url) return "";
  // data URL은 변환 불필요
  if (url.startsWith("data:")) return url;
  // resPath prefix 제거
  const resPath = window.resPath || "";
  if (resPath && url.includes(resPath)) {
    return url.substring(url.indexOf(resPath) + resPath.length);
  }
  return url;
}

/**
 * 유틸리티: 가격 포맷팅
 */
function formatPrice(price) {
  return new Intl.NumberFormat("ko-KR", {
    style: "currency",
    currency: "KRW",
  }).format(price);
}

/**
 * 유틸리티: 무게 포맷팅
 */
function formatWeight(weight) {
  if (!weight) return "-";
  if (weight >= 1000) {
    return `${(weight / 1000).toFixed(1)}kg`;
  }
  return `${weight}g`;
}

/**
 * 유틸리티: 디바운스
 */
function debounce(fn, delay) {
  let timeoutId;
  return function (...args) {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => fn.apply(this, args), delay);
  };
}
