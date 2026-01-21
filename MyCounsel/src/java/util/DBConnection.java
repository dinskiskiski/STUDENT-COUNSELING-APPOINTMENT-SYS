package util; // Suggest putting this in a 'util' package

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Update these values to match your NetBeans Database configuration
    private static final String URL = "jdbc:derby://localhost:1527/CounselingSystemDB"; 
    
    private static final String USER = "app";
    private static final String PASSWORD = "app";

    public static Connection createConnection() {
        Connection con = null;
        try {
            // 1. Load Driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // 2. Establish Connection
            con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("DB Connection Success!");
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.out.println("DB Connection Failed: " + e.getMessage());
        }
        return con;
    }
}