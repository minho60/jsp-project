package admin.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.AdminConstants;

/**
 * 관리자 인증 필터.
 * /admin/* 경로에 적용되며, /admin/signin 경로는 제외.
 * 세션 key: AdminConstants.SESSION_KEY (쇼핑몰 사용자 세션과 분리)
 */
@WebFilter(urlPatterns = "/admin/*")
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String contextPath = request.getContextPath();
        String uri = request.getRequestURI();
        // contextPath 제거 후의 경로
        String path = uri.substring(contextPath.length());

        // 정적 리소스는 필터 통과
        if (path.startsWith("/assets/")) {
            chain.doFilter(req, res);
            return;
        }

        // JSP에서 공통으로 사용할 경로 변수 설정
        request.setAttribute("ctx", contextPath);
        request.setAttribute("resPath", contextPath + "/assets");

        // 로그인 페이지는 통과 (이미 로그인 상태면 리다이렉트)
        if ("/admin/signin".equals(path)) {
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute(AdminConstants.SESSION_KEY) != null) {
                String redirect = request.getParameter("redirect");
                if (redirect != null && !redirect.isEmpty()) {
                    response.sendRedirect(contextPath + redirect);
                } else {
                    response.sendRedirect(contextPath + "/admin");
                }
                return;
            }
            chain.doFilter(req, res);
            return;
        }

        // 로그인 처리(POST)도 통과
        if ("/admin/signin".equals(path) && "POST".equalsIgnoreCase(request.getMethod())) {
            chain.doFilter(req, res);
            return;
        }

        // 로그아웃도 통과
        if ("/admin/logout".equals(path)) {
            chain.doFilter(req, res);
            return;
        }

        // 디버그 페이지도 통과
        if ("/admin/db_debug".equals(path)) {
            chain.doFilter(req, res);
            return;
        }

        // 인증 확인
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute(AdminConstants.SESSION_KEY) == null) {
            String redirect = "";
            if (!"/admin".equals(path) && !"/admin/".equals(path)) {
                redirect = "?redirect=" + path;
            }
            response.sendRedirect(contextPath + "/admin/signin" + redirect);
            return;
        }

        // 인증된 사용자 정보를 request에 설정
        request.setAttribute("adminAccount", session.getAttribute(AdminConstants.SESSION_KEY));
        chain.doFilter(req, res);
    }

    @Override
    public void destroy() {
    }
}
