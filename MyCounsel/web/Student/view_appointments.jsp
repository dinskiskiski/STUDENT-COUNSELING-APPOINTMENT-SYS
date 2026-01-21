<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Appointment"%>
<%@page import="model.AppointmentRecord"%>
<%
    // SESSION CHECK
    if (session.getAttribute("userSession") == null || !"student".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Appointment appointment = (Appointment) request.getAttribute("appointment");
    AppointmentRecord record = (AppointmentRecord) request.getAttribute("record");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Appointment Details</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f4f9; padding: 20px; }
        .container { max-width: 700px; margin: 0 auto; background: #fff; padding: 20px; border-radius: 8px; }
        h2 { color: #3498db; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #3498db; color: white; }
        .btn { padding: 10px 15px; background-color: #2ecc71; color: white; text-decoration: none; border-radius: 5px; }
        .btn-danger { background-color: #e74c3c; }
    </style>
</head>
<body>
<div class="container">
    <h2>Appointment Details</h2>

    <% if (appointment != null) { %>
        <table>
            <tr>
                <th>Student Name</th>
                <td><%= appointment.getStudentName() %></td>
            </tr>
            <tr>
                <th>Matrix Number</th>
                <td><%= appointment.getMatrixNumber() %></td>
            </tr>
            <tr>
                <th>Issue / Reason</th>
                <td><%= appointment.getAppointmentIssue() %></td>
            </tr>
            <tr>
                <th>Date & Time</th>
                <td><%= appointment.getAppointmentDate() %> at <%= appointment.getAppointmentTime() %></td>
            </tr>
            <tr>
                <th>Status</th>
                <td><%= appointment.getStatus() %></td>
            </tr>
   

        </table>

        <h3>Consultation Record</h3>
        <% if (record != null) { %>
            <table>
                <tr>
                    <th>Appointment Note</th>
                    <td><%= record.getAppointmentNote() %></td>
                </tr>
                <tr>
                    <th>Recommendation</th>
                    <td><%= record.getRecommendation() %></td>
                </tr>
            </table>
        <% } else { %>
            <p>No consultation record yet.</p>
        <% } %>

        <br>
        <a href="DashboardServlet" class="btn">Back to Dashboard</a>
    <% } else { %>
        <p>Appointment not found.</p>
        <a href="DashboardServlet" class="btn btn-danger">Back</a>
    <% } %>
</div>
</body>
</html>
