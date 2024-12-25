<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Events UI</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/event.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Include Chart.js -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">

</head>
<body>
<div class="container">
    <!-- Search Bar -->
    <div class="search-bar">
        <input type="text" id="searchInput" placeholder="Search...">
        <button onclick="searchEvent()">Search</button>
    </div>

    <!-- Event Table -->
    <table class="event-table" id=" admin_view_event_tab_table">
        <thead>
        <tr>
            <th>Event ID</th>
            <th>Event Name</th>
            <th>Date</th>
            <th>Batch</th>
            <th>Progress</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>1</td>
            <td>Java Workshop</td>
            <td>2024-12-25</td>
            <td>HDSE24.1f</td>
            <td>75%</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Python Bootcamp</td>
            <td>2024-12-20</td>
            <td>DSE23.2f</td>
            <td>85%</td>
        </tr>
        <tr>
            <td>3</td>
            <td>Web Development</td>
            <td>2024-12-22</td>
            <td>HDSE24.2f</td>
            <td>80%</td>
        </tr>
        </tbody>
    </table>

    <!-- Buttons -->
    <div class="button-panel">
        <button onclick="addEvent()">Add Event</button>
        <button onclick="editEvent()">Edit Event</button>
        <button onclick="deleteEvent()">Delete Event</button>
    </div>

    <!-- Metrics Dashboard -->
    <div class="metrics-dashboard">
        <h3>Event Metrics</h3>
        <div id="metrics">
            <canvas id="progressPieChart" width="400" height="400"></canvas> <!-- Placeholder for pie chart -->
        </div>
    </div>

        <!-- Attendance Marking Panel -->
        <h2>Attendance Marking</h2>
        <div class="attendance-panel">
            <ul id="attendanceList">
                <!-- Dynamic checkboxes for marking attendance go here -->
            </ul>
            <button onclick="submitAttendance()">Submit Attendance</button>
        </div>

        <!-- Feedback Box -->
        <h2>Feedback</h2>
        <textarea id="feedbackBox" placeholder="Enter feedback for the event..."></textarea>
        <button onclick="submitFeedback()">Submit Feedback</button>

</div>
<script src="${pageContext.request.contextPath}/js/event.js"></script>
</body>
</html>
