<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Futuretech | Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Admin_css/admin_dashboard.css">
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
                <h2>My Dashboard</h2>
                <p>Welcome back, <span id="username">Admin Name</span></p>
            </div>
            <div class="profile_logo">
                <h3 id="profile_logo">AN</h3>
            </div>
        </div>
    </div>
    <div id="navbar_and_logout_section">
        <div class="navbar_section">
            <nav class="navbar">
                <a href="${pageContext.request.contextPath}/AdminDashboard" class="deactive">Dashboard</a>
                <a href="${pageContext.request.contextPath}/AdminStudentDirectory" class="active">Student Directory</a>
                <a href="${pageContext.request.contextPath}/AdminCourseManagement" class="deactive">Course Management</a>
                <a href="${pageContext.request.contextPath}/AdminFeeTracker" class="deactive">Fee Tracker</a>
                <a href="${pageContext.request.contextPath}/AdminAssignments" class="deactive">Assignments</a>
                <a href="${pageContext.request.contextPath}/AdminRegister" class="deactive">Register</a>
                <a href="${pageContext.request.contextPath}/AdminSettings" class="deactive">Settings</a>
            </nav>
        </div>

        <div class="logout_section">
            <h2 id="logout_btn">Logout</h2>
        </div>
    </div>
     <main class="main_content">
     	    <div class="table_wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Student</th>
                            <th>Contact</th>
                            <th>Course</th>
                            <th>Batch</th>
                            <th>Progress</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>

                    <tbody>

                        <% List<Map<String,Object>> students =
                            (List<Map<String,Object>>)request.getAttribute("students");

                                if(students != null){
                                for(Map<String,Object> s : students){
                                    %>

                                    <tr>
                                        <td>
                                            <strong>
                                                <%= s.get("name") %>
                                            </strong><br>
                                            <span>ID: <%= s.get("id") %></span>
                                        </td>

                                        <td>
                                            <%= s.get("email") %><br>
                                                <i class="fa-solid fa-phone call_icon"></i>
                                                <%= s.get("phone") %>
                                        </td>

                                        <td>
                                            <%= s.get("course") %>
                                        </td>
                                        <td>
                                            <%= s.get("batch") %>
                                        </td>

                                        <td>
                                            <div class="progress">
                                                <span style="width:<%= s.get(" progress") %>%"></span>
                                            </div>
                                            <%= s.get("progress") %>%
                                        </td>

                                        <td>
                                            <span class="status <%= s.get(" status") %>">
                                                <%= s.get("status") %>
                                            </span>
                                        </td>

                                        <td class="actions">

                                            <a href="StudentDirectory?action=view&id=<%= s.get(" id") %>">
                                                <i class="fa-solid fa-eye view"></i>
                                            </a>

                                            <a href="StudentDirectory?action=edit&id=<%= s.get(" id") %>">
                                                <i class="fa-solid fa-pen edit"></i>
                                            </a>

                                            <form action="StudentDirectory" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="<%= s.get(" id") %>">
                                                <button type="submit" style="background:none;border:none;">
                                                    <i class="fa-solid fa-trash delete"></i>
                                                </button>
                                            </form>

                                        </td>
                                        <% } }else{ %>
                                    <tr>
                                        <td colspan="7">No Students Found</td>
                                    </tr>
                                    <% } %>

                    </tbody>
                </table>
            </div>
     </main>
    
    
    
    <%
	if(session.getAttribute("userrole")==null){
%>
	<script type="text/javascript">
		alert("Access Denied! Please login first.")
		window.location.href="../admin_authentication.jsp"
	</script>
	<%
	return;
	}
	%>
	<script>
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
        
        const logout_btn=document.getElementById("logout_btn");
        logout_btn.addEventListener('click',()=>{
        	if(confirm("Do you realy want to Logout"))
        		window.location.href="${pageContext.request.contextPath}/LogoutServlet";
        })
        
        document.querySelector(".add_btn").onclick = function() {
    document.getElementById('addStudentModal').style.display = 'block';
}


window.onclick = function(event) {
    let modal = document.getElementById('addStudentModal');
    if (event.target === modal) {
        modal.style.display = 'none';
    }
}
    </script>
</body>

</html>