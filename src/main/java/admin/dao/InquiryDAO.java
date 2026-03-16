package admin.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

import admin.dto.InquiryDTO;
import admin.dto.UserDTO;

/**
 * 문의 DAO
 */
public class InquiryDAO {

    private static final InquiryDAO INSTANCE = new InquiryDAO();
    private final List<InquiryDTO> inquiryList = new ArrayList<>();

    private InquiryDAO() {
        addInquiry(1, "PRODUCT", "삼겹살 신선도 관련 문의드립니다",
                "안녕하세요. 지난주에 구매한 THE짙은 삼겹살 400g이요.\n\n배송 받았을 때 포장 상태가 조금 이상했는데,\n제품 품질에는 문제가 없을까요?\n\n확인 부탁드립니다.",
                2, "WAITING", getRandomDate(0), null, null);
        addInquiry(2, "DELIVERY", "배송일 변경 요청합니다",
                "주문번호 2026012512345입니다.\n\n원래 26일 배송 예정인데, 27일로 변경 가능할까요?\n집에 아무도 없어서요.\n\n연락처: 010-9876-5432",
                3, "WAITING", getRandomDate(1), null, null);
        addInquiry(3, "EXCHANGE", "교환 신청합니다",
                "안녕하세요.\n\n1월 20일에 받은 목살 400g 제품인데요,\n진공포장이 풀려서 상태가 안좋습니다.\n\n교환 가능할까요?\n사진 첨부합니다.",
                4, "ANSWERED", getRandomDate(3),
                "안녕하세요, 도드람몰입니다.\n\n불편을 드려 죄송합니다.\n교환 절차 안내드리겠습니다.\n\n수거 후 새 제품으로 재발송 예정이며,\n수거 일정은 별도 문자로 안내드리겠습니다.\n\n감사합니다.",
                getRandomDate(2));
        addInquiry(4, "PAYMENT", "결제 오류 문의",
                "카드 결제 시 오류가 발생했는데\n금액이 이중 결제된 것 같습니다.\n\n확인 부탁드립니다.\n\n카드사: 삼성카드\n결제일시: 2026-01-23 14:32",
                5, "ANSWERED", getRandomDate(4),
                "안녕하세요, 도드람몰입니다.\n\n확인 결과 이중결제 건 맞습니다.\n해당 금액은 3-5영업일 내 자동 환불됩니다.\n\n불편을 드려 죄송합니다.\n\n감사합니다.",
                getRandomDate(3));
        addInquiry(5, "ETC", "레시피 문의드려요",
                "THE짙은 삼겹살로 만들 수 있는\n간단한 요리 레시피 추천 부탁드려요!\n\n구이 말고 다른 요리도 해보고 싶어서요.",
                6, "WAITING", getRandomDate(1), null, null);
        addInquiry(6, "PRODUCT", "냉동삼겹살 해동방법 문의",
                "냉동 삼겹살 구매했는데요,\n해동은 어떻게 하는게 좋을까요?\n\n냉장 해동이 좋은지,\n상온 해동이 좋은지 알려주세요.",
                7, "ANSWERED", getRandomDate(5),
                "안녕하세요, 도드람몰입니다.\n\n냉동 삼겹살은 냉장실에서 천천히 해동하시는 것이 좋습니다.\n(약 12-24시간 소요)\n\n급하신 경우 흐르는 물에 밀봉된 상태로 해동하시면 됩니다.\n상온 해동은 육즙 손실이 있어 추천드리지 않습니다.\n\n맛있게 드세요!",
                getRandomDate(4));
        addInquiry(7, "DELIVERY", "배송 조회가 안됩니다",
                "어제 주문했는데 배송조회가 안되네요.\n\n주문번호: 2026012400123\n\n확인 부탁드립니다.",
                8, "WAITING", getRandomDate(0), null, null);
        addInquiry(8, "PRODUCT", "대량주문 할인 문의",
                "행사용으로 삼겹살 50팩 정도 주문하려고 하는데요,\n대량주문 할인 가능할까요?\n\n연락처: 010-1111-2222\n회사명: OO기업",
                9, "ANSWERED", getRandomDate(7),
                "안녕하세요, 도드람몰입니다.\n\n대량주문 관련 안내드립니다.\n30팩 이상 주문 시 10% 할인이 적용됩니다.\n\n자세한 내용은 고객센터(1588-0000)로 연락주시면\n상세히 안내드리겠습니다.\n\n감사합니다.",
                getRandomDate(6));
        addInquiry(9, "EXCHANGE", "반품 요청드립니다",
                "변심으로 반품 요청드립니다.\n미개봉 상태이고 내일까지 수거 가능합니다.\n\n주문번호: 2026012000789",
                10, "WAITING", getRandomDate(2), null, null);
        addInquiry(10, "PAYMENT", "카드 할부 가능한가요?",
                "5만원 이상 결제 시 무이자 할부 가능한지 궁금합니다.\n\n신한카드 사용 예정입니다.",
                11, "ANSWERED", getRandomDate(10),
                "안녕하세요, 도드람몰입니다.\n\n현재 5만원 이상 결제 시\n신한/삼성/현대카드는 2-3개월 무이자 할부 가능합니다.\n\n결제 시 할부 옵션에서 선택하실 수 있습니다.\n\n감사합니다.",
                getRandomDate(9));
    }

