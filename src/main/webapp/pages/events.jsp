<%@ page import="java.util.List" %>
<%@ page import="java.lang.String" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String role = (String) session.getAttribute("role");
%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/event.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<div class="header">
    <div class="left">
        <ul class="breadcrumb">
            <li>
                <a href="#">${sessionScope.role}</a>
            </li>
            /
            <li>
                <a href="#" class="active">Events</a>
            </li>
        </ul>
    </div>
    <%
        if ("teacher".equalsIgnoreCase(role)) {
    %>
    <a class="report">
        <i class="bx bx-plus"></i>
        <span>Add Events</span>
    </a>
    <%
        if ("teacher".equalsIgnoreCase(role)) {
    %>
    <%
        }
    %>


    <%
        }
    %>
    <div class="event-background">
        <div class="popup-event">
            <div class="popup-header">
                <h2>Add Event</h2>
                <span class="close-btn">&times;</span>
            </div>
            <form id="event-form">
                <label for="eventName">Event Name:</label>
                <input type="text" id="eventName" name="eventName" required><br><br>

                <label for="eventType">Event Type:</label>
                <select id="eventType" name="eventType" required>
                    <option value="" disabled selected>Select an event type</option>
                    <option value="Session-Workshop">Session/Workshop</option>
                    <option value="Mock Interviews">Mock Interviews</option>
                </select><br><br>

                <label for="eventDate">Date:</label>
                <input type="date" id="eventDate" name="eventDate" required><br><br>

                <label for="eventTime">Time:</label>
                <input type="text" id="eventTime" name="eventTime" required><br><br>

                <label for="platform">Platform:</label>
                <input type="text" id="platform" name="platform" required><br><br>

                <label for="lecture">Lecturer:</label>
                <input type="text" id="lecture" name="lecture" required><br><br>

                <div class="buttons">
                    <button type="button" class="cancel">Cancel</button>
                    <button type="submit" class="submit-btn">Submit</button>
                </div>
            </form>
        </div>
    </div>
</div>

        <div class="bottom-data">
            <div class="orders">
                <div class="header">
                    <i class="bx bx-calendar-check"></i>
                    <h3>Events</h3>
                    <div class="search-container">
                        <label>
                            <input type="text" id="search-bar" class="search-bar" placeholder="Search...">
                        </label>
                    </div>
                </div>
                <table>
                    <thead>
                    <tr>
                        <th>Event ID</th>
                        <th>Event Name</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Platform</th>
                        <th>Lecturer</th>
                        <th>Status</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        // Retrieve and safely cast events
                        Object eventsObject = request.getAttribute("events");
                        if (eventsObject instanceof List) {
                            List<String[]> events = (List<String[]>) eventsObject;
                            for (String[] event : events) {
                    %>
                    <tr>
                        <td><%= event[0] %></td>
                        <td><%= event[1] %></td>
                        <td><%= event[2] %></td>
                        <td><%= event[3] %></td>
                        <td><%= event[4] %></td>
                        <td><%= event[5] %></td>
                        <td><%= event[6] %></td>
                        <td>
                            <button class="view" onclick="window.location='${pageContext.request.contextPath}/pages/EventDetail.jsp?id=<%= event[0] %>'">
                                <i class="bx bx-show"></i>
                            </button>
                        </td>

                        <%
                            if ("admin".equalsIgnoreCase(role) || "teacher".equalsIgnoreCase(role)) {
                        %>
                        <td>
                            <button class="delete">
                                <i class="bx bxs-trash bin"></i>
                            </button>
                        </td>
                        <%
                            if ("teacher".equalsIgnoreCase(role)) {
                        %>
                        <td>
                            <button class="edit">
                                <i class="bx bx-edit write"></i>
                            </button>
                        </td>
                        <%
                            }
                        %>
                        <%
                            }
                        %>
                    </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>


                    <br>
                <!-- Popup Form -->
                <div class="popup-overlay">
                    <div class="popup-content">
                        <span class="popup-close">&times;</span>
                        <p>Do you want to delete this announcement?</p>
                        <div class="popup-buttons">
                            <button class="cancel-btn">Cancel</button>
                            <button class="ok-btn">OK</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
<!-- Popup Form -->
<div class="edit-event">
    <div class="event-content">
        <span class="event-close">&times;</span>
        <h3>Edit Event Details</h3>
        <form id="editForm">
            <div class="form-group">
                <label for="student-id">Event ID:</label>
                <input type="text" id="student-id" class="form-control" name="id" required disabled>
            </div>
            <div class="form-group">
                <label for="student-name">Event Name:</label>
                <input type="text" id="student-name" class="form-control" name="name" required>
            </div>
            <div class="form-group">
                <label for="student-date">Date:</label>
                <input type="date" id="student-date" class="form-control" name="date" required>
            </div>
            <div class="form-group">
                <label for="student-time">Time:</label>
                <input type="text" id="student-time" class="form-control" name="time" required>
            </div>
            <div class="form-group">
                <label for="student-platform">Platform:</label>
                <input type="text" id="student-platform" class="form-control" name="platform" required>
            </div>
            <div class="form-group">
                <label for="lecturer">lecturer:</label>
                <input type="text" id="lecturer" class="form-control" name="lecturer" required>
            </div>
            <div class="popup-buttons">
                <button type="button" class="cancel">Cancel</button>
                <button type="submit" class="ok-btn">Save</button>
            </div>
        </form>
    </div>
</div>

       <!-- Feedback Box -->
        <section>
            <div class="feedback">
                <h2 id="feedbackHeading"><i class="fa fa-comment-dots"></i> Feedback</h2>
                <div class="feedback-box">
                    <textarea id="feedbackBox_student" placeholder="Enter feedback for the event..."></textarea>
                    <button onclick="submitFeedback()">Submit Feedback</button>
                </div>
            </div>
        </section>

<script>
    const pageContextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/event.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>

