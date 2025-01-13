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
        }
    %>
</div>
<div class="add-event-popup">
    <div class="popup-container">
        <span class="popup-close">&times;</span>
        <h3>Add Event Details</h3>
        <form id="addeventForm">
            <div class="form-group">
                <label for="eventname">Event Name:</label>
                <input type="text" id="eventname" name="eventName" required>
            </div>
            <div class="form-group">
                <label for="date">Date:</label>
                <input type="date" id="date" name="Date" required>
            </div>
            <div class="form-group">
                <label for="time">Time:</label>
                <input type="text" id="time" name="time" required>
            </div>
            <div class="form-group">
                <label for="platform">Platform:</label>
                <input type="text" id="platform" name="platform" required>
            </div>
            <div class="form-group">
                <label for="lecturername">Lecturer:</label>
                <input type="text" id="lecturername" name="lecturername" required>
            </div>
            <div class="popup-buttons">
                <button type="button" class="cancel-btn">Cancel</button>
                <button type="submit" class="save-btn">Save</button>
            </div>
        </form>
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

<br>

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

<br><br><br><br><br><br><br><br><br><br><br>
<!-- Event Details Section  -->
<div class ="event-details">
    <h2>Event Details</h2>
    <%
        String eventId = request.getParameter("eventId");
        String eventName = "Mock Interview";
        String eventType = "Mock Interview";
        String eventDate = "20/02/2025";
        String eventTime = "9:30 A.M.";
        String platform = "Zoom";
        String lecturer = "Mrs. Sandaruwani";
        String status = "N/A";
    %>

    <table class="attendance">
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
    <br>

    <!-- Button to open popup -->
    <button id="markAttendanceBtn">Mark Attendance</button>
</div>
<!-- Popup structure -->
<div class="popupOverlay" id="popupAtendanceOverlay">
    <div class="popupContent">
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

            <div class="popupButtons">
                <button type="button" class="close-btn" id="closePopupBtn">Close</button>
                <button type="submit" class="mark-btn">Mark Attendance</button>
            </div>
        </form>
    </div>
</div>

<script>
    const pageContextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/event.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
