<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Student" %>

<%
    // Security Check
    if (session.getAttribute("userSession") == null || !"counselor".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Student s = (Student) request.getAttribute("student");
    // Fallback in case student is null to prevent crash (optional safety)
    if (s == null) {
        response.sendRedirect("StudentListServlet");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student - Counselor Portal</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .card { border: none; box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1); }
        .card-header { background-color: #4e73df; color: white; font-weight: bold; }
        .form-label { font-weight: 500; color: #5a5c69; }
        .input-group-text { background-color: #f8f9fa; }
    </style>
</head>
<body>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                
                <div class="mb-3">
                    <a href="StudentListServlet" class="text-decoration-none text-secondary">
                        <i class="fas fa-arrow-left me-1"></i> Back to Student List
                    </a>
                </div>

                <div class="card">
                    <div class="card-header py-3">
                        <h5 class="m-0"><i class="fas fa-user-edit me-2"></i>Edit Student Details</h5>
                    </div>
                    <div class="card-body p-4">
                        
                        <form action="StudentEditServlet" method="post">
                            <input type="hidden" name="studentID" value="<%= s.getStudentID() %>" />

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Student Name</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <input type="text" name="studentName" class="form-control" value="<%= s.getStudentName() %>" required />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Matrix Number</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                        <input type="text" name="matrixNumber" class="form-control" value="<%= s.getMatrixNumber() %>" required />
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Email Address</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                        <input type="email" name="studentEmail" class="form-control" value="<%= s.getStudentEmail() %>" required />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Phone Number</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                        <input type="text" name="studentPhone" class="form-control" value="<%= s.getStudentPhone() %>" />
                                    </div>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Course / Program</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-graduation-cap"></i></span>
                                    <input type="text" name="course" class="form-control" value="<%= s.getCourse() %>" />
                                </div>
                            </div>

                            <div class="d-flex justify-content-end">
                                <a href="StudentListServlet" class="btn btn-secondary me-2">Cancel</a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i> Update Student
                                </button>
                            </div>

                        </form>
                    </div>
                </div> </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>