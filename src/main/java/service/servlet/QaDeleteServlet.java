package service.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.dao.QaDAO;

@WebServlet("/qa/delete")
public class QaDeleteServlet extends HttpServlet {

    private QaDAO dao = new QaDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        long qaNum = Long.parseLong(request.getParameter("qaNum"));

        // 세션에서 인증 여부 확인
        Boolean auth = (Boolean) request.getSession().getAttribute("qaAuth_" + qaNum);

        if (auth == null || !auth) {
            response.getWriter().write("fail"); // 인증되지 않음
            return;
        }

        // 인증된 경우, 삭제 처리
        int result = dao.deleteQa(qaNum);

        if (result > 0) {
            response.getWriter().write("ok"); // 삭제 성공
        } else {
            response.getWriter().write("fail"); // 삭제 실패
        }
    }
}