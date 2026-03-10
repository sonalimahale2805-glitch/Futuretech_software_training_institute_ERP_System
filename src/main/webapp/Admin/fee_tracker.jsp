<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Futuretech | Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Admin_css/admin_dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Admin_css/fee_tracker.css">
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
                <a href="${pageContext.request.contextPath}/AdminStudentDirectory" class="deactive">Student Directory</a>
                <a href="${pageContext.request.contextPath}/AdminCourseManagement" class="deactive">Course Management</a>
                <a href="${pageContext.request.contextPath}/AdminFeeTracker" class="active">Fee Tracker</a>
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
     	<div class="cards">
      <div class="card">
        <h3>Total Revenue</h3>
        <p id="totalRevenue">₹1,50,000</p>
      </div>
      <div class="card">
        <h3>Collected</h3>
        <p id="totalCollected">₹1,00,000</p>
      </div>
      <div class="card">
        <h3>Pending</h3>
        <p id="totalPending">₹50,000</p>
      </div>
    </div>

    <!-- ADD STUDENT FORM -->
    <h2>Add Student</h2>
    <div class="form">
      <input type="text" id="studentName" placeholder="Student Name">
      <input type="text" id="course" placeholder="Course">
      <input type="number" id="totalFee" placeholder="Total Fee">
      <input type="number" id="paidFee" placeholder="Paid Amount">
      <input type="number" id="installments" placeholder="Installments (e.g. 1/3)">
      <input type="date" id="nextDue">
      <button onclick="addStudent()">Add Student</button>
    </div>

    <h2>Student Fees</h2>

    <table>
      <thead>
        <tr>
          <th>Student</th>
          <th>Course</th>
          <th>Total Fee</th>
          <th>Paid</th>
          <th>Balance</th>
          <th>Installments</th>
          <th>Next Due</th>
          <th>Status</th>
        </tr>
      </thead>

      <tbody id="studentTable">
        <tr>
          <td>sakshi kharat</td>
          <td>Java Full Stack</td>
          <td>₹45,000</td>
          <td>₹45,000</td>
          <td>₹0</td>
          <td>3/3</td>
          <td>-</td>
          <td class="paid">Paid</td>
        </tr>

        <tr>
          <td>sonali mahale</td>
          <td>Python & Django</td>
          <td>₹38,000</td>
          <td>₹25,000</td>
          <td>₹13,000</td>
          <td>2/3</td>
          <td>2028-02-15</td>
          <td class="partial">Partial</td>
        </tr>
      </tbody>
    </table>
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
        
        
        
        
        function addStudent() {
  const name = document.getElementById("studentName").value;
  const course = document.getElementById("course").value;
  const totalFee = parseInt(document.getElementById("totalFee").value);
  const paidFee = parseInt(document.getElementById("paidFee").value);
  const installments = document.getElementById("installments").value;
  const nextDue = document.getElementById("nextDue").value;

  if (!name || !course || !totalFee || !paidFee) {
    alert("Please fill all required fields");
    return;
  }

  const balance = totalFee - paidFee;

  let status = "Partial";
  let statusClass = "partial";

  if (balance === 0) {
    status = "Paid";
    statusClass = "paid";
  }

  const table = document.getElementById("studentTable");

  const row = document.createElement("tr");

  row.innerHTML = `
    <td>${name}</td>
    <td>${course}</td>
    <td>₹${totalFee.toLocaleString()}</td>
    <td>₹${paidFee.toLocaleString()}</td>
    <td>₹${balance.toLocaleString()}</td>
    <td>${installments}</td>
    <td>${nextDue || "-"}</td>
    <td class="${statusClass}">${status}</td>
  `;

  table.appendChild(row);

  // Clear form
  document.getElementById("studentName").value = "";
  document.getElementById("course").value = "";
  document.getElementById("totalFee").value = "";
  document.getElementById("paidFee").value = "";
  document.getElementById("installments").value = "";
  document.getElementById("nextDue").value = "";

  alert("Student Added Successfully ✅");
}
    </script>
</body>

</html>