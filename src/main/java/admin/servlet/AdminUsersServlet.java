package admin.servlet;

import java.io.IOException;
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
}
