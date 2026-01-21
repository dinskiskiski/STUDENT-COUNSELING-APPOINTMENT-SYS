
package controller;

import dao.AppointmentDAO;
import dao.StudentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Appointment;
import model.Student;

import model.Counselor;
import dao.CounselorDAO;


public class CounselorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String contextPath = request.getContextPath();

        if ("insert".equals(action)) {
//            String id = request.getParameter("counselorID");
            String name = request.getParameter("counselorName");
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            String pos = request.getParameter("position");

            Counselor newCounselor = new Counselor();
//            newCounselor.setCounselorID(id);
            newCounselor.setCounselorName(name);
            newCounselor.setEmail(email);
            newCounselor.setCounselorPassword(pass);
            newCounselor.setPosition(pos);

            CounselorDAO dao = new CounselorDAO();
            boolean success = dao.addCounselor(newCounselor);

            if (success) {
                // Redirect to DashboardServlet using contextPath
                response.sendRedirect(contextPath + "/DashboardServlet?msg=success");
            } else {
                // Redirect back to the form using contextPath
                response.sendRedirect(contextPath + "/Counselor/CreateCounselor.jsp?msg=error");
            }
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String studentID = request.getParameter("id");
        
        if ("viewStudent".equals(action)) {
            StudentDAO studDao = new StudentDAO();
            AppointmentDAO appDao = new AppointmentDAO();
            
            // 1. Get Student Details
            Student student = studDao.getStudentById(studentID);
            // 2. Get Student's specific Appointment History
            List<Appointment> history = appDao.getAppointmentsByStudent(studentID);
            
            // 3. Set attributes for JSP
            request.setAttribute("selectedStudent", student);
            request.setAttribute("appointmentHistory", history);
            
            // 4. Forward to the Counselor folder path
            request.getRequestDispatcher("Counselor/view_student.jsp").forward(request, response);
        }
    }
}
