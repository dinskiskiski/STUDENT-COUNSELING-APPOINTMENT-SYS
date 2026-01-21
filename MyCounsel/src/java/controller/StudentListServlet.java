package controller;

import dao.StudentDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.Student;

public class StudentListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (session.getAttribute("userSession") == null || !"counselor".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        StudentDAO dao = new StudentDAO();
        List<Student> students = dao.getAllStudents();
        request.setAttribute("students", students);

        request.getRequestDispatcher("Counselor/student_list.jsp").forward(request, response);
    }
}
