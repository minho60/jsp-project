package admin.servlet;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.AdminConstants;

/**
 * 관리자 로그인/로그아웃 서블릿
 */
@WebServlet(urlPatterns = {"/admin/signin", "/admin/logout"})
public class AdminSigninServlet extends HttpServlet {

    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "123%4";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getRequestURI().substring(request.getContextPath().length());

        if ("/admin/logout".equals(path)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate(); // 세션 완전 무효화
            }
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        // 로그인 페이지 표시
        request.setAttribute("pageTitle", "로그인 | 관리자");
        request.getRequestDispatcher("/WEB-INF/admin/signin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            // 세션 고정 공격 방지: 기존 세션 파기 후 새 세션 발급
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            HttpSession session = request.getSession(true);
            session.setMaxInactiveInterval(AdminConstants.SESSION_TIMEOUT_SECONDS);

            Map<String, Object> account = new LinkedHashMap<>();
            account.put("id", 1);
            account.put("username", username);
            session.setAttribute(AdminConstants.SESSION_KEY, account);

            String redirect = request.getParameter("redirect");
            if (redirect != null && !redirect.isEmpty()) {
                response.sendRedirect(request.getContextPath() + redirect);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin");
            }
        } else {
            request.setAttribute("pageTitle", "로그인 | 관리자");
            request.setAttribute("loginError", "아이디 또는 비밀번호가 올바르지 않습니다.");
            request.getRequestDispatcher("/WEB-INF/admin/signin.jsp").forward(request, response);
        }
    }
}
