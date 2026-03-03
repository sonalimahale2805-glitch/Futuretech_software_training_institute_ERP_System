<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin | Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Admin_css/register.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/Assets/images/logo.png" type="image/x-icon">
</head>
<div class="admin_container">
    <div class="logo_name">
       <img src="${pageContext.request.contextPath}/Assets/images/logo.png" alt="institute logo" style="height:60px; border-radius:3px;">
        <div class="name">
            <h2>Futuretech</h2>
            <p>Admin Portal</p>
        </div>
    </div>
    <div class="heading_section">
        <div class="title">
            <h2>My Dashboard</h2>
            <p>Welcome back, <span>Admin Name</span></p>
        </div>
        <div class="profile_logo">
            <h3>AN</h3>
        </div>
    </div>
</div>

<div class="navbar_section">
    <nav class="navbar">
        <a href="#dashboard" class="deactive">Dashboard</a>
        <a href="#student_directory" class="deactive">Student Directory</a>
        <a href="#course_management" class="deactive">Course Management</a>
        <a href="#fee_tracker" class="deactive">Fee Tracker</a>
        <a href="#assignment" class="deactive">Assignments</a>
        <a href="#register" class="active">Register</a>
        <a href="#settings" class="deactive">Settings</a>
    </nav>
</div>

<div class="logout_section">
    <h2>Logout</h2>
</div>

<body>

</body>

</html>