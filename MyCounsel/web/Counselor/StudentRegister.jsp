<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Student" %>
<%
    // Security: Only counselor
    if (session.getAttribute("userSession") == null || !"counselor".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Register New Student</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        form { width: 400px; margin: auto; }
        label { display: block; margin-top: 10px; }
        input[type=text], input[type=email], input[type=password] { width: 100%; padding: 8px; }
        input[type=submit] { margin-top: 20px; padding: 10px 20px; }
        nav a { margin-right: 15px; }
    </style>
</head>
<body>
    <h1>Register New Student</h1>

    <!-- Navbar -->
    <nav>
        <a href="CounselorServlet">Dashboard</a>
        <a href="StudentListServlet">Manage Students</a>
        <a href="../LogoutServlet">Logout</a>
    </nav>

    <form action="RegisterStudentServlet" method="post">
        <label for="matrixNumber">Matrix Number:</label>
        <input type="text" name="matrixNumber" id="matrixNumber" required>

        <label for="studentName">Name:</label>
        <input type="text" name="studentName" id="studentName" required>

        <label for="studentEmail">Email:</label>
        <input type="email" name="studentEmail" id="studentEmail" required>

        <label for="studentPhone">Phone:</label>
        <input type="text" name="studentPhone" id="studentPhone">

        <label for="course">Course:</label>
        <input type="text" name="course" id="course">

        <label for="studentPassword">Password:</label>
        <input type="password" name="studentPassword" id="studentPassword" required>

        <input type="submit" value="Register Student">
    </form>

    <% if (request.getAttribute("errorMsg") != null) { %>
        <p style="color:red;"><%= request.getAttribute("errorMsg") %></p>
    <% } %>
    <% if (request.getAttribute("successMsg") != null) { %>
        <p style="color:green;"><%= request.getAttribute("successMsg") %></p>
    <% } %>
</body>
</html>
