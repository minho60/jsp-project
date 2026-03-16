package service.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.dao.EventDao;
import service.dto.EventDto;

@WebServlet("/event/list")
public class EventListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final int PAGE_SIZE = 6; // 한 페이지에 보여줄 이벤트 수

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EventDao dao = new EventDao();

        // 1️⃣ 페이지 번호 가져오기 (없으면 1)
        String pageParam = request.getParameter("page");
        int page = (pageParam == null || pageParam.isEmpty()) ? 1 : Integer.parseInt(pageParam);

        // 2️⃣ 총 이벤트 수 / 총 페이지 계산
        int totalCount = dao.getTotalCount();
        int totalPage = (int) Math.ceil((double) totalCount / PAGE_SIZE);

        // 3️⃣ 시작 행 계산
        int startRow = (page - 1) * PAGE_SIZE;

        // 4️⃣ 페이지 이벤트 가져오기
        List<EventDto> eventList = dao.selectByPage(startRow, PAGE_SIZE);

        // 5️⃣ JSP 전달
        request.setAttribute("eventList", eventList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPage", totalPage);

        request.getRequestDispatcher("/service/event/event.jsp").forward(request, response);
    }
}