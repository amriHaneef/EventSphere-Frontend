<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Events UI</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/event.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dashboard.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Include Chart.js -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">

</head>
<body>
<!-- Sidebar -->
<div class="sidebar ">
    <a href="#" class="logo">
        <i class="bx bx-code-alt"></i>
        <div class="logo-name"><span>Event</span>Sphere</div>
    </a>
    <ul class="side-menu">
        <li>
            <a href="${pageContext.request.contextPath}/pages/Home"><i class='bx bx-home'></i>Home</a>
        </li>
        <li class="active">
            <!-- Add link to events page -->
            <a href="${pageContext.request.contextPath}/pages/events.jsp"><i class="bx bx-calendar-check"></i>Events</a>
        </li>
        <li>
            <a href="#"><i class='bx bxs-megaphone'></i>Announcements</a>
        </li>
        <li>
            <a href="#"><i class='bx bxs-book-open'></i>Batches</a>
        </li>
        <li>
            <a href="#"><i class="bx bx-group"></i>Users</a>
        </li>
        <li>
            <a href="#"><i class="bx bx-group"></i>Students</a>
        </li>
        <li>
            <a href="#"><i class="bx bx-cog"></i>My Account</a>
        </li>
    </ul>
    <ul class="side-menu">
        <li>
            <a href="#" class="logout"><i class='bx bx-log-out'></i>Logout</a>
        </li>
    </ul>
</div>
<!-- End of sidebar  -->

<!-- Main content -->
<div class="content">
    <!-- Navbar  -->
    <nav>
        <i class="bx bx-menu"></i>

        <input type="checkbox" id="theme-toggle" hidden>
        <label for="theme-toggle" class="theme-toggle"></label>

        <a href="#" class="notif">
            <i class="bx bx-bell"></i>
            <span class="count">12</span>
        </a>
        <a href="#" class="profile">
            <img src="${pageContext.request.contextPath}/images/noprofil.jpg" alt="profile_image">
        </a>
    </nav>
    <!-- End of navbar  -->


<main>
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

       <!-- Popup Form -->
       <div id="popupForm" class="popup-form">
           <div class="popup-content">
               <span class="close-btn" onclick="closePopup()">&times;</span>
               <h2>Add Event</h2><br>
               <form id="addEventForm">
                   <label for="eventName">Event Name:</label>
                   <input type="text" id="eventName" name="eventName" required><br><br>

                   <label for="eventDate">Date:</label>
                   <input type="date" id="eventDate" name="eventDate" required><br><br>

                   <label for="eventBatch">Batch:</label>
                   <select id="eventBatch" name="eventBatch" required>
                       <option value="" disabled selected>Select a batch</option>
                       <option value="DSE23.2f">DSE23.2f</option>
                       <option value="DSE23.3f">DSE23.3f</option>
                       <option value="HDSE23.2f">HDSE23.2f</option>
                       <option value="HDSE24.2f">HDSE24.2f</option>
                   </select><br><br>

                   <label for="eventProgress">Progress:</label>
                   <input type="number" id="eventProgress" name="eventProgress" min="0" max="100" required><br><br>

                   <button type="submit">Add Event</button>
               </form>
           </div>
       </div>


       <!-- Metrics Dashboard -->
    <div class="metrics-dashboard">
        <h3>Event Metrics</h3>
        <div id="metrics">
            <canvas id="progressPieChart" width="400" height="400"></canvas> <!-- Placeholder for pie chart -->
        </div>
    </div>

        <!-- Attendance Marking Panel -->
        <div class="attendance-panel">
            <h2>Attendance Marking</h2>
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
        <h2>Assigned Events</h2><br>
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
</main>
</div>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
<script src="${pageContext.request.contextPath}/js/event.js"></script>
</body>
</html>
