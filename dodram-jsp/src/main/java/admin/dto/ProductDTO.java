package admin.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 상품 정보를 담는 DTO (products 테이블과 매핑)
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductDTO {

    // 상품 상태 enum
    public enum Status {
        ACTIVE("판매중"),
        INACTIVE("판매중지"),
        SOLD_OUT("품절"),
        DISCONTINUED("단종");

        private final String label;

        Status(String label) { this.label = label; }

        public String getKey() { return name(); }
        public String getLabel() { return label; }
    }

    private long productNumber;    // product_num (BIGINT)
    private int categoryNumber;    // category_num
    private String name;           // name
    private String description;    // description
    private int price;             // price
    private String status;         // status (Status enum의 name() 값)
    private String thumbnailImage; // thumbnail_image
    private String origin;         // origin
    private int weight;            // weight
    private List<String> detailImages; // product_images 테이블에서 조인
    private String createdAt;      // created_at (DATETIME → String)
    private String updatedAt;      // updated_at (DATETIME → String)

    /** 상태 키에 해당하는 한글 라벨 */
    public String getStatusLabel() {
        try {
            return Status.valueOf(status).getLabel();
        } catch (Exception e) {
            return status;
        }
    }
}
