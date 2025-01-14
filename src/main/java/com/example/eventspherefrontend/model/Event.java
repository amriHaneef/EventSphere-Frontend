package com.example.eventspherefrontend.model;

import java.time.LocalDateTime;
import java.util.List;

public class Event {
    private int id;
    private String title;
    private String type;
    private String timePeriod;
    private String sessionLink;
    private String platform;
    private int coordinatorId;
    private String coordinatorName;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String status;
    private LocalDateTime eventDate;
    private List<String> eventids;

    // Constructors
    public Event() {}

    public Event(int id, String title, String type, String timePeriod, String sessionLink, String platform, int coordinatorId, String coordinatorName, LocalDateTime createdAt, LocalDateTime updatedAt, String status, LocalDateTime eventDate) {
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

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getEventDate() {
        return eventDate;
    }

    public void setEventDate(LocalDateTime eventDate) {
        this.eventDate = eventDate;
    }

    public List<String> geteventids() {
        return eventids;
    }

    public void seteventids(List<String> eventids) {
        this.eventids = eventids;
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
