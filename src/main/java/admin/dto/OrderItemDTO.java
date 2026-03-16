package admin.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 주문 항목 (주문 1건에 포함되는 개별 상품) DTO (order_items 테이블과 매핑)
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OrderItemDTO {

    private long productNumber;  // product_num (BIGINT)
    private int quantity;        // quantity
    private int unitPrice;       // unit_price (주문 시점 단가 스냅샷)

    // --- enriched 필드 (상품 조인 후 채워짐) ---
    private String productName;
    private int price;           // 현재 상품 가격 (products 조인)
    private int subtotal;        // unitPrice × quantity
    private String thumbnailImage;
    private String origin;
    private int weight;

    /** productNumber, quantity, unitPrice만 세팅하는 생성자 */
    public OrderItemDTO(long productNumber, int quantity, int unitPrice) {
        this.productNumber = productNumber;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }
}
