package studentassignment;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import jakarta.servlet.http.Part;
import DataBase.DBConnection;

@WebServlet("/StudentAssignment") 
@MultipartConfig // Required for handling file uploads
public class StudentAssignment extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // doGet handles page display and setting user info in sidebar
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        response.setContentType("text/html");
		PrintWriter out= response.getWriter();
        
        // Load the JSP page
        request.getRequestDispatcher("student_assignment.jsp").include(request, response);
        
        // Set student name and profile initial in the sidebar using JavaScript
        if (session != null && session.getAttribute("username") != null) {
            String studentName = (String) session.getAttribute("username");
            response.getWriter().println("<script>");
            response.getWriter().println("document.getElementById('username').innerText = '" + studentName + "';");
            response.getWriter().println("document.getElementById('profile_logo').innerText = '" + studentName.toUpperCase().charAt(0) + "';");
            response.getWriter().println("</script>");
        }
    }

    // doPost handles the assignment file upload and database entry
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Get parameters from the frontend form
        String assignmentId = request.getParameter("assignment_id");
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();

        try (Connection con = DBConnection.getConnection()) {
            // 1. Setup the physical path to save the uploaded file
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir(); // Create 'uploads' folder if it doesn't exist
            
            // 2. Write the file to the server's disk
            filePart.write(uploadPath + File.separator + fileName);

            // 3. Prepare SQL query to save submission details in database
            String sql = "INSERT INTO submissions (assignment_id, student_id, file_name, file_path, status, marks) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setInt(1, Integer.parseInt(assignmentId));
            
            // Get Student ID from session, default to 101 if session is empty
            Integer studentId = (session != null && session.getAttribute("student_id") != null) 
                                ? (Integer) session.getAttribute("student_id") : 101;
            ps.setInt(2, studentId);
            
            ps.setString(3, fileName);
            ps.setString(4, "uploads/" + fileName);
            ps.setString(5, "Submitted"); // Default status after upload
            ps.setString(6, "Pending");   // Default marks/grade status

            // Execute the update
            int row = ps.executeUpdate();
            if(row > 0) {
                // Set success message for the alert box in JSP
                request.setAttribute("msg", "Successfully Submitted: " + fileName);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Error: " + e.getMessage());
        }

        // Call doGet to refresh the page and maintain sidebar data
        doGet(request, response);
    }
}


//DATABASE ........


/**--- student section ---
CREATE DATABASE studentdb;
USE studentdb;

CREATE TABLE assignments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    description TEXT,
    deadline DATE
);

CREATE TABLE submissions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    assignment_id INT,
    student_id INT,
    file_name VARCHAR(255),
    file_path VARCHAR(500),
    status VARCHAR(50) DEFAULT 'Submitted',
    marks VARCHAR(20),
    FOREIGN KEY (assignment_id) REFERENCES assignments(id)
);

INSERT INTO assignments (title, description, deadline) VALUES
('Java Collections Framework','Implement ArrayList, LinkedList, HashMap with examples','2026-02-05'),
('Exception Handling Exercise','Create banking app with proper exception handling','2026-02-10'),
('OOP Principles Project','Design Library Management System using OOP','2026-02-01'),
('Core Java Basics','Exercises on data types, operators, control flow','2026-01-30');
select *from assignments;*/