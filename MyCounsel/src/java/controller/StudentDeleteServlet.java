package controller;

import dao.StudentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class StudentDeleteServlet extends HttpServlet {

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
        dao.deleteStudent(studentID);

        response.sendRedirect("StudentListServlet");
    }
}
