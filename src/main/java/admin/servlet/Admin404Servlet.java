package admin.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 관리자 영역 404 처리
 * /admin/* 와일드카드로 매핑되지 않은 URL을 잡아서 404 표시
 * (정확한 URL 매핑이 우선하므로 기존 서블릿과 충돌 없음)
 */
@WebServlet("/admin/*")
public class Admin404Servlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        request.setAttribute("pageTitle", "404 | 관리자");
        request.setAttribute("currentPath", "");
        request.setAttribute("contentPage", "/WEB-INF/admin/pages/404.jsp");
        request.getRequestDispatcher("/WEB-INF/admin/layout.jsp").forward(request, response);
    }
}
