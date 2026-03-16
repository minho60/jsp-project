package admin.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import admin.dto.ProductDTO;
import util.DBUtil;

/**
 * 상품 DAO - DB 연동 (products + product_images 테이블)
 */
public class ProductDAO {

    private static final ProductDAO INSTANCE = new ProductDAO();

    private ProductDAO() {}

    public static ProductDAO getInstance() { return INSTANCE; }

    /** products 테이블 → ProductDTO RowMapper (detailImages 제외) */
    private static final util.RowMapper<ProductDTO> ROW_MAPPER = rs -> {
        ProductDTO p = new ProductDTO();
        p.setProductNumber(rs.getLong("product_num"));
        p.setCategoryNumber(rs.getInt("category_num"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getInt("price"));
        p.setStatus(rs.getString("status"));
        p.setThumbnailImage(rs.getString("thumbnail_image"));
        p.setOrigin(rs.getString("origin"));
        p.setWeight(rs.getInt("weight"));
        p.setCreatedAt(rs.getString("created_at"));
        p.setUpdatedAt(rs.getString("updated_at"));
        p.setDetailImages(Collections.emptyList()); // 별도 조회 필요
        return p;
    };

    /** 상품의 상세 이미지 목록 조회 */
    private List<String> getDetailImages(long productNumber) throws SQLException {
        String sql = "SELECT image_path FROM product_images WHERE product_num = ? ORDER BY sort_order";
        return DBUtil.executeQuery(sql, ps -> {
            ps.setLong(1, productNumber);
        }, rs -> rs.getString("image_path"));
    }

    /** 상품에 상세 이미지 채우기 */
    private void fillDetailImages(ProductDTO product) throws SQLException {
        product.setDetailImages(getDetailImages(product.getProductNumber()));
    }

    /** 여러 상품에 상세 이미지 채우기 */
    private void fillDetailImages(List<ProductDTO> products) throws SQLException {
        for (ProductDTO p : products) {
            fillDetailImages(p);
        }
    }

    /** 전체 상품 목록 (상세 이미지 포함) */
    public List<ProductDTO> getAll() throws SQLException {
        String sql = "SELECT product_num, category_num, name, description, price, status, "
                   + "thumbnail_image, origin, weight, created_at, updated_at "
                   + "FROM products ORDER BY product_num";
        List<ProductDTO> list = DBUtil.executeQuery(sql, null, ROW_MAPPER);
        fillDetailImages(list);
        return list;
    }

    /** 상품 번호로 조회 (상세 이미지 포함) */
    public ProductDTO findByNumber(long productNumber) throws SQLException {
        String sql = "SELECT product_num, category_num, name, description, price, status, "
                   + "thumbnail_image, origin, weight, created_at, updated_at "
                   + "FROM products WHERE product_num = ?";
        List<ProductDTO> list = DBUtil.executeQuery(sql, ps -> {
            ps.setLong(1, productNumber);
        }, ROW_MAPPER);
        if (list.isEmpty()) return null;
        ProductDTO p = list.get(0);
        fillDetailImages(p);
        return p;
    }

    /** 카테고리별 상품 목록 (상세 이미지 포함) */
    public List<ProductDTO> findByCategory(int categoryNumber) throws SQLException {
        String sql = "SELECT product_num, category_num, name, description, price, status, "
                   + "thumbnail_image, origin, weight, created_at, updated_at "
                   + "FROM products WHERE category_num = ? ORDER BY product_num";
        List<ProductDTO> list = DBUtil.executeQuery(sql, ps -> {
            ps.setInt(1, categoryNumber);
        }, ROW_MAPPER);
        fillDetailImages(list);
        return list;
    }

    /** 상품 추가 (상세 이미지 포함) */
    public ProductDTO add(int categoryNumber, String name, String description,
                          int price, String status, String thumbnailImage,
                          String origin, int weight, List<String> detailImages) throws SQLException {
        String sql = "INSERT INTO products (category_num, name, description, price, status, "
                   + "thumbnail_image, origin, weight) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        DBUtil.executeUpdate(sql, ps -> {
            ps.setInt(1, categoryNumber);
            ps.setString(2, name);
            ps.setString(3, description);
            ps.setInt(4, price);
            ps.setString(5, status);
            ps.setString(6, thumbnailImage);
            ps.setString(7, origin != null ? origin : "");
            ps.setInt(8, weight);
        });

        // 방금 삽입된 상품의 product_num 조회
        String selectSql = "SELECT product_num, category_num, name, description, price, status, "
                         + "thumbnail_image, origin, weight, created_at, updated_at "
                         + "FROM products ORDER BY product_num DESC LIMIT 1";
        List<ProductDTO> list = DBUtil.executeQuery(selectSql, null, ROW_MAPPER);
        if (list.isEmpty()) return null;

        ProductDTO product = list.get(0);

        // 상세 이미지 삽입
        if (detailImages != null && !detailImages.isEmpty()) {
            insertDetailImages(product.getProductNumber(), detailImages);
        }
        product.setDetailImages(detailImages != null ? detailImages : Collections.emptyList());
        return product;
    }

    /** 상품 수정 */
    public boolean update(long productNumber, int categoryNumber, String name,
                          String description, int price, String status,
                          String thumbnailImage, String origin, int weight,
                          List<String> detailImages) throws SQLException {
        String sql = "UPDATE products SET category_num = ?, name = ?, description = ?, "
                   + "price = ?, status = ?, thumbnail_image = ?, origin = ?, weight = ? "
                   + "WHERE product_num = ?";
        int rows = DBUtil.executeUpdate(sql, ps -> {
            ps.setInt(1, categoryNumber);
            ps.setString(2, name);
            ps.setString(3, description);
            ps.setInt(4, price);
            ps.setString(5, status);
            ps.setString(6, thumbnailImage);
            ps.setString(7, origin != null ? origin : "");
            ps.setInt(8, weight);
            ps.setLong(9, productNumber);
        });

        // 상세 이미지 교체 (기존 삭제 후 재삽입)
        if (detailImages != null) {
            deleteDetailImages(productNumber);
            if (!detailImages.isEmpty()) {
                insertDetailImages(productNumber, detailImages);
            }
        }
        return rows > 0;
    }

    /** 상품 삭제 (product_images는 ON DELETE CASCADE로 자동 삭제) */
    public boolean delete(long productNumber) throws SQLException {
        String sql = "DELETE FROM products WHERE product_num = ?";
        int rows = DBUtil.executeUpdate(sql, ps -> {
            ps.setLong(1, productNumber);
        });
        return rows > 0;
    }

    /** 상세 이미지 삽입 */
    private void insertDetailImages(long productNumber, List<String> images) throws SQLException {
        String sql = "INSERT INTO product_images (product_num, image_path, sort_order) VALUES (?, ?, ?)";
        for (int i = 0; i < images.size(); i++) {
            final int sortOrder = i + 1;
            final String imagePath = images.get(i);
            DBUtil.executeUpdate(sql, ps -> {
                ps.setLong(1, productNumber);
                ps.setString(2, imagePath);
                ps.setInt(3, sortOrder);
            });
        }
    }

    /** 특정 상품의 상세 이미지 전체 삭제 */
    private void deleteDetailImages(long productNumber) throws SQLException {
        String sql = "DELETE FROM product_images WHERE product_num = ?";
        DBUtil.executeUpdate(sql, ps -> {
            ps.setLong(1, productNumber);
        });
    }
}
