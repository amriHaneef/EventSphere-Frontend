package com.example.eventspherefrontend.model;

import java.util.Date;

public class Event {
    private int id;
    private String title;
    private String type;
    private String timePeriod;
    private String sessionLink;
    private String platform;
    private int coordinatorId; // To store the ID of the coordinator
    private String coordinatorName; // Optional: To store the name of the coordinator
    private String createdAt; // Changed to Date type
    private String updatedAt; // Changed to Date type
    private String status;
    private String eventDate; // Changed to Date type

    // Constructors
    public Event() {}

    public Event(int id, String title, String type, String timePeriod, String sessionLink, String platform, int coordinatorId, String coordinatorName, String createdAt, String updatedAt, String status, String eventDate) {
        this.id = id;
        this.title = title;
        this.type = type;
        this.timePeriod = timePeriod;
        this.sessionLink = sessionLink;
        this.platform = platform;
        this.coordinatorId = coordinatorId;
        this.coordinatorName = coordinatorName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.status = status;
        this.eventDate = eventDate;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTimePeriod() {
        return timePeriod;
    }

    public void setTimePeriod(String timePeriod) {
        this.timePeriod = timePeriod;
    }

    public String getSessionLink() {
        return sessionLink;
    }

    public void setSessionLink(String sessionLink) {
        this.sessionLink = sessionLink;
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform;
    }

    public int getCoordinatorId() {
        return coordinatorId;
    }

    public void setCoordinatorId(int coordinatorId) {
        this.coordinatorId = coordinatorId;
    }

    public String getCoordinatorName() {
        return coordinatorName;
    }

    public void setCoordinatorName(String coordinatorName) {
        this.coordinatorName = coordinatorName;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEventDate() {
        return eventDate;
    }

    public void setEventDate(String eventDate) {
        this.eventDate = eventDate;
    }

    // toString
    @Override
    public String toString() {
        return "Event{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", type='" + type + '\'' +
                ", timePeriod='" + timePeriod + '\'' +
                ", sessionLink='" + sessionLink + '\'' +
                ", platform='" + platform + '\'' +
                ", coordinatorId=" + coordinatorId +
                ", coordinatorName='" + coordinatorName + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", status='" + status + '\'' +
                ", eventDate=" + eventDate +
                '}';
    }
}
