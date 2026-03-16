package service.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.dao.QaDAO;
import service.dto.QaDTO;

@WebServlet("/qa/list")
public class QaListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        int page = 1;
        int size = 10;

        if(request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        int offset = (page - 1) * size;

        QaDAO dao = new QaDAO();

        List<QaDTO> qaList = dao.getQaList(keyword, startDate, endDate, offset, size);
        int totalCount = dao.getQaCount(keyword, startDate, endDate);

        int totalPage = (int)Math.ceil((double)totalCount / size);

        request.setAttribute("qaList", qaList);
        request.setAttribute("page", page);
        request.setAttribute("totalPage", totalPage);

       request.getRequestDispatcher("/service/qa/qa_list.jsp").forward(request, response);
    }
}

