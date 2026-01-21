/*
 * File: LoginController.java
 * Purpose: Authenticates users and creates the Session
 */
package controller;

import dao.CounselorDAO;
import dao.StudentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Counselor;
import model.Student;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String role = request.getParameter("role");

        HttpSession session = request.getSession();
        
        if ("student".equalsIgnoreCase(role)) {
            StudentDAO dao = new StudentDAO();
            Student student = dao.authenticateUser(email, pass);
            if (student != null) {
                // Login Success: Set Session Attributes
                session.setAttribute("userSession", student.getStudentID());
                session.setAttribute("currentUserName", student.getStudentName());
                session.setAttribute("role", "student");
                
                // Redirect to the Dashboard Controller (not the JSP directly)
                response.sendRedirect("DashboardServlet");
            } else {
                request.setAttribute("errorMsg", "Invalid Student ID or Password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } else if ("counselor".equalsIgnoreCase(role)) {
            CounselorDAO dao = new CounselorDAO();
            Counselor counselor = dao.authenticateCounselor(email, pass);

            if (counselor != null) {
                session.setAttribute("userSession", counselor.getCounselorID());
                session.setAttribute("currentUserName", counselor.getCounselorName());
                session.setAttribute("position", counselor.getPosition());
                session.setAttribute("role", "counselor");

                response.sendRedirect("DashboardServlet");
            } else {
                request.setAttribute("errorMsg", "Invalid Counselor Credentials.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }
}