package model;

import java.io.Serializable;

public class AppointmentRecord implements Serializable {

    private int recordID;
    private String appointmentNote;
    private String recommendation;
    private int appointmentID;

    public AppointmentRecord() {}

    public int getRecordID() { return recordID; }
    public void setRecordID(int recordID) { this.recordID = recordID; }

    public String getAppointmentNote() { return appointmentNote; }
    public void setAppointmentNote(String appointmentNote) { this.appointmentNote = appointmentNote; }

    public String getRecommendation() { return recommendation; }
    public void setRecommendation(String recommendation) { this.recommendation = recommendation; }

    public int getAppointmentID() { return appointmentID; }
    public void setAppointmentID(int appointmentID) { this.appointmentID = appointmentID; }
}
