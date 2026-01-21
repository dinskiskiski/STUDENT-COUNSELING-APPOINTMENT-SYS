<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Appointment" %>
<%
    // Retrieve the appointment object sent by the Servlet
    Appointment app = (Appointment) request.getAttribute("appointment");

    // Safety Check: If someone tries to access this page directly without an appointment
    if (app == null) {
        response.sendRedirect("DashboardServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultation Session</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            /* Consistent Blue Gradient */
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            padding-bottom: 40px; /* Space for scrolling */
        }

        .consultation-card {
            width: 100%;
            max-width: 800px; /* Wide card for comfortable typing */
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
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        /* The grey box containing student info */
        .student-info-panel {
            background-color: #f8f9fc;
            border-left: 5px solid #4e73df; /* Blue accent line */
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 25px;
        }

        .info-label {
            font-size: 0.8rem;
            text-transform: uppercase;
            color: #858796;
            font-weight: bold;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-weight: 600;
            color: #5a5c69;
            font-size: 1.1rem;
        }

        textarea.form-control {
            border: 1px solid #d1d3e2;
            padding: 15px;
            font-size: 1rem;
            resize: vertical; /* Allow vertical resizing only */
        }

        textarea.form-control:focus {
            border-color: #4e73df;
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
        }

        .btn-complete {
            background-color: #2ecc71;
            border: none;
            padding: 10px 25px;
            font-weight: bold;
        }
        .btn-complete:hover { background-color: #27ae60; }
    </style>
</head>
<body>

    <div class="d-flex justify-content-center align-items-center min-vh-100 p-4">
        
        <div class="card consultation-card">
            
            <div class="card-header">
                <div>
                    <h4 class="fw-bold text-primary mb-0"><i class="fas fa-file-medical-alt me-2"></i>Consultation Session</h4>
                    <span class="text-muted small">Record session notes and recommendations</span>
                </div>
                <div class="text-end">
                    <span class="badge bg-primary fs-6">Session ID: #<%= app.getAppointmentID() %></span>
                </div>
            </div>

            <div class="card-body p-4">
                
                <div class="student-info-panel shadow-sm">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="info-label">Student Name</div>
                            <div class="info-value"><%= app.getStudentName() %></div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-label">Matrix Number</div>
                            <div class="info-value"><%= app.getMatrixNumber() %></div>
                        </div>
                        <div class="col-12 border-top pt-2 mt-2">
                            <div class="info-label">Reported Issue</div>
                            <div class="text-dark"><%= app.getAppointmentIssue() %></div>
                        </div>
                        <div class="col-12">
                            <small class="text-muted">
                                <i class="far fa-calendar-alt me-1"></i> <%= app.getAppointmentDate() %> &nbsp;|&nbsp; 
                                <i class="far fa-clock me-1"></i> <%= app.getAppointmentTime() %>
                            </small>
                        </div>
                    </div>
                </div>

                <form action="StartConsultationServlet" method="POST">
                    <input type="hidden" name="appointmentID" value="<%= app.getAppointmentID() %>">

                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark">
                            <i class="fas fa-align-left me-1 text-secondary"></i> Consultation Notes
                        </label>
                        <textarea name="appointmentNote" class="form-control" rows="6" required 
                                  placeholder="Record key points discussed, student's demeanor, and main concerns..."></textarea>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark">
                            <i class="fas fa-clipboard-check me-1 text-secondary"></i> Recommendation / Action Plan
                        </label>
                        <textarea name="recommendation" class="form-control" rows="4" required 
                                  placeholder="Suggest next steps, follow-up appointments, or resources..."></textarea>
                    </div>

                    <hr class="my-4">

                    <div class="d-flex justify-content-between align-items-center">
                        <a href="DashboardServlet" class="btn btn-outline-secondary">
                            <i class="fas fa-times me-2"></i>Cancel
                        </a>
                        <button type="submit" class="btn btn-success btn-complete text-white shadow-sm" onclick="return confirm('Are you sure you want to complete this session? This cannot be undone.');">
                            <i class="fas fa-check-circle me-2"></i>Complete Session
                        </button>
                    </div>

                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>