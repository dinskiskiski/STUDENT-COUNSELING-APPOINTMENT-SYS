<%-- 
    File: login.jsp
    Purpose: Centered Entry point for Students and Counselors.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Counseling System</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            /* Beautiful Blue Gradient Background */
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            /* Ensure body takes full height to allow vertical centering */
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }
        
        /* The Card Styling */
        .login-card {
            width: 100%;
            max-width: 420px; /* Limits width so it looks like a nice box */
            border: none;
            border-radius: 1rem;
            box-shadow: 0 1rem 3rem rgba(0, 0, 0, 0.175);
            background: white;
            overflow: hidden;
        }

        .card-header {
            background-color: transparent;
            border-bottom: none;
            padding-top: 2rem;
            text-align: center;
        }

        .logo-icon {
            font-size: 3.5rem;
            color: #4e73df;
            margin-bottom: 10px;
        }

        .btn-login {
            background-color: #4e73df;
            border: none;
            padding: 12px;
            font-size: 1.1rem;
            transition: all 0.3s;
        }

        .btn-login:hover {
            background-color: #2e59d9;
            transform: translateY(-2px);
        }

        /* Custom Radio Toggle Styling */
        .btn-check:checked + .btn-outline-primary {
            background-color: #4e73df;
            color: white;
            border-color: #4e73df;
        }
        
        /* Input Focus Color */
        .form-control:focus {
            border-color: #4e73df;
            box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.25);
        }
    </style>
</head>
<body>

    <div class="d-flex justify-content-center align-items-center min-vh-100 p-3">
        
        <div class="card login-card">
            
            <div class="card-header">
                <div class="logo-icon"><i class="fas fa-user-md"></i></div>
                <h3 class="fw-bold text-dark mb-0">MyCounsel</h3>
                <p class="text-muted small">Welcome.</p>
            </div>

            <div class="card-body p-4 pt-2">
                
                <% 
                    String msg = (String) request.getAttribute("errorMsg");
                    if (msg != null) { 
                %>
                    <div class="alert alert-danger d-flex align-items-center small py-2" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <div><%= msg %></div>
                    </div>
                <% } %>

                <form action="LoginServlet" method="POST">
                    
                    <div class="mb-4">
                        <div class="btn-group w-100" role="group">
                            <input type="radio" class="btn-check" name="role" id="roleStudent" value="student" checked>
                            <label class="btn btn-outline-primary" for="roleStudent">
                                <i class="fas fa-user-graduate me-1"></i> Student
                            </label>

                            <input type="radio" class="btn-check" name="role" id="roleCounselor" value="counselor">
                            <label class="btn btn-outline-primary" for="roleCounselor">
                                <i class="fas fa-chalkboard-teacher me-1"></i> Counselor
                            </label>
                        </div>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="floatingInput" name="email" placeholder="name@example.com" required>
                        <label for="floatingInput">Email Address</label>
                    </div>

                    <div class="form-floating mb-4">
                        <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Password" required>
                        <label for="floatingPassword">Password</label>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-login text-white fw-bold shadow-sm">
                            Login
                        </button>
                    </div>

                </form>
            </div>

            <div class="card-footer bg-light text-center py-3 border-0">
                <div class="small">
                    <span class="text-muted">New here?</span> 
                    <a href="register.jsp" class="fw-bold text-decoration-none" style="color: #4e73df;">Create an Account</a>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>