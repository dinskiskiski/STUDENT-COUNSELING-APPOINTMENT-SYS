<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // --- SECURITY CHECK ---
    // Only admins should be able to access this page directly
    String role = (String) session.getAttribute("role");
    String position = (String) session.getAttribute("position");

    if (session.getAttribute("userSession") == null || !"counselor".equals(role) || !"ADMIN".equalsIgnoreCase(position)) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register New Counselor</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            /* Consistent Blue Gradient Background */
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }

        .admin-card {
            width: 100%;
            max-width: 500px;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 1rem 3rem rgba(0, 0, 0, 0.175);
            background: white;
            overflow: hidden;
        }

        .card-header {
            background-color: transparent;
            border-bottom: 1px solid #f0f0f0;
            padding: 2rem 1rem 1rem 1rem;
            text-align: center;
        }

        .btn-create {
            background-color: #27ae60;
            border: none;
            padding: 12px;
            font-size: 1.1rem;
            transition: all 0.3s;
        }

        .btn-create:hover {
            background-color: #219150;
            transform: translateY(-2px);
        }

        /* Custom Toggle Styling */
        .btn-check:checked + .btn-outline-primary {
            background-color: #4e73df;
            color: white;
        }
        
        .form-floating > label { padding-left: 15px; }
    </style>
</head>
<body>

    <div class="d-flex justify-content-center align-items-center min-vh-100 p-4">
        
        <div class="card admin-card">
            
            <div class="card-header">
                <div class="mb-2">
                    <i class="fas fa-user-shield fa-3x text-primary"></i>
                </div>
                <h3 class="fw-bold text-dark">Add Staff Member</h3>
                <p class="text-muted small mb-0">Register a new Counselor or Admin</p>
            </div>

            <div class="card-body p-4">
                
                <form action="../CounselorServlet?action=insert" method="post">
                    
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="cName" name="counselorName" placeholder="Full Name" required>
                        <label for="cName">Full Name</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="cEmail" name="email" placeholder="name@example.com" required>
                        <label for="cEmail">Email Address</label>
                    </div>

                    <div class="form-floating mb-4">
                        <input type="password" class="form-control" id="cPass" name="password" placeholder="Password" required>
                        <label for="cPass">Password</label>
                    </div>

                    <div class="mb-4">
                        <label class="form-label text-muted small fw-bold">ASSIGN POSITION</label>
                        <div class="btn-group w-100" role="group">
                            <input type="radio" class="btn-check" name="position" id="posCounselor" value="COUNSELOR" checked required>
                            <label class="btn btn-outline-primary" for="posCounselor">
                                <i class="fas fa-user-md me-1"></i> Counselor
                            </label>

                            <input type="radio" class="btn-check" name="position" id="posAdmin" value="ADMIN" required>
                            <label class="btn btn-outline-danger" for="posAdmin">
                                <i class="fas fa-key me-1"></i> Admin
                            </label>
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-success btn-create text-white fw-bold shadow-sm">
                            Register Counselor
                        </button>
                    </div>

                </form>
            </div>

            <div class="card-footer bg-light text-center py-3 border-0">
                <a href="<%= request.getContextPath()%>/DashboardServlet" class="text-decoration-none fw-bold text-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
                </a>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>