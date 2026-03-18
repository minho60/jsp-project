package admin.dao;

import java.sql.SQLException;
import java.util.List;

import admin.dto.InquiryDTO;
import util.DBUtil;

/**
 * 1:1 문의 DAO - DB 연동 (qa 테이블)
 */
public class InquiryDAO {

    private static final InquiryDAO INSTANCE = new InquiryDAO();

    private InquiryDAO() {}

    public static InquiryDAO getInstance() { return INSTANCE; }

    /** qa + members 조인 → InquiryDTO RowMapper (목록용) */
    private static final util.RowMapper<InquiryDTO> LIST_MAPPER = rs -> {
        InquiryDTO dto = new InquiryDTO();
        dto.setQaNum(rs.getLong("qa_num"));
        dto.setType(rs.getString("type"));
        dto.setTitle(rs.getString("title"));
        dto.setStatus(rs.getString("status"));
        dto.setCreatedAt(rs.getString("created_at"));

        long userNum = rs.getLong("user_num");
        dto.setUserNum(rs.wasNull() ? null : userNum);

        dto.setWriterName(rs.getString("writer_name"));
        dto.setWriterEmail(rs.getString("writer_email"));
        dto.setWriterType(rs.getString("writer_type"));
        return dto;
    };

    /** qa 단건 RowMapper (상세용) */
    private static final util.RowMapper<InquiryDTO> DETAIL_MAPPER = rs -> {
        InquiryDTO dto = new InquiryDTO();
        dto.setQaNum(rs.getLong("qa_num"));
        dto.setType(rs.getString("type"));
        dto.setTitle(rs.getString("title"));
        dto.setContent(rs.getString("content"));

        long userNum = rs.getLong("user_num");
        dto.setUserNum(rs.wasNull() ? null : userNum);

        dto.setGuestName(rs.getString("guest_name"));
        dto.setGuestEmail(rs.getString("guest_email"));

        dto.setStatus(rs.getString("status"));
        dto.setAnswer(rs.getString("answer"));
        dto.setAnsweredAt(rs.getString("answered_at"));
        dto.setCreatedAt(rs.getString("created_at"));
        dto.setUpdatedAt(rs.getString("updated_at"));
        return dto;
    };

    /**
     * 전체 문의 목록 (관리자용, 회원/비회원 모두 표시)
     * qa.sql의 "전체 문의 목록 (관리자용)" 쿼리 사용
     */
    public List<InquiryDTO> getAllWithUser() throws SQLException {
        String sql = "SELECT q.qa_num, q.type, q.title, q.status, q.created_at, q.user_num, "
                   + "CASE WHEN q.user_num IS NOT NULL THEN m.id        ELSE q.guest_name  END AS writer_name, "
                   + "CASE WHEN q.user_num IS NOT NULL THEN m.email     ELSE q.guest_email END AS writer_email, "
                   + "CASE WHEN q.user_num IS NOT NULL THEN '회원'      ELSE '비회원'      END AS writer_type "
                   + "FROM qa q "
                   + "LEFT JOIN members m ON q.user_num = m.user_num "
                   + "ORDER BY q.created_at DESC";
        return DBUtil.executeQuery(sql, null, LIST_MAPPER);
    }

    /**
     * 문의번호로 상세 조회 (회원 정보 조인)
     */
    public InquiryDTO findByQaNum(long qaNum) throws SQLException {
        String sql = "SELECT q.qa_num, q.type, q.title, q.content, q.user_num, "
                   + "q.guest_name, q.guest_email, "
                   + "q.status, q.answer, q.answered_at, q.created_at, q.updated_at "
                   + "FROM qa q WHERE q.qa_num = ?";
        List<InquiryDTO> list = DBUtil.executeQuery(sql, ps -> {
            ps.setLong(1, qaNum);
        }, DETAIL_MAPPER);
        if (list.isEmpty()) return null;

        InquiryDTO dto = list.get(0);
        enrichWithUser(dto);
        return dto;
    }

    /**
     * 회원/비회원 정보를 조인하여 enriched 필드 채우기
     */
    private void enrichWithUser(InquiryDTO dto) throws SQLException {
        admin.util.MaskUtil mu = new admin.util.MaskUtil();

        if (dto.getUserNum() != null) {
            // 회원 문의
            admin.dto.UserDTO user = UserDAO.getInstance().findByUserNumber(dto.getUserNum());
            dto.setWriterName(user != null ? user.getUserName() : "알 수 없음");
            dto.setWriterEmail(mu.maskEmail(user != null ? user.getEmail() : ""));
            dto.setPhone(mu.maskPhoneNumber(user != null ? user.getPhoneNumber() : ""));
            dto.setWriterType("회원");
        } else {
            // 비회원 문의
            dto.setWriterName(dto.getGuestName() != null ? dto.getGuestName() : "비회원");
            dto.setWriterEmail(mu.maskEmail(dto.getGuestEmail() != null ? dto.getGuestEmail() : ""));
            dto.setPhone("");
            dto.setWriterType("비회원");
        }
    }

    /**
     * 답변대기 건수
     */
    public int countWaiting() throws SQLException {
        String sql = "SELECT COUNT(*) AS waiting_count FROM qa WHERE status = 'WAITING'";
        List<Integer> list = DBUtil.executeQuery(sql, null, rs -> rs.getInt("waiting_count"));
        return list.isEmpty() ? 0 : list.get(0);
    }

    /**
     * 문의 상태별 건수 (대시보드용)
     */
    public int countByStatus(String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM qa WHERE status = ?";
        List<Integer> list = DBUtil.executeQuery(sql, ps -> {
            ps.setString(1, status);
        }, rs -> rs.getInt(1));
        return list.isEmpty() ? 0 : list.get(0);
    }

    /**
     * 전체 문의 건수
     */
    public int countAll() throws SQLException {
        String sql = "SELECT COUNT(*) FROM qa";
        List<Integer> list = DBUtil.executeQuery(sql, null, rs -> rs.getInt(1));
        return list.isEmpty() ? 0 : list.get(0);
    }

    /**
     * 답변 등록/수정
     */
    public boolean saveAnswer(long qaNum, String answer) throws SQLException {
        String sql = "UPDATE qa SET answer = ?, status = 'ANSWERED', answered_at = NOW() WHERE qa_num = ?";
        int rows = DBUtil.executeUpdate(sql, ps -> {
            ps.setString(1, answer);
            ps.setLong(2, qaNum);
        });
        return rows > 0;
    }

    /**
     * 문의 삭제
     */
    public boolean delete(long qaNum) throws SQLException {
        String sql = "DELETE FROM qa WHERE qa_num = ?";
        int rows = DBUtil.executeUpdate(sql, ps -> {
            ps.setLong(1, qaNum);
        });
        return rows > 0;
    }
}
