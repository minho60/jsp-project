package admin.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.DBConnectionMgr;

/**
 * DB 디버그 페이지 서블릿 (인증 불필요)
 */
@WebServlet(urlPatterns = "/admin/db_debug")
public class AdminDBDebugServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("pageTitle", "DB 디버그 | 관리자");
        request.setAttribute("configInfo", DBConnectionMgr.getSourceInfo());
        request.setAttribute("connectionTest", DBConnectionMgr.testConnection());
        request.getRequestDispatcher("/WEB-INF/admin/db_debug.jsp").forward(request, response);
    }
}
