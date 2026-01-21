package model;

import java.io.Serializable;

public class Student implements Serializable {
    
    // 1. Private Fields (Match ERD columns)
    private String studentID;      // PK
    private String studentName;
    private String studentEmail;
    private String studentPhone;
    private String course;
    private String studentPassword;
    private String matrixNumber;

    // 2. No-Argument Constructor
    public Student() {
    }

    // 3. Getters and Setters
    public String getStudentID() { return studentID; }
    public void setStudentID(String studentID) { this.studentID = studentID; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getStudentEmail() { return studentEmail; }
    public void setStudentEmail(String studentEmail) { this.studentEmail = studentEmail; }

    public String getStudentPhone() { return studentPhone; }
    public void setStudentPhone(String studentPhone) { this.studentPhone = studentPhone; }

    public String getCourse() { return course; }
    public void setCourse(String course) { this.course = course; }

    public String getStudentPassword() { return studentPassword; }
    public void setStudentPassword(String studentPassword) { this.studentPassword = studentPassword; }
    
    public String getMatrixNumber() { return matrixNumber; }
    public void setMatrixNumber(String MatrixNumber) { this.matrixNumber = MatrixNumber; }
}