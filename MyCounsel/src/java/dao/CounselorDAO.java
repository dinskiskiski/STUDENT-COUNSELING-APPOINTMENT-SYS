package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
        String sql = "INSERT INTO COUNSELOR (COUNSELORNAME, EMAIL, COUNSELORPASSWORD, POSITION) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.createConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, counselor.getCounselorName());
            ps.setString(2, counselor.getEmail());
            ps.setString(3, counselor.getCounselorPassword());
            ps.setString(4, counselor.getPosition());
            
            rowInserted = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }
    
    // NEW METHOD: Get all counselors
    public List<Counselor> getAllCounselors() {
        List<Counselor> counselors = new ArrayList<>();
        String sql = "SELECT * FROM COUNSELOR ORDER BY POSITION DESC, COUNSELORNAME ASC";
        
        try (Connection conn = DBConnection.createConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Counselor counselor = new Counselor();
                counselor.setCounselorID(rs.getString("counselorID"));
                counselor.setCounselorName(rs.getString("counselorName"));
                counselor.setEmail(rs.getString("email"));
                counselor.setPosition(rs.getString("POSITION"));
                counselors.add(counselor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return counselors;
    }
    
    // NEW METHOD: Get counselor by ID
    public Counselor getCounselorById(String counselorID) {
        Counselor counselor = null;
        String sql = "SELECT * FROM COUNSELOR WHERE counselorID = ?";
        
        try (Connection conn = DBConnection.createConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, counselorID);
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
    
    // NEW METHOD: Update counselor
    public boolean updateCounselor(Counselor counselor) {
        boolean rowUpdated = false;
        String sql = "UPDATE COUNSELOR SET COUNSELORNAME = ?, EMAIL = ?, POSITION = ? WHERE counselorID = ?";
        
        try (Connection conn = DBConnection.createConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, counselor.getCounselorName());
            ps.setString(2, counselor.getEmail());
            ps.setString(3, counselor.getPosition());
            ps.setString(4, counselor.getCounselorID());
            
            rowUpdated = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }
    
    // NEW METHOD: Delete counselor
    public boolean deleteCounselor(String counselorID) {
        boolean rowDeleted = false;
        String sql = "DELETE FROM COUNSELOR WHERE counselorID = ?";
        
        try (Connection conn = DBConnection.createConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, counselorID);
            rowDeleted = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }
}