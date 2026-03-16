package admin.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.dto.OrderDTO;
import admin.dto.OrderItemDTO;
import admin.dto.ProductDTO;
import util.DBUtil;

/**
 * 주문 DAO - DB 연동 (orders + order_items 테이블)
 */
public class OrderDAO {

    private static final OrderDAO INSTANCE = new OrderDAO();

    private OrderDAO() {}

    public static OrderDAO getInstance() { return INSTANCE; }

    /** orders 테이블 → OrderDTO RowMapper */
    private static final util.RowMapper<OrderDTO> ORDER_MAPPER = rs -> {
        OrderDTO o = new OrderDTO();
        o.setOrderNumber(rs.getLong("order_num"));
        o.setOrderDate(rs.getString("order_date"));
        o.setOrderState(rs.getString("order_state"));
        o.setOrdererName(rs.getString("orderer_name"));
        o.setOrdererPhone(rs.getString("orderer_phone"));
        o.setOrdererEmail(rs.getString("orderer_email"));
        o.setReceiverName(rs.getString("receiver_name"));
        o.setReceiverPhone(rs.getString("receiver_phone"));
        o.setReceiverAddress(rs.getString("receiver_address"));
        return o;
    };

    /** order_items 테이블 → OrderItemDTO RowMapper */
    private static final util.RowMapper<OrderItemDTO> ITEM_MAPPER = rs -> {
        OrderItemDTO item = new OrderItemDTO();
        item.setProductNumber(rs.getLong("product_num"));
        item.setQuantity(rs.getInt("quantity"));
        item.setUnitPrice(rs.getInt("unit_price"));
        return item;
    };

    /** 주문의 항목 목록 조회 */
    private List<OrderItemDTO> getItems(long orderNumber) throws SQLException {
        String sql = "SELECT product_num, quantity, unit_price FROM order_items WHERE order_num = ? ORDER BY item_id";
        return DBUtil.executeQuery(sql, ps -> {
            ps.setLong(1, orderNumber);
        }, ITEM_MAPPER);
    }

    /** 전체 주문 목록 (항목 포함) */
    public List<OrderDTO> getAll() throws SQLException {
        String sql = "SELECT order_num, order_date, order_state, orderer_name, orderer_phone, orderer_email, "
                   + "receiver_name, receiver_phone, receiver_address FROM orders ORDER BY order_num";
        List<OrderDTO> list = DBUtil.executeQuery(sql, null, ORDER_MAPPER);
        for (OrderDTO o : list) {
            o.setItems(getItems(o.getOrderNumber()));
        }
        return list;
    }

    /** 주문 번호로 조회 (항목 포함) */
    public OrderDTO findByOrderNumber(long orderNumber) throws SQLException {
        String sql = "SELECT order_num, order_date, order_state, orderer_name, orderer_phone, orderer_email, "
                   + "receiver_name, receiver_phone, receiver_address FROM orders WHERE order_num = ?";
        List<OrderDTO> list = DBUtil.executeQuery(sql, ps -> {
            ps.setLong(1, orderNumber);
        }, ORDER_MAPPER);
        if (list.isEmpty()) return null;
        OrderDTO o = list.get(0);
        o.setItems(getItems(o.getOrderNumber()));
        return o;
    }

    /** 상품 정보를 조인한 enriched 목록 */
    public List<OrderDTO> getAllEnriched() throws SQLException {
        List<OrderDTO> orders = getAll();
        List<OrderDTO> result = new ArrayList<>();
        for (OrderDTO order : orders) {
            result.add(enrich(order));
        }
        return result;
    }

    /** 단일 주문 enriched */
    public OrderDTO findEnriched(long orderNumber) throws SQLException {
        OrderDTO order = findByOrderNumber(orderNumber);
        if (order == null) return null;
        return enrich(order);
    }

    /** 주문에 상품 정보를 조인 (enriched 필드 채우기) */
    private OrderDTO enrich(OrderDTO order) {
        ProductDAO pd = ProductDAO.getInstance();

        List<OrderItemDTO> enrichedItems = new ArrayList<>();
        int totalQuantity = 0;
        int totalAmount = 0;

        for (OrderItemDTO it : order.getItems()) {
            OrderItemDTO ei = new OrderItemDTO(it.getProductNumber(), it.getQuantity(), it.getUnitPrice());

            // 상품 정보 조인
            ProductDTO product = null;
            try {
                product = pd.findByNumber(it.getProductNumber());
            } catch (SQLException e) {
                e.printStackTrace();
            }

            String productName = product != null ? product.getName() : "삭제된 상품";
            int unitPrice = it.getUnitPrice();
            int subtotal = unitPrice * it.getQuantity();

            ei.setProductName(productName);
            ei.setPrice(unitPrice);
            ei.setSubtotal(subtotal);
            if (product != null) {
                ei.setThumbnailImage(product.getThumbnailImage());
                ei.setOrigin(product.getOrigin());
                ei.setWeight(product.getWeight());
            }

            totalQuantity += it.getQuantity();
            totalAmount += subtotal;
            enrichedItems.add(ei);
        }

        String firstName = enrichedItems.isEmpty() ? "상품 없음"
                : enrichedItems.get(0).getProductName();
        int otherCount = enrichedItems.size() - 1;
        String orderName = otherCount > 0
                ? firstName + " 외 " + otherCount + "건"
                : firstName;

        order.setItems(enrichedItems);
        order.setOrderName(orderName);
        order.setTotalQuantity(totalQuantity);
        order.setTotalAmount(totalAmount);
        return order;
    }

    /** 주문 상태 변경 */
    public boolean updateState(long orderNumber, String newState) throws SQLException {
        String sql = "UPDATE orders SET order_state = ? WHERE order_num = ?";
        int rows = DBUtil.executeUpdate(sql, ps -> {
            ps.setString(1, newState);
            ps.setLong(2, orderNumber);
        });
        return rows > 0;
    }

    /** 주문 삭제 (order_items는 ON DELETE CASCADE로 자동 삭제) */
    public boolean delete(long orderNumber) throws SQLException {
        String sql = "DELETE FROM orders WHERE order_num = ?";
        int rows = DBUtil.executeUpdate(sql, ps -> {
            ps.setLong(1, orderNumber);
        });
        return rows > 0;
    }
}
