<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <link rel="stylesheet" href="${resPath}/admin/styles/products.css" />

        <div class="page-header">
            <h2>상품 관리</h2>
            <div class="header-actions">
                <button class="btn primary sm" id="add-product-btn">
                    <i data-lucide="plus" width="16"></i><span>상품 추가</span>
                </button>
            </div>
        </div>

        <div class="tab-container">
            <div class="tab-list" data-tabs-trigger="products-view">
                <button class="tab active" data-value="products">상품 목록</button>
                <button class="tab" data-value="categories">카테고리 관리</button>
            </div>
        </div>

        <div data-tabs-content="products-view">
            <!-- 상품 목록 탭 -->
            <div class="tab-panel active" data-value="products">
                <div class="controls-row">
                    <div class="filter-group">
                        <select class="input sm" id="category-filter">
                            <option value="">전체 카테고리</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.categoryNumber}">${cat.icon} ${cat.name}</option>
                            </c:forEach>
                        </select>
                        <select class="input sm" id="status-filter">
                            <option value="">전체 상태</option>
                            <option value="ACTIVE">판매중</option>
                            <option value="INACTIVE">판매중지</option>
                            <option value="SOLD_OUT">품절</option>
                            <option value="DISCONTINUED">단종</option>
                        </select>
                    </div>
                    <input type="text" class="input sm" id="search-product" placeholder="상품명으로 검색">
                </div>
                <div class="table-container">
                    <table class="table">
                        <thead class="table-head">
                            <tr class="table-row">
                                <th class="table-head-cell">
                                    <button class="btn sm ghost header-sort-btn" data-sort-key="productNumber"
                                        data-sort-type="number" data-popover-trigger="productNumber">
                                        <span>상품 번호</span><i data-lucide="arrow-down" class="header-icon"></i>
                                    </button>
                                    <div class="popover" data-popover-content="productNumber"></div>
                                </th>
                                <th class="table-head-cell th-image"></th>
                                <th class="table-head-cell"><span>카테고리</span></th>
                                <th class="table-head-cell">
                                    <button class="btn sm ghost header-sort-btn" data-sort-key="name"
                                        data-popover-trigger="name">
                                        <span>상품명</span><i data-lucide="chevrons-up-down" class="header-icon"></i>
                                    </button>
                                    <div class="popover" data-popover-content="name"></div>
                                </th>
                                <th class="table-head-cell">
                                    <button class="btn sm ghost header-sort-btn" data-sort-key="price"
                                        data-sort-type="number" data-popover-trigger="price">
                                        <span>정가</span><i data-lucide="chevrons-up-down" class="header-icon"></i>
                                    </button>
                                    <div class="popover" data-popover-content="price"></div>
                                </th>
                                <th class="table-head-cell">
                                    <button class="btn sm ghost header-sort-btn" data-sort-key="weight"
                                        data-sort-type="number" data-popover-trigger="weight">
                                        <span>무게</span><i data-lucide="chevrons-up-down" class="header-icon"></i>
                                    </button>
                                    <div class="popover" data-popover-content="weight"></div>
                                </th>
                                <th class="table-head-cell"><span>원산지</span></th>
                                <th class="table-head-cell"><span>상태</span></th>
                                <th class="table-head-cell"></th>
                            </tr>
                        </thead>
                        <tbody class="table-body" id="products-table-body"></tbody>
                    </table>
                </div>
                <div class="pagination-container" id="products-pagination-container">
                    <div class="pagination-info" id="products-pagination-info"></div>
                    <div class="pagination-controls" id="products-pagination-controls"></div>
                </div>
            </div>

            <!-- 카테고리 관리 탭 -->
            <div class="tab-panel" data-value="categories">
                <div class="controls-row">
                    <button class="btn outline sm" id="add-category-btn">
                        <i data-lucide="folder-plus" width="16"></i><span>카테고리 추가</span>
                    </button>
                    <input type="text" class="input sm" id="search-category" placeholder="카테고리명으로 검색">
                </div>
                <div class="categories-grid" id="categories-grid"></div>
            </div>
        </div>

        <!-- 상품 추가/편집 모달 -->
        <div data-modal-content="product-modal">
            <div class="modal-box">
                <div class="modal-header">
                    <h3 id="product-modal-title">상품 추가</h3>
                    <button class="btn ghost sm icon-only" data-modal-close><i data-lucide="x"></i></button>
                </div>
                <form id="product-form" class="modal-body">
                    <input type="hidden" id="product-number" name="productNumber">
                    <div class="form-group">
                        <label class="form-label" for="product-category">카테고리 <span class="required">*</span></label>
                        <select class="input" id="product-category" name="categoryNumber" required>
                            <option value="">카테고리 선택</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.categoryNumber}">${cat.icon} ${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="product-name">상품명 <span class="required">*</span></label>
                        <input type="text" class="input" id="product-name" name="name" placeholder="상품명을 입력하세요"
                            required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="product-description">상품 설명</label>
                        <textarea class="input" id="product-description" name="description"
                            placeholder="상품에 대한 설명을 입력하세요" rows="3"></textarea>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label class="form-label" for="product-price">정가 <span class="required">*</span></label>
                            <input type="number" class="input" id="product-price" name="price" placeholder="0" min="0"
                                required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="product-weight">무게 (g) <span
                                    class="required">*</span></label>
                            <input type="number" class="input" id="product-weight" name="weight" placeholder="0" min="0"
                                required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="product-origin">원산지 <span class="required">*</span></label>
                        <input type="text" class="input" id="product-origin" name="origin" placeholder="예: 국내산, 미국산"
                            required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="product-status">판매 상태</label>
                        <select class="input" id="product-status" name="status">
                            <option value="ACTIVE">판매중</option>
                            <option value="INACTIVE">판매중지</option>
                            <option value="SOLD_OUT">품절</option>
                            <option value="DISCONTINUED">단종</option>
                        </select>
                    </div>
                    <div class="form-divider"></div>
                    <div class="form-group">
                        <label class="form-label">썸네일 이미지</label>
                        <input type="hidden" id="product-thumbnail" name="thumbnailImage">
                        <div class="image-upload-zone" id="thumbnail-upload-zone">
                            <div class="image-upload-preview" id="thumbnail-preview">
                                <i data-lucide="image-plus" class="image-upload-icon"></i>
                                <span class="image-upload-text">클릭하거나 드래그하여 이미지 업로드</span>
                                <span class="image-upload-hint">JPEG, PNG, GIF, WebP (최대 5MB)</span>
                            </div>
                        </div>
                        <span class="form-hint">상품 목록에 표시될 대표 이미지입니다</span>
                    </div>
                    <div class="form-group">
                        <label class="form-label">상세 이미지</label>
                        <div class="image-gallery-grid" id="detail-images-container">
                            <div class="image-gallery-add" id="detail-upload-zone">
                                <i data-lucide="plus" class="image-gallery-add-icon"></i>
                            </div>
                        </div>
                        <span class="form-hint">상품 상세 페이지에 표시될 이미지들입니다 (최대 10개)</span>
                    </div>
                </form>
                <div class="modal-footer">
                    <button class="btn outline sm" type="button" data-modal-close>취소</button>
                    <button class="btn primary sm" type="submit" form="product-form" id="product-submit-btn">저장</button>
                </div>
            </div>
        </div>

        <!-- 카테고리 추가/편집 모달 -->
        <div data-modal-content="category-modal">
            <div class="modal-box sm">
                <div class="modal-header">
                    <h3 id="category-modal-title">카테고리 추가</h3>
                    <button class="btn ghost sm icon-only" data-modal-close><i data-lucide="x"></i></button>
                </div>
                <form id="category-form" class="modal-body">
                    <input type="hidden" id="category-number" name="categoryNumber">
                    <div class="form-group">
                        <label class="form-label" for="category-icon">아이콘</label>
                        <input type="text" class="input" id="category-icon" name="icon" placeholder="📦" maxlength="2">
                        <span class="form-hint">이모지를 사용하세요</span>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="category-name">카테고리명 <span class="required">*</span></label>
                        <input type="text" class="input" id="category-name" name="name" placeholder="카테고리명을 입력하세요"
                            required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="category-description">설명</label>
                        <textarea class="input" id="category-description" name="description"
                            placeholder="카테고리에 대한 설명을 입력하세요" rows="2"></textarea>
                    </div>
                </form>
                <div class="modal-footer">
                    <button class="btn outline sm" type="button" data-modal-close>취소</button>
                    <button class="btn primary sm" type="submit" form="category-form"
                        id="category-submit-btn">저장</button>
                </div>
            </div>
        </div>

        <script>
            window.productsData = ${ productsJson };
            window.categoriesData = ${ categoriesJson };
        </script>
        <script type="module" src="${resPath}/admin/scripts/products/products.js"></script>