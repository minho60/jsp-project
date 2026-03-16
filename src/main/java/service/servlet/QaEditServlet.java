package service.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.dao.QaDAO;
import service.dto.QaDTO;

@WebServlet("/qa/edit")
public class QaEditServlet extends HttpServlet {

    private QaDAO dao = new QaDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        long qaNum = Long.parseLong(request.getParameter("id"));

        Boolean auth = (Boolean) request.getSession().getAttribute("qaAuth_" + qaNum);

        if (auth == null || !auth) {
            response.sendRedirect(request.getContextPath() + "/qa/list");
            return;
        }

        request.setAttribute("qa", dao.findById(qaNum));

        request.getRequestDispatcher("/service/qa/qa_edit.jsp")
                .forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long qaNum = Long.parseLong(request.getParameter("qaNum"));
        String type = request.getParameter("type");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        QaDTO qa = new QaDTO();
        qa.setQaNum(qaNum);
        qa.setType(type);
        qa.setTitle(title);
        qa.setContent(content);

        int result = dao.updateQa(qa); // 데이터베이스에서 수정

        if (result > 0) {
            // 수정 성공 시 목록 페이지로 리디렉션
            response.sendRedirect(request.getContextPath() + "/qa/view?id=" + qaNum);
        } else {
            // 수정 실패 시 에러 메시지 출력
            request.setAttribute("errorMessage", "수정에 실패했습니다.");
            request.getRequestDispatcher("/service/qa/qa_edit.jsp").forward(request, response);
        }
    }
}

