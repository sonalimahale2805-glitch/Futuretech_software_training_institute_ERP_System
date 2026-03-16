package Adminassignment;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/AdminAssignments")
@MultipartConfig 
public class AdminAssignments extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // --- Database Configuration (Directly Added) ---
    private String dbURL = "jdbc:mysql://localhost:3306/futuretech_erp";
    private String dbUser = "root";
    private String dbPass = "Mysql@123";

    public AdminAssignments() {
        super();
    }

    /**
     * Display Page & Update Status (Review Button)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

       /** if(session == null || !"admin".equals(session.getAttribute("userrole"))) {
            response.sendRedirect("admin_authentication.jsp");
            return;
        }*/

        // Action: Review Button Logic
        String id = request.getParameter("id");
        if (id != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
                String sql = "UPDATE submissions SET status = 'Reviewed' WHERE id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                con.close();
            } catch (Exception e) { e.printStackTrace(); }
        }

        request.getRequestDispatcher("assignments.jsp").include(request, response);

        // UI Script for Admin Profile
        try {
            String adminName = (String) session.getAttribute("username");
            if(adminName != null) {
                out.println("<script>");
                out.println("document.getElementById('username').innerText = '" + adminName + "';");
                out.println("document.getElementById('profile_logo').innerText = '"+adminName.toUpperCase().charAt(0)+"'");
                out.println("</script>");
            }
        } catch(Exception e) { e.printStackTrace(); }
    }

    /**
     * Post New Assignment (Database Insertion)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String dueDate = request.getParameter("dueDate");
        String description = request.getParameter("description");
        
        String fileName = "";
        String finalStatus = "Missing"; 

      
        try {
            Part filePart = request.getPart("file");
            if (filePart != null && filePart.getSize() > 0) {
                fileName = filePart.getSubmittedFileName();
                finalStatus = "Submitted"; 
            }
           
            
            
            
            
            
            
         //Admine database/ Direct Database Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // Query 1: Assignments table
            String sql1 = "INSERT INTO assignments (title, due_date, description, file_name) VALUES (?, ?, ?, ?)";
            PreparedStatement ps1 = con.prepareStatement(sql1);
            ps1.setString(1, title);
            ps1.setString(2, dueDate);
            ps1.setString(3, description);
            ps1.setString(4, fileName);
            ps1.executeUpdate();

            // Query 2: Submissions table
            String sql2 = "INSERT INTO submissions (student_name, assignment_name, due_date, status) VALUES (?, ?, ?, ?)";
            PreparedStatement ps2 = con.prepareStatement(sql2);
            ps2.setString(1, "Rahul Kumar"); 
            ps2.setString(2, title);
            ps2.setString(3, dueDate);
            ps2.setString(4, finalStatus); 
            ps2.executeUpdate();

            con.close();
            
            
            
            
            
            
                
         // --- 2. STUDENT DATABASE (studentdb) - SYNC LOGIC ---
            String studentDbURL = "jdbc:mysql://localhost:3306/studentdb";
            Connection conStudent = DriverManager.getConnection(studentDbURL, dbUser, dbPass);

            // Student DB table: assignments (title, description, deadline)
            String sqlStudent = "INSERT INTO assignments (title, description, deadline) VALUES (?, ?, ?)";
            PreparedStatement psStudent = conStudent.prepareStatement(sqlStudent);
            psStudent.setString(1, title);
            psStudent.setString(2, description);
            psStudent.setString(3, dueDate); 
            psStudent.executeUpdate();

            conStudent.close(); 
            
           
            
            
            
            // Redirect to show the new data in table
            response.sendRedirect("AdminAssignments");

        } catch (Exception e) { 
            e.printStackTrace();
            response.getWriter().println("Database Error: " + e.getMessage());
        }
    }
    }


//database.....


/**-- Admin section Database---
CREATE DATABASE futuretech_erp;
USE futuretech_erp;

CREATE TABLE assignments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    due_date DATE,
    description TEXT,
    file_name VARCHAR(255)
);

CREATE TABLE submissions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100),
    assignment_name VARCHAR(100),
    due_date DATE,
    status ENUM('Submitted', 'Missing', 'Reviewed') DEFAULT 'Missing'
);*/
