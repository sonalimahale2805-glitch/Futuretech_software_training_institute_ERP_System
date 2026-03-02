/*CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100)
);

 CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    batch VARCHAR(50),
    instructor VARCHAR(100),
    duration VARCHAR(50),
    start_date DATE,
    end_date DATE
);

CREATE TABLE skills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    skill_name VARCHAR(100)
);

CREATE TABLE student_course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT
);

INSERT INTO students (name, email, password)
VALUES ('Rahul Kumar', 'rahul@gmail.com', '1234');
INSERT INTO courses (course_name, batch, instructor, duration, start_date, end_date)
VALUES ('Java Full Stack Development', 'JFSD-2025-B3', 'Prof. Rajesh Kumar', '6 Months', '2025-12-01', '2026-05-31');


INSERT INTO skills (course_id, skill_name)
VALUES
(1, 'Core Java'),
(1, 'Advanced Java'),
(1, 'Spring Framework'),
(1, 'Hibernate ORM'),
(1, 'React.js');


INSERT INTO student_course (student_id, course_id)
VALUES (1, 1);
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM skills;
SELECT * FROM student_course;
UPDATE skills 
SET skill_name = 'Web Development'
WHERE id = 4;
SELECT * FROM skills;*/



package com.ft.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DomainServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int studentId = 1;   
        try {
            Connection con = DBConnection.getConnection();

            // Student Name
            PreparedStatement ps1 = con.prepareStatement(
                    "SELECT name FROM students WHERE id=?");
            ps1.setInt(1, studentId);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next()) {
                request.setAttribute("studentName", rs1.getString("name"));
            }

            //  Course Details
            PreparedStatement ps2 = con.prepareStatement(
                    "SELECT c.* FROM courses c " +
                    "JOIN student_course sc ON c.id = sc.course_id " +
                    "WHERE sc.student_id=?");

            ps2.setInt(1, studentId);
            ResultSet rs2 = ps2.executeQuery();

            int courseId = 0;

            if (rs2.next()) {
                courseId = rs2.getInt("id");

                request.setAttribute("courseName", rs2.getString("course_name"));
                request.setAttribute("batch", rs2.getString("batch"));
                request.setAttribute("instructor", rs2.getString("instructor"));
                request.setAttribute("duration", rs2.getString("duration"));
                request.setAttribute("startDate", rs2.getDate("start_date"));
                request.setAttribute("endDate", rs2.getDate("end_date"));
            }

            //  Skills
            PreparedStatement ps3 = con.prepareStatement(
                    "SELECT skill_name FROM skills WHERE course_id=?");

            ps3.setInt(1, courseId);
            ResultSet rs3 = ps3.executeQuery();

            List<String> skills = new ArrayList<>();

            while (rs3.next()) {
                skills.add(rs3.getString("skill_name"));
            }

            request.setAttribute("skills", skills);

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        RequestDispatcher rd = request.getRequestDispatcher("Domain.jsp");
        rd.forward(request, response);
    }
}