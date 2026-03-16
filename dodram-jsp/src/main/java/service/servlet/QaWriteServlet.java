package service.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.dao.QaDAO;
import service.dto.QaDTO;

@WebServlet("/qa/write")
public class QaWriteServlet extends HttpServlet {

    private QaDAO dao = new QaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 글쓰기 폼 페이지 이동
        request.getRequestDispatcher("/service/qa/qa.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        QaDTO dto = new QaDTO();

        try {
            // 필수 컬럼
            String type = request.getParameter("type");
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            if (type == null || type.trim().isEmpty() ||
                title == null || title.trim().isEmpty() ||
                content == null || content.trim().isEmpty()) {
                throw new IllegalArgumentException("타입, 제목, 내용은 필수입니다.");
            }

            dto.setType(type);
            dto.setTitle(title);
            dto.setContent(content);

            // 회원/비회원 구분
            String userNumStr = request.getParameter("user_num"); // 회원이면 user_num 전달
            if (userNumStr != null && !userNumStr.trim().isEmpty()) {
                // 회원
                dto.setUserNum(Long.parseLong(userNumStr));
                dto.setGuestName(null);
                dto.setGuestPassword(null);
                dto.setGuestEmail(null);
            } else {
                // 비회원
                String guestName = request.getParameter("guest_name");
                String guestPassword = request.getParameter("guest_password");

                if (guestName == null || guestName.trim().isEmpty() ||
                    guestPassword == null || guestPassword.trim().isEmpty()) {
                    throw new IllegalArgumentException("비회원 작성자명과 비밀번호는 필수입니다.");
                }

                dto.setGuestName(guestName);
                dto.setGuestPassword(guestPassword);

                String emailId = request.getParameter("email_id");
                String emailDomain = request.getParameter("email_domain");
                if (emailId != null && emailDomain != null &&
                    !emailId.trim().isEmpty() && !emailDomain.trim().isEmpty()) {
                    dto.setGuestEmail(emailId + "@" + emailDomain);
                }
            }

            int result = dao.insertQa(dto);
            System.out.println("[Servlet] insert result = " + result);

            response.sendRedirect(request.getContextPath() + "/qa/list");

        } catch (Exception e) {
            System.out.println("[Servlet] 글 등록 중 예외 발생: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/qa/list");
        }
    }
}