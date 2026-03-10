<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Futuretech | Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Admin_css/admin_dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Assets/Admin_css/course_management.css">
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
                <a href="${pageContext.request.contextPath}/AdminCourseManagement" class="active">Course Management</a>
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
     	<div class="dashboard_content">
            <section class="stats_grid">
                <div class="stat_card"><span>Total Courses</span><p id="statTotal">7</p></div>
                <div class="stat_card"><span>Active Courses</span><p>6</p></div>
                <div class="stat_card"><span>Total Students</span><p>1150</p></div>
                <div class="stat_card"><span>Domains</span><p>6</p></div>
            </section>
            <div class="management_box">
                <div class="m_header">
                    <h3>Course & Domain Management</h3>
                    <button class="add_btn" onclick="openModal()"><i class='bx bx-plus'></i> Add New Course</button>
                </div>
                <div class="filter_row">
                    <div class="search_courses">
                        <i class='bx bx-book'></i>
                        <input type="text" id="courseSearch" placeholder="Search courses...">
                    </div>
                    <select class="domain_select">
                        <option>All</option>
                    </select>
                </div>

                <div class="course_grid" id="courseGrid"></div>
            </div>
        </div>
        
        <div class="modal_overlay" id="modalOverlay">
        <div class="modal_content">
            <h2>Create New Course</h2>
            <form id="addCourseForm">
                <div class="form_group"><label>Course Title</label><input type="text" id="newTitle" required></div>
                <div class="form_group"><label>Domain</label><input type="text" id="newDomain" required></div>
                <div class="form_group"><label>Description</label><textarea id="newDesc" rows="2" required></textarea></div>
                <div class="form_group"><label>Fee (₹)</label><input type="text" id="newFee" placeholder="e.g. 40,000" required></div>
                <div class="modal_btns">
                    <button type="button" class="close_btn" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="save_btn">Add Course</button>
                </div>
            </form>
        </div>
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
        
        
        
        
        const courses = [
            { title: "Java Full Stack Development", domain: "Java Development", desc: "Complete Java development with Spring Boot, Hibernate, and React", students: 324, duration: "6 Months", fee: "₹45,000", modules: 12 },
            { title: "Python & Django", domain: "Web Development", desc: "Python programming with Django framework and REST APIs", students: 256, duration: "4 Months", fee: "₹38,000", modules: 10 },
            { title: "Web Development", domain: "Frontend Development", desc: "HTML, CSS, JavaScript, and modern frameworks", students: 198, duration: "3 Months", fee: "₹35,000", modules: 8 },
            { title: "Data Science", domain: "Data Analytics", desc: "Python, Machine Learning, Data Analysis, and Visualization", students: 145, duration: "5 Months", fee: "₹50,000", modules: 14 },
            { title: "DevOps Engineering", domain: "Cloud & DevOps", desc: "Docker, Kubernetes, Jenkins, AWS, and CI/CD pipelines", students: 87, duration: "4 Months", fee: "₹42,000", modules: 11 },
            { title: "Mobile App Development", domain: "Mobile Development", desc: "React Native and Flutter for cross-platform development", students: 112, duration: "5 Months", fee: "₹48,000", modules: 13 }
        ];
        function renderCourses() {
            const grid = document.getElementById('courseGrid');
            document.getElementById('statTotal').innerText = courses.length; // Update stat counter
            grid.innerHTML = courses.map((course, index) => `
                <div class="course_card">
                    <div class="active_badge">Active</div>
                    <div class="icon_box"><i class='bx bx-book-open'></i></div>
                    <h3>${course.title}</h3>
                    <p class="desc">${course.desc}</p>
                    <div class="domain_tag">${course.domain}</div>
                    
                    <div class="metrics_row">
                        <div class="m_item">
                            <i class='bx bx-group'></i>
                            <strong>${course.students}</strong>
                            <span>Students</span>
                        </div>
                        <div class="m_item">
                            <i class='bx bx-time-five'></i>
                            <strong>${course.duration.split(' ')[0]}</strong>
                            <span>${course.duration.split(' ')[1] || 'Months'}</span>
                        </div>
                        <div class="m_item">
                            <i class='bx bx-rupee'></i>
                            <strong>${course.fee.replace('₹','')}</strong>
                            <span>Fee</span>
                        </div>
                    </div>

                    <p class="module_text">${course.modules} Modules</p>

                    <div class="card_btns">
                        <button class="edit_btn"><i class='bx bx-edit-alt'></i> Edit</button>
                        <button class="del_btn" onclick="deleteCourse(${index})"><i class='bx bx-trash'></i></button>
                    </div>
                </div>
            `).join('');
        }
        function openModal() {
            document.getElementById('modalOverlay').style.display = 'flex';
        }
        function closeModal() {
            document.getElementById('modalOverlay').style.display = 'none';
        }
        document.getElementById('addCourseForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const newCourse = {
                title: document.getElementById('newTitle').value,
                domain: document.getElementById('newDomain').value,
                desc: document.getElementById('newDesc').value,
                students: 0,
                duration: "6 Months", 
                fee: "₹" + document.getElementById('newFee').value,
                modules: 10
            };
            courses.unshift(newCourse);
            renderCourses();
            closeModal();
            this.reset();
        });
        function deleteCourse(index) {
            if(confirm("Delete this course?")) {
                courses.splice(index, 1);
                renderCourses();
            }
        }
        document.addEventListener('DOMContentLoaded', renderCourses);
        document.getElementById('courseSearch').addEventListener('input', (e) => {
            const val = e.target.value.toLowerCase();
            document.querySelectorAll('.course_card').forEach(card => {
                const title = card.querySelector('h3').innerText.toLowerCase();
                card.style.display = title.includes(val) ? 'block' : 'none';
            });
        });
    </script>
</body>

</html>