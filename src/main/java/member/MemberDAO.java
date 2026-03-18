package member;

import java.sql.SQLException;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import util.DBUtil;

/**
 * 쇼핑몰 회원 DAO - 실제 DB 연동 (members 테이블)
 */
public class MemberDAO {

    private static final MemberDAO INSTANCE = new MemberDAO();

    private MemberDAO() {}

    public static MemberDAO getInstance() {
        return INSTANCE;
    }

    /**
     * 회원가입 - 비밀번호는 BCrypt 해싱 후 저장
     */
    public boolean insert(MemberDTO member) throws SQLException {
        String hashedPw = BCrypt.hashpw(member.getPw(), BCrypt.gensalt());

        String sql = "INSERT INTO members (id, pw, name, phone, email) VALUES (?, ?, ?, ?, ?)";
        int rows = DBUtil.executeUpdate(sql, ps -> {
            ps.setString(1, member.getId());
            ps.setString(2, hashedPw);
            ps.setString(3, member.getName());
            ps.setString(4, member.getPhone());
            ps.setString(5, member.getEmail());
        });
        return rows > 0;
    }

    /**
     * 아이디로 회원 조회
     */
    public MemberDTO findById(String id) throws SQLException {
        String sql = "SELECT user_num, id, pw, name, phone, email, created_at FROM members WHERE id = ?";
        List<MemberDTO> list = DBUtil.executeQuery(sql, ps -> {
            ps.setString(1, id);
        }, rs -> {
            MemberDTO m = new MemberDTO();
            m.setUserNum(rs.getLong("user_num"));
            m.setId(rs.getString("id"));
            m.setPw(rs.getString("pw"));
            m.setName(rs.getString("name"));
            m.setPhone(rs.getString("phone"));
            m.setEmail(rs.getString("email"));
            m.setCreatedAt(rs.getString("created_at"));
            return m;
        });
        return list.isEmpty() ? null : list.get(0);
    }

    /**
     * 이메일로 회원 조회
     */
    public MemberDTO findByEmail(String email) throws SQLException {
        String sql = "SELECT user_num, id, pw, name, phone, email, created_at FROM members WHERE email = ?";
        List<MemberDTO> list = DBUtil.executeQuery(sql, ps -> {
            ps.setString(1, email);
        }, rs -> {
            MemberDTO m = new MemberDTO();
            m.setUserNum(rs.getLong("user_num"));
            m.setId(rs.getString("id"));
            m.setPw(rs.getString("pw"));
            m.setName(rs.getString("name"));
            m.setPhone(rs.getString("phone"));
            m.setEmail(rs.getString("email"));
            m.setCreatedAt(rs.getString("created_at"));
            return m;
        });
        return list.isEmpty() ? null : list.get(0);
    }

    /**
     * 로그인 검증 - BCrypt로 비밀번호 비교
     * @return 로그인 성공시 MemberDTO, 실패시 null
     */
    public MemberDTO authenticate(String id, String rawPassword) throws SQLException {
        MemberDTO member = findById(id);
        if (member == null) {
            return null;
        }
        if (BCrypt.checkpw(rawPassword, member.getPw())) {
            member.setPw(null); // 비밀번호는 세션에 저장하지 않음
            return member;
        }
        return null;
    }

    /**
     * 아이디 중복 확인
     * @return true면 이미 존재함 (사용 불가)
     */
    public boolean existsById(String id) throws SQLException {
        return findById(id) != null;
    }

    /**
     * 이메일 중복 확인
     * @return true면 이미 존재함 (사용 불가)
     */
    public boolean existsByEmail(String email) throws SQLException {
        return findByEmail(email) != null;
    }
}
