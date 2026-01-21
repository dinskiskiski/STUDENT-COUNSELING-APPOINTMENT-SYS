<%-- 
    File: edit_profile.jsp
    Purpose: Modern, Responsive Profile Editor for Students.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Student"%>
<%@page import="dao.StudentDAO"%> 

<%
    // --- 1. SESSION & SECURITY LOGIC (Preserved) ---
    Object sessionObj = session.getAttribute("userSession");
    Student student = null;

    // Security: Check if session exists at all
    if (sessionObj == null) {
        response.sendRedirect("../login.jsp"); // Adjusted path assuming this is in a subfolder
        return;
    }

    // Smart Check: Get Student Object
    if (sessionObj instanceof Student) {
        student = (Student) sessionObj;
    } 
    else if (sessionObj instanceof String) {
        String tempID = (String) sessionObj;
        StudentDAO dao = new StudentDAO();
        student = dao.getStudentById(tempID);
    }
    
    // Safety check
    if (student == null) {
        response.sendRedirect("../login.jsp?error=SessionError");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            /* Consistent Blue Gradient */
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }

        .profile-card {
            width: 100%;
            max-width: 800px; /* Wide enough for 2 columns */
            border: none;
            border-radius: 1rem;
            box-shadow: 0 1rem 3rem rgba(0, 0, 0, 0.175);
            background: white;
            overflow: hidden;
        }

        .card-header {
            background-color: white;
            border-bottom: 1px solid #f0f0f0;
            padding: 1.5rem;
        }
        
        .section-title {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 700;
            color: #4e73df;
            margin-bottom: 1rem;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 5px;
        }

        .form-floating > label { padding-left: 15px; }

        .btn-save {
            background-color: #2ecc71;
            border: none;
            padding: 10px 25px;
            font-weight: bold;
            transition: all 0.3s;
        }
        .btn-save:hover { background-color: #27ae60; transform: translateY(-2px); }
    </style>
</head>
<body>

    <div class="d-flex justify-content-center align-items-center min-vh-100 p-4">
        
        <div class="card profile-card">
            
            <div class="card-header d-flex justify-content-between align-items-center">
                <div>
                    <h3 class="fw-bold text-dark mb-0">Update Profile</h3>
                    <p class="text-muted small mb-0">Manage your personal information</p>
                </div>
                <div class="text-center">
                    <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center" style="width: 50px; height: 50px; font-size: 1.2rem;">
                        <i class="fas fa-user-edit"></i>
                    </div>
                </div>
            </div>

            <div class="card-body p-4">
                
                <% String error = request.getParameter("error"); %>
                <% if (error != null) { %>
                    <div class="alert alert-danger d-flex align-items-center" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <div><%= error %></div>
                    </div>
                <% } %>

                <form action="<%= request.getContextPath() %>/UpdateProfileServlet" method="POST">
                    <input type="hidden" name="studentID" value="<%= student.getStudentID() %>">

                    <div class="row g-4">
                        
                        <div class="col-md-6">
                            <h6 class="section-title">Personal Details</h6>

                            <div class="form-floating mb-3">
                                <input type="text" class="form-control bg-light" id="matrix" value="<%= student.getMatrixNumber() %>" readonly>
                                <label for="matrix">Matrix Number (Read-only)</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="name" name="studentName" value="<%= student.getStudentName() %>" required>
                                <label for="name">Full Name</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" id="email" name="studentEmail" value="<%= student.getStudentEmail() %>" required>
                                <label for="email">Email Address</label>
                            </div>
                            
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="phone" name="studentPhone" value="<%= (student.getStudentPhone() != null) ? student.getStudentPhone() : "" %>">
                                <label for="phone">Phone Number</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="course" name="course" value="<%= student.getCourse() %>" required>
                                <label for="course">Course Code</label>
                            </div>
                        </div>

                        <div class="col-md-6 d-flex flex-column">
                            <h6 class="section-title">Security Settings</h6>
                            
                            <div class="alert alert-light border small text-muted">
                                <i class="fas fa-info-circle me-1"></i> Leave these fields blank if you do not wish to change your password.
                            </div>

                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="newPass" name="newPassword" placeholder="New Password">
                                <label for="newPass">New Password</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="confirmPass" name="confirmPassword" placeholder="Confirm Password">
                                <label for="confirmPass">Confirm New Password</label>
                            </div>
                            
                            <div class="mt-auto"></div> 
                        </div>

                    </div> <hr class="my-4">

                    <div class="d-flex justify-content-end gap-2">
                        <a href="<%= request.getContextPath() %>/DashboardServlet" class="btn btn-outline-secondary">
                            Cancel
                        </a>
                        <button type="submit" class="btn btn-success btn-save text-white shadow-sm">
                            <i class="fas fa-save me-2"></i> Save Changes
                        </button>
                    </div>

                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>