<%@ page import="java.util.List" %>
<%@ page import="java.lang.String" %>
<%@ page import="com.example.eventspherefrontend.model.Event" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String role = (String) session.getAttribute("role");
%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/event.css">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/DashboardHome.css">


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

<button type="button"  onclick="onloading()">test</button>
<%--event table --%>
<div id="eventTable">

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
                    List<Event> allEvents = (List<Event>) request.getAttribute("allEvents");
                %>
                <%
                    if (allEvents != null && !allEvents.isEmpty()) {
                        for (Event allEvent : allEvents) {
                %>

                <tr>
                    <td ><%= allEvent.getId() %></td>
                    <td><%= allEvent.getTitle() %></td>
                    <td><%= allEvent.getEventDate().substring(0, 10) %></td>
                    <td><%= allEvent.getTimePeriod().substring(0, 10) %></td>
                    <td><%= allEvent.getPlatform() %></td>
                    <td><%= allEvent.getCoordinatorName() %></td>
                    <td><%= allEvent.getStatus() %></td>

                    <%
                        if ("admin".equalsIgnoreCase(role) || "teacher".equalsIgnoreCase(role)) {
                    %>
                    <td>
                        <button class="update" id="btnUpdate" onclick="eventsDetailsPopUp('<%= allEvent.getId() %>')">
                            <i class="bx bxs-pencil"></i>
                        </button>

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
                    <td>
                        <button class="view" onclick="showEventDetails('<%= allEvent.getId() %>', '<%= allEvent.getTitle() %>', '<%= allEvent.getEventDate().substring(0, 10) %>', '<%= allEvent.getTimePeriod().substring(0, 10) %>', '<%= allEvent.getPlatform() %>', '<%= allEvent.getCoordinatorName() %>', '<%= allEvent.getStatus() %>')">
                            <i class="bx bx-show eye"></i>
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
                    <span class="delete-close">&times;</span>
                    <p>Do you want to delete this event?</p>
                    <div class="popup-buttons">
                        <button class="cancel-Btn">Cancel</button>
                        <button class="ok-btn">OK</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Popup Form -->
    <div class="edit-Overlay">
        <div class="edit-Content">
            <span class="edit-Close">&times;</span>
            <h3>Edit Student Details</h3>
            <form id="editeventForm">
                <div class="form-group">
                    <label for="event-id">Event Id:</label>
                    <input type="text" id="event-id" class="form-control" name="eventid" required>
                </div>
                <div class="form-group">
                    <label for="event-name">Event Name:</label>
                    <input type="text" id="event-name" class="form-control" name="eventName" required>
                </div>
                <div class="form-group">
                    <label for="event-date">Date:</label>
                    <input type="date" id="event-date" class="form-control" name="Date" required>
                </div>
                <div class="form-group">
                    <label for="event-time">Time:</label>
                    <input type="Text" id="event-time" class="form-control" name="time" required>
                </div>
                <div class="form-group">
                    <label for="event-Platform">Platform:</label>
                    <input type="text" id="event-Platform" class="form-control" name="platform" required>
                </div>
                <div class="form-group">
                    <label for="lecturer-name">Lecturer:</label>
                    <input type="text" id="lecturer-name" class="form-control" name="lecturername" required>
                </div>
                <div class="form-group">
                    <label for="event-status">Status:</label>
                    <select id="event-status"  class="form-control" name="eventstatus" required>
                        <option value="" disabled selected>Select a status</option>
                        <option value="status1">Schedule</option>
                        <option value="Status2">Done</option>
                    </select>
                </div>

                <div class="edit-buttons">
                    <button type="button" class="Cancel-Btn">Cancel</button>
                    <button type="submit" class="save-Btn">Save</button>
                </div>

            </form>
        </div>
    </div>

    <br>

    <!-- Feedback Box -->
    <% if ("student".equalsIgnoreCase(role)) { %>
    <section>
        <div class="feedback">
            <h2 id="feedbackHeading"><i class="fa fa-comment-dots"></i> Feedback</h2>
            <div class="feedback-box">
                <textarea id="feedbackBox_student" placeholder="Enter feedback for the event..."></textarea>
                <button onclick="submitFeedback()">Submit Feedback</button>
            </div>
        </div>
    </section>
</div>
<% } %>
<!-- Event Details Section  -->
<div id="eventData">
  <h1>testing heading</h1>
</div>
<div id="detailsTab" >
    <div class ="event-details" >
        <h2>Event Details</h2>
        <button id="backevent" onclick="">
            <i class="fas fa-arrow-left"></i>
        </button>

        <table class="attendance">
            <tr>
                <th>Event ID</th>
                <td id="detail-event-id">N/A</td>
            </tr>
            <tr>
                <th>Event Name</th>
                <td id="detail-event-name">N/A</td>
            </tr>
            <tr>
                <th>Event Type</th>
                <td id="detail-event-type">N/A</td>
            </tr>
            <tr>
                <th>Date</th>
                <td id="detail-event-date">N/A</td>
            </tr>
            <tr>
                <th>Time</th>
                <td id="detail-event-time">N/A</td>
            </tr>
            <tr>
                <th>Platform</th>
                <td id="detail-event-platform">N/A</td>
            </tr>
            <tr>
                <th>Lecturer</th>
                <td id="detail-event-lecturer">N/A</td>
            </tr>
            <tr>
                <th>Status</th>
                <td id="detail-event-status">N/A</td>
            </tr>
        </table>
    </div>

    <!-- Button to open popup -->
    <button id="markAttendanceBtn" onclick="showAttendancePopup()">Mark Attendance</button>
    <!-- Attendance Popup Form -->
    <div class="attendance-popup">
        <div class="popup-container">
            <span class="attendance-close">&times;</span>
            <h3>Mark Attendance</h3>
            <form id="attendanceForm">
                <div id="studentListContainer">
                    <!-- Students will be dynamically loaded here -->
                </div>
                <div class="attendance-button">
                    <button type="button" class="cancelBtn">Cancel</button>
                    <button type="submit" class="saveBtn">Save Attendance</button>
                </div>
            </form>
        </div>
    </div>


</div>

<script>
    const pageContextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/event.js"></script>

<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
<script src="${pageContext.request.contextPath}/js/eventspop.js"></script>
