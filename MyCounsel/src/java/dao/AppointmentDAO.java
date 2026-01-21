package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Appointment;
import model.AppointmentRecord;
import util.DBConnection;

public class AppointmentDAO {

    // 1. CREATE APPOINTMENT
    public boolean addAppointment(Appointment app) {
        String sql = "INSERT INTO Appointment (appointmentIssue, appointmentDate, appointmentTime, Status, studentID) VALUES (?, ?, ?, 'Pending', ?)";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, app.getAppointmentIssue());
            ps.setString(2, app.getAppointmentDate());
            ps.setString(3, app.getAppointmentTime());
            ps.setString(4, app.getStudentID());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. UPDATE STATUS (Counselor accepts/rejects)
    public boolean updateStatus(int appointmentID, String newStatus, String counselorID) {
        String sql = "UPDATE Appointment SET Status = ?, counselorID = ? WHERE appointmentID = ?";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setString(2, counselorID);
            ps.setInt(3, appointmentID);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 3. CANCEL APPOINTMENT (Student or Counselor)
    public boolean cancelAppointment(int appointmentID) {
        String sql = "UPDATE Appointment SET Status = 'Cancelled' WHERE appointmentID = ?";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, appointmentID);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 4. GET APPOINTMENTS BY STUDENT
    public List<Appointment> getAppointmentsByStudent(String studentID) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM Appointment WHERE studentID = ? ORDER BY appointmentDate, appointmentTime";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, studentID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment app = new Appointment();
                app.setAppointmentID(rs.getInt("appointmentID"));
                app.setAppointmentIssue(rs.getString("appointmentIssue"));
                app.setAppointmentDate(rs.getString("appointmentDate"));
                app.setAppointmentTime(rs.getString("appointmentTime"));
                app.setStatus(rs.getString("status"));
                app.setStudentID(rs.getString("studentID"));
                app.setCounselorID(rs.getString("counselorID"));
                list.add(app);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 5. GET PENDING APPOINTMENTS FOR COUNSELOR
    public List<Appointment> getPendingAppointments() {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.*, s.studentName, s.matrixNumber " +
                     "FROM Appointment a JOIN Student s ON a.studentID = s.studentID " +
                     "WHERE a.status = 'Pending' ORDER BY a.appointmentDate, a.appointmentTime";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment app = new Appointment();
                app.setAppointmentID(rs.getInt("appointmentID"));
                app.setAppointmentIssue(rs.getString("appointmentIssue"));
                app.setAppointmentDate(rs.getString("appointmentDate"));
                app.setAppointmentTime(rs.getString("appointmentTime"));
                app.setStatus(rs.getString("status"));
                app.setStudentID(rs.getString("studentID"));
                app.setStudentName(rs.getString("studentName"));
                app.setMatrixNumber(rs.getString("matrixNumber"));
                list.add(app);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 6. ADD CONSULTATION RECORD
    public boolean addAppointmentRecord(AppointmentRecord record) {
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

    // 7. GET CONSULTATION RECORD BY APPOINTMENT ID
    public AppointmentRecord getAppointmentRecord(int appointmentID) {
        AppointmentRecord record = null;
        String sql = "SELECT * FROM AppointmentRecord WHERE appointmentID = ?";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, appointmentID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                record = new AppointmentRecord();
                record.setRecordID(rs.getInt("recordID"));
                record.setAppointmentNote(rs.getString("appointmentNote"));
                record.setRecommendation(rs.getString("recommendation"));
                record.setAppointmentID(rs.getInt("appointmentID"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return record;
    }
    
    
    public List<Appointment> getAcceptedAppointments(String counselorID) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.*, s.STUDENTNAME, s.MATRIXNUMBER, c.COUNSELORNAME " +
                     "FROM APPOINTMENT a " +
                     "JOIN STUDENT s ON a.STUDENTID = s.STUDENTID " +
                     "LEFT JOIN COUNSELOR c ON a.COUNSELORID = c.COUNSELORID " +
                     "WHERE a.STATUS = 'Accepted' AND a.COUNSELORID = ?";

        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, counselorID); // Set the counselor ID parameter

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment app = new Appointment();
                app.setAppointmentID(rs.getInt("APPOINTMENTID"));
                app.setAppointmentIssue(rs.getString("APPOINTMENTISSUE"));
                app.setAppointmentDate(rs.getString("APPOINTMENTDATE"));
                app.setAppointmentTime(rs.getString("APPOINTMENTTIME"));
                app.setStatus(rs.getString("STATUS"));
                app.setStudentID(rs.getString("STUDENTID"));
                app.setStudentName(rs.getString("STUDENTNAME"));
                app.setMatrixNumber(rs.getString("MATRIXNUMBER"));
                app.setCounselorName(rs.getString("COUNSELORNAME"));
                list.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


// Get Appointment by ID (for StartConsultationServlet)
public Appointment getAppointmentByID(int appointmentID) {
    Appointment app = null;
    String sql = "SELECT a.*, s.STUDENTNAME, s.MATRIXNUMBER " +
                 "FROM APPOINTMENT a JOIN STUDENT s ON a.STUDENTID = s.STUDENTID " +
                 "WHERE a.APPOINTMENTID = ?";

    try (Connection con = DBConnection.createConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, appointmentID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            app = new Appointment();
            app.setAppointmentID(rs.getInt("APPOINTMENTID"));
            app.setAppointmentIssue(rs.getString("APPOINTMENTISSUE"));
            app.setAppointmentDate(rs.getString("APPOINTMENTDATE"));
            app.setAppointmentTime(rs.getString("APPOINTMENTTIME"));
            app.setStatus(rs.getString("STATUS"));
            app.setStudentID(rs.getString("STUDENTID"));
            app.setStudentName(rs.getString("STUDENTNAME"));
            app.setMatrixNumber(rs.getString("MATRIXNUMBER"));
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return app;
}

 // 7. Get Completed Appointments
    public List<Appointment> getCompletedAppointments(String counselorID) {
        List<Appointment> list = new ArrayList<>();
        // Added: AND a.COUNSELORID = ?
        String sql = "SELECT a.*, s.STUDENTNAME, s.MATRIXNUMBER " +
                     "FROM APPOINTMENT a JOIN STUDENT s ON a.STUDENTID = s.STUDENTID " +
                     "WHERE a.STATUS = 'Completed' AND a.COUNSELORID = ?";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, counselorID); // Set the counselor ID parameter

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment app = new Appointment();
                app.setAppointmentID(rs.getInt("APPOINTMENTID"));
                app.setAppointmentIssue(rs.getString("APPOINTMENTISSUE"));
                app.setAppointmentDate(rs.getString("APPOINTMENTDATE"));
                app.setAppointmentTime(rs.getString("APPOINTMENTTIME"));
                app.setStatus(rs.getString("STATUS"));
                app.setStudentID(rs.getString("STUDENTID"));
                app.setStudentName(rs.getString("STUDENTNAME"));
                app.setMatrixNumber(rs.getString("MATRIXNUMBER"));
                list.add(app);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
     // 8. Get Cancelled Appointments
    public List<Appointment> getCancelledAppointments(String counselorID) {
        List<Appointment> list = new ArrayList<>();
        // Added: AND a.COUNSELORID = ?
        String sql = "SELECT a.*, s.STUDENTNAME, s.MATRIXNUMBER " +
                     "FROM APPOINTMENT a JOIN STUDENT s ON a.STUDENTID = s.STUDENTID " +
                     "WHERE a.STATUS = 'Cancelled' AND a.COUNSELORID = ?";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, counselorID); // Set the counselor ID parameter

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment app = new Appointment();
                app.setAppointmentID(rs.getInt("APPOINTMENTID"));
                app.setAppointmentIssue(rs.getString("APPOINTMENTISSUE"));
                app.setAppointmentDate(rs.getString("APPOINTMENTDATE"));
                app.setAppointmentTime(rs.getString("APPOINTMENTTIME"));
                app.setStatus(rs.getString("STATUS"));
                app.setStudentID(rs.getString("STUDENTID"));
                app.setStudentName(rs.getString("STUDENTNAME"));
                app.setMatrixNumber(rs.getString("MATRIXNUMBER"));
                list.add(app);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get appointment by ID
public Appointment getAppointmentById(int appointmentID) {
    String sql = "SELECT a.*, s.STUDENTNAME, s.MATRIXNUMBER FROM APPOINTMENT a " +
                 "JOIN STUDENT s ON a.STUDENTID = s.STUDENTID WHERE a.APPOINTMENTID = ?";
    try (Connection con = DBConnection.createConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, appointmentID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Appointment app = new Appointment();
            app.setAppointmentID(rs.getInt("APPOINTMENTID"));
            app.setAppointmentIssue(rs.getString("APPOINTMENTISSUE"));
            app.setAppointmentDate(rs.getString("APPOINTMENTDATE"));
            app.setAppointmentTime(rs.getString("APPOINTMENTTIME"));
            app.setStatus(rs.getString("STATUS"));
            app.setStudentID(rs.getString("STUDENTID"));
            app.setCounselorID(rs.getString("COUNSELORID"));
            app.setStudentName(rs.getString("STUDENTNAME"));
            app.setMatrixNumber(rs.getString("MATRIXNUMBER"));
            return app;
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}

        // DELETE appointment by ID (only for accepted or cancelled)
    public boolean deleteAppointment(int appointmentID) {
        String sql = "DELETE FROM Appointment WHERE appointmentID = ? AND (Status='Accepted' OR Status='Cancel')";

        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, appointmentID);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // In AppointmentDAO.java
public boolean deleteAppointmentWithRecord(int appointmentID) {
    try (Connection con = DBConnection.createConnection()) {
        con.setAutoCommit(false); // start transaction

        // 1. Delete related record first
        try (PreparedStatement ps1 = con.prepareStatement(
                "DELETE FROM AppointmentRecord WHERE appointmentID = ?")) {
            ps1.setInt(1, appointmentID);
            ps1.executeUpdate();
        }

        // 2. Delete appointment
        try (PreparedStatement ps2 = con.prepareStatement(
                "DELETE FROM Appointment WHERE appointmentID = ?")) {
            ps2.setInt(1, appointmentID);
            int deleted = ps2.executeUpdate();
            con.commit();
            return deleted > 0;
        }

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

public boolean isSlotTaken(String date, String time) {
    boolean isTaken = false;
    // We check for any appointment at this date/time that IS NOT Cancelled
    String sql = "SELECT COUNT(*) FROM appointment WHERE appointmentDate = ? AND appointmentTime = ? AND status != 'Cancelled'";
    
    try (Connection conn = DBConnection.createConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, date);
        ps.setString(2, time); // Ensure time format matches (e.g., '08:00' or '08:00:00')
        
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int count = rs.getInt(1);
            if (count > 0) {
                isTaken = true; // Found an existing appointment!
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return isTaken;
}
    
}
