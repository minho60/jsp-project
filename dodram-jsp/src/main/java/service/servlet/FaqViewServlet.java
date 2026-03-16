package service.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.dao.FaqDAO;
import service.dto.FaqDTO;

@WebServlet("/faq/view")
public class FaqViewServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int qaNum = Integer.parseInt(request.getParameter("qaNum"));

        FaqDAO dao = new FaqDAO();
        FaqDTO faq = dao.getFaq(qaNum);

        request.setAttribute("faq", faq);

        RequestDispatcher rd = request.getRequestDispatcher("/service/faq/faq_view.jsp");
        rd.forward(request, response);
    }
}
