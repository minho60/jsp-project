<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <link rel="stylesheet" href="${resPath}/admin/styles/inquiries.css" />

        <div class="page-header">
            <a href="${ctx}/admin/inquiries" class="btn sm ghost"><i data-lucide="arrow-left"></i><span>목록으로</span></a>
            <h2>문의 상세</h2>
        </div>

        <c:choose>
            <c:when test="${empty inquiry}">
                <div class="error-container">
                    <div class="error-icon"><i data-lucide="alert-circle"></i></div>
                    <p class="error-message">${not empty error ? error : '문의를 찾을 수 없습니다.'}</p>
                    <a href="${ctx}/admin/inquiries" class="btn sm primary">목록으로 돌아가기</a>
                </div>
            </c:when>
            <c:otherwise>
                <%-- 유형 배지 색상 --%>
                    <c:set var="typeColor" value="gray" />
                    <c:choose>
                        <c:when test="${inquiry.type == 'MEMBER'}">
                            <c:set var="typeColor" value="blue" />
                        </c:when>
                        <c:when test="${inquiry.type == 'ORDER'}">
                            <c:set var="typeColor" value="violet" />
                        </c:when>
                        <c:when test="${inquiry.type == 'DELIVERY'}">
                            <c:set var="typeColor" value="teal" />
                        </c:when>
                        <c:when test="${inquiry.type == 'REFUND'}">
                            <c:set var="typeColor" value="orange" />
                        </c:when>
                        <c:when test="${inquiry.type == 'RECEIPT'}">
                            <c:set var="typeColor" value="slate" />
                        </c:when>
                        <c:when test="${inquiry.type == 'EVENT'}">
                            <c:set var="typeColor" value="pink" />
                        </c:when>
                    </c:choose>
                    <c:set var="statusColor" value="${inquiry.status == 'WAITING' ? 'amber' : 'emerald'}" />
                    <c:set var="typeLabel" value="${inquiry.typeLabel}" />
                    <c:set var="statusLabel" value="${inquiry.statusLabel}" />

                    <div class="detail-container">
                        <div class="detail-card">
                            <div class="detail-card-header">
                                <div class="header-left">
                                    <div class="header-badges">
                                        <span class="badge ${typeColor}">${typeLabel}</span>
                                        <span class="badge ${inquiry.writerType == '회원' ? 'blue' : 'gray'} outline">${inquiry.writerType}</span>
                                    </div>
                                    <h3 class="detail-title">${inquiry.title}</h3>
                                </div>
                                <div class="header-right-actions">
                                    <span class="badge ${statusColor}">
                                        <c:choose>
                                            <c:when test="${inquiry.status == 'WAITING'}"><i data-lucide="clock"
                                                    width="14"></i></c:when>
                                            <c:otherwise><i data-lucide="check-circle" width="14"></i></c:otherwise>
                                        </c:choose>
                                        <span>${statusLabel}</span>
                                    </span>
                                    <button class="btn sm ghost danger" id="delete-inquiry-btn"
                                        title="문의 삭제"><i data-lucide="trash-2" width="16"></i></button>
                                </div>
                            </div>
                            <div class="detail-meta">
                                <div class="meta-item"><span class="meta-label">작성자</span><span
                                        class="meta-value">${inquiry.writerName}</span></div>
                                <div class="meta-item"><span class="meta-label">이메일</span><span
                                        class="meta-value">${inquiry.writerEmail}</span></div>
                                <c:if test="${inquiry.writerType == '회원' && not empty inquiry.phone}">
                                    <div class="meta-item"><span class="meta-label">연락처</span><span
                                            class="meta-value">${inquiry.phone}</span></div>
                                </c:if>
                                <div class="meta-item"><span class="meta-label">작성일</span><span
                                        class="meta-value">${inquiry.createdAt}</span></div>
                            </div>
                            <div class="detail-content">
                                <div class="content-label">문의 내용</div>
                                <div class="content-body">${inquiry.content}</div>
                            </div>
                        </div>

                        <div class="answer-card">
                            <div class="answer-header">
                                <i data-lucide="message-square" width="20"></i>
                                <h4>관리자 답변</h4>
                                <c:if test="${inquiry.status == 'ANSWERED' && not empty inquiry.answeredAt}">
                                    <span class="answered-at">${inquiry.answeredAt}</span>
                                </c:if>
                            </div>
                            <c:choose>
                                <c:when test="${inquiry.status == 'ANSWERED' && not empty inquiry.answer}">
                                    <div class="answer-content">
                                        <div class="answer-body">${inquiry.answer}</div>
                                    </div>
                                    <div class="answer-actions">
                                        <button class="btn sm outline" data-modal-trigger="answer-modal"><i
                                                data-lucide="pencil"></i><span>답변 수정</span></button>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-answer">
                                        <p>아직 답변이 등록되지 않았습니다.</p>
                                        <button class="btn sm primary" data-modal-trigger="answer-modal"><i
                                                data-lucide="send"></i><span>답변 작성하기</span></button>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div data-modal-content="answer-modal">
                        <div class="modal-box">
                            <div class="modal-header">
                                <h3>답변 작성</h3>
                                <button class="btn icon-only ghost" data-modal-close><i data-lucide="x"></i></button>
                            </div>
                            <div class="modal-body">
                                <label class="form-label">답변 내용</label>
                                <textarea class="input" id="answer-textarea" rows="8"
                                    placeholder="고객님께 전달할 답변을 작성해주세요...">${inquiry.answer}</textarea>
                            </div>
                            <div class="modal-footer">
                                <button class="btn sm ghost" data-modal-close>취소</button>
                                <button class="btn sm primary" id="submit-answer-btn"><i
                                        data-lucide="check"></i><span>답변 등록</span></button>
                            </div>
                        </div>
                    </div>
            </c:otherwise>
        </c:choose>

        <script>window.inquiryDetail = ${ inquiryJson };</script>
        <script type="module" src="${resPath}/admin/scripts/inquiries/inquiryDetail.js"></script>