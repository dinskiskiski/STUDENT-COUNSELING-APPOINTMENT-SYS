package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Counselor;
import util.DBConnection;

public class CounselorDAO {

    public Counselor authenticateCounselor(String email, String password) {
        Counselor counselor = null;
        String sql = "SELECT * FROM Counselor WHERE email = ? AND counselorPassword = ?";
        
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                counselor = new Counselor();
                counselor.setCounselorID(rs.getString("counselorID"));
                counselor.setCounselorName(rs.getString("counselorName"));
                counselor.setEmail(rs.getString("email"));
                counselor.setPosition(rs.getString("POSITION"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return counselor;
    }
    
    public boolean addCounselor(Counselor counselor) {
        boolean rowInserted = false;
        // The column names must match your database exactly
        String sql = "INSERT INTO COUNSELOR ( COUNSELORNAME, EMAIL, COUNSELORPASSWORD, POSITION) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.createConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, counselor.getCounselorName());
            ps.setString(2, counselor.getEmail());
            ps.setString(3, counselor.getCounselorPassword());
            ps.setString(4, counselor.getPosition()); // The new attribute

            rowInserted = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }
}