package controller;

import dao.AppointmentDAO;
import dao.AppointmentRecordDAO;
import dao.StudentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Appointment;
import model.AppointmentRecord;
import model.Student;

public class ViewAppointmentRecordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("DashboardServlet");
            return;
        }

        int appointmentID = Integer.parseInt(idStr);

        // 1. Get appointment details
        AppointmentDAO appDao = new AppointmentDAO();
        Appointment app = appDao.getAppointmentById(appointmentID); // we'll add this method

        if (app == null) {
            response.sendRedirect("DashboardServlet");
            return;
        }

        // 2. Get student details
        StudentDAO studDao = new StudentDAO();
        Student student = studDao.getStudentById(app.getStudentID());

        // 3. Get consultation notes if exists
        AppointmentRecordDAO recordDao = new AppointmentRecordDAO();
        AppointmentRecord record = recordDao.getRecordByAppointmentId(appointmentID); // we'll add this method too

        // 4. Set attributes for JSP
        request.setAttribute("appointment", app);
        request.setAttribute("student", student);
        request.setAttribute("record", record);

        // 5. Forward to JSP
        request.getRequestDispatcher("Counselor/view_appointment.jsp").forward(request, response);
    }
}
