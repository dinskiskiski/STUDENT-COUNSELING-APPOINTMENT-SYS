package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Student;
import util.DBConnection;

public class StudentDAO {

    // 1. REGISTER STUDENT
    public boolean registerStudent(Student student) {
        String sql = "INSERT INTO Student (matrixNumber, studentName, studentEmail, studentPhone, course, studentPassword) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, student.getMatrixNumber());
            ps.setString(2, student.getStudentName());
            ps.setString(3, student.getStudentEmail());
            ps.setString(4, student.getStudentPhone());
            ps.setString(5, student.getCourse());
            ps.setString(6, student.getStudentPassword());
            
            int i = ps.executeUpdate();
            return i > 0; // Returns true if insert was successful

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. AUTHENTICATE STUDENT (LOGIN)
    public Student authenticateUser(String email, String password) {
        Student student = null;
        String sql = "SELECT * FROM Student WHERE STUDENTEMAIL = ? AND studentPassword = ?";
        
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                student = new Student();
                student.setStudentID(rs.getString("studentID"));
                student.setStudentName(rs.getString("studentName"));
                student.setStudentEmail(rs.getString("studentEmail"));
                student.setCourse(rs.getString("course"));
                // We don't usually load the password back into the object for security
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return student; // Returns null if login failed, or the Student object if successful
    }
    // 3. RETREIVE STUDENT INFORMATION(STUDENT DETAIL ON COUNCELOR)
    public Student getStudentById(String studentID) {
        Student student = null;
        String sql = "SELECT * FROM STUDENT WHERE STUDENTID = ?";

        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, studentID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                student = new Student();
                student.setStudentID(rs.getString("STUDENTID"));
                student.setStudentName(rs.getString("STUDENTNAME"));
                student.setStudentEmail(rs.getString("STUDENTEMAIL"));
                student.setCourse(rs.getString("COURSE"));
                student.setStudentPhone(rs.getString("STUDENTPHONE"));
                student.setMatrixNumber(rs.getString("MATRIXNUMBER"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return student;
    }
    
     // 4. READ: Get all students
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM STUDENT";

        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Student student = new Student();
                student.setStudentID(rs.getString("STUDENTID"));
                student.setStudentName(rs.getString("STUDENTNAME"));
                student.setStudentEmail(rs.getString("STUDENTEMAIL"));
                student.setStudentPhone(rs.getString("STUDENTPHONE"));
                student.setCourse(rs.getString("COURSE"));
                student.setMatrixNumber(rs.getString("MATRIXNUMBER"));
                students.add(student);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    // 5. UPDATE student info
    public boolean updateStudent(Student student) {
        String sql = "UPDATE STUDENT SET STUDENTNAME=?, STUDENTEMAIL=?, STUDENTPHONE=?, COURSE=?, MATRIXNUMBER=? WHERE STUDENTID=?";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, student.getStudentName());
            ps.setString(2, student.getStudentEmail());
            ps.setString(3, student.getStudentPhone());
            ps.setString(4, student.getCourse());
            ps.setString(5, student.getMatrixNumber());
            ps.setString(6, student.getStudentID());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 6. DELETE student
    public boolean deleteStudent(String studentID) {
        Connection con = null;
        PreparedStatement psRecord = null;
        PreparedStatement psAppt = null;
        PreparedStatement psStudent = null;

        try {
            con = DBConnection.createConnection();

            // 1. DISABLE AUTO-COMMIT (Start Transaction)
            con.setAutoCommit(false);

            // Delete Appointment record 1st
            String sqlRecord = "DELETE FROM APPOINTMENTRECORD WHERE APPOINTMENTID IN " +
                               "(SELECT APPOINTMENTID FROM APPOINTMENT WHERE STUDENTID = ?)";
            psRecord = con.prepareStatement(sqlRecord);
            psRecord.setString(1, studentID);
            psRecord.executeUpdate();

            // Delete Appointment table
            String sqlAppt = "DELETE FROM APPOINTMENT WHERE STUDENTID = ?";
            psAppt = con.prepareStatement(sqlAppt);
            psAppt.setString(1, studentID);
            psAppt.executeUpdate();

            // Delete Student
            String sqlStudent = "DELETE FROM STUDENT WHERE STUDENTID = ?";
            psStudent = con.prepareStatement(sqlStudent);
            psStudent.setString(1, studentID);
            int rowsAffected = psStudent.executeUpdate();

            // 2. COMMIT TRANSACTION (Save Changes)
            con.commit();

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            // If ANY step fails, rollback everything so we don't have half-deleted data
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            // 3. CLOSE RESOURCES SAFELY
            try { if (psRecord != null) psRecord.close(); } catch (Exception e) {}
            try { if (psAppt != null) psAppt.close(); } catch (Exception e) {}
            try { if (psStudent != null) psStudent.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
    
    //7. UPDATE STUDENT PROFILE WITH PASSWORD
    public boolean updateStudentProfileWithPassword(Student s) {
        String sql = "UPDATE Student SET studentName=?, studentEmail=?, studentPhone=?, course=?, studentPassword=? WHERE studentID=?";

        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getStudentName());
            ps.setString(2, s.getStudentEmail());
            ps.setString(3, s.getStudentPhone());
            ps.setString(4, s.getCourse());
            ps.setString(5, s.getStudentPassword());
            ps.setString(6, s.getStudentID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    
}
    