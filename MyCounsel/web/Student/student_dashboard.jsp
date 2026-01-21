<%-- 
    File: student_dashboard.jsp
    Purpose: Modern Dashboard for Students to view appointments and take actions.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Appointment"%>
<%@page import="java.util.List"%>

<%
    // --- SECURITY CHECK ---
    // If no session exists or role is not student, redirect to login
    if (session.getAttribute("userSession") == null || !session.getAttribute("role").equals("student")) {
        response.sendRedirect("login.jsp");
        return; 
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Counseling System</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; overflow-x: hidden; }
        
        /* Sidebar Styling */
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(180deg, #4e73df 10%, #224abe 100%);
            color: white;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        .sidebar .nav-link { color: rgba(255,255,255,0.8); padding: 1rem; border-radius: 5px; margin-bottom: 5px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background-color: rgba(255,255,255,0.2); }
        .sidebar .sidebar-brand { padding: 1.5rem 1rem; font-size: 1.2rem; font-weight: bold; text-align: center; }
        
        /* Content Styling */
        .card { border: none; box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15); border-radius: 0.5rem; }
        .card-header { background-color: white; border-bottom: 1px solid #e3e6f0; font-weight: bold; color: #4e73df; }
        
        /* Status Badges */
        .badge-pending { background-color: #f6c23e; color: black; }
        .badge-approved { background-color: #36b9cc; color: white; }
        .badge-completed { background-color: #1cc88a; color: white; }
        .badge-cancelled { background-color: #e74a3b; color: white; }
    </style>
</head>
<body>

<div class="d-flex">
    
    <div class="d-flex flex-column flex-shrink-0 p-3 sidebar" style="width: 250px;">
        <div class="sidebar-brand mb-3">
             MyCounsel Student
        </div>
        <hr class="bg-light">
        <ul class="nav nav-pills flex-column mb-auto">
            <li class="nav-item">
                <a href="DashboardServlet" class="nav-link active">
                    <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                </a>
            </li>
            <li>
                <a href="Student/make_appointment.jsp" class="nav-link">
                    <i class="fas fa-calendar-plus me-2"></i> Book Appointment
                </a>
            </li>
            <li>
                <a href="Student/edit_profile.jsp" class="nav-link">
                    <i class="fas fa-user-edit me-2"></i> Edit Profile
                </a>
            </li>
        </ul>
        <hr class="bg-light">
        <div class="dropdown">
            <a href="LogoutServlet" class="d-flex align-items-center text-white text-decoration-none p-2 rounded hover-bg">
                <i class="fas fa-sign-out-alt me-2"></i> <strong>Log Out</strong>
            </a>
        </div>
    </div>

    <div class="container-fluid p-4">
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h1 class="h3 text-gray-800">Hello, <%= session.getAttribute("currentUserName") %>!</h1>
                <p class="text-muted">Welcome to MyCounsel Student Counseling Appointment System.</p>
            </div>
            
        </div>

        <div class="card mb-4">
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold">Your Appointment History</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle" width="100%" cellspacing="0">
                        <thead class="table-light">
                            <tr>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Issue / Topic</th>
                                <th>Status</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointmentList");

                                if (appointments != null && !appointments.isEmpty()) {
                                    for(Appointment appt : appointments) {
                                        String status = appt.getStatus();
                                        
                                        // Determine badge color based on status
                                        String badgeClass = "badge-secondary"; // Default
                                        if("Pending".equalsIgnoreCase(status)) badgeClass = "badge-pending";
                                        else if("Approved".equalsIgnoreCase(status)) badgeClass = "badge-approved";
                                        else if("Completed".equalsIgnoreCase(status)) badgeClass = "badge-completed";
                                        else if("Cancelled".equalsIgnoreCase(status)) badgeClass = "badge-cancelled";
                            %>
                            <tr>
                                <td><%= appt.getAppointmentDate() %></td>
                                <td><%= appt.getAppointmentTime() %></td>
                                <td><%= appt.getAppointmentIssue() %></td>
                                <td>
                                    <span class="badge rounded-pill <%= badgeClass %> px-3">
                                        <%= status %>
                                    </span>
                                </td>
                                <td class="text-center">
                                    <% 
                                        // LOGIC: Show Cancel if Active, Show Record if Completed
                                        if (!"Cancelled".equalsIgnoreCase(status) && !"Completed".equalsIgnoreCase(status)) { 
                                    %>
                                        <a href="CancelAppointmentServlet?id=<%= appt.getAppointmentID() %>" 
                                           class="btn btn-outline-danger btn-sm"
                                           onclick="return confirm('Are you sure you want to cancel this appointment?');"
                                           title="Cancel Appointment">
                                            <i class="fas fa-trash-alt me-1"></i> Cancel
                                        </a>
                                    
                                    <% } else if ("Completed".equalsIgnoreCase(status)) { %>
                                        
                                        <a href="ViewRecordServlet?id=<%= appt.getAppointmentID() %>" 
                                           class="btn btn-outline-primary btn-sm"
                                           title="View Notes">
                                            <i class="fas fa-file-medical me-1"></i> View Record
                                        </a>

                                    <% } else { %>
                                        <span class="text-muted">-</span>
                                    <% } %>
                                </td>
                            </tr>
                            <% 
                                    } 
                                } else { 
                            %>
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <i class="fas fa-calendar-times fa-2x mb-3"></i><br>
                                    You haven't made any appointments yet.
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>