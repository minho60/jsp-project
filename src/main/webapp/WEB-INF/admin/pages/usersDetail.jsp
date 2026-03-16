<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <link rel="stylesheet" href="${resPath}/admin/styles/usersDetail.css" />

        <div class="page-header">
            <a href="${ctx}/admin/users" class="btn sm ghost">
                <i data-lucide="arrow-left"></i>
                <span>목록으로</span>
            </a>
            <h2>사용자 상세</h2>
        </div>

        <c:choose>
            <c:when test="${empty user}">
                <div class="error-container">
                    <div class="error-icon"><i data-lucide="user-x"></i></div>
                    <p class="error-message">${not empty error ? error : '사용자를 찾을 수 없습니다.'}</p>
                    <a href="${ctx}/admin/users" class="btn sm primary">목록으로 돌아가기</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="detail-container">
                    <div class="profile-card">
                        <div class="profile-header">
                            <div class="profile-avatar"><i data-lucide="user" width="32" height="32"></i></div>
                            <div class="profile-info">
                                <h3 class="profile-name">${user.name}</h3>
                                <span class="profile-username">@${user.userName}</span>
                            </div>
                            <div class="profile-badge"><span class="badge emerald">활성</span></div>
                        </div>
                    </div>

                    <div class="detail-card">
                        <div class="detail-card-header">
                            <div class="header-left">
                                <i data-lucide="info" width="20"></i>
                                <h4>기본 정보</h4>
                            </div>
                        </div>
                        <div class="detail-info-grid">
                            <div class="info-item">
                                <div class="info-icon"><i data-lucide="hash" width="18"></i></div>
                                <div class="info-content">
                                    <span class="info-label">사용자 번호</span>
                                    <span class="info-value">${user.userNumber}</span>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-icon"><i data-lucide="user" width="18"></i></div>
                                <div class="info-content">
                                    <span class="info-label">아이디</span>
                                    <span class="info-value">${user.userName}</span>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-icon"><i data-lucide="badge-check" width="18"></i></div>
                                <div class="info-content">
                                    <span class="info-label">이름</span>
                                    <span class="info-value" data-field="name">${user.name}</span>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-icon"><i data-lucide="mail" width="18"></i></div>
                                <div class="info-content">
                                    <span class="info-label">이메일</span>
                                    <span class="info-value email-value" data-field="email">${user.email}</span>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-icon"><i data-lucide="phone" width="18"></i></div>
                                <div class="info-content">
                                    <span class="info-label">연락처</span>
                                    <span class="info-value phone-value"
                                        data-field="phoneNumber">${user.phoneNumber}</span>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-icon"><i data-lucide="calendar" width="18"></i></div>
                                <div class="info-content">
                                    <span class="info-label">가입일</span>
                                    <span class="info-value" data-timestamp="${user.createdAt}"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="action-card">
                        <div class="action-group">
                            <button class="btn sm outline" id="btn-edit"><i data-lucide="pencil"></i><span>정보
                                    수정</span></button>
                            <button class="btn sm outline" id="btn-reset-pw"><i data-lucide="key"></i><span>비밀번호
                                    재설정</span></button>
                        </div>
                        <div class="action-group edit-actions" style="display:none;">
                            <button class="btn sm primary" id="btn-save"><i
                                    data-lucide="check"></i><span>저장</span></button>
                            <button class="btn sm ghost" id="btn-cancel"><i data-lucide="x"></i><span>취소</span></button>
                        </div>
                        <div class="action-group" id="group-danger">
                            <button class="btn sm destructive" id="btn-delete"><i data-lucide="user-x"></i><span>계정
                                    삭제</span></button>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <script>
            window.userDetail = ${ userJson };
        </script>
        <script type="module" src="${resPath}/admin/scripts/users/usersDetail.js"></script>