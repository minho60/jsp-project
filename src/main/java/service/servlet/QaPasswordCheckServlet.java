package service.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import service.dao.QaDAO;

@WebServlet("/qa/checkPassword")
public class QaPasswordCheckServlet extends HttpServlet {

    private QaDAO dao = new QaDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        long qaNum = Long.parseLong(request.getParameter("qaNum"));
        String inputPassword = request.getParameter("guestPassword");

        boolean match = dao.checkGuestPassword(qaNum, inputPassword);

        response.setContentType("text/plain;charset=UTF-8");

        if (match) {

            // 인증 세션 저장
            request.getSession().setAttribute("qaAuth_" + qaNum, true);

            response.getWriter().write("ok");

        } else {

            response.getWriter().write("fail");

        }
    }
}