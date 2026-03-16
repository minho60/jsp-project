package member.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;

/**
 * 쇼핑몰 아이디 중복확인 API
 * GET /member/check-id?id=xxx -> JSON 응답
 */
@WebServlet("/member/check-id")
public class MemberCheckIdServlet extends HttpServlet {

    private final MemberDAO memberDAO = MemberDAO.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            response.getWriter().write("{\"available\":false,\"message\":\"아이디를 입력해주세요.\"}");
            return;
        }

        // 아이디 형식 검사
        if (!id.matches("^[a-z][a-z0-9_-]{3,15}$")) {
            response.getWriter().write("{\"available\":false,\"message\":\"영문소문자/숫자/언더바/하이픈, 4~16자, 첫 글자는 영문으로 입력해주세요.\"}");
            return;
        }

        try {
            boolean exists = memberDAO.existsById(id);
            if (exists) {
                response.getWriter().write("{\"available\":false,\"message\":\"이미 사용 중인 아이디입니다.\"}");
            } else {
                response.getWriter().write("{\"available\":true,\"message\":\"사용 가능한 아이디입니다.\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"available\":false,\"message\":\"중복확인 중 오류가 발생했습니다.\"}");
        }
    }
}
