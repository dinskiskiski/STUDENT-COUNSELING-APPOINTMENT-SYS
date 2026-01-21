/*
 * File: AppointmentServlet.java
 * Purpose: Handles Create (with validation) and Update actions for appointments
 */
package controller;

import dao.AppointmentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet; // Optional if using annotations
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Appointment;

public class AppointmentServlet extends HttpServlet {

    // --- HANDLE CREATION (Student booking a slot) ---
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve Data from the Form
        String issue = request.getParameter("appointmentIssue");
        String date = request.getParameter("appointmentDate");
        String time = request.getParameter("appointmentTime");
        String studentID = request.getParameter("studentID");

        // Debugging log
        System.out.println("Booking Attempt: ID=" + studentID + " Date=" + date + " Time=" + time);

        AppointmentDAO dao = new AppointmentDAO();

        // 2. --- CLASH DETECTION LOGIC ---
        // Check if this date & time is already booked by ANYONE
        if (dao.isSlotTaken(date, time)) {
            
            // A. CLASH FOUND!
            // Set an error message to display in the JSP
            request.setAttribute("errorMsg", "Booking Failed: The slot " + time + " on " + date + " is already taken. Please pick another.");
            
            // Forward back to the booking page so the user can try again.
            // (Note: Ensure the path matches your folder structure, e.g., "Student/make_appointment.jsp")
            request.getRequestDispatcher("Student/make_appointment.jsp").forward(request, response);
            return; // STOP execution here so we don't save to DB
        }

        // 3. --- NO CLASH - PROCEED TO SAVE ---
        Appointment app = new Appointment();
        app.setAppointmentIssue(issue);
        app.setAppointmentDate(date);
        app.setAppointmentTime(time);
        app.setStudentID(studentID);
        app.setStatus("Pending"); // Set default status

        dao.addAppointment(app);

        // 4. Success - Redirect back to Dashboard to reload the list
        response.sendRedirect("DashboardServlet");
    }
    
    // --- HANDLE STATUS UPDATES (Counselor Approving/Rejecting) ---
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        HttpSession session = request.getSession();

        if ("update".equals(action) && idStr != null) {
            try {
                int appID = Integer.parseInt(idStr);
                String status = request.getParameter("status"); // e.g., 'Approved'
                
                // Get Counselor ID safely
                Object sessionObj = session.getAttribute("userSession");
                String counselorID = (sessionObj != null) ? sessionObj.toString() : "Unknown";

                AppointmentDAO dao = new AppointmentDAO();
                dao.updateStatus(appID, status, counselorID);
                
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            
            // Reload Dashboard
            response.sendRedirect("DashboardServlet");
        }
    }
}