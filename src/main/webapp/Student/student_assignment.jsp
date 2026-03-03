<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    <main class="main_content">
        <div class="container">

  <!-- UPLOAD SUBMISSION -->
  <div class="card">
    <h2>Upload Submission</h2>

    <div class="upload-box">
      Drop your files here or click to browse <br>
      <small>Supports PDF, DOC, ZIP (Max 10MB)</small><br><br>

      <input type="file" id="file">
    </div>

    <button onclick="submitAssignment()">Submit Assignment</button>
  </div>

  <!-- TASKS DUE -->
  <div class="card">
    <h2>Tasks Due</h2>
    <div id="taskList"></div>
  </div>

</div>

<script>
/* ===========================
   TASK DATA
=========================== */
let tasks = [
  {
    name: "Java Collections Framework",
    desc: "Implement ArrayList, LinkedList, HashMap with examples",
    deadline: "2026-02-05",
    status: "Pending"
  },
  {
    name: "Exception Handling Exercise",
    desc: "Create banking app with proper exception handling",
    deadline: "2026-02-10",
    status: "Pending"
  },
  {
    name: "OOP Principles Project",
    desc: "Design a Library Management System using OOP concepts",
    deadline: "2026-02-01",
    status: "Submitted"
  },
  {
    name: "Core Java Basics",
    desc: "Exercises on data types, operators, control flow",
    deadline: "2026-01-30",
    status: "Reviewed",
    grade: "A+"
  }
];

/* ===========================
   DISPLAY TASKS
=========================== */
function displayTasks() {
  let taskDiv = document.getElementById("taskList");
  taskDiv.innerHTML = "";

  tasks.forEach(t => {
    let badgeText = t.status;

    if (t.grade) {
      badgeText += " ✔ Grade: " + t.grade;
    }

    taskDiv.innerHTML += `
      <div class="task">
        <h4>${t.name}</h4>
        <p>${t.desc}</p>
        <small>Deadline: ${t.deadline}</small><br>
        <span class="badge ${t.status.toLowerCase()}">${badgeText}</span>
      </div>
    `;
  });
}

displayTasks();

/* ===========================
   SUBMIT FUNCTION
=========================== */
function submitAssignment() {
  const fileInput = document.getElementById("file");
  const file = fileInput.files[0];

  if (!file) {
    alert("Please select a file to submit!");
    return;
  }

  const newTask = {
    name: file.name,
    desc: "Uploaded file",
    deadline: "Today",
    status: "Submitted"
  };

  tasks.push(newTask);
  displayTasks();

  alert("File submitted successfully: " + file.name);

  fileInput.value = "";
}
</script>
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