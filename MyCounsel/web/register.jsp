<%-- 
    File: register.jsp
    Purpose: Modern Registration Page for Students (Matches Login Theme).
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            /* Exact same gradient as Login Page */
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }

        .register-card {
            width: 100%;
            max-width: 750px; /* Slightly wider than login to fit 2 columns */
            border: none;
            border-radius: 1rem;
            box-shadow: 0 1rem 3rem rgba(0, 0, 0, 0.175);
            background: white;
            overflow: hidden;
        }

        .card-header {
            background-color: transparent;
            border-bottom: 1px solid #f0f0f0;
            padding: 1.5rem;
            text-align: center;
        }

        .form-floating > label {
            padding-left: 15px;
        }
        
        /* Green button for Registration (Positive Action) */
        .btn-register {
            background-color: #2ecc71;
            border: none;
            padding: 12px;
            font-size: 1.1rem;
            transition: all 0.3s;
        }

        .btn-register:hover {
            background-color: #27ae60;
            transform: translateY(-2px);
        }
        
        /* Input Focus Color */
        .form-control:focus {
            border-color: #2ecc71;
            box-shadow: 0 0 0 0.25rem rgba(46, 204, 113, 0.25);
        }
    </style>
</head>
<body>

    <div class="d-flex justify-content-center align-items-center min-vh-100 p-4">
        
        <div class="card register-card">
            
            <div class="card-header">
                <h3 class="fw-bold text-dark mb-1"><i class="fas fa-user-plus me-2 text-success"></i>Create Account</h3>
                <p class="text-muted small mb-0">Fill in your details to register as a student</p>
            </div>

            <div class="card-body p-4">
                
                <form action="RegisterServlet" method="POST" class="row g-3">
                    
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="matrix" name="matrixNumber" placeholder="2025xxxxxx" required>
                            <label for="matrix">Student ID (Matrix No)</label>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="fullname" name="studentName" placeholder="John Doe" required>
                            <label for="fullname">Full Name</label>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="email" class="form-control" id="email" name="studentEmail" placeholder="name@example.com" required>
                            <label for="email">Email Address</label>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="phone" name="studentPhone" placeholder="012-3456789" required>
                            <label for="phone">Phone Number</label>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="course" name="course" placeholder="CS110" required>
                            <label for="course">Course Code (e.g., CS110)</label>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="password" class="form-control" id="password" name="studentPassword" placeholder="Password" required>
                            <label for="password">Password</label>
                        </div>
                    </div>

                    <div class="col-12 mt-4">
                        <button type="submit" class="btn btn-success btn-register w-100 text-white fw-bold shadow-sm">
                          Register Now
                        </button>
                    </div>

                </form>
            </div>

            <div class="card-footer bg-light text-center py-3 border-0">
                <div class="small">
                    <span class="text-muted">Already have an account?</span> 
                    <a href="login.jsp" class="fw-bold text-decoration-none" style="color: #4e73df;">Back to Login</a>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>