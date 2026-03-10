<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin | Dashboard</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
    :root {
    --bg_color: #0f172a;
    --card_bg_color: #151e31;
    --card_border_color: #2c3346;
    --card_shadow: #00000080;
    --card_hover_border_color: #384158;
    --white_text: #fff;
    --gray_text: #99a1af;
    --input_bg_color: #21293c;
    --input_border_color: #38404f;
    --btn_g_left: #923aea;
    --btn_g_right: #2cd1ee;
    --btn_text_color: #ffffff;
    --navbar_bg_color: #1b2637;
    --header_bg_color: #162033;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Poppins', Arial, sans-serif;
    min-height: 100vh;
    background-color: var(--bg_color);
     overflow-x: hidden;
    margin: 0;
    
}

h1,
h2 {
    color: var(--white_text);
    margin-bottom: 15px;
}

p,
label {
    color: var(--gray_text);
    margin-bottom: 15px;
}

.logo_name {
    width: 240px;
    min-width: 240px;
    height: 90px;
    display: flex;
    align-items: center;
    padding: 0 15px;
    background-color: var(--navbar_bg_color);
    border: 1px solid var(--gray_text);
    border-top: none;
}

.logo_name .name {
    padding-left: 20px;
    padding-top: 15px;
}

.heading_section {
    flex: 1;
    height: 90px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 30px;
    background-color: var(--header_bg_color);
    border: 1px solid var(--gray_text);
    border-top: none;
    border-left: none;
}

.profile_logo {
    background: linear-gradient(135deg, var(--btn_g_left), var(--btn_g_right));
    padding: 15px;
    border-radius: 50%;
    color: var(--white_text);
}

.admin_container {
    margin: 0;
    padding: 0;
    display: flex;
    width: 100%;
    top: 0;
    left: 0;
    height: 90px;
    position: fixed;
    z-index: 1000;

}

.navbar_section {
    display: flex;
}

.navbar {
    top: 90px;
    left: 0;
    position: fixed;
    display: flex;
    flex-direction: column;
    background-color: var(--navbar_bg_color);
    border: 1px solid var(--gray_text);
    width: 240px;
    min-width: 240px;
    border-top: none;
    height: calc(100vh - 180px);
    padding: 30px 0px;
}

.navbar a {
    text-decoration: none;
    margin-bottom: 10px;
    color: var(--white_text);
    font-size: 18px;
    padding: 10px 10px;
    width: 200px;
    margin-left: 20px;

}

.active {
    background: linear-gradient(135deg, var(--btn_g_left), var(--btn_g_right));
    padding-top: 13px;
    padding-bottom: 13px;
    padding-left: 20px;
    border-radius: 15px;
    color: var(--white_text);
    font-size: 21px;
    box-shadow: 0 10px 25px var(--card_shadow);
    transition: 0.3s;

}

.active:hover {
    box-shadow: 0 0 10px 1px var(--btn_g_right);


}

.deactive {
    padding-left: 50px;
    transition: .3s;
}

.deactive:hover {
    background-color: var(--bg_color);
    padding: 10px;
    border-radius: 15px;
    padding-left: 20px;
}

.logout_section {
    display: flex;
    position: fixed;
    background-color: var(--navbar_bg_color);
    width: 240px;
    min-width: 240px;
    height: 90px;
    border: 1px solid var(--gray_text);
    justify-content: center;
    align-items: center;
    left: 0;
    bottom: 0;
}

.logout_section h2 {
    color: red;
    text-shadow: none;
    margin-left: -85px;
    margin-top: auto;
    font-size: 20px;
    cursor: pointer;
}


.stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.stat_card {
    background: var(--card_bg_color);
    border: 1px solid var(--card_border_color);
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 10px 25px var(--card_shadow);
}

.stat_card h2 {
    font-size: 28px;
}

