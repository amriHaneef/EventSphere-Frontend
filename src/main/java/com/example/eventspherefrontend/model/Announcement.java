package com.example.eventspherefrontend.model;

import java.util.List;

public class Announcement {
    private String id;
    private String title;
    private String content;
    private String createdAt;
    private String createdBy;
    private String role;
    private List<String> studentIds;
    private List<String> batchIds;

    // Getters and setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getCreatedBy() {
        return createdBy;
    }


    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public List<String> getStudentIds() {
        return studentIds;
    }
    public void setStudentIds(List<String> studentIds) {
        this.studentIds = studentIds;
    }

    public List<String> getBatchIds() {
        return batchIds;
    }

    public void setBatchIds(List<String> batchIds) {
        this.batchIds = batchIds;
    }


    @Override
    public String toString() {
        return "Announcement{" +
                "announcementId='" + id + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", createdAt='" + createdAt + '\'' +
                ", createdBy='" + createdBy + '\'' +
                ", role='" + role + '\'' +
                ", batchIds='" + batchIds + '\'' +
                ", studentIds=" + studentIds +
                '}';
    }
}