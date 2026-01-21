<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>

<%
    // --- SECURITY CHECK ---
    if (session.getAttribute("userSession") == null || !"counselor".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .card { border: none; box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15); }
        .card-header { background-color: #fff; border-bottom: 1px solid #e3e6f0; }
        .table th { background-color: #4e73df; color: white; border: none; }
        .table-hover tbody tr:hover { background-color: #f8f9fc; }
        .btn-action { margin: 0 2px; }
    </style>
</head>
<body>

    <div class="container-fluid mt-4 px-4">
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h3 mb-0 text-gray-800">Student Management</h1>
            <a href="DashboardServlet" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
            </a>
        </div>

        <div class="card shadow mb-4">
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
                <h6 class="m-0 font-weight-bold text-primary">Registered Students</h6>
                
                <div class="input-group" style="width: 300px;">
                    <span class="input-group-text bg-white border-end-0"><i class="fas fa-search text-muted"></i></span>
                    <input type="text" id="searchInput" class="form-control border-start-0" placeholder="Search student...">
                </div>
            </div>
            
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0" id="studentTable">
                        <thead>
                            <tr>
                                <th></th> <th>Student Name</th>
                                <th>Matrix No</th>
                                <th>Email & Phone</th>
                                <th>Course</th>
                                <th class="text-center" style="width: 150px;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Student> students = (List<Student>) request.getAttribute("students");
                                if (students != null && !students.isEmpty()) {
                                    int count = 1; // Initialize counter
                                    for (Student s : students) {
                            %>
                            <tr>
                                <td class="align-middle text-muted fw-bold"><%= count++ %></td>
                                
                                <td class="align-middle fw-bold">
                                    <%= s.getStudentName() %>
                                </td>
                                <td class="align-middle"><span class="badge bg-light text-dark border"><%= s.getMatrixNumber() %></span></td>
                                <td class="align-middle">
                                    <small class="d-block"><i class="fas fa-envelope me-1 text-muted"></i> <%= s.getStudentEmail() %></small>
                                    <small class="d-block"><i class="fas fa-phone me-1 text-muted"></i> <%= s.getStudentPhone() %></small>
                                </td>
                                <td class="align-middle"><%= s.getCourse() %></td>
                                <td class="align-middle text-center">
                                    <a href="StudentEditServlet?id=<%= s.getStudentID() %>" class="btn btn-sm btn-primary btn-action" title="Edit">
                                        <i class="fas fa-pen"></i>
                                    </a>
                                    <a href="StudentDeleteServlet?id=<%= s.getStudentID() %>" 
                                       class="btn btn-sm btn-danger btn-action" 
                                       onclick="return confirm('Are you sure you want to delete <%= s.getStudentName() %>?');" 
                                       title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                            <% 
                                    } 
                                } else { 
                            %>
                            <tr>
                                <td colspan="6" class="text-center py-5 text-muted">
                                    <i class="fas fa-user-slash fa-3x mb-3"></i><br>
                                    No students found in the database.
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Simple client-side search script
        document.getElementById('searchInput').addEventListener('keyup', function() {
            let filter = this.value.toUpperCase();
            let table = document.getElementById('studentTable');
            let tr = table.getElementsByTagName('tr');

            for (let i = 1; i < tr.length; i++) {
                let tdName = tr[i].getElementsByTagName("td")[1];
                let tdMatrix = tr[i].getElementsByTagName("td")[2];
                
                if (tdName || tdMatrix) {
                    let txtValueName = tdName.textContent || tdName.innerText;
                    let txtValueMatrix = tdMatrix.textContent || tdMatrix.innerText;
                    
                    if (txtValueName.toUpperCase().indexOf(filter) > -1 || txtValueMatrix.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        });
    </script>
</body>
</html>