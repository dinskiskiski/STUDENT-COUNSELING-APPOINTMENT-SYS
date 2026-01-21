/*
 * File: RegisterController.java
 * Purpose: Handles student registration
 */
package controller;

import dao.StudentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Student;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Retrieve parameters from JSP
        String studentID = request.getParameter("studentID");
        String matrixNumber = request.getParameter("matrixNumber");
        String name = request.getParameter("studentName");
        String email = request.getParameter("studentEmail");
        String phone = request.getParameter("studentPhone");
        String course = request.getParameter("course");
        String password = request.getParameter("studentPassword");

        // 2. Create the Bean
        Student student = new Student();
        student.setStudentID(studentID);
        student.setMatrixNumber(matrixNumber);
        student.setStudentName(name);
        student.setStudentEmail(email);
        student.setStudentPhone(phone);
        student.setCourse(course);
        student.setStudentPassword(password);

        // 3. Call DAO
        StudentDAO dao = new StudentDAO();
        boolean success = dao.registerStudent(student);

        // 4. Redirect based on result
        if (success) {
            // Registration successful -> Go to Login
            response.sendRedirect("login.jsp?msg=Registration Successful! Please Login.");
        } else {
            // Failed -> Go back to Register
            request.setAttribute("errorMsg", "Registration Failed. ID may already exist.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}