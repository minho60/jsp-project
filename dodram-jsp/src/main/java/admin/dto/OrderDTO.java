package admin.dto;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 주문 정보를 담는 DTO (orders 테이블과 매핑)
 */
@Getter
@Setter
@NoArgsConstructor
public class OrderDTO {

    // 주문 상태 enum
    public enum State {
        PAYMENT_PENDING("결제대기"),
        PREPARING_PRODUCT("상품준비중"),
        SHIPPING_PENDING("배송대기"),
        SHIPPING_IN_PROGRESS("배송중"),
        DELIVERED("배송완료"),
        CANCEL_REQUESTED("취소접수"),
        CANCELLING("취소중"),
        CANCELLED("취소완료"),
        RETURN_REQUESTED("반품요청"),
        RETURN_PICKUP_IN_PROGRESS("반품수거중"),
        RETURNED("반품완료");

        private final String label;

        State(String label) { this.label = label; }

        public String getKey() { return name(); }
        public String getLabel() { return label; }
    }

    private long orderNumber;    // order_num (BIGINT)
    private String orderDate;    // order_date (DATE → String)
    private String orderState;   // order_state

    // 주문자 정보
    private String ordererName;
    private String ordererPhone;
    private String ordererEmail;

    // 수령인 정보
    private String receiverName;
    private String receiverPhone;
    private String receiverAddress;

    // 주문 항목
    private List<OrderItemDTO> items;

    // --- enriched 필드 ---
    private String orderName;
    private int totalQuantity;
    private int totalAmount;

    /** 상태 키에 해당하는 한글 라벨 */
    public String getOrderStateLabel() {
        try {
            return State.valueOf(orderState).getLabel();
        } catch (Exception e) {
            return orderState;
        }
    }
}
