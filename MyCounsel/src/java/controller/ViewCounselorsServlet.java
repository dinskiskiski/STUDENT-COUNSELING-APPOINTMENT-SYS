package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.CounselorDAO;
import model.Counselor;


public class ViewCounselorsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Security check - only ADMIN can view counselors
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
        
        // Fetch all counselors
        CounselorDAO dao = new CounselorDAO();
        List<Counselor> counselors = dao.getAllCounselors();
        
        request.setAttribute("counselors", counselors);
        request.getRequestDispatcher("Counselor/ViewCounselors.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}