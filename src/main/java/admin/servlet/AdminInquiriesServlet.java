package admin.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.dao.InquiryDAO;
import admin.dto.InquiryDTO;
import util.JsonUtil;

/**
 * 1:1 문의 목록 서블릿
 */
@WebServlet("/admin/inquiries")
public class AdminInquiriesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            request.setAttribute("inquiryList", InquiryDAO.getInstance().getAllWithUser());
            request.setAttribute("waitingCount", InquiryDAO.getInstance().countWaiting());
            request.setAttribute("InquiryStatus", InquiryDTO.Status.values());
            request.setAttribute("InquiryType", InquiryDTO.Type.values());
            request.setAttribute("inquiryListJson", JsonUtil.toJson(InquiryDAO.getInstance().getAllWithUser()));
            request.setAttribute("pageTitle", "1대1 문의 | 관리자");
            request.setAttribute("currentPath", "/admin/inquiries");
            request.setAttribute("contentPage", "/WEB-INF/admin/pages/inquiries.jsp");
            request.getRequestDispatcher("/WEB-INF/admin/layout.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("문의 목록 조회 중 DB 오류 발생", e);
        }
    }
}
