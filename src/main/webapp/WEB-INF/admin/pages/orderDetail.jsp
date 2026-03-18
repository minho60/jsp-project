<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <link rel="stylesheet" href="${resPath}/admin/styles/orderDetail.css" />

            <div class="page-header">
                <a href="${ctx}/admin/orders" class="btn sm ghost">
                    <i data-lucide="arrow-left"></i><span>목록으로</span>
                </a>
                <h2>주문 상세</h2>
            </div>

            <c:choose>
                <c:when test="${empty order}">
                    <div class="error-container">
                        <div class="error-icon"><i data-lucide="package-x"></i></div>
                        <p class="error-message">${not empty error ? error : '주문을 찾을 수 없습니다.'}</p>
                        <a href="${ctx}/admin/orders"><button class="btn sm primary">목록으로 돌아가기</button></a>
                    </div>
                </c:when>
                <c:otherwise>
                    <%-- 상태별 배지 색상을 서블릿이 아닌 JSP에서 간단히 처리 --%>
                        <c:set var="badgeColor" value="gray" />
                        <c:choose>
                            <c:when
                                test="${order.orderState == 'PAYMENT_PENDING' || order.orderState == 'CANCEL_REQUESTED' || order.orderState == 'RETURN_REQUESTED'}">
                                <c:set var="badgeColor" value="amber" />
                            </c:when>
                            <c:when test="${order.orderState == 'PREPARING_PRODUCT'}">
                                <c:set var="badgeColor" value="blue" />
                            </c:when>
                            <c:when test="${order.orderState == 'SHIPPING_PENDING'}">
                                <c:set var="badgeColor" value="purple" />
                            </c:when>
                            <c:when test="${order.orderState == 'SHIPPING_IN_PROGRESS'}">
                                <c:set var="badgeColor" value="primary" />
                            </c:when>
                            <c:when test="${order.orderState == 'DELIVERED'}">
                                <c:set var="badgeColor" value="green" />
                            </c:when>
                            <c:when test="${order.orderState == 'CANCELLED' || order.orderState == 'RETURNED'}">
                                <c:set var="badgeColor" value="red" />
                            </c:when>
                        </c:choose>
                        <c:set var="statusLabel" value="${order.orderStateLabel}" />

                        <div class="detail-container">
                            <div class="detail-card">
                                <div class="detail-card-header">
                                    <div class="header-left">
                                        <h3 class="detail-title">주문번호 #${order.orderNumber}</h3>
                                        <span class="order-name-sub">${order.orderName}</span>
                                    </div>
                                    <span class="badge ${badgeColor}">
                                        <c:choose>
                                            <c:when test="${order.orderState == 'DELIVERED'}"><i
                                                    data-lucide="check-circle" width="14"></i></c:when>
                                            <c:when test="${order.orderState == 'SHIPPING_IN_PROGRESS'}"><i
                                                    data-lucide="truck" width="14"></i></c:when>
                                            <c:when
                                                test="${order.orderState == 'CANCELLED' || order.orderState == 'RETURNED'}">
                                                <i data-lucide="x-circle" width="14"></i>
                                            </c:when>
                                            <c:otherwise><i data-lucide="clock" width="14"></i></c:otherwise>
                                        </c:choose>
                                        <span>${statusLabel}</span>
                                    </span>
                                </div>
                                <div class="detail-meta">
                                    <div class="meta-item"><span class="meta-label">주문일</span><span
                                            class="meta-value">${order.orderDate}</span></div>
                                    <div class="meta-item"><span class="meta-label">총 수량</span><span
                                            class="meta-value">${order.totalQuantity}개</span></div>
                                    <div class="meta-item"><span class="meta-label">상품 종류</span><span
                                            class="meta-value">
                                            <fmt:formatNumber value="${order.items.size()}" />종
                                        </span></div>
                                    <div class="meta-item"><span class="meta-label">최종 금액</span><span
                                            class="meta-value total-price">
                                            <fmt:formatNumber value="${order.totalAmount}" />원
                                        </span></div>
                                </div>
                            </div>

                            <div class="detail-card">
                                <div class="detail-card-header">
                                    <div class="header-left">
                                        <div class="header-icon-title"><i data-lucide="user" width="20"></i>
                                            <h4>주문자 / 수령인 정보</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="customer-info-grid">
                                    <div class="customer-info-section">
                                        <h5 class="section-label">주문자</h5>
                                        <div class="info-row">
                                            <span class="info-label">회원 구분</span>
                                            <span class="info-value">
                                                <c:choose>
                                                    <c:when test="${not empty order.memberNumber}">
                                                        <span class="badge blue sm">회원</span>
                                                        <span>${order.memberId}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge gray sm">비회원</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label">이름</span>
                                            <span class="info-value">${order.ordererName}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label">연락처</span>
                                            <span class="info-value">${order.ordererPhone}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label">이메일</span>
                                            <span class="info-value">${order.ordererEmail}</span>
                                        </div>
                                    </div>
                                    <div class="customer-info-section">
                                        <h5 class="section-label">수령인</h5>
                                        <div class="info-row">
                                            <span class="info-label">이름</span>
                                            <span class="info-value">${order.receiverName}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label">연락처</span>
                                            <span class="info-value">${order.receiverPhone}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label">주소</span>
                                            <span class="info-value">${order.receiverAddress}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="detail-card">
                                <div class="detail-card-header">
                                    <div class="header-left">
                                        <div class="header-icon-title"><i data-lucide="shopping-cart" width="20"></i>
                                            <h4>주문 상품</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="order-items-list">
                                    <c:forEach var="item" items="${order.items}">
                                        <div class="order-item">
                                            <div class="item-thumbnail">
                                                <c:choose>
                                                    <c:when test="${not empty item.thumbnailImage}">
                                                        <img src="${resPath}${item.thumbnailImage}"
                                                            alt="${item.productName}"
                                                            onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                                        <div class="item-thumbnail-fallback" style="display:none;"><i
                                                                data-lucide="image-off" width="24"></i></div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="item-thumbnail-fallback"><i data-lucide="image-off"
                                                                width="24"></i></div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="item-info">
                                                <div class="item-name">${item.productName}</div>
                                                <div class="item-details">
                                                    <c:if test="${not empty item.origin}"><span class="item-detail"><i
                                                                data-lucide="map-pin" width="12"></i>
                                                            ${item.origin}</span></c:if>
                                                    <c:if test="${not empty item.weight && item.weight > 0}"><span
                                                            class="item-detail"><i data-lucide="weight" width="12"></i>
                                                            ${item.weight}g</span></c:if>
                                                    <span class="item-detail"><i data-lucide="hash" width="12"></i>
                                                        ${item.productNumber}</span>
                                                </div>
                                            </div>
                                            <div class="item-pricing">
                                                <div class="item-unit-price">
                                                    <fmt:formatNumber value="${item.price}" />원
                                                </div>
                                                <div class="item-quantity">× ${item.quantity}</div>
                                            </div>
                                            <div class="item-subtotal">
                                                <span class="subtotal-amount">
                                                    <fmt:formatNumber value="${item.subtotal}" />원
                                                </span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="order-summary">
                                    <div class="summary-row">
                                        <span class="summary-label">상품 금액</span>
                                        <span class="summary-value">
                                            <fmt:formatNumber value="${order.totalAmount}" />원
                                        </span>
                                    </div>
                                    <div class="summary-row">
                                        <span class="summary-label">배송비</span>
                                        <span class="summary-value free">무료</span>
                                    </div>
                                    <div class="summary-row total">
                                        <span class="summary-label">총 결제 금액</span>
                                        <span class="summary-value">
                                            <fmt:formatNumber value="${order.totalAmount}" />원
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="detail-card">
                                <div class="detail-card-header">
                                    <div class="header-left">
                                        <div class="header-icon-title"><i data-lucide="settings" width="20"></i>
                                            <h4>주문 관리</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="order-management">
                                    <div class="status-change-form">
                                        <label class="form-label">주문 상태 변경</label>
                                        <div class="status-change-row">
                                            <select class="input sm" id="status-select">
                                                <c:forEach var="st" items="${OrderStatus}">
                                                    <option value="${st.key}" ${order.orderState==st.key ? 'selected'
                                                        : '' }>${st.label}</option>
                                                </c:forEach>
                                            </select>
                                            <button class="btn sm primary" id="change-status-btn">
                                                <i data-lucide="refresh-cw"></i><span>상태 변경</span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="action-card">
                                <div class="action-group">
                                    <button class="btn sm outline"><i data-lucide="printer"></i><span>인쇄</span></button>
                                </div>
                                <div class="action-group">
                                    <button class="btn sm destructive"><i data-lucide="trash-2"></i><span>주문
                                            삭제</span></button>
                                </div>
                            </div>
                        </div>
                </c:otherwise>
            </c:choose>

            <script>
                window.orderDetail = ${ orderJson };
                window.OrderStatus = ${ OrderStatusJson };
            </script>
            <script type="module" src="${resPath}/admin/scripts/orders/orderDetail.js"></script>