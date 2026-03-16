package admin.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 문의 정보를 담는 DTO
 */
@Getter
@Setter
@NoArgsConstructor
public class InquiryDTO {

    // 문의 상태 enum
    public enum Status {
        WAITING("답변대기"),
        ANSWERED("답변완료");

        private final String label;

        Status(String label) { this.label = label; }

        public String getKey() { return name(); }
        public String getLabel() { return label; }

        /** 배지 색상 */
        public String getColor() {
            return this == WAITING ? "warning" : "success";
        }
    }

    // 문의 유형 enum
    public enum Type {
        PRODUCT("상품문의"),
        DELIVERY("배송문의"),
        EXCHANGE("교환/반품"),
        PAYMENT("결제문의"),
        ETC("기타");

        private final String label;

        Type(String label) { this.label = label; }

        public String getKey() { return name(); }
        public String getLabel() { return label; }

        /** 유형별 배지 색상 */
        public String getColor() {
            switch (this) {
                case PRODUCT:  return "primary";
                case DELIVERY: return "info";
                case EXCHANGE: return "danger";
                case PAYMENT:  return "warning";
                default:       return "secondary";
            }
        }
    }

    private int inquiryNumber;
    private String type; // Type enum의 name() 값
    private String title;
    private String content;
    private int userNumber;
    private String status; // Status enum의 name() 값
    private long createdAt;
    private String answer;
    private Long answeredAt;

    // --- enriched 필드 (유저 조인 후 채워짐) ---
    private String userName;
    private String email;
    private String phone;

    /** 상태 한글 라벨 */
    public String getStatusLabel() {
        try {
            return Status.valueOf(status).getLabel();
        } catch (Exception e) {
            return status;
        }
    }

    /** 상태 배지 색상 */
    public String getStatusColor() {
        try {
            return Status.valueOf(status).getColor();
        } catch (Exception e) {
            return "secondary";
        }
    }

    /** 유형 한글 라벨 */
    public String getTypeLabel() {
        try {
            return Type.valueOf(type).getLabel();
        } catch (Exception e) {
            return type;
        }
    }

    /** 유형 배지 색상 */
    public String getTypeColor() {
        try {
            return Type.valueOf(type).getColor();
        } catch (Exception e) {
            return "secondary";
        }
    }
}
