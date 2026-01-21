package controller;

import dao.StudentDAO;
import model.Student;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// 1. URL Mapping: Matches <form action="UpdateProfileServlet"> in your JSP
@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/UpdateProfileServlet"})
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve form data
        String id = request.getParameter("studentID");
        String name = request.getParameter("studentName");
        String email = request.getParameter("studentEmail");
        String phone = request.getParameter("studentPhone");
        String course = request.getParameter("course");

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // 2. Basic password validation (only if user tries to change it)
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect("edit_profile.jsp?error=Passwords do not match.");
                return;
            }

            
        }

        // 3. Prepare Student object
        Student studentToUpdate = new Student();
        studentToUpdate.setStudentID(id);
        studentToUpdate.setStudentName(name);
        studentToUpdate.setStudentEmail(email);
        studentToUpdate.setStudentPhone(phone);
        studentToUpdate.setCourse(course);

        // Only set password if user entered a new one
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            studentToUpdate.setStudentPassword(newPassword); 
        }

        // 4. Update DB
        StudentDAO dao = new StudentDAO();
        boolean success;

        if (newPassword != null && !newPassword.trim().isEmpty()) {
            success = dao.updateStudentProfileWithPassword(studentToUpdate);
        } else {
            success = dao.updateStudent(studentToUpdate);
        }

        if (success) {
            HttpSession session = request.getSession();

            // Update session name
            session.setAttribute("currentUserName", name);

            response.sendRedirect("DashboardServlet");

        } else {
            response.sendRedirect("edit_profile.jsp?error=Update failed. Please try again.");
        }
    }
}