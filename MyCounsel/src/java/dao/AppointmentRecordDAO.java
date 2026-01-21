package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.AppointmentRecord;
import util.DBConnection;

public class AppointmentRecordDAO {

    // Save consultation notes & recommendations
    public boolean addRecord(AppointmentRecord record) {
        String sql = "INSERT INTO AppointmentRecord (appointmentNote, recommendation, appointmentID) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, record.getAppointmentNote());
            ps.setString(2, record.getRecommendation());
            ps.setInt(3, record.getAppointmentID());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get consultation record by appointment ID
public AppointmentRecord getRecordByAppointmentId(int appointmentID) {
    String sql = "SELECT * FROM AppointmentRecord WHERE appointmentID = ?";
    try (Connection con = DBConnection.createConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, appointmentID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            AppointmentRecord record = new AppointmentRecord();
            record.setRecordID(rs.getInt("recordID"));
            record.setAppointmentNote(rs.getString("appointmentNote"));
            record.setRecommendation(rs.getString("recommendation"));
            record.setAppointmentID(rs.getInt("appointmentID"));
            return record;
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}

    
    
}
