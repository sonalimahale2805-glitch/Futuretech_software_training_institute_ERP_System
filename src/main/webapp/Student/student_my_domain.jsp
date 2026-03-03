<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Futuretech | Student Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Student_css/student_dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Student_css/student_my_domain.css">
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
                <a href="${pageContext.request.contextPath}/StudentMyDomain" class="active">My Domain</a>
                <a href="${pageContext.request.contextPath}/StudentAssignment" class="deactive">Assignments</a>
                <a href="${pageContext.request.contextPath}/StudentFeeHistory" class="deactive">Fee History</a>
                <a href="${pageContext.request.contextPath}/StudentProfile" class="deactive">Profile</a>
            </nav>
        </div>

        <div class="logout_section" id="logout_section">
            <h2 id="logout_btn">Logout</h2>
        </div>
    </div>
    <main class="main_content">
        	   <!-- Course Card -->
          <section class="card">
            <h2>
              <i class="fa-solid fa-layer-group"></i>
              ${courseName}
            </h2>
            <p>Batch: ${batch}</p>

            <div class="grid">
              <div class="box">
                <i class="fa-solid fa-chalkboard-user"></i><br>
                Instructor<br><b>${instructor}</b>
              </div>

              <div class="box">
                <i class="fa-solid fa-clock"></i><br>
                Duration<br><b>${duration}</b>
              </div>

              <div class="box">
                <i class="fa-solid fa-calendar-days"></i><br>
                Start Date<br><b>${startDate}</b>
              </div>

              <div class="box">
                <i class="fa-solid fa-calendar-check"></i><br>
                End Date<br><b>${endDate}</b>
              </div>
            </div>
          </section>

          <!-- Skills Section -->
          <section class="card">
            <h3>
              <i class="fa-solid fa-code"></i>
              Skills & Technologies Covered
            </h3>

            <div class="tags">
              <% List<String> skills = (List<String>) request.getAttribute("skills");
                  if(skills != null){
                  for(String skill : skills){
                  %>
                  <span>
                    <i class="fa-solid fa-check"></i>
                    <%= skill %>
                  </span>
                  <% } } %>
            </div>
          </section>
    </main>
	<%
	if(session.getAttribute("userrole")==null){
%>
	<script type="text/javascript">
		alert("Access Denied! Please login first.")
		window.location.href="../student_authentication.jsp"
	</script>
	<%
	return;
	}
	%>
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

    </script>
</body>

</html>