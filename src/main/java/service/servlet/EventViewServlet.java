package service.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.dao.EventDao;
import service.dto.EventDto;

@WebServlet("/event/view")
public class EventViewServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("eventId"));

        EventDao dao = new EventDao();
        EventDto dto = dao.selectOne(id);

        request.setAttribute("event", dto);

        RequestDispatcher rd =
                request.getRequestDispatcher("/service/event/event_view.jsp");

        rd.forward(request, response);
    }
}