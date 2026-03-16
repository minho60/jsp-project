package member.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.MemberConstants;
import member.MemberDAO;
import member.MemberDTO;

/**
 * 쇼핑몰 회원 로그인 서블릿
 * GET  /member/login -> 로그인 페이지 표시
 * POST /member/login -> 로그인 처리
 */
@WebServlet("/member/login")
public class MemberLoginServlet extends HttpServlet {

    private final MemberDAO memberDAO = MemberDAO.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 이미 로그인된 상태면 메인으로 리다이렉트
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute(MemberConstants.SESSION_KEY) != null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        request.getRequestDispatcher("/member/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String pw = request.getParameter("pw");

        try {
            MemberDTO member = memberDAO.authenticate(id, pw);

            if (member != null) {
                // 세션 고정 공격 방지: 기존 세션 파기 후 새 세션 발급
                HttpSession oldSession = request.getSession(false);
                if (oldSession != null) {
                    oldSession.invalidate();
                }
                HttpSession session = request.getSession(true);
                session.setMaxInactiveInterval(MemberConstants.SESSION_TIMEOUT_SECONDS);
                session.setAttribute(MemberConstants.SESSION_KEY, member);

                // 로그인 전 페이지로 리다이렉트 (있으면)
                String redirect = request.getParameter("redirect");
                if (redirect != null && !redirect.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + redirect);
                } else {
                    response.sendRedirect(request.getContextPath() + "/");
                }
            } else {
                request.setAttribute("loginError", "아이디 또는 비밀번호가 올바르지 않습니다.");
                request.setAttribute("savedId", id);
                request.getRequestDispatcher("/member/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("loginError", "로그인 처리 중 오류가 발생했습니다.");
            request.setAttribute("savedId", id);
            request.getRequestDispatcher("/member/login.jsp").forward(request, response);
        }
    }
}