    public static InquiryDAO getInstance() { return INSTANCE; }

    private void addInquiry(int num, String type, String title, String content,
                            int userNumber, String status, long createdAt,
                            String answer, Long answeredAt) {
        InquiryDTO dto = new InquiryDTO();
        dto.setInquiryNumber(num);
        dto.setType(type);
        dto.setTitle(title);
        dto.setContent(content);
        dto.setUserNumber(userNumber);
        dto.setStatus(status);
        dto.setCreatedAt(createdAt);
        dto.setAnswer(answer);
        dto.setAnsweredAt(answeredAt);
        inquiryList.add(dto);
    }

    private static long getRandomDate(int daysAgo) {
        Random rng = new Random(daysAgo * 31L + 7);
        long now = System.currentTimeMillis();
        long dayMs = 24L * 60 * 60 * 1000;
        long base = now - daysAgo * dayMs;
        return base - rng.nextInt(24 * 60 * 60) * 1000L;
    }

    public List<InquiryDTO> getAll() {
        return Collections.unmodifiableList(inquiryList);
    }

    public InquiryDTO findByInquiryNumber(int num) {
        return inquiryList.stream()
                .filter(i -> i.getInquiryNumber() == num)
                .findFirst().orElse(null);
    }

    public int countWaiting() {
        return (int) inquiryList.stream()
                .filter(i -> "WAITING".equals(i.getStatus()))
                .count();
    }

    /** 유저 정보를 조인한 목록 */
    public List<InquiryDTO> getAllWithUser() {
        UserDAO ud = UserDAO.getInstance();
        admin.util.MaskUtil mu = new admin.util.MaskUtil();
        List<InquiryDTO> result = new ArrayList<>();

        for (InquiryDTO inq : inquiryList) {
            InquiryDTO joined = copyInquiry(inq);
            UserDTO user = null;
            try {
                user = ud.findByUserNumber(inq.getUserNumber());
            } catch (SQLException e) {
                e.printStackTrace();
            }

            joined.setUserName(user != null ? user.getUserName() : "알 수 없음");
            joined.setEmail(mu.maskEmail(user != null ? user.getEmail() : ""));
            joined.setPhone(mu.maskPhoneNumber(user != null ? user.getPhoneNumber() : ""));
            result.add(joined);
        }
        return result;
    }

    /** 단일 문의에 유저 조인 */
    public InquiryDTO findWithUser(int inquiryNumber) {
        InquiryDTO inq = findByInquiryNumber(inquiryNumber);
        if (inq == null) return null;

        UserDAO ud = UserDAO.getInstance();
        admin.util.MaskUtil mu = new admin.util.MaskUtil();

        InquiryDTO joined = copyInquiry(inq);
        UserDTO user = null;
        try {
            user = ud.findByUserNumber(inq.getUserNumber());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        joined.setUserName(user != null ? user.getUserName() : "알 수 없음");
        joined.setEmail(mu.maskEmail(user != null ? user.getEmail() : ""));
        joined.setPhone(mu.maskPhoneNumber(user != null ? user.getPhoneNumber() : ""));
        return joined;
    }

    private InquiryDTO copyInquiry(InquiryDTO src) {
        InquiryDTO copy = new InquiryDTO();
        copy.setInquiryNumber(src.getInquiryNumber());
        copy.setType(src.getType());
        copy.setTitle(src.getTitle());
        copy.setContent(src.getContent());
        copy.setUserNumber(src.getUserNumber());
        copy.setStatus(src.getStatus());
        copy.setCreatedAt(src.getCreatedAt());
        copy.setAnswer(src.getAnswer());
        copy.setAnsweredAt(src.getAnsweredAt());
        return copy;
    }

    /** 답변 등록/수정 */
    public boolean saveAnswer(int inquiryNumber, String answer) {
        InquiryDTO inq = findByInquiryNumber(inquiryNumber);
        if (inq == null) return false;
        inq.setAnswer(answer);
        inq.setStatus("ANSWERED");
        inq.setAnsweredAt(System.currentTimeMillis());
        return true;
    }
}
