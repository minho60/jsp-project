package member.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;
import member.MemberDTO;

/**
 * 쇼핑몰 회원가입 서블릿
 * GET  /member/register -> 회원가입 페이지 표시
 * POST /member/register -> 회원가입 처리
 */
@WebServlet("/member/register")
public class MemberRegisterServlet extends HttpServlet {

    private final MemberDAO memberDAO = MemberDAO.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/member/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        try {
            // 서버 사이드 유효성 검사
            // 아이디: 영문소문자/숫자/언더바/하이픈, 4~16자, 첫 글자 영문
            if (id == null || !id.matches("^[a-z][a-z0-9_-]{3,15}$")) {
                sendError(request, response, "아이디는 영문소문자/숫자/언더바/하이픈 조합, 4~16자, 첫 글자는 영문이어야 합니다.");
                return;
            }

            // 비밀번호: 8~16자, 영문/숫자/특수문자 중 2종 이상
            if (pw == null || pw.length() < 8 || pw.length() > 16) {
                sendError(request, response, "비밀번호는 8~16자로 입력해주세요.");
                return;
            }
            int typeCount = 0;
            if (pw.matches(".*[a-zA-Z].*")) typeCount++;
            if (pw.matches(".*[0-9].*")) typeCount++;
            if (pw.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?].*")) typeCount++;
            if (typeCount < 2) {
                sendError(request, response, "비밀번호는 영문/숫자/특수문자 중 2가지 이상을 조합해주세요.");
                return;
            }

            // 이름: 2자 이상
            if (name == null || name.trim().length() < 2) {
                sendError(request, response, "이름은 2자 이상 입력해주세요.");
                return;
            }

            // 휴대폰: 01x로 시작 10~11자리
            if (phone == null || !phone.matches("^01[016789]\\d{7,8}$")) {
                sendError(request, response, "올바른 휴대폰번호 형식이 아닙니다.");
                return;
            }

            // 이메일 형식
            if (email == null || !email.matches("^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
                sendError(request, response, "올바른 이메일 형식이 아닙니다.");
                return;
            }

            // 아이디 중복 확인
            if (memberDAO.existsById(id)) {
                sendError(request, response, "이미 사용 중인 아이디입니다.");
                return;
            }

            // 이메일 중복 확인
            if (memberDAO.existsByEmail(email)) {
                sendError(request, response, "이미 사용 중인 이메일입니다.");
                return;
            }

            // 회원 등록
            MemberDTO member = new MemberDTO();
            member.setId(id);
            member.setPw(pw); // DAO에서 BCrypt 해싱
            member.setName(name.trim());
            member.setPhone(phone);
            member.setEmail(email);

            boolean success = memberDAO.insert(member);

            if (success) {
                // 가입 성공 -> JSP에서 Step3(가입완료) 표시
                request.setAttribute("registerSuccess", true);
                request.setAttribute("registeredId", id);
                request.getRequestDispatcher("/member/register.jsp").forward(request, response);
            } else {
                sendError(request, response, "회원가입 처리 중 오류가 발생했습니다.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // MySQL 중복 키 에러 (1062)
            if (e.getErrorCode() == 1062) {
                String msg = e.getMessage();
                if (msg.contains("id")) {
                    sendError(request, response, "이미 사용 중인 아이디입니다.");
                } else if (msg.contains("email")) {
                    sendError(request, response, "이미 사용 중인 이메일입니다.");
                } else {
                    sendError(request, response, "이미 등록된 정보입니다.");
                }
            } else {
                sendError(request, response, "회원가입 처리 중 오류가 발생했습니다.");
            }
        }
    }

    private void sendError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("registerError", message);
        request.getRequestDispatcher("/member/register.jsp").forward(request, response);
    }
}
