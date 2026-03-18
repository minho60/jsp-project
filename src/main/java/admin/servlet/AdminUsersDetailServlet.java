package admin.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.dao.UserDAO;
import admin.dto.UserDTO;
import util.JsonUtil;

/**
 * 사용자 상세 서블릿
 */
@WebServlet("/admin/users/detail")
public class AdminUsersDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        UserDTO user = null;
        String error = null;

        if (idParam == null || idParam.isEmpty()) {
            error = "사용자 번호가 필요합니다.";
        } else {
            try {
                long userNumber = Long.parseLong(idParam);
                user = UserDAO.getInstance().findByUserNumber(userNumber);
                if (user == null) {
                    error = "해당 사용자를 찾을 수 없습니다.";
                }
            } catch (NumberFormatException e) {
                error = "올바르지 않은 사용자 번호입니다.";
            } catch (SQLException e) {
                throw new ServletException("사용자 조회 중 DB 오류 발생", e);
            }
        }

        request.setAttribute("user", user);
        request.setAttribute("error", error);
        request.setAttribute("userJson", user != null ? JsonUtil.toJson(user) : "null");
        request.setAttribute("pageTitle", "사용자 상세 | 관리자");
        request.setAttribute("currentPath", "/admin/users");
        request.setAttribute("contentPage", "/WEB-INF/admin/pages/usersDetail.jsp");
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
                case "update": {
                    long userNumber = parseLong(request.getParameter("userNumber"), 0);
                    String name = request.getParameter("name");
                    String email = request.getParameter("email");
                    String phoneNumber = request.getParameter("phoneNumber");
                    boolean ok = UserDAO.getInstance().update(userNumber, name, email, phoneNumber);
                    out.print(ok
                            ? "{\"success\":true,\"message\":\"사용자 정보가 수정되었습니다.\"}"
                            : "{\"success\":false,\"message\":\"사용자를 찾을 수 없습니다.\"}");
                    break;
                }
                case "delete": {
                    long userNumber = parseLong(request.getParameter("userNumber"), 0);
                    boolean ok = UserDAO.getInstance().delete(userNumber);
                    out.print(ok
                            ? "{\"success\":true,\"message\":\"사용자가 삭제되었습니다.\"}"
                            : "{\"success\":false,\"message\":\"사용자를 찾을 수 없습니다.\"}");
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
