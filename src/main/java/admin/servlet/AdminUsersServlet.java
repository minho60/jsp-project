package admin.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.dao.UserDAO;
import admin.dto.UserDTO;
import admin.util.MaskUtil;
import util.JsonUtil;

/**
 * 사용자 목록 서블릿
 */
@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            MaskUtil mu = new MaskUtil();
            List<UserDTO> users = UserDAO.getInstance().getAll();

            // 마스킹 처리된 유저 목록
            List<UserDTO> censored = new ArrayList<>();
            for (UserDTO u : users) {
                UserDTO cu = new UserDTO();
                cu.setUserNumber(u.getUserNumber());
                cu.setUserName(u.getUserName());
                // name 필드는 제외 (마스킹 목적)
                cu.setEmail(mu.maskEmail(u.getEmail()));
                cu.setPhoneNumber(mu.maskPhoneNumber(u.getPhoneNumber()));
                cu.setCreatedAt(u.getCreatedAt());
                censored.add(cu);
            }

            request.setAttribute("users", censored);
            request.setAttribute("usersJson", JsonUtil.toJson(censored));
            request.setAttribute("pageTitle", "사용자 목록 | 관리자");
            request.setAttribute("currentPath", "/admin/users");
            request.setAttribute("contentPage", "/WEB-INF/admin/pages/users.jsp");
            request.getRequestDispatcher("/WEB-INF/admin/layout.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("사용자 목록 조회 중 DB 오류 발생", e);
        }
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
                case "create": {
                    String id = request.getParameter("id");
                    String password = request.getParameter("password");
                    String name = request.getParameter("name");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phone");

                    // 필수값 검증
                    if (id == null || id.trim().isEmpty()) {
                        response.setStatus(400);
                        out.print("{\"success\":false,\"message\":\"아이디를 입력해 주세요.\"}");
                        break;
                    }
                    if (password == null || password.trim().isEmpty()) {
                        response.setStatus(400);
                        out.print("{\"success\":false,\"message\":\"비밀번호를 입력해 주세요.\"}");
                        break;
                    }
                    if (name == null || name.trim().isEmpty()) {
                        response.setStatus(400);
                        out.print("{\"success\":false,\"message\":\"이름을 입력해 주세요.\"}");
                        break;
                    }
                    if (email == null || email.trim().isEmpty()) {
                        response.setStatus(400);
                        out.print("{\"success\":false,\"message\":\"이메일을 입력해 주세요.\"}");
                        break;
                    }

                    // 중복 검증
                    UserDAO dao = UserDAO.getInstance();
                    if (dao.existsById(id.trim())) {
                        response.setStatus(409);
                        out.print("{\"success\":false,\"message\":\"이미 사용 중인 아이디입니다.\"}");
                        break;
                    }
                    if (dao.existsByEmail(email.trim())) {
                        response.setStatus(409);
                        out.print("{\"success\":false,\"message\":\"이미 사용 중인 이메일입니다.\"}");
                        break;
                    }

                    boolean ok = dao.insert(
                            id.trim(),
                            password.trim(),
                            name.trim(),
                            email.trim(),
                            phone != null ? phone.trim() : ""
                    );
                    out.print(ok
                            ? "{\"success\":true,\"message\":\"사용자가 추가되었습니다.\"}"
                            : "{\"success\":false,\"message\":\"사용자 추가에 실패했습니다.\"}");
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
}
