package controller;

import dao.AppointmentDAO;
import dao.AppointmentRecordDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.Appointment;
import model.AppointmentRecord;

public class StartConsultationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Security: Only counselor
        if (session.getAttribute("userSession") == null ||
            !"counselor".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        int appointmentID = Integer.parseInt(request.getParameter("id"));

        // Load Appointment details for display
        AppointmentDAO appDao = new AppointmentDAO();
        Appointment app = appDao.getAppointmentByID(appointmentID);

        request.setAttribute("appointment", app);
        request.getRequestDispatcher("Counselor/start_consultation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userSession") == null ||
            !"counselor".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
        String note = request.getParameter("appointmentNote");
        String recommendation = request.getParameter("recommendation");

        // 1. Save consultation record
        AppointmentRecord record = new AppointmentRecord();
        record.setAppointmentID(appointmentID);
        record.setAppointmentNote(note);
        record.setRecommendation(recommendation);

        AppointmentRecordDAO recordDao = new AppointmentRecordDAO();
        boolean saved = recordDao.addRecord(record);

        if (saved) {
            // 2. Update appointment status to Completed
            AppointmentDAO appDao = new AppointmentDAO();
            appDao.updateStatus(appointmentID, "Completed", (String) session.getAttribute("userSession"));
        }

        response.sendRedirect("DashboardServlet");
    }
}
