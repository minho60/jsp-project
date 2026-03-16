<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="stylesheet" href="${resPath}/admin/styles/dashboard.css" />
        <div class="dashboard">
            <div style="display: flex; justify-content: space-between; margin-bottom: var(--spacing-6);">
                <div class="badge amber"
                    style="width: 100%; white-space: unset; padding: var(--spacing-2); border-radius: var(--radius-2);">
                    본 화면은 시각적 이해를 돕기 위해 연출된 데이터를 사용하고 있습니다.</div>
            </div>
            <!-- 상단 요약 카드 4개 -->
            <div class="dashboard-items grid-cols-4 xl:grid-cols-2 md:grid-cols-1">
                <div class="card">
                    <div class="card-header"><span>오늘 매출</span></div>
                    <div class="card-content">
                        <h2>16,777,216원</h2>
                        <p class="card-trend trend-up">+12.5%</p>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header"><span>오늘 주문</span></div>
                    <div class="card-content">
                        <h2>384건</h2>
                        <p class="card-trend trend-up">+8.2%</p>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header"><span>신규 회원</span></div>
                    <div class="card-content">
                        <h2>47명</h2>
                        <p class="card-trend trend-down">-3.1%</p>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header"><span>총 회원 수</span></div>
                    <div class="card-content">
                        <h2>32,768명</h2>
                        <p class="card-trend trend-neutral">+0.1%</p>
                    </div>
                </div>
            </div>

            <!-- 중단 차트 + 배송현황 -->
            <div class="dashboard-items grid-cols-5 xl:grid-cols-1">
                <div class="card grid-colspan-3 xl:grid-colspan-5">
                    <div class="card-header"><span>주간 매출 추이</span></div>
                    <div class="card-content"
                        style="position: relative; flex: 1; min-height: 0; overflow: hidden; padding: 10px 10px 0 10px;">
                        <canvas id="weeklySalesChart"></canvas>
                    </div>
                </div>
                <div class="card grid-colspan-2 xl:grid-colspan-5">
                    <div class="card-header">
                        <span>배송 현황</span>
                        <span class="shipping-total">총 1,424건</span>
                    </div>
                    <div class="card-content">
                        <div class="shipping-status-wrapper">
                            <div class="shipping-chart">
                                <canvas id="shippingDonutChart" width="140" height="140"></canvas>
                                <div class="shipping-chart-center">
                                    <span class="chart-center-value">72%</span>
                                    <span class="chart-center-label">완료율</span>
                                </div>
                            </div>
                            <div class="status-list-progress">
                                <div class="status-progress-item">
                                    <div class="status-progress-header">
                                        <span class="status-dot preparing"></span>
                                        <span class="status-label">배송 준비</span>
                                        <span class="status-value">128건</span>
                                    </div>
                                    <div class="status-progress-bar">
                                        <div class="status-progress-fill preparing" style="width: 9%"></div>
                                    </div>
                                </div>
                                <div class="status-progress-item">
                                    <div class="status-progress-header">
                                        <span class="status-dot shipping"></span>
                                        <span class="status-label">배송 중</span>
                                        <span class="status-value">256건</span>
                                    </div>
                                    <div class="status-progress-bar">
                                        <div class="status-progress-fill shipping" style="width: 18%"></div>
                                    </div>
                                </div>
                                <div class="status-progress-item">
                                    <div class="status-progress-header">
                                        <span class="status-dot delivered"></span>
                                        <span class="status-label">배송 완료</span>
                                        <span class="status-value">1,024건</span>
                                    </div>
                                    <div class="status-progress-bar">
                                        <div class="status-progress-fill delivered" style="width: 72%"></div>
                                    </div>
                                </div>
                                <div class="status-progress-item">
                                    <div class="status-progress-header">
                                        <span class="status-dot cancelled"></span>
                                        <span class="status-label">취소/반품</span>
                                        <span class="status-value">16건</span>
                                    </div>
                                    <div class="status-progress-bar">
                                        <div class="status-progress-fill cancelled" style="width: 1%"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="shipping-mini-cards">
                            <div class="mini-stat-card">
                                <span class="mini-stat-label">전일 대비</span>
                                <div class="mini-stat-content">
                                    <span class="mini-stat-value">+12.5%</span>
                                    <span class="mini-stat-trend up">▲</span>
                                </div>
                            </div>
                            <div class="mini-stat-card">
                                <span class="mini-stat-label">평균 배송</span>
                                <div class="mini-stat-content">
                                    <span class="mini-stat-value">1.2일</span>
                                    <span class="mini-stat-trend neutral">-</span>
                                </div>
                            </div>
                            <div class="mini-stat-card">
                                <span class="mini-stat-label">반품률</span>
                                <div class="mini-stat-content">
                                    <span class="mini-stat-value">1.1%</span>
                                    <span class="mini-stat-trend down">▼</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 하단 최근 주문 + 베스트셀러 -->
            <div class="dashboard-items grid-cols-2 xl:grid-cols-1">
                <div class="card">
                    <div class="card-header">
                        <span>최근 주문</span>
                        <a href="${ctx}/admin/orders" class="card-link">전체보기</a>
                    </div>
                    <div class="card-content">
                        <div class="order-list">
                            <div class="order-item">
                                <div class="order-info"><span class="order-id">4</span><span class="order-product">상품
                                        이름</span></div>
                                <span class="order-price">45,000원</span>
                            </div>
                            <div class="order-item">
                                <div class="order-info"><span class="order-id">3</span><span class="order-product">상품
                                        이름</span></div>
                                <span class="order-price">89,000원</span>
                            </div>
                            <div class="order-item">
                                <div class="order-info"><span class="order-id">2</span><span class="order-product">상품
                                        이름</span></div>
                                <span class="order-price">198,000원</span>
                            </div>
                            <div class="order-item">
                                <div class="order-info"><span class="order-id">1</span><span class="order-product">상품
                                        이름</span></div>
                                <span class="order-price">32,000원</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header"><span>베스트셀러 TOP 5</span></div>
                    <div class="card-content">
                        <div class="bestseller-list">
                            <div class="bestseller-item"><span class="bestseller-rank">1</span><span
                                    class="bestseller-name">상품 이름</span><span class="bestseller-sales">1,248개</span>
                            </div>
                            <div class="bestseller-item"><span class="bestseller-rank">2</span><span
                                    class="bestseller-name">상품 이름</span><span class="bestseller-sales">987개</span></div>
                            <div class="bestseller-item"><span class="bestseller-rank">3</span><span
                                    class="bestseller-name">상품 이름</span><span class="bestseller-sales">654개</span></div>
                            <div class="bestseller-item"><span class="bestseller-rank">4</span><span
                                    class="bestseller-name">상품 이름</span><span class="bestseller-sales">432개</span></div>
                            <div class="bestseller-item"><span class="bestseller-rank">5</span><span
                                    class="bestseller-name">상품 이름</span><span class="bestseller-sales">321개</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var canvas = document.getElementById('weeklySalesChart');
                var ctx = canvas.getContext('2d');

                function getCssVar(name) {
                    var varName = name.startsWith('--') ? name : '--' + name;
                    return getComputedStyle(document.documentElement).getPropertyValue(varName).trim();
                }

                function getThemeColors() {
                    var isDark = document.documentElement.getAttribute('data-theme') === 'dark';
                    return {
                        primary: getCssVar('color-blue-500'),
                        gridColor: isDark ? getCssVar('color-gray-800') : getCssVar('color-gray-200'),
                        textColor: getCssVar('color-gray-500'),
                        pointBg: isDark ? getCssVar('color-gray-900') : getCssVar('color-gray-0'),
                        tooltipBg: isDark ? getCssVar('color-gray-900') : getCssVar('color-gray-0'),
                        tooltipText: isDark ? getCssVar('color-gray-50') : getCssVar('color-gray-900'),
                        amber: getCssVar('color-amber-500'),
                        blue: getCssVar('color-blue-500'),
                        green: getCssVar('color-green-500'),
                        red: getCssVar('color-red-500')
                    };
                }

                var colors = getThemeColors();

                function withAlpha(oklchColor, alpha) {
                    var match = oklchColor.match(/oklch\((.+)\)/);
                    if (match) return 'oklch(' + match[1] + ' / ' + alpha + ')';
                    return oklchColor;
                }

                function createGradient(opacity) {
                    var gradient = ctx.createLinearGradient(0, 0, 0, 400);
                    gradient.addColorStop(0, withAlpha(colors.primary, opacity || 0.5));
                    gradient.addColorStop(1, withAlpha(colors.primary, 0));
                    return gradient;
                }

                var weeklySalesChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: ['월', '화', '수', '목', '금', '토', '일'],
                        datasets: [{
                            label: '주간 매출',
                            data: [1200000, 1900000, 1500000, 2100000, 2800000, 2400000, 1800000],
                            borderColor: colors.primary,
                            backgroundColor: createGradient(0.5),
                            borderWidth: 2, tension: 0.4,
                            pointBackgroundColor: colors.pointBg,
                            pointBorderColor: colors.primary,
                            pointBorderWidth: 2, pointRadius: 4, pointHoverRadius: 6,
                            fill: true
                        }]
                    },
                    options: {
                        responsive: true, maintainAspectRatio: false,
                        plugins: {
                            legend: { display: false }, tooltip: {
                                mode: 'index', intersect: false,
                                backgroundColor: colors.tooltipBg, titleColor: colors.tooltipText,
                                bodyColor: colors.tooltipText, borderColor: colors.gridColor,
                                borderWidth: 1, padding: 10, displayColors: false,
                                callbacks: {
                                    label: function (context) {
                                        var label = context.dataset.label || '';
                                        if (label) label += ': ';
                                        if (context.parsed.y !== null) label += new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(context.parsed.y);
                                        return label;
                                    }
                                }
                            }
                        },
                        layout: { padding: { left: 0, right: 0, top: 10, bottom: 0 } },
                        scales: {
                            x: { grid: { display: false, drawBorder: false }, ticks: { color: colors.textColor, padding: 5 } },
                            y: { grid: { color: colors.gridColor, borderDash: [5, 5], drawBorder: false, tickLength: 0 }, ticks: { color: colors.textColor, padding: 10, callback: function (v) { return v / 10000 + '만'; } }, beginAtZero: true }
                        },
                        interaction: { mode: 'nearest', axis: 'x', intersect: false }
                    }
                });

                function updateChartColors() {
                    var colors = getThemeColors();
                    var isDark = document.documentElement.getAttribute('data-theme') === 'dark';
                    var opacity = isDark ? 0.3 : 0.5;
                    var newGradient = ctx.createLinearGradient(0, 0, 0, 400);
                    newGradient.addColorStop(0, withAlpha(colors.primary, opacity));
                    newGradient.addColorStop(1, withAlpha(colors.primary, 0));
                    var ds = weeklySalesChart.data.datasets[0];
                    ds.borderColor = colors.primary;
                    ds.backgroundColor = newGradient;
                    ds.pointBackgroundColor = Array(ds.data.length).fill(colors.pointBg);
                    ds.pointBorderColor = colors.primary;
                    weeklySalesChart.options.plugins.tooltip.backgroundColor = colors.tooltipBg;
                    weeklySalesChart.options.plugins.tooltip.titleColor = colors.tooltipText;
                    weeklySalesChart.options.plugins.tooltip.bodyColor = colors.tooltipText;
                    weeklySalesChart.options.plugins.tooltip.borderColor = colors.gridColor;
                    weeklySalesChart.options.scales.x.ticks.color = colors.textColor;
                    weeklySalesChart.options.scales.y.grid.color = colors.gridColor;
                    weeklySalesChart.options.scales.y.ticks.color = colors.textColor;
                    weeklySalesChart.update();
                }

                var donutCanvas = document.getElementById('shippingDonutChart');
                if (donutCanvas) {
                    new Chart(donutCanvas.getContext('2d'), {
                        type: 'doughnut',
                        data: { labels: ['배송 준비', '배송 중', '배송 완료', '취소/반품'], datasets: [{ data: [128, 256, 1024, 16], backgroundColor: [colors.amber, colors.blue, colors.green, colors.red], borderWidth: 0, cutout: '70%' }] },
                        options: { responsive: true, maintainAspectRatio: true, plugins: { legend: { display: false }, tooltip: { enabled: false } } }
                    });
                }

                new MutationObserver(function (mutations) {
                    mutations.forEach(function (m) { if (m.attributeName === 'data-theme') updateChartColors(); });
                }).observe(document.documentElement, { attributes: true, attributeFilter: ['data-theme'] });
            });
        </script>