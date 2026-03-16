package member.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.MemberConstants;

/**
 * 쇼핑몰 회원 로그아웃 서블릿
 * GET /member/logout -> 세션 파기 후 메인으로 리다이렉트
 */
@WebServlet("/member/logout")
public class MemberLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            // 쇼핑몰 회원 세션만 제거 (관리자 세션과 분리)
            session.removeAttribute(MemberConstants.SESSION_KEY);
        }

        response.sendRedirect(request.getContextPath() + "/");
    }
}
