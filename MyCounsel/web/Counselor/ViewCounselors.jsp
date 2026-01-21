<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Counselor" %>

<%
    // --- SECURITY CHECK - ADMIN ONLY ---
    if (session.getAttribute("userSession") == null || !"counselor".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    String position = (String) session.getAttribute("position");
    if (!"ADMIN".equalsIgnoreCase(position)) {
        response.sendRedirect("CounselorDashboard.jsp");
        return;
    }
    String currentUserName = (String) session.getAttribute("currentUserName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Counselors - Admin</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar { box-shadow: 0 2px 4px rgba(0,0,0,.1); }
        .card { border: none; box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15); border-radius: 0.5rem; }
        .card-header { background-color: #fff; border-bottom: 1px solid #e3e6f0; font-weight: bold; color: #4e73df; }
        .table thead th { background-color: #4e73df; color: white; border: none; }
        .badge-admin { background-color: #dc3545; }
        .badge-counselor { background-color: #6c757d; }
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
                        Welcome, <strong><%= currentUserName %></strong> <span class="badge bg-danger">ADMIN</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="<%= request.getContextPath() %>/DashboardServlet"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-light btn-sm ms-2 text-primary" href="LogoutServlet">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-user-tie text-primary me-2"></i>Counselor Management</h2>
        </div>

        <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>
            <% if ("deleted".equals(request.getParameter("success"))) { %>
                Counselor deleted successfully!
            <% } else if ("updated".equals(request.getParameter("success"))) { %>
                Counselor updated successfully!
            <% } %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <div class="card shadow">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">All Counselors</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Position</th>
                                <th style="width: 150px;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                List<Counselor> counselors = (List<Counselor>) request.getAttribute("counselors");
                                if (counselors != null && !counselors.isEmpty()) {
                                    for (Counselor c : counselors) { 
                            %>
                            <tr>
                                <td><%= c.getCounselorID() %></td>
                                <td><%= c.getCounselorName() %></td>
                                <td><%= c.getEmail() %></td>
                                <td>
                                    <% if ("ADMIN".equalsIgnoreCase(c.getPosition())) { %>
                                        <span class="badge badge-admin">ADMIN</span>
                                    <% } else { %>
                                        <span class="badge badge-counselor">COUNSELOR</span>
                                    <% } %>
                                </td>
                                <td>
                                    <a href="DeleteCounselorServlet?id=<%= c.getCounselorID() %>" class="btn btn-danger btn-sm" title="Delete" 
                                       onclick="return confirm('Are you sure you want to delete <%= c.getCounselorName() %>?');">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                            <%      }
                                } else { %>
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4">No counselors found.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>