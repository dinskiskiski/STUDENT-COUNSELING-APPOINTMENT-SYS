package controller;

import dao.StudentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.Student;

public class StudentEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (session.getAttribute("userSession") == null || !"counselor".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String studentID = request.getParameter("id");
        StudentDAO dao = new StudentDAO();
        Student student = dao.getStudentById(studentID);
        request.setAttribute("student", student);
        request.getRequestDispatcher("Counselor/student_edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentID = request.getParameter("studentID");
        String name = request.getParameter("studentName");
        String email = request.getParameter("studentEmail");
        String phone = request.getParameter("studentPhone");
        String course = request.getParameter("course");
        String matrix = request.getParameter("matrixNumber");

        Student student = new Student();
        student.setStudentID(studentID);
        student.setStudentName(name);
        student.setStudentEmail(email);
        student.setStudentPhone(phone);
        student.setCourse(course);
        student.setMatrixNumber(matrix);

        StudentDAO dao = new StudentDAO();
        dao.updateStudent(student);

        response.sendRedirect("StudentListServlet");
    }
}
