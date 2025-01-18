package com.example.eventspherefrontend.model;

import java.util.List;

public class StudentAnnouncement {
    private String announcementId;
    private List<String> studentIds;
    private List<String> batchIds;

    // Getter and setter for announcementId
    public String getAnnouncementId() {
        return announcementId;
    }

    public void setAnnouncementId(String announcementId) {
        this.announcementId = announcementId;
    }

    // Getter and setter for studentIds
    public List<String> getStudentIds() {
        return studentIds;
    }

    public void setStudentIds(List<String> studentIds) {
        this.studentIds = studentIds;
    }

    // Getter and setter for batchIds
    public List<String> getBatchIds() {
        return batchIds;
    }

    public void setBatchIds(List<String> batchIds) {
        this.batchIds = batchIds;
    }

    @Override
    public String toString() {
        return "StudentAnnouncement{" +
                "announcementId=" + announcementId +
                ", studentIds=" + studentIds +
                ", batchIds=" + batchIds +
                '}';
    }
}
