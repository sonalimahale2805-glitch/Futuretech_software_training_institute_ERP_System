<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Futuretech | Student Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Student_css/student_dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Student_css/student_profile.css">
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
                <a href="${pageContext.request.contextPath}/StudentAssignment" class="deactive">Assignments</a>
                <a href="${pageContext.request.contextPath}/StudentFeeHistory" class="deactive">Fee History</a>
                <a href="${pageContext.request.contextPath}/StudentProfile" class="active">Profile</a>
            </nav>
        </div>

        <div class="logout_section" id="logout_section">
            <h2 id="logout_btn">Logout</h2>
        </div>
    </div>
    <main class="main_content">
        <div class="content-container">
      <div class="profile-card">
        <div class="avatar-box" id="avatarBox">
          <img id="profileImg">
          <span id="avatarText">SM</span>
          <input type="file" id="imgUpload" hidden>
        </div>
        <div class="user-info">
          <h3 id="displayName">Shubhada Mate</h3>
          <p id="displayEmail">shubhada@123.com</p>
          <div class="domain-text">
            <p id="displayDomain">Domain:Full Stack Development</p>
          </div>
          <br>
          <button class="edit-btn" id="editBtn">Edit Profile</button>
        </div>
      </div>

      <div class="info-panel">
        <div class="row">
          <label>Student Name</label>
          <input type="text" value="Shubhada Mate" disabled>
        </div>
        <div class="row">
          <label>Domain</label>
          <input type="text" value="Full Stack Development" disabled>
        </div>
        <div class="row">
          <label>Batch</label>
          <input type="text" value="Spring 2026" disabled>
        </div>
        <div class="row">
          <label>Contact Number</label>
          <input type="text" value="+91 1234567890" disabled>
        </div>
        <div class="row">
          <label>Student E-Mail</label>
          <input type="text" value="shubhada@123.com" disabled>
        </div>
        <div class="row">
          <label>Account Status</label>
          <input type="text" value="Active" disabled style="color: #4ade80;">
        </div>
      </div>
    </div>
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