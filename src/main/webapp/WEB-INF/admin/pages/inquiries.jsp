<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <link rel="stylesheet" href="${resPath}/admin/styles/inquiries.css" />

        <div class="page-header">
            <h2>1대1 문의</h2>
            <c:if test="${waitingCount > 0}">
                <span class="badge amber"><i data-lucide="bell" width="14"></i><span>답변 대기
                        ${waitingCount}건</span></span>
            </c:if>
        </div>
        <div class="tab-container">
            <div class="tab-list" data-tabs-trigger="inquiry-status"></div>
        </div>
        <div class="controls-row">
            <div class="type-filter"><select class="input sm" id="type-filter"></select></div>
            <input type="text" class="input sm" id="search-inquiry" placeholder="제목, 작성자로 검색">
        </div>
        <div class="table-container">
            <table class="table">
                <thead class="table-head">
                    <tr class="table-row">
                        <th class="table-head-cell"><button class="btn sm ghost header-sort-btn"
                                data-sort-key="qaNum" data-sort-type="number"
                                data-popover-trigger="qaNum"><span>번호</span><i data-lucide="arrow-down"
                                    class="header-icon"></i></button>
                            <div class="popover" data-popover-content="qaNum"></div>
                        </th>
                        <th class="table-head-cell"><span>유형</span></th>
                        <th class="table-head-cell"><button class="btn sm ghost header-sort-btn" data-sort-key="title"
                                data-popover-trigger="title"><span>제목</span><i data-lucide="chevrons-up-down"
                                    class="header-icon"></i></button>
                            <div class="popover" data-popover-content="title"></div>
                        </th>
                        <th class="table-head-cell"><button class="btn sm ghost header-sort-btn"
                                data-sort-key="writerName" data-popover-trigger="writerName"><span>작성자</span><i
                                    data-lucide="chevrons-up-down" class="header-icon"></i></button>
                            <div class="popover" data-popover-content="writerName"></div>
                        </th>
                        <th class="table-head-cell"><button class="btn sm ghost header-sort-btn"
                                data-sort-key="createdAt"
                                data-popover-trigger="createdAt"><span>작성일</span><i data-lucide="chevrons-up-down"
                                    class="header-icon"></i></button>
                            <div class="popover" data-popover-content="createdAt"></div>
                        </th>
                        <th class="table-head-cell"><span>상태</span></th>
                        <th class="table-head-cell"></th>
                    </tr>
                </thead>
                <tbody class="table-body" id="inquiry-table-body"></tbody>
            </table>
        </div>
        <div class="pagination-container" id="pagination-container">
            <div class="pagination-info" id="pagination-info"></div>
            <div class="pagination-controls" id="pagination-controls"></div>
        </div>
        <script>window.inquiryData = ${ inquiryListJson }; window.waitingCount = ${ waitingCount };</script>
        <script type="module" src="${resPath}/admin/scripts/inquiries/inquiries.js"></script>