.green { color: #22c55e; }
.blue { color: #38bdf8; }
.purple { color: #a855f7; }

.card {
    background: var(--card_bg_color);
    border: 1px solid var(--card_border_color);
    border-radius: 15px;
    padding: 20px;
}

.card_header {
    display: flex;
    justify-content: space-between;
    align-items: center;
     flex-wrap: wrap;  
    gap: 10px;
}

.add_btn {
    background: linear-gradient(135deg, var(--btn_g_left), var(--btn_g_right));
    border: none;
    padding: 12px 18px;
    border-radius: 12px;
    color: white;
    cursor: pointer;
}

.filters {
    display: flex;
    gap: 15px;
    margin: 20px 0;
     flex-wrap: wrap;
}

.filters input,
.filters select {
    background: var(--input_bg_color);
    border: 1px solid var(--input_border_color);
    padding: 12px;
    border-radius: 10px;
    color: white;
    flex: 1;
     min-width: 150px;
}

.table_wrapper {
    overflow-x: auto;
}

table {
    width: 100%;
     min-width: 700px; 
    border-collapse: collapse;
}

th, td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid var(--card_border_color);
    color: var(--gray_text);
}

th {
    color: var(--white_text);
}

.progress {
    background: #1f2937;
    border-radius: 10px;
    height: 8px;
    width: 100px;
    margin-bottom: 5px;
}

.progress span {
    display: block;
    height: 100%;
    border-radius: 10px;
    background: linear-gradient(135deg, var(--btn_g_left), var(--btn_g_right));
}
.status {
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 14px;
}

.status.active { background: #14532d; color: #22c55e; }
.status.completed { background: #0f3c4c; color: #38bdf8; }
.status.suspended { background: #4c1d1d; color: #ef4444; }

.actions {
    font-size: 18px;
    cursor: pointer;
}


.search_box {
    position: relative;
    flex: 1;
}

.search_box i {
    position: absolute;
    top: 50%;
    left: 15px;
    transform: translateY(-50%);
    color: #9ca3af;
}

.search_box input {
    padding-left: 40px;
}

.call_icon {
    color: #22c55e;
    margin-right: 6px;
}

.actions i {
    margin-right: 5px;
    cursor: pointer;
    font-size: 14px;
    transition: 0.3s;
    
}

.actions .view {
    color: #38bdf8;
}

.actions .edit {
    color: #22c55e;
}

.actions .delete {
    color: #ef4444;
}

.actions i:hover {
    transform: scale(1.2);
}

.main_content {
    margin-left: 240px;
    margin-top: 90px;
    padding: 30px;
    width: calc(100% - 240px);
    min-height: calc(100vh - 90px);
}
@media (max-width: 768px) {

    .admin_container {
        flex-direction: column;
        height: auto;
        position: relative;
    }

    .logo_name {
        width: 100%;
        min-width: 100%;
    }

    .heading_section {
        width: 100%;
    }

    .navbar {
        position: relative;
        width: 100%;
        min-width: 100%;
        height: auto;
        flex-direction: row;
        overflow-x: auto;
        padding: 10px;
        top: 0;
    }

    .navbar a {
        width: auto;
        margin: 0 10px;
        font-size: 14px;
    }

    .logout_section {
        position: relative;
        width: 100%;
    }

    .main_content {
        margin-left: 0;
        margin-top: 0;
        width: 100%;
        height: auto;
        padding: 15px;
    }

}
@media (max-width: 768px) {

    body {
        overflow-y: auto;
    }

    .main_content {
        margin-left: 0;
        margin-top: 0;
        width: 100%;
        min-height: auto;
    }

}
    </style>


</head>

<body>

<!-- HEADER -->
<div class="admin_container">
    <div class="logo_name">
        <img src="images/image.png" style="height:60px;">
        <div class="name">
            <h2>Futuretech</h2>
            <p>Admin Portal</p>
        </div>
    </div>

    <div class="heading_section">
        <div class="title">
            <h2>My Dashboard</h2>
            <p>Welcome back, <span>Admin</span></p>
        </div>
        <div class="profile_logo">
            <h3>AN</h3>
        </div>
    </div>
</div>

<!-- SIDEBAR -->
<div class="navbar_section">
    <nav class="navbar">
        <a href="#" class="deactive">Dashboard</a>
        <a href="#" class="active">Student Directory</a>
        <a href="#" class="deactive">Course Management</a>
        <a href="#" class="deactive">Fee Tracker</a>
        <a href="#" class="deactive">Assignments</a>
        <a href="#" class="deactive">Register</a>
        <a href="#" class="deactive">Settings</a>
    </nav>
</div>

<div class="main_content">

<div class="card_header">
    <h2>Student Directory</h2>
    <button class="add_btn" onclick="openAddModal()">+ Add Student</button>
</div>

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

<%
List<Map<String,Object>> students =
(List<Map<String,Object>>)request.getAttribute("students");

if(students != null){
for(Map<String,Object> s : students){
%>

<tr>
<td>
<strong><%= s.get("name") %></strong><br>
<span>ID: <%= s.get("id") %></span>
</td>

<td>
<%= s.get("email") %><br>
<i class="fa-solid fa-phone call_icon"></i>
<%= s.get("phone") %>
</td>

<td><%= s.get("course") %></td>
<td><%= s.get("batch") %></td>

<td>
<div class="progress">
<span style="width:<%= s.get("progress") %>%"></span>
</div>
<%= s.get("progress") %>%
</td>

<td>
<span class="status <%= s.get("status") %>">
<%= s.get("status") %>
</span>
</td>

<td class="actions">

<a href="StudentDirectory?action=view&id=<%= s.get("id") %>">
<i class="fa-solid fa-eye view"></i>
</a>

<a href="StudentDirectory?action=edit&id=<%= s.get("id") %>">
<i class="fa-solid fa-pen edit"></i>
</a>

<form action="StudentDirectory" method="post" style="display:inline;">
<input type="hidden" name="action" value="delete">
<input type="hidden" name="id" value="<%= s.get("id") %>">
<button type="submit" style="background:none;border:none;">
<i class="fa-solid fa-trash delete"></i>
</button>
</form>

</td>
<%
}
}else{
%>
<tr>
<td colspan="7">No Students Found</td>
</tr>
<%
}
%>

</tbody>
</table>
</div>

</div>
</div>

<div class="logout_section">
    <a href="StudentDirectory">
        <h2>Logout</h2>
    </a>
</div>
<div id="addStudentModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:#00000080;">
    <div style="background:#151e31; color:white; width:400px; margin:100px auto; padding:20px; border-radius:10px;">
        <h3>Add Student</h3>

        <form action="StudentDirectory" method="post">
            <input type="hidden" name="action" value="add">

            <input type="text" name="name" placeholder="Name"><br><br>
            <input type="email" name="email" placeholder="Email"><br><br>
            <input type="text" name="phone" placeholder="Phone"><br><br>
            <input type="text" name="course" placeholder="Course"><br><br>
            <input type="text" name="batch" placeholder="Batch"><br><br>
            <input type="number" name="progress" placeholder="Progress"><br><br>
            <input type="text" name="status" placeholder="Status"><br><br>

            <button type="submit">Save</button>
            <button type="button" onclick="closeAddModal()">Cancel</button>
        </form>
    </div>

</div>
<%
String viewName = (String)request.getAttribute("editName");
if(viewName != null){
%>

<div style="position:fixed;top:0;left:0;width:100%;height:100%;background:#00000080;">
<div style="background:#151e31; color:white; width:400px; margin:100px auto; padding:20px; border-radius:10px;">
<h3>Student Details</h3>

<p><b>Name:</b> <%= request.getAttribute("editName") %></p>
<p><b>Email:</b> <%= request.getAttribute("editEmail") %></p>
<p><b>Phone:</b> <%= request.getAttribute("editPhone") %></p>
<p><b>Course:</b> <%= request.getAttribute("editCourse") %></p>
<p><b>Batch:</b> <%= request.getAttribute("editBatch") %></p>
<p><b>Progress:</b> <%= request.getAttribute("editProgress") %>%</p>
<p><b>Status:</b> <%= request.getAttribute("editStatus") %></p>

<a href="StudentDirectory">Close</a>

</div>
</div>

<%
}
%>
<%
if(request.getAttribute("editStudentId") != null){
%>

<div style="position:fixed;top:0;left:0;width:100%;height:100%;background:#00000080;">
<div style="background:#151e31; color:white; width:400px; margin:100px auto; padding:20px; border-radius:10px;">
<h3>Edit Student</h3>

<form action="StudentDirectory" method="post">

<input type="hidden" name="action" value="update">
<input type="hidden" name="id" value="<%= request.getAttribute("editStudentId") %>">

<input type="text" name="name" value="<%= request.getAttribute("editName") %>"><br><br>
<input type="email" name="email" value="<%= request.getAttribute("editEmail") %>"><br><br>
<input type="text" name="phone" value="<%= request.getAttribute("editPhone") %>"><br><br>
<input type="text" name="course" value="<%= request.getAttribute("editCourse") %>"><br><br>
<input type="text" name="batch" value="<%= request.getAttribute("editBatch") %>"><br><br>
<input type="number" name="progress" value="<%= request.getAttribute("editProgress") %>"><br><br>
<input type="text" name="status" value="<%= request.getAttribute("editStatus") %>"><br><br>

<button type="submit">Update</button>

</form>

<a href="StudentDirectory">Cancel</a>

</div>
</div>

<%
}
%>
<script src="${pageContext.request.contextPath}/js/StudentDirectory.js"></script>
<script>

function openAddModal(){
    document.getElementById("addStudentModal").style.display="block";
}

function closeAddModal(){
    document.getElementById("addStudentModal").style.display="none";
}

</script>
</body>

</html>