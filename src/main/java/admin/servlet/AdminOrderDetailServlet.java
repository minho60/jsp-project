package admin.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.dao.OrderDAO;
import admin.dto.OrderDTO;
import util.JsonUtil;

/**
 * 주문 상세 서블릿
 */
@WebServlet("/admin/orders/detail")
public class AdminOrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        OrderDTO order = null;
        String error = null;

        if (idParam == null || idParam.isEmpty()) {
            error = "주문 번호가 필요합니다.";
        } else {
            try {
                long orderNumber = Long.parseLong(idParam);
                order = OrderDAO.getInstance().findEnriched(orderNumber);
                if (order == null) {
                    error = "해당 주문을 찾을 수 없습니다.";
                }
            } catch (NumberFormatException e) {
                error = "올바르지 않은 주문 번호입니다.";
            } catch (SQLException e) {
                throw new ServletException("주문 조회 중 DB 오류 발생", e);
            }
        }

        request.setAttribute("order", order);
        request.setAttribute("error", error);
        request.setAttribute("OrderStatus", OrderDTO.State.values());
        request.setAttribute("orderJson", order != null ? JsonUtil.toJson(order) : "null");
        request.setAttribute("OrderStatusJson", JsonUtil.toJson(OrderDTO.State.values()));
        request.setAttribute("pageTitle", "주문 상세 | 관리자");
        request.setAttribute("currentPath", "/admin/orders");
        request.setAttribute("contentPage", "/WEB-INF/admin/pages/orderDetail.jsp");
        request.getRequestDispatcher("/WEB-INF/admin/layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action) {
                case "updateState": {
                    long orderNumber = parseLong(request.getParameter("orderNumber"), 0);
                    String orderState = request.getParameter("orderState");
                    boolean ok = OrderDAO.getInstance().updateState(orderNumber, orderState);
                    out.print(ok
                            ? "{\"success\":true,\"message\":\"주문 상태가 변경되었습니다.\"}"
                            : "{\"success\":false,\"message\":\"주문을 찾을 수 없습니다.\"}");
                    break;
                }
                case "delete": {
                    long orderNumber = parseLong(request.getParameter("orderNumber"), 0);
                    boolean ok = OrderDAO.getInstance().delete(orderNumber);
                    out.print(ok
                            ? "{\"success\":true,\"message\":\"주문이 삭제되었습니다.\"}"
                            : "{\"success\":false,\"message\":\"주문을 찾을 수 없습니다.\"}");
                    break;
                }
                default:
                    response.setStatus(400);
                    out.print("{\"success\":false,\"message\":\"알 수 없는 action입니다.\"}");
            }
        } catch (SQLException e) {
            response.setStatus(500);
            out.print("{\"success\":false,\"message\":\"DB 오류가 발생했습니다.\"}");
        }
    }

    private static long parseLong(String s, long defaultVal) {
        try { return Long.parseLong(s); } catch (Exception e) { return defaultVal; }
    }
}
