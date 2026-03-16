package admin.dao;

import java.sql.SQLException;
import java.util.List;

import admin.dto.UserDTO;
import util.DBUtil;

/**
 * 사용자 DAO - DB 연동 (members 테이블)
 */
public class UserDAO {

    private static final UserDAO INSTANCE = new UserDAO();

    private UserDAO() {}

    public static UserDAO getInstance() { return INSTANCE; }

    /** members 테이블에서 UserDTO로 매핑하는 RowMapper */
    private static final util.RowMapper<UserDTO> ROW_MAPPER = rs -> {
        UserDTO u = new UserDTO();
        u.setUserNumber(rs.getLong("user_num"));
        u.setUserName(rs.getString("id"));
        u.setName(rs.getString("name"));
        u.setEmail(rs.getString("email"));
        u.setPhoneNumber(rs.getString("phone"));
        u.setCreatedAt(rs.getString("created_at"));
        return u;
    };

    /** 전체 사용자 목록 조회 */
    public List<UserDTO> getAll() throws SQLException {
        String sql = "SELECT user_num, id, name, phone, email, created_at FROM members ORDER BY user_num";
        return DBUtil.executeQuery(sql, null, ROW_MAPPER);
    }

    /** 사용자 번호(user_num)로 조회 */
    public UserDTO findByUserNumber(long userNumber) throws SQLException {
        String sql = "SELECT user_num, id, name, phone, email, created_at FROM members WHERE user_num = ?";
        List<UserDTO> list = DBUtil.executeQuery(sql, ps -> {
            ps.setLong(1, userNumber);
        }, ROW_MAPPER);
        return list.isEmpty() ? null : list.get(0);
    }

    /** 아이디(id)로 조회 */
    public UserDTO findByUserName(String userName) throws SQLException {
        String sql = "SELECT user_num, id, name, phone, email, created_at FROM members WHERE id = ?";
        List<UserDTO> list = DBUtil.executeQuery(sql, ps -> {
            ps.setString(1, userName);
        }, ROW_MAPPER);
        return list.isEmpty() ? null : list.get(0);
    }

    /** 사용자 정보 수정 */
    public boolean update(long userNumber, String name, String email, String phoneNumber) throws SQLException {
        String sql = "UPDATE members SET name = ?, email = ?, phone = ? WHERE user_num = ?";
        int rows = DBUtil.executeUpdate(sql, ps -> {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phoneNumber);
            ps.setLong(4, userNumber);
        });
        return rows > 0;
    }

    /** 사용자 삭제 */
    public boolean delete(long userNumber) throws SQLException {
        String sql = "DELETE FROM members WHERE user_num = ?";
        int rows = DBUtil.executeUpdate(sql, ps -> {
            ps.setLong(1, userNumber);
        });
        return rows > 0;
    }

    /** 전체 사용자 수 */
    public int count() throws SQLException {
        String sql = "SELECT COUNT(*) FROM members";
        List<Integer> list = DBUtil.executeQuery(sql, null, rs -> rs.getInt(1));
        return list.isEmpty() ? 0 : list.get(0);
    }
}
