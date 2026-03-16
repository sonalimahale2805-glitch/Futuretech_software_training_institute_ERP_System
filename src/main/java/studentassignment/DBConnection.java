package studentassignment;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        // Database credentials
        String conn_string = "jdbc:mysql://localhost:3306/studentdb"; 
        String user = "root";
        String password = "Mysql@123"; 
        Connection con = null;
        try {
            // Establish the database connection
            con = DriverManager.getConnection(conn_string, user, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}