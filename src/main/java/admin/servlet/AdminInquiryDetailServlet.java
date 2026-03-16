package admin.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.dao.InquiryDAO;
import admin.dto.InquiryDTO;
import util.JsonUtil;

/**
 * 문의 상세 서블릿
 */
@WebServlet("/admin/inquiries/detail")
public class AdminInquiryDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        InquiryDTO inquiry = null;
        String error = null;

        if (idParam == null || idParam.isEmpty()) {
            error = "문의 번호가 필요합니다.";
        } else {
            try {
                int inquiryNumber = Integer.parseInt(idParam);
                inquiry = InquiryDAO.getInstance().findWithUser(inquiryNumber);
                if (inquiry == null) {
                    error = "해당 문의를 찾을 수 없습니다.";
                }
            } catch (NumberFormatException e) {
                error = "올바르지 않은 문의 번호입니다.";
            }
        }

        request.setAttribute("inquiry", inquiry);
        request.setAttribute("error", error);
        request.setAttribute("InquiryStatus", InquiryDTO.Status.values());
        request.setAttribute("InquiryType", InquiryDTO.Type.values());
        request.setAttribute("inquiryJson", inquiry != null ? JsonUtil.toJson(inquiry) : "null");
        request.setAttribute("pageTitle", "문의 상세 | 관리자");
        request.setAttribute("currentPath", "/admin/inquiries");
        request.setAttribute("contentPage", "/WEB-INF/admin/pages/inquiryDetail.jsp");
        request.getRequestDispatcher("/WEB-INF/admin/layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");

        if ("saveAnswer".equals(action)) {
            int inquiryNumber = parseInt(request.getParameter("inquiryNumber"), 0);
            String answer = request.getParameter("answer");

            if (answer == null || answer.trim().isEmpty()) {
                out.print("{\"success\":false,\"message\":\"답변 내용을 입력해주세요.\"}");
                return;
            }

            boolean ok = InquiryDAO.getInstance().saveAnswer(inquiryNumber, answer.trim());
            out.print(ok
                    ? "{\"success\":true,\"message\":\"답변이 등록되었습니다.\"}"
                    : "{\"success\":false,\"message\":\"문의를 찾을 수 없습니다.\"}");
        } else {
            response.setStatus(400);
            out.print("{\"success\":false,\"message\":\"알 수 없는 action입니다.\"}");
        }
    }

    private static int parseInt(String s, int defaultVal) {
        try { return Integer.parseInt(s); } catch (Exception e) { return defaultVal; }
    }
}
