package service.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.dao.QaDAO;
import service.dto.QaDTO;

@WebServlet("/qa/view")
public class QaViewServlet extends HttpServlet {

    private QaDAO dao = new QaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            long qaNum = Long.parseLong(request.getParameter("id"));
            QaDTO qa = dao.findById(qaNum);

            if (qa == null) {
                response.sendRedirect(request.getContextPath() + "/qa/list");
                return;
            }

            request.setAttribute("qa", qa);
            request.getRequestDispatcher("/service/qa/qa_view.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/qa/list");
        }
    }
}