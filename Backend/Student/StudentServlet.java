/*  CREATE TABLE students1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(30),
    course VARCHAR(100),
    batch VARCHAR(50),
    progress INT,
    status VARCHAR(20)
);

*
INSERT INTO students1 (name, email, phone, course, batch, progress, status)
VALUES
('Rahul Sharma', 'rahul@gmail.com', '9876543210', 'Java Full Stack', 'Morning', 80, 'active'),

('Sneha Patil', 'sneha@gmail.com', '9123456780', 'Web Development', 'Evening', 60, 'completed'),

('Amit Joshi', 'amit@gmail.com', '9988776655', 'Python Programming', 'Morning', 45, 'active'),

('Priya Deshmukh', 'priya@gmail.com', '9012345678', 'Data Science', 'Weekend', 30, 'suspended'),

('Karan Mehta', 'karan@gmail.com', '9090909090', 'Java Full Stack', 'Evening', 95, 'completed');

*
*
SELECT * FROM students1;*/


package com.ft.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class StudentServlet extends HttpServlet {

    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            Connection conn = DBConnection.getConnection();

            
            if ("delete".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                PreparedStatement ps = conn.prepareStatement("DELETE FROM students1 WHERE id=?");
                ps.setInt(1, id);
                ps.executeUpdate();
                conn.close();
                response.sendRedirect("StudentDirectory");
                return;
            }

            
            if ("edit".equals(action) || "view".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM students1 WHERE id=?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    request.setAttribute("editStudentId", rs.getInt("id"));
                    request.setAttribute("editName", rs.getString("name"));
                    request.setAttribute("editEmail", rs.getString("email"));
                    request.setAttribute("editPhone", rs.getString("phone"));
                    request.setAttribute("editCourse", rs.getString("course"));
                    request.setAttribute("editBatch", rs.getString("batch"));
                    request.setAttribute("editProgress", rs.getInt("progress"));
                    request.setAttribute("editStatus", rs.getString("status"));
                }
            }

            
            List<Map<String, Object>> students = new ArrayList<>();

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM students1");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getInt("id"));
                row.put("name", rs.getString("name"));
                row.put("email", rs.getString("email"));
                row.put("phone", rs.getString("phone"));
                row.put("course", rs.getString("course"));
                row.put("batch", rs.getString("batch"));
                row.put("progress", rs.getInt("progress"));
                row.put("status", rs.getString("status"));

                students.add(row);
            }

            conn.close();

            request.setAttribute("students", students);
            RequestDispatcher rd = request.getRequestDispatcher("StudentDirectory.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            Connection conn = DBConnection.getConnection();

           
            if ("delete".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                PreparedStatement ps = conn.prepareStatement("DELETE FROM students1 WHERE id=?");
                ps.setInt(1, id);
                ps.executeUpdate();
            }

            
            else if ("add".equals(action)) {

                PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO students1(name,email,phone,course,batch,progress,status) VALUES(?,?,?,?,?,?,?)");

                ps.setString(1, request.getParameter("name"));
                ps.setString(2, request.getParameter("email"));
                ps.setString(3, request.getParameter("phone"));
                ps.setString(4, request.getParameter("course"));
                ps.setString(5, request.getParameter("batch"));
                ps.setInt(6, Integer.parseInt(request.getParameter("progress")));
                ps.setString(7, request.getParameter("status"));

                ps.executeUpdate();
            }

           
            else if ("update".equals(action)) {

                PreparedStatement ps = conn.prepareStatement(
                        "UPDATE students1 SET name=?,email=?,phone=?,course=?,batch=?,progress=?,status=? WHERE id=?");

                ps.setString(1, request.getParameter("name"));
                ps.setString(2, request.getParameter("email"));
                ps.setString(3, request.getParameter("phone"));
                ps.setString(4, request.getParameter("course"));
                ps.setString(5, request.getParameter("batch"));
                ps.setInt(6, Integer.parseInt(request.getParameter("progress")));
                ps.setString(7, request.getParameter("status"));
                ps.setInt(8, Integer.parseInt(request.getParameter("id")));

                ps.executeUpdate();
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("StudentDirectory");
    }
}
