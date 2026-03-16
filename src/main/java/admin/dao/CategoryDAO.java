package admin.dao;

import java.sql.SQLException;
import java.util.List;

import admin.dto.CategoryDTO;
import util.DBUtil;

/**
 * 카테고리 DAO - DB 연동 (categories 테이블)
 */
public class CategoryDAO {

    private static final CategoryDAO INSTANCE = new CategoryDAO();

    private CategoryDAO() {}

    public static CategoryDAO getInstance() { return INSTANCE; }

    /** categories 테이블 → CategoryDTO RowMapper */
    private static final util.RowMapper<CategoryDTO> ROW_MAPPER = rs -> {
        CategoryDTO c = new CategoryDTO();
        c.setCategoryNumber(rs.getInt("category_num"));
        c.setName(rs.getString("name"));
        c.setDescription(rs.getString("description"));
        c.setIcon(rs.getString("icon"));
        c.setCreatedAt(rs.getString("created_at"));
        return c;
    };

    /** 전체 카테고리 목록 */
    public List<CategoryDTO> getAll() throws SQLException {
        String sql = "SELECT category_num, name, description, icon, created_at FROM categories ORDER BY category_num";
        return DBUtil.executeQuery(sql, null, ROW_MAPPER);
    }

    /** 카테고리 번호로 조회 */
    public CategoryDTO findByNumber(int categoryNumber) throws SQLException {
        String sql = "SELECT category_num, name, description, icon, created_at FROM categories WHERE category_num = ?";
        List<CategoryDTO> list = DBUtil.executeQuery(sql, ps -> {
            ps.setInt(1, categoryNumber);
        }, ROW_MAPPER);
        return list.isEmpty() ? null : list.get(0);
    }

    /** 카테고리 추가 */
    public CategoryDTO add(String name, String description, String icon) throws SQLException {
        String sql = "INSERT INTO categories (name, description, icon) VALUES (?, ?, ?)";
        DBUtil.executeUpdate(sql, ps -> {
            ps.setString(1, name);
            ps.setString(2, description != null ? description : "");
            ps.setString(3, icon != null ? icon : "");
        });
        // 방금 삽입된 카테고리 조회 (간단하게 name으로)
        String selectSql = "SELECT category_num, name, description, icon, created_at FROM categories WHERE name = ? ORDER BY category_num DESC LIMIT 1";
        List<CategoryDTO> list = DBUtil.executeQuery(selectSql, ps -> {
            ps.setString(1, name);
        }, ROW_MAPPER);
        return list.isEmpty() ? null : list.get(0);
    }

    /** 카테고리 수정 */
    public boolean update(int categoryNumber, String name, String description, String icon) throws SQLException {
        String sql = "UPDATE categories SET name = ?, description = ?, icon = ? WHERE category_num = ?";
        int rows = DBUtil.executeUpdate(sql, ps -> {
            ps.setString(1, name);
            ps.setString(2, description != null ? description : "");
            ps.setString(3, icon != null ? icon : "");
            ps.setInt(4, categoryNumber);
        });
        return rows > 0;
    }

    /** 카테고리 삭제 */
    public boolean delete(int categoryNumber) throws SQLException {
        String sql = "DELETE FROM categories WHERE category_num = ?";
        int rows = DBUtil.executeUpdate(sql, ps -> {
            ps.setInt(1, categoryNumber);
        });
        return rows > 0;
    }
}
