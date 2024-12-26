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

    <!-- Assigned  Events Table student -->
    <section>
        <h2>Assigned Events</h2>
        <table id=" student_view_event_tab_table">
            <thead>
            <tr>
                <th>Date</th>
                <th>Time</th>
                <th>Event name</th>
                <th>Platform</th>
                <th>Lecturer</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>2025-01-15</td>
                <td>10:00 AM</td>
                <td>Web Development</td>
                <td>Zoom</td>
                <td>Mrs.Sandaruwani</td>
                <td>Attended</td>
            </tr>
            <tr>
                <td>2025-01-20</td>
                <td>2:00 PM</td>
                <td>Java Workshop</td>
                <td>Google Meet</td>
                <td>Mrs.thilini</td>
                <td>Missed</td>
            </tr>
            </tbody>
        </table>
    </section>

    <!-- Circular Progress Bar -->
    <section>
        <h2>Progress Bar</h2>
        <div id="progressTracker">
            <svg id="progressCircle" viewBox="0 0 36 36">
                <path
                        fill="none"
                        stroke="#35519c"
                        stroke-width="2"
                        stroke-linecap="round"
                        d="M18 2 a16 16 0 1 1 0 32 a16 16 0 1 1 0 -32"
                ></path>
                <path
                        stroke="#4CAF50"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-dasharray="230"
                        stroke-dashoffset="150"
                        transform="rotate(-90 18 18)"
                        id="progressPath"
                ></path>
            </svg>
            <div id="progressText">70%</div>
        </div>
    </section>

</div>
<script src="${pageContext.request.contextPath}/js/event.js"></script>
</body>
</html>
