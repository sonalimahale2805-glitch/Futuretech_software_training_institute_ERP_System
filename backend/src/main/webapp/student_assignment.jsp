<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, DataBase.DBConnection" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Futuretech | Student Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Student_css/student_dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Student_css/student_assignment.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/Assets/images/logo.png" type="image/x-icon">
</head>

<body>
    <div class="student_container">
        <div class="logo_name" id="logo_name">
            <img id="institute_logo" src="${pageContext.request.contextPath}/Assets/images/logo.png" alt="institute logo">
            <div class="name">
                <h2>Futuretech</h2>
                <p>Student Portal</p>
            </div>
        </div>
        <div class="heading_section">
            <span id="menuBtn" class="menuBtn">&#9776;</span>
            <div class="title">
                <h2>My Dashboard</h2>
                <p>Welcome back, <span id="username">Student Name</span></p>
            </div>
            <div class="profile_logo">
                <h3 id="profile_logo">SN</h3>
            </div>
        </div>
    </div>
    <div id="navbar_and_logout_section">
        <div class="navbar_section" id="sidebar">
            <nav class="navbar" id="navbar">
                <a href="${pageContext.request.contextPath}/StudentDashboard" class="deactive">Dashboard</a>
                <a href="${pageContext.request.contextPath}/StudentMyDomain" class="deactive">My Domain</a>
                <a href="${pageContext.request.contextPath}/StudentAssignment" class="active">Assignments</a>
                <a href="${pageContext.request.contextPath}/StudentFeeHistory" class="deactive">Fee History</a>
                <a href="${pageContext.request.contextPath}/StudentProfile" class="deactive">Profile</a>
            </nav>
        </div>

        <div class="logout_section" id="logout_section">
            <h2 id="logout_btn">Logout</h2>
        </div>
    </div>

<main class="container">
    <div class="card">
        <h2>Upload Submission</h2>
        <div id="selected-task-name">Please select a task from the list below</div>

        <form action="StudentAssignment" method="post" enctype="multipart/form-data">
            <input type="hidden" name="assignment_id" id="assignment_id" required>
            
            <div class="upload-box" onclick="document.getElementById('file-input').click()">
                <span id="file-label">Drop your files here or click to browse</span> <br>
                <small>Supports PDF, DOC, ZIP (Max 10MB)</small>
                <input type="file" name="file" id="file-input" required onchange="showFileName()">
            </div>

            <button type="submit" class="submit-btn">Submit Assignment</button>
        </form>
    </div>

    <div class="card">
        <h2>Tasks Due</h2>
        <div id="taskList">
            <%
                try(Connection con = DBConnection.getConnection()) {
                    // Fetch assignments and join with submissions to show status
                    String query = "SELECT a.id, a.title, a.description, a.deadline, s.status, s.marks FROM assignments a LEFT JOIN submissions s ON a.id = s.assignment_id";
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery(query);
                    
                    while(rs.next()) {
                        String status = (rs.getString("status") == null) ? "Pending" : rs.getString("status");
                        String grade = rs.getString("marks");
            %>
                <div class="task" id="task-<%= rs.getInt("id") %>" onclick="selectAssignment('<%= rs.getInt("id") %>', '<%= rs.getString("title") %>')">
                    <h4><%= rs.getString("title") %></h4>
                    <p><%= rs.getString("description") %></p>
                    <small>Deadline: <%= rs.getString("deadline") %></small><br>
                    <span class="badge <%= status.toLowerCase() %>">
                        <%= status %> <%= (grade != null) ? " | Grade: " + grade : "" %>
                    </span>
                </div>
            <%
                    }
                } catch(Exception e) { out.println("Error: " + e.getMessage()); }
            %>
        </div>
    </div>  
    </main>

    <script>
        const logout_btn=document.getElementById("logout_btn");
        logout_btn.addEventListener('click',()=>{
        	if(confirm("Do you realy want to Logout"))
        		window.location.href="${pageContext.request.contextPath}/LogoutServlet";
        })
        const menuBtn = document.getElementById("menuBtn");
        const navbar_and_logout_section = document.getElementById("navbar_and_logout_section");

        menuBtn.addEventListener("click", () => {
            if (window.innerWidth <= 768) {
                navbar_and_logout_section.classList.toggle("show");
            }
        });

        window.addEventListener("resize", () => {
            if (window.innerWidth > 768) {
                navbar_and_logout_section.classList.add("show");
            } else {
                navbar_and_logout_section.classList.remove("show");
            }
        });

    
    // Set assignment ID when a task is clicked
    function selectAssignment(id, name) {
        document.getElementById('assignment_id').value = id;
        document.getElementById('selected-task-name').innerText = "Selected: " + name;
        document.querySelectorAll('.task').forEach(t => t.classList.remove('active'));
        document.getElementById('task-' + id).classList.add('active');
    }

    // Display the file name after selection
    function showFileName() {
        const fileInput = document.getElementById('file-input');
        const fileLabel = document.getElementById('file-label');
        if (fileInput.files.length > 0) {
            fileLabel.innerText = "File Selected: " + fileInput.files[0].name;
        }
    }

    // Display success or error message from Servlet
    <% if(request.getAttribute("msg") != null) { %>
        alert("<%= request.getAttribute("msg") %>");
    <% } %>
</script>
</body>

</html>