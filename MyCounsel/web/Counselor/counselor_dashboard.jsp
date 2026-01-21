<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Appointment" %>
<%@ page import="dao.AppointmentDAO" %>

<%
    // --- SECURITY CHECK ---
    if (session.getAttribute("userSession") == null || !"counselor".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    String counselorID = (String) session.getAttribute("userSession");
    String currentUserName = (String) session.getAttribute("currentUserName");
    String position = (String) session.getAttribute("position");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Counselor Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar { box-shadow: 0 2px 4px rgba(0,0,0,.1); }
        .card { border: none; box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15); border-radius: 0.5rem; }
        .card-header { background-color: #fff; border-bottom: 1px solid #e3e6f0; font-weight: bold; color: #4e73df; }
        .btn-action { margin-right: 5px; }
        .status-tab { font-weight: 500; }
        .table thead th { background-color: #4e73df; color: white; border: none; }
        .nav-tabs .nav-link.active { color: #4e73df; font-weight: bold; border-top: 3px solid #4e73df; }
        .nav-tabs .nav-link { color: #6c757d; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="fas fa-user-md me-2"></i>MyCounsel</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item me-3 text-white">
                        Welcome, <strong><%= currentUserName %></strong>
                        <% if ("ADMIN".equalsIgnoreCase(position)) { %>
                            <span class="badge bg-danger ms-1">ADMIN</span>
                        <% } %>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="StudentListServlet"><i class="fas fa-users"></i> Manage Students</a>
                    </li>
                    <% if ("ADMIN".equalsIgnoreCase(position)) { %>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="ViewCounselorsServlet"><i class="fas fa-user-tie"></i> View Counselors</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="Counselor/CreateCounselor.jsp"><i class="fas fa-plus-circle"></i> New Counselor</a>
                    </li>
                    <% } %>
                    <li class="nav-item">
                        <a class="btn btn-light btn-sm ms-2 text-primary" href="LogoutServlet">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        
        <div class="card shadow mb-4">
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold text-primary">Appointment Management</h6>
            </div>
            <div class="card-body">
                
                <ul class="nav nav-tabs mb-4" id="appointmentTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" type="button" role="tab">
                            <i class="fas fa-hourglass-half me-1"></i> Pending
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="accepted-tab" data-bs-toggle="tab" data-bs-target="#accepted" type="button" role="tab">
                            <i class="fas fa-bell me-1"></i> Accepted / Upcoming
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="completed-tab" data-bs-toggle="tab" data-bs-target="#completed" type="button" role="tab">
                            <i class="fas fa-check-circle me-1"></i> Completed
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="cancelled-tab" data-bs-toggle="tab" data-bs-target="#cancelled" type="button" role="tab">
                            <i class="fas fa-times-circle me-1"></i> Cancelled
                        </button>
                    </li>
                </ul>

                <div class="tab-content" id="appointmentTabsContent">

                    <div class="tab-pane fade show active" id="pending" role="tabpanel">
                        <div class="table-responsive">
                            <table class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th>Student Name</th>
                                        <th>Matrix No</th>
                                        <th>Issue</th>
                                        <th>Date & Time</th>
                                        <th style="width: 200px;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        List<Appointment> pending = (List<Appointment>) request.getAttribute("pendingApps");
                                        if (pending != null && !pending.isEmpty()) {
                                            for (Appointment app : pending) { 
                                    %>
                                    <tr>
                                        <td><%= app.getStudentName() %></td>
                                        <td><%= app.getMatrixNumber() %></td>
                                        <td><%= app.getAppointmentIssue() %></td>
                                        <td><%= app.getAppointmentDate() %> <span class="badge bg-secondary"><%= app.getAppointmentTime() %></span></td>
                                        <td>
                                            <a href="AppointmentServlet?action=update&id=<%= app.getAppointmentID() %>&status=Accepted" class="btn btn-success btn-sm btn-action" title="Accept">
                                                <i class="fas fa-check"></i>
                                            </a>
                                            <a href="AppointmentServlet?action=update&id=<%= app.getAppointmentID() %>&status=Cancelled" class="btn btn-danger btn-sm btn-action" title="Decline" onclick="return confirm('Cancel this appointment?');">
                                                <i class="fas fa-times"></i>
                                            </a>
                                        </td>
                                    </tr>
                                    <%      }
                                        } else { %>
                                    <tr><td colspan="5" class="text-center text-muted py-4">No pending appointments found.</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="accepted" role="tabpanel">
                        <div class="table-responsive">
                            <table class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th>Student Name</th>
                                        <th>Matrix No</th>
                                        <th>Issue</th>
                                        <th>Date & Time</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        List<Appointment> accepted = new AppointmentDAO().getAcceptedAppointments(counselorID);
                                        if (accepted != null && !accepted.isEmpty()) {
                                            for (Appointment app : accepted) { 
                                    %>
                                    <tr>
                                        <td><%= app.getStudentName() %></td>
                                        <td><%= app.getMatrixNumber() %></td>
                                        <td><%= app.getAppointmentIssue() %></td>
                                        <td><%= app.getAppointmentDate() %> <span class="badge bg-info text-dark"><%= app.getAppointmentTime() %></span></td>
                                        <td>
                                            <a href="StartConsultationServlet?id=<%= app.getAppointmentID() %>" class="btn btn-primary btn-sm btn-action">
                                                <i class="fas fa-play"></i> Start
                                            </a>
                                            <a href="AppointmentServlet?action=update&id=<%= app.getAppointmentID() %>&status=Cancelled" class="btn btn-outline-danger btn-sm" onclick="return confirm('Cancel this appointment?');">
                                                Cancel
                                            </a>
                                        </td>
                                    </tr>
                                    <%      }
                                        } else { %>
                                    <tr><td colspan="5" class="text-center text-muted py-4">No upcoming appointments.</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="completed" role="tabpanel">
                        <div class="table-responsive">
                            <table class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th>Student Name</th>
                                        <th>Matrix No</th>
                                        <th>Issue</th>
                                        <th>Date Completed</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        List<Appointment> completed = new AppointmentDAO().getCompletedAppointments(counselorID);
                                        if (completed != null && !completed.isEmpty()) {
                                            for (Appointment app : completed) { 
                                    %>
                                    <tr>
                                        <td><%= app.getStudentName() %></td>
                                        <td><%= app.getMatrixNumber() %></td>
                                        <td><%= app.getAppointmentIssue() %></td>
                                        <td><%= app.getAppointmentDate() %></td>
                                        <td>
                                            <a href="ViewAppointmentRecordServlet?id=<%= app.getAppointmentID() %>" class="btn btn-info btn-sm text-white btn-action">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                            <a href="DeleteAppointmentServlet?id=<%= app.getAppointmentID() %>" class="btn btn-danger btn-sm" onclick="return confirm('Permanently delete this record?');">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                    <%      }
                                        } else { %>
                                    <tr><td colspan="5" class="text-center text-muted py-4">No completed appointments.</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="cancelled" role="tabpanel">
                        <div class="table-responsive">
                            <table class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th>Student Name</th>
                                        <th>Matrix No</th>
                                        <th>Issue</th>
                                        <th>Original Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        List<Appointment> cancelled = new AppointmentDAO().getCancelledAppointments(counselorID);
                                        if (cancelled != null && !cancelled.isEmpty()) {
                                            for (Appointment app : cancelled) { 
                                    %>
                                    <tr class="table-light text-muted">
                                        <td><%= app.getStudentName() %></td>
                                        <td><%= app.getMatrixNumber() %></td>
                                        <td><%= app.getAppointmentIssue() %></td>
                                        <td><%= app.getAppointmentDate() %></td>
                                        <td>
                                            <a href="ViewAppointmentRecordServlet?id=<%= app.getAppointmentID() %>" class="btn btn-secondary btn-sm btn-action">
                                                <i class="fas fa-file-alt"></i> Details
                                            </a>
                                            <a href="DeleteAppointmentServlet?id=<%= app.getAppointmentID() %>" class="btn btn-outline-danger btn-sm" onclick="return confirm('Permanently delete this record?');">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                    <%      }
                                        } else { %>
                                    <tr><td colspan="5" class="text-center text-muted py-4">No cancelled appointments.</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        console.log("Current Position: <%= position %>");
    </script>
</body>
</html>