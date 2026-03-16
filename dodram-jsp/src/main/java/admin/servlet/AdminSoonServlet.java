package admin.servlet;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 페이지 준비중 서블릿
 * 아직 구현되지 않은 기능 접근 시 표시
 */
@WebServlet("/admin/soon")
public class AdminSoonServlet extends HttpServlet {

    private static final String[][] GRADIENTS = {
        {"#193cb8", "#51a2ff"},
        {"#193cb8", "#51a2ff"},
        {"#6e11b0", "#ed6bff"},
        {"#a50036", "#ff637e"},
        {"#973c00", "#fdc700"},
        {"#3d6300", "#9ae600"},
    };

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] grad = GRADIENTS[new Random().nextInt(GRADIENTS.length)];

        request.setAttribute("gradFrom", grad[0]);
        request.setAttribute("gradTo", grad[1]);
        request.setAttribute("pageTitle", "준비중 | 관리자");
        request.setAttribute("currentPath", "/admin/soon");
        request.setAttribute("contentPage", "/WEB-INF/admin/pages/soon.jsp");
        request.getRequestDispatcher("/WEB-INF/admin/layout.jsp").forward(request, response);
    }
}
