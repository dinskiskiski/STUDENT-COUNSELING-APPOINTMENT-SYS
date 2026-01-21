<%-- 
    File: view_student.jsp
    Purpose: Display specific student profile and history to Counselor.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Student"%>
<%@page import="model.Appointment"%>
<%@page import="java.util.List"%>
<%
    // Security Check
    if (session.getAttribute("userSession") == null || !session.getAttribute("role").equals("counselor")) {
        response.sendRedirect("login.jsp");
        return; 
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Details</title>
    <style>
        .profile-card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 800px; margin: auto; }
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px; }
        .info-item { border-left: 4px solid #3498db; padding-left: 10px; background: #f9f9f9; }
    </style>
</head>
<body>
    <%
        Student stud = (Student) request.getAttribute("selectedStudent");
        List<Appointment> history = (List<Appointment>) request.getAttribute("appointmentHistory");

        // Redirect if direct access without going through Servlet
        if (stud == null) {
            response.sendRedirect("../DashboardServlet");
            return;
        }
    %>

    <div class="profile-card">
        <a href="<%= request.getContextPath() %>/DashboardServlet">← Back to Dashboard</a>

        <hr>
        <h2>Student Profile: <%= stud.getStudentName() %></h2>

        <div class="info-grid">
            <div class="info-item">
                <strong>Matrix Number:</strong><br>
                <span><%= stud.getMatrixNumber() %></span>
            </div>
            <div class="info-item">
                <strong>Email:</strong><br>
                <span><%= stud.getStudentEmail() %></span>
            </div>
            <div class="info-item">
                <strong>Course:</strong><br>
                <span><%= stud.getCourse() %></span>
            </div>
            <div class="info-item">
                <strong>Phone:</strong><br>
                <span><%= stud.getStudentPhone() %></span>
            </div>
        </div>

        <h3>Appointment History</h3>
        <table border="1" width="100%" style="border-collapse: collapse;">
            <tr style="background: #9b59b6; color: white;">
                <th>Date</th>
                <th>Issue</th>
                <th>Status</th>
            </tr>
            <% 
                if (history != null && !history.isEmpty()) {
                    for(Appointment a : history) { 
            %>
                <tr>
                    <td><%= a.getAppointmentDate() %></td>
                    <td><%= a.getAppointmentIssue() %></td>
                    <td><%= a.getStatus() %></td>
                </tr>
            <% 
                    }
                } else { 
            %>
                <tr><td colspan="3">No previous history found.</td></tr>
            <% } %>
        </table>
    </div>
</body>
</html>