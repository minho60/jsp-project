package admin.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 관리자 대시보드(메인) 서블릿
 */
@WebServlet(urlPatterns = {"/admin", "/admin/"})
public class AdminMainServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("pageTitle", "대시보드 | 관리자");
        request.setAttribute("currentPath", "/admin");
        request.getRequestDispatcher("/WEB-INF/admin/layout.jsp").forward(request, response);
    }
}
