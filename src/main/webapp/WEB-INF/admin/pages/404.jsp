<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <style>
            main {
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                gap: var(--spacing-6);
                text-align: center;
                height: 100%;
            }

            .code {
                font-size: 4rem;
                font-weight: 700;
            }

            .title {
                font-size: var(--text-lg);
                font-weight: 600;
            }

            .description {
                font-size: var(--text-md);
                color: var(--color-muted-foreground);
                line-height: 1.6;
            }

            .actions {
                display: flex;
                gap: var(--spacing-3);
                justify-content: center;
            }
        </style>
        <div class="code">404</div>
        <h1 class="title">페이지를 찾을 수 없습니다 !</h1>
        <p class="description">
            요청하신 페이지가 존재하지 않거나<br />
            주소가 변경되었을 수 있습니다.
        </p>
        <div class="actions">
            <a href="${ctx}/admin"><button class="btn primary md">홈으로 가기</button></a>
            <button onclick="history.back()" class="btn outline md">이전 페이지</button>
        </div>