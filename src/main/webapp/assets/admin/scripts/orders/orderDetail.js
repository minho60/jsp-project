/**
 * 주문 상세 페이지 스크립트
 */

// ─── 초기화 ─────────────────────────────────────

document.addEventListener("DOMContentLoaded", () => {
  initStatusChange();
  initOrderDelete();
  initTimestamps();
  lucide.createIcons();
});

// ─── 주문 상태 변경 ─────────────────────────────────

function initStatusChange() {
  const statusSelect = document.getElementById("status-select");
  const changeBtn = document.getElementById("change-status-btn");

  if (!changeBtn || !statusSelect) return;

  changeBtn.addEventListener("click", () => {
    const newStatus = statusSelect.value;
    const order = window.orderDetail;

    if (!order) return;

    if (newStatus === order.orderState) {
      alert("현재 상태와 동일합니다.");
      return;
    }

    const statusLabel =
      window.OrderStatus?.find?.((s) => s.key === newStatus)?.label ||
      newStatus;
    const confirmed = confirm(
      `주문 #${order.orderNumber}의 상태를 "${statusLabel}"(으)로 변경하시겠습니까?`,
    );

    if (confirmed) {
      const params = new URLSearchParams();
      params.set("action", "updateState");
      params.set("orderNumber", order.orderNumber);
      params.set("orderState", newStatus);

      fetch(window.ctx + "/admin/orders/detail", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
        },
        body: params.toString(),
      })
        .then((res) => res.json())
        .then((data) => {
          alert(data.message);
          if (data.success) location.reload();
        })
        .catch(() => alert("요청 중 오류가 발생했습니다."));
    }
  });
}

// ─── 주문 삭제 ─────────────────────────────────

function initOrderDelete() {
  const deleteBtns = document.querySelectorAll(".btn.sm.destructive");
  deleteBtns.forEach((btn) => {
    if (btn.textContent.includes("주문")) {
      btn.addEventListener("click", () => {
        const order = window.orderDetail;
        if (!order) return;

        if (!confirm(`주문 #${order.orderNumber}을 삭제하시겠습니까?`)) return;

        const params = new URLSearchParams();
        params.set("action", "delete");
        params.set("orderNumber", order.orderNumber);

        fetch(window.ctx + "/admin/orders/detail", {
          method: "POST",
          headers: {
            "Content-Type":
              "application/x-www-form-urlencoded; charset=UTF-8",
          },
          body: params.toString(),
        })
          .then((res) => res.json())
          .then((data) => {
            alert(data.message);
            if (data.success)
              location.href = window.ctx + "/admin/orders";
          })
          .catch(() => alert("요청 중 오류가 발생했습니다."));
      });
    }
  });
}

// ─── 타임스탬프 포맷팅 ─────────────────────────────────

function initTimestamps() {
  const timestampElements = document.querySelectorAll("[data-timestamp]");
  timestampElements.forEach((el) => {
    const raw = el.dataset.timestamp;
    if (!raw) return;

    // 숫자형이면 parseInt, 아니면 DATETIME 문자열 그대로 사용
    const isNumeric = /^\d+$/.test(raw);
    if (isNumeric) {
      const date = new Date(parseInt(raw));
      el.textContent = date.toLocaleDateString("ko-KR", {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
        hour: "2-digit",
        minute: "2-digit",
      });
    } else {
      // DATETIME 문자열 (예: "2026-01-10 14:30:00") → "YYYY-MM-DD HH:mm"
      el.textContent = raw.substring(0, 16);
    }
  });
}
