<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <link rel="stylesheet" href="${resPath}/admin/styles/users.css" />
        <div style="display: flex; justify-content: space-between; margin-bottom: var(--spacing-6);">
            <h2>사용자 목록</h2>
            <button class="btn sm primary">
                <i data-lucide="user-plus"></i><span>사용자 추가</span>
            </button>
        </div>
        <div style="display: flex; justify-content: space-between; margin-bottom: var(--spacing-4);">
            <input type="text" class="input sm" id="search-user" placeholder="아이디로 검색">
        </div>
        <div class="table-container">
            <table class="table">
                <thead class="table-head">
                    <tr class="table-row">
                        <th class="table-head-cell">
                            <button class="btn sm ghost header-sort-btn" data-sort-key="userNumber"
                                data-sort-type="number" data-popover-trigger="userNumber">
                                <span>사용자번호</span><i data-lucide="arrow-up" class="header-icon"></i>
                            </button>
                            <div class="popover" data-popover-content="userNumber"></div>
                        </th>
                        <th class="table-head-cell">
                            <button class="btn sm ghost header-sort-btn" data-sort-key="userName"
                                data-popover-trigger="userName">
                                <span>아이디</span><i data-lucide="chevrons-up-down" class="header-icon"></i>
                            </button>
                            <div class="popover" data-popover-content="userName"></div>
                        </th>
                        <th class="table-head-cell">
                            <button class="btn sm ghost header-sort-btn" data-sort-key="email"
                                data-popover-trigger="email">
                                <span>이메일</span><i data-lucide="chevrons-up-down" class="header-icon"></i>
                            </button>
                            <div class="popover" data-popover-content="email"></div>
                        </th>
                        <th class="table-head-cell"><span>가입일</span></th>
                        <th class="table-head-cell"></th>
                    </tr>
                </thead>
                <tbody class="table-body" id="users-table-body"></tbody>
            </table>
        </div>
        <div class="pagination-container" id="pagination-container">
            <div class="pagination-info" id="pagination-info"></div>
            <div class="pagination-controls" id="pagination-controls"></div>
        </div>
        <script>
            window.users = ${ usersJson };
        </script>
        <script type="module" src="${resPath}/admin/scripts/users/users.js"></script>