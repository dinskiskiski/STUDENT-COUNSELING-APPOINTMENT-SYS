package controller;

import dao.AppointmentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();

        // Security: Only student or counselor can delete
        String role = (String) session.getAttribute("role");
        if (session.getAttribute("userSession") == null || 
            (!"student".equals(role) && !"counselor".equals(role))) {
            response.sendRedirect("login.jsp");
            return;
        }

        int appointmentID = Integer.parseInt(request.getParameter("id"));
        AppointmentDAO dao = new AppointmentDAO();
        dao.deleteAppointmentWithRecord(appointmentID);

        response.sendRedirect("DashboardServlet"); // reload dashboard
    }
}
