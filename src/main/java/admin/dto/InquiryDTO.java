package admin.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 1:1 문의 정보를 담는 DTO (qa 테이블과 매핑)
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
            return this == WAITING ? "amber" : "emerald";
        }
    }

    // 문의 유형 enum (7종 — qa.sql 기준)
    public enum Type {
        MEMBER("회원/정보관리"),
        ORDER("주문/결제"),
        DELIVERY("배송"),
        REFUND("반품/환불/교환/AS"),
        RECEIPT("영수증/증빙서류"),
        EVENT("상품/이벤트"),
        ETC("기타");

        private final String label;

        Type(String label) { this.label = label; }

        public String getKey() { return name(); }
        public String getLabel() { return label; }

        /** 유형별 배지 색상 */
        public String getColor() {
            switch (this) {
                case MEMBER:   return "blue";
                case ORDER:    return "violet";
                case DELIVERY: return "teal";
                case REFUND:   return "orange";
                case RECEIPT:  return "slate";
                case EVENT:    return "pink";
                default:       return "gray";
            }
        }
    }

    // --- 기본 필드 (qa 테이블) ---
    private long qaNum;           // qa_num (PK)
    private String type;          // Type enum의 name()
    private String title;
    private String content;

    // 회원 정보
    private Long userNum;         // 회원이면 FK, 비회원이면 null

    // 비회원 정보
    private String guestName;
    private String guestEmail;

    // 상태/답변
    private String status;        // Status enum의 name()
    private String answer;
    private String answeredAt;    // DATETIME → String
    private String createdAt;     // DATETIME → String
    private String updatedAt;     // DATETIME → String

    // --- enriched 필드 (유저 조인 후 채워짐) ---
    private String writerName;    // 회원 id 또는 비회원 guest_name
    private String writerEmail;   // 회원 email 또는 비회원 guest_email
    private String writerType;    // "회원" 또는 "비회원"
    private String phone;         // 회원인 경우 전화번호

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
            return "gray";
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
            return "gray";
        }
    }
}
