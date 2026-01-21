<%-- 
    File: make_appointment.jsp
    Purpose: Student booking form with Fixed Time Slots.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Student"%>
<%
    // --- 1. SESSION CHECK ---
    Object sessionObj = session.getAttribute("userSession");
    String studentID = "";

    if (sessionObj == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // Extract ID safely (whether session is an Object or String)
    if (sessionObj instanceof Student) {
        studentID = ((Student) sessionObj).getStudentID(); // Adjust getter if needed (e.g. getMatrixNo)
    } else {
        studentID = sessionObj.toString();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            /* Consistent Blue Gradient */
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }

        .booking-card {
            width: 100%;
            max-width: 500px;
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
            text-align: center;
        }
        
        /* Highlight the labels inside floating forms */
        .form-floating > label { padding-left: 15px; }

        .btn-book {
            background-color: #4e73df;
            border: none;
            padding: 12px;
            font-weight: bold;
            transition: all 0.3s;
        }
        .btn-book:hover { background-color: #2e59d9; transform: translateY(-2px); }
    </style>
</head>
<body>

    <div class="d-flex justify-content-center align-items-center min-vh-100 p-4">
        
        <div class="card booking-card">
            
            <div class="card-header">
                <h3 class="fw-bold text-primary mb-0"><i class="fas fa-calendar-check me-2"></i>Book Session</h3>
                <p class="text-muted small mb-0">Select a date and time slot</p>
            </div>

            <div class="card-body p-4">
                
                <% String error = (String) request.getAttribute("errorMsg"); %>
                <% if (error != null) { %>
                    <div class="alert alert-danger d-flex align-items-center" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <div><%= error %></div>
                    </div>
                <% } %>

                <form action="<%= request.getContextPath() %>/AppointmentServlet" method="POST">
                    
                    <input type="hidden" name="studentID" value="<%= studentID %>">

                    <div class="form-floating mb-3">
                        <input type="date" class="form-control" id="date" name="appointmentDate" required
                               min="<%= new java.sql.Date(System.currentTimeMillis()) %>">
                        <label for="date">Preferred Date</label>
                    </div>

                    <div class="form-floating mb-3">
                        <select class="form-select" id="timeSlot" name="appointmentTime" required>
                            <option value="" selected disabled>Select a time...</option>
                            <option value="08:00">08:00 AM</option>
                            <option value="10:00">10:00 AM</option>
                            <option value="12:00">12:00 PM</option>
                            <option value="14:00">02:00 PM</option>
                            <option value="16:00">04:00 PM</option>
                        </select>
                        <label for="timeSlot">Time Slot</label>
                    </div>

                    <div class="form-floating mb-4">
                        <textarea class="form-control" placeholder="Describe your issue" id="issue" name="appointmentIssue" style="height: 120px" required></textarea>
                        <label for="issue">Reason for Consultation</label>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary btn-book text-white shadow-sm">
                            Submit Request
                        </button>
                        <a href="<%= request.getContextPath() %>/DashboardServlet" class="btn btn-light text-secondary">
                            Cancel
                        </a>
                    </div>

                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>