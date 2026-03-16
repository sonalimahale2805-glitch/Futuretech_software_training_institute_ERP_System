<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Futuretech | Admin Assignments</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Admin_css/admin_dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Admin_css/Admin_assignment.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/Assets/images/logo.png" type="image/x-icon">
</head>

<body>
     <div class="admin_container">
        <div class="logo_name">
            <img src="${pageContext.request.contextPath}/Assets/images/logo.png" alt="institute logo" style="height:60px; border-radius:3px;">
            <div class="name">
                <h2>Futuretech</h2>
                <p>Admin Portal</p>
            </div>
        </div>
        <div class="heading_section">
            <span id="menuBtn" class="menuBtn">&#9776;</span>
            <div class="title">
                <h2>Assignment Management</h2>
                <p>Welcome back, <span id="username">Admin</span></p>
            </div>
            <div class="profile_logo"><h3 id="profile_logo">AN</h3></div>
        </div>
    </div>

    <div id="navbar_and_logout_section">
        <div class="navbar_section">
            <nav class="navbar">
                <a href="${pageContext.request.contextPath}/AdminDashboard" class="deactive">Dashboard</a>
                <a href="${pageContext.request.contextPath}/AdminStudentDirectory" class="deactive">Student Directory</a>
                <a href="${pageContext.request.contextPath}/AdminCourseManagement" class="deactive">Course Management</a>
                <a href="${pageContext.request.contextPath}/AdminFeeTracker" class="deactive">Fee Tracker</a>
                <a href="${pageContext.request.contextPath}/AdminAssignments" class="active">Assignments</a>
                <a href="${pageContext.request.contextPath}/AdminRegister" class="deactive">Register</a>
                <a href="${pageContext.request.contextPath}/AdminSettings" class="deactive">Settings</a>
            </nav>
        </div>
        <div class="logout_section"><h2 id="logout_btn">Logout</h2></div>
    </div>
    
    <main class="main_content">
        <div class="assignment-wrapper">
            <h3>Publish New Assignment</h3>
            <div class="card">
                <form action="AdminAssignments" method="post" enctype="multipart/form-data">
                    <div class="form-row">
                        <input type="text" name="title" placeholder="Assignment Title" class="input-field" required>
                        <input type="date" name="dueDate" class="input-field" required title="Due Date">
                    </div>
                    
                    
                 <textarea name="description" placeholder="Instructions for students (Optional)..." class="text-area"></textarea>
                    <div class="form-footer">
                        <div>
                            <span class="file-label">Attach Resource (Optional):</span>
                            <input type="file" name="file" class="file-input">
                        </div>
                        <button type="submit" class="submit-btn">Publish Assignment</button>
                    </div>
                </form>
            </div>

            <h3>Student Submissions Tracker</h3>
            <div class="card table-card">
                <table class="tracker-table">
                    <thead>
                        <tr>
                            <th>Student Name</th>
                            <th>Assignment</th>
                            <th>Due Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/futuretech_erp", "root", "Mysql@123");
                                Statement st = con.createStatement();
                                ResultSet rs = st.executeQuery("SELECT * FROM submissions ORDER BY id DESC");
                                
                                while(rs.next()) {
                                    String status = rs.getString("status");
                                    String sClass = "";
                                    
                                    if(status.equalsIgnoreCase("Submitted")) sClass = "status-submitted";
                                    else if(status.equalsIgnoreCase("Reviewed")) sClass = "status-reviewed";
                                    else if(status.equalsIgnoreCase("Missing")) sClass = "status-missing";
                                    else sClass = "status-pending";
                        %>
                        <tr>
                            <td class="bold-text"><%= rs.getString("student_name") %></td>
                            <td><%= rs.getString("assignment_name") %></td>
                            <td class="dim-text"><%= rs.getString("due_date") %></td>
                            <td><span class="badge <%= sClass %>"><%= status %></span></td>
                            <td><a href="AdminAssignments?id=<%=rs.getInt("id") %>" class="review-link">Review and Grade</a></td>
                        </tr>
                        <% } con.close(); } catch(Exception e) { out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>"); } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script>
        // Sidebar Toggle for Mobile
        const menuBtn = document.getElementById("menuBtn");
        const navbar_and_logout_section = document.getElementById("navbar_and_logout_section");

        menuBtn.addEventListener("click", () => {
            if (window.innerWidth <= 768) { navbar_and_logout_section.classList.toggle("show"); }
        });

        window.addEventListener("resize", () => {
            if (window.innerWidth > 768) {
                navbar_and_logout_section.classList.add("show");
            } else {
                navbar_and_logout_section.classList.remove("show");
            }
        });
        
        // Logout Functionality
        const logout_btn = document.getElementById("logout_btn");
        logout_btn.addEventListener('click', () => {
            if(confirm("Do you really want to Logout?"))
                window.location.href="${pageContext.request.contextPath}/LogoutServlet";
        });
    </script>
</body>
</html>