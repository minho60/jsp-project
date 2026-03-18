<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <link rel="stylesheet" href="${resPath}/admin/styles/orders.css" />

        <div class="page-header">
            <h2>주문 내역</h2>
        </div>

        <div class="tab-container">
            <div class="tab-list" id="order-tab-list"></div>
        </div>

        <div class="controls-row">
            <div class="filter-group">
                <select class="input sm" id="member-filter">
                    <option value="">주문자 유형</option>
                    <option value="member">회원 주문</option>
                    <option value="guest">비회원 주문</option>
                </select>
            </div>
            <input type="text" class="input sm" id="search-order" placeholder="주문명으로 검색">
        </div>

        <div class="table-container">
            <table class="table">
                <thead class="table-head">
                    <tr class="table-row">
                        <th class="table-head-cell">
                            <button class="btn sm ghost header-sort-btn" data-sort-key="orderNumber"
                                data-sort-type="number" data-popover-trigger="orderNumber">
                                <span>주문번호</span><i data-lucide="arrow-down" class="header-icon"></i>
                            </button>
                            <div class="popover" data-popover-content="orderNumber"></div>
                        </th>
                        <th class="table-head-cell">
                            <button class="btn sm ghost header-sort-btn" data-sort-key="ordererName"
                                data-popover-trigger="ordererName">
                                <span>주문자</span><i data-lucide="chevrons-up-down" class="header-icon"></i>
                            </button>
                            <div class="popover" data-popover-content="ordererName"></div>
                        </th>
                        <th class="table-head-cell">
                            <button class="btn sm ghost header-sort-btn" data-sort-key="orderName"
                                data-popover-trigger="orderName">
                                <span>주문명</span><i data-lucide="chevrons-up-down" class="header-icon"></i>
                            </button>
                            <div class="popover" data-popover-content="orderName"></div>
                        </th>
                        <th class="table-head-cell">
                            <button class="btn sm ghost header-sort-btn" data-sort-key="orderDate"
                                data-popover-trigger="orderDate">
                                <span>주문일</span><i data-lucide="chevrons-up-down" class="header-icon"></i>
                            </button>
                            <div class="popover" data-popover-content="orderDate"></div>
                        </th>
                        <th class="table-head-cell"><span>주문상태</span></th>
                        <th class="table-head-cell">
                            <button class="btn sm ghost header-sort-btn" data-sort-key="totalQuantity"
                                data-sort-type="number" data-popover-trigger="totalQuantity">
                                <span>총 수량</span><i data-lucide="chevrons-up-down" class="header-icon"></i>
                            </button>
                            <div class="popover" data-popover-content="totalQuantity"></div>
                        </th>
                        <th class="table-head-cell">
                            <button class="btn sm ghost header-sort-btn" data-sort-key="totalAmount"
                                data-sort-type="number" data-popover-trigger="totalAmount">
                                <span>최종 금액</span><i data-lucide="chevrons-up-down" class="header-icon"></i>
                            </button>
                            <div class="popover" data-popover-content="totalAmount"></div>
                        </th>
                        <th class="table-head-cell"></th>
                    </tr>
                </thead>
                <tbody class="table-body" id="orders-table-body"></tbody>
            </table>
        </div>

        <div class="pagination-container" id="pagination-container">
            <div class="pagination-info" id="pagination-info"></div>
            <div class="pagination-controls" id="pagination-controls"></div>
        </div>

        <script>
            window.orders = ${ ordersJson };
            window.OrderStatus = ${ OrderStatusJson };
        </script>
        <script type="module" src="${resPath}/admin/scripts/orders/orders.js"></script>