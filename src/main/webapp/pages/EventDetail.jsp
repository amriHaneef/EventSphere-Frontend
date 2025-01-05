<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Event Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eventdetail.css">
</head>
<body>
<h2>Event Details</h2>

<%
    // Initialize variables to hold event details
    String eventId = request.getParameter("eventId");
    String eventName = "Mock Interview";
    String eventType = "Mock Interview";
    String eventDate = "20/02/2025";
    String eventTime = "9:30 A.M.";
    String platform = "Zoom";
    String lecturer = "Mrs. Sandaruwani";
    String status = "N/A";

    // Fetch event details from the database (mocked details provided here)
%>

<table>
    <tr>
        <th>Event ID</th>
        <td><%= eventId != null ? eventId : "N/A" %></td>
    </tr>
    <tr>
        <th>Event Name</th>
        <td><%= eventName %></td>
    </tr>
    <tr>
        <th>Event Type</th>
        <td><%= eventType %></td>
    </tr>
    <tr>
        <th>Date</th>
        <td><%= eventDate %></td>
    </tr>
    <tr>
        <th>Time</th>
        <td><%= eventTime %></td>
    </tr>
    <tr>
        <th>Platform</th>
        <td><%= platform %></td>
    </tr>
    <tr>
        <th>Lecturer</th>
        <td><%= lecturer %></td>
    </tr>
    <tr>
        <th>Status</th>
        <td><%= status %></td>
    </tr>
</table>


<!-- Button to open popup -->
<button id="markAttendanceBtn">Mark Attendance</button>

<!-- Popup structure -->
<div class="popup-overlay" id="popupOverlay">
    <div class="popup-content">
        <h3>Mark Attendance</h3>
        <form id="attendanceForm">
            <label for="batch">Select Batch:</label>
            <select id="batch" name="batch" required>
                <option value="" disabled selected>Select a batch</option>
                <option value="Batch1">Batch 1</option>
                <option value="Batch2">Batch 2</option>
                <option value="Batch3">Batch 3</option>
            </select>

            <label for="student">Student Index:</label>
            <select id="student" name="student" required>
                <option value="" disabled selected>Select a student</option>
                <option value="Student1">Student 1</option>
                <option value="Student2">Student 2</option>
                <option value="Student3">Student 3</option>
            </select><br>

            <label for="mockDetails">Mock Details:</label>
            <input type="text" id="mockDetails" name="mockDetails" placeholder="Enter mock details" required>

            <div class="popup-buttons">
                <button type="button" class="close-btn" id="closePopupBtn">Close</button>
                <button type="submit" class="mark-btn">Mark Attendance</button>
            </div>
        </form>
    </div>
</div>

</body>
<script src="${pageContext.request.contextPath}/js/eventdetail.js"></script>
</html>
