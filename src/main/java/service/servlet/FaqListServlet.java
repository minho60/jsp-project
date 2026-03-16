package service.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.dao.FaqDAO;
import service.dto.FaqDTO;

@WebServlet("/faq/list")
public class FaqListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FaqDAO dao = new FaqDAO();
    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        String keyword = request.getParameter("keyword");
        String pageParam = request.getParameter("page");

        int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
        int offset = (page - 1) * PAGE_SIZE;

        List<FaqDTO> faqList = dao.getFaqList(category, keyword, offset, PAGE_SIZE);
        int totalCount = dao.getFaqCount(category, keyword);
        int totalPage = (int) Math.ceil((double) totalCount / PAGE_SIZE);

        request.setAttribute("faqList", faqList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("category", category);
        request.setAttribute("keyword", keyword);

        RequestDispatcher rd = request.getRequestDispatcher("/service/faq/faq_list.jsp");
        rd.forward(request, response);
    }
}