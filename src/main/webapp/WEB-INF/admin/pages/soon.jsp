<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <style>
            main {
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                gap: var(--spacing-3);
                text-align: center;
                height: 100%;
            }

            .icon {
                width: 72px;
                height: 72px;
                animation: jelly 0.5s ease-out forwards;
                transform-origin: center;
            }

            @keyframes jelly {
                0% {
                    transform: scale(0.8, 1.2);
                }

                30% {
                    transform: scale(1.15, 0.85);
                }

                55% {
                    transform: scale(0.95, 1.05);
                }

                75% {
                    transform: scale(1.05, 0.95);
                }

                100% {
                    transform: scale(1, 1);
                }
            }

            .title {
                font-size: var(--text-3xl);
                font-weight: 700;
            }

            .description {
                font-size: var(--text-md);
                color: var(--color-muted-foreground);
                line-height: 1.6;
            }
        </style>
        <i data-lucide="rocket" class="icon icon-grad"></i>
        <h1 class="title">페이지 준비중 !</h1>
        <p class="description">
            이 페이지는 아직 생성되지 않았습니다.<br />
            조금만 기다려 주세요!
        </p>

        <script>
            function lucideStrokeGradient({
                selector = "svg.lucide",
                color1 = "#ff3cac",
                color2 = "#784ba0",
                direction = "left-to-right",
            } = {}) {
                document.querySelectorAll(selector).forEach((svg, index) => {
                    if (svg.dataset.strokeGradientMaskApplied) return;
                    svg.dataset.strokeGradientMaskApplied = "true";

                    const uid = "lucide-grad-" + index + "-" + Math.random().toString(36).slice(2, 7);
                    const gradId = uid + "-grad";
                    const maskId = uid + "-mask";

                    const strokeWidth = svg.getAttribute("stroke-width") || svg.style.strokeWidth || 2;
                    const originalContent = svg.innerHTML;

                    const coords = {
                        "left-to-right": { x1: "0", y1: "0", x2: "1", y2: "0" },
                        "right-to-left": { x1: "1", y1: "0", x2: "0", y2: "0" },
                        "top-to-bottom": { x1: "0", y1: "0", x2: "0", y2: "1" },
                        "bottom-to-top": { x1: "0", y1: "1", x2: "0", y2: "0" },
                        "diagonal": { x1: "0", y1: "0", x2: "1", y2: "1" },
                    }[direction] || { x1: "0", y1: "0", x2: "1", y2: "0" };

                    svg.innerHTML =
                        '<defs>' +
                        '<linearGradient id="' + gradId + '" x1="' + coords.x1 + '" y1="' + coords.y1 + '" x2="' + coords.x2 + '" y2="' + coords.y2 + '">' +
                        '<stop offset="0%" stop-color="' + color1 + '" />' +
                        '<stop offset="100%" stop-color="' + color2 + '" />' +
                        '</linearGradient>' +
                        '<mask id="' + maskId + '" maskUnits="userSpaceOnUse">' +
                        '<g fill="none" stroke="white" stroke-width="' + strokeWidth + '" stroke-linecap="round" stroke-linejoin="round">' +
                        originalContent +
                        '</g>' +
                        '</mask>' +
                        '</defs>' +
                        '<rect x="0" y="0" width="100%" height="100%" fill="url(#' + gradId + ')" mask="url(#' + maskId + ')" />';
                });
            }

            document.addEventListener("DOMContentLoaded", () => {
                lucideStrokeGradient({
                    selector: ".icon-grad",
                    color1: "${gradFrom}",
                    color2: "${gradTo}",
                });
            });
        </script>