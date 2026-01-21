package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.CounselorDAO;


public class DeleteCounselorServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Security check - only ADMIN can delete counselors
        if (session == null || session.getAttribute("userSession") == null || 
            !"counselor".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String position = (String) session.getAttribute("position");
        if (!"ADMIN".equalsIgnoreCase(position)) {
            response.sendRedirect("Counselor/CounselorDashboard.jsp");
            return;
        }
        
        String counselorID = request.getParameter("id");
        String currentUserID = (String) session.getAttribute("userSession");
        
        // Prevent admin from deleting themselves
        if (counselorID.equals(currentUserID)) {
            response.sendRedirect("ViewCounselorsServlet?error=self_delete");
            return;
        }
        
        CounselorDAO dao = new CounselorDAO();
        boolean success = dao.deleteCounselor(counselorID);
        
        if (success) {
            response.sendRedirect("ViewCounselorsServlet?success=deleted");
        } else {
            response.sendRedirect("ViewCounselorsServlet?error=delete_failed");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}