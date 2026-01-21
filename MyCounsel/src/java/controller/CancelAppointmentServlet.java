package controller;

import dao.AppointmentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CancelAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Security check
        if (session.getAttribute("userSession") == null ||
            !"student".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        int appointmentID = Integer.parseInt(request.getParameter("id"));

        AppointmentDAO dao = new AppointmentDAO();
        dao.cancelAppointment(appointmentID);

        // Redirect back to dashboard (reload list)
        response.sendRedirect("DashboardServlet");
    }
}
