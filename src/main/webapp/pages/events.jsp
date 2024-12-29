<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EventSphere</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/event.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
    <main id="admin_view_event_tab" style="display: none">
        <div class="header">
            <div class="left">
                <ul class="breadcrumb">
                    <li>
                        <a href="#">Admin</a>
                    </li>
                    /
                    <li>
                        <a href="#" class="active">Event</a>
                    </li>
                </ul>
            </div>
            <div class="container">
                <!-- Search Bar -->
                <div class="search-bar">
                    <input type="text" id="searchInput" placeholder="Search...">
                    <button onclick="searchEvent()">Search</button>
                </div>

                <!-- Event Table -->
                <table class="event-table" id=" event_tab_table">
                    <thead>
                    <tr>
                        <th>Event ID</th>
                        <th>Event Name</th>
                        <th>Date</th>
                        <th>Event Type</th>
                        <th>Progress</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1</td>
                        <td>Java Workshop</td>
                        <td>2024-12-25</td>
                        <td>Session/workshop</td>
                        <td>75%</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>Python Bootcamp</td>
                        <td>2024-12-20</td>
                        <td>Session/workshop</td>
                        <td>85%</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>Web Development</td>
                        <td>2024-12-22</td>
                        <td>Session/workshop</td>
                        <td>80%</td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <!-- Metrics Dashboard -->
            <div class="metrics-dashboard">
                <h3>Event Metrics</h3>
                <div id="metrics">
                    <canvas id="progressPieChart" width="400" height="400"></canvas> <!-- Placeholder for pie chart -->
                </div>
            </div>
        </div>
    </main>

    <main id="Teacher_view_event_tab" >
        <div class="header">
            <div class="left">
                <ul class="breadcrumb">
                    <li>
                        <a href="#">Teacher/Event</a>
                    </li>
                </ul><br>
            </div>

            <div class="container">
                <!-- Search Bar -->
                <div class="search-bar">
                    <input type="text" id="searchInput_techer" placeholder="Search...">
                    <button onclick="searchEvent()">Search</button><br>
                </div>

                <!-- Buttons -->
                <div class="button-panel">
                    <button class="add-event-btn" onclick="addEvent()">
                        <i class="fa fa-plus "></i> Add Event
                    </button>
                </div>
                <section>
                    <!-- Popup Form -->
                    <div id="popupForm" class="popup-form">
                        <div class="popup-content">
                            <span class="close-btn" onclick="closePopup()">&times;</span><br>
                            <h2 id="popupTitle">Add Event</h2><br>
                            <form id="eventForm">
                                <input type="hidden" id="eventId" name="eventId">

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

                                <button type="submit" id="popupSubmitButton">Add Event</button>
                            </form>
                        </div>
                    </div>
                </section>

                    <!-- Event Table -->
                <table class="event-table" id="Teacher_view_event_tab_table">
                    <thead>
                    <tr>
                        <th>Event ID</th>
                        <th>Event Name</th>
                        <th>Date</th>
                        <th>Event Type</th>
                        <th>Progress</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1</td>
                        <td>Java Workshop</td>
                        <td>2024-12-25</td>
                        <td>Session/workshop</td>
                        <td>75%</td>
                        <td>
                            <button class="icon-btn edit-btn" onclick="editEvent(1)">
                                <i class="fa fa-edit"></i>
                            </button>
                            <button class="icon-btn delete-btn" onclick="deleteEvent(1)">
                                <i class="fa fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>Python Bootcamp</td>
                        <td>2024-12-20</td>
                        <td>Session/workshop</td>
                        <td>85%</td>
                        <td>
                            <button class="icon-btn edit-btn" onclick="editEvent(2)">
                                <i class="fa fa-edit"></i>
                            </button>
                            <button class="icon-btn delete-btn" onclick="deleteEvent(2)">
                                <i class="fa fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>Web Development</td>
                        <td>2024-12-22</td>
                        <td>Session/workshop</td>
                        <td>80%</td>
                        <td>
                            <button class="icon-btn edit-btn" onclick="editEvent(3)">
                                <i class="fa fa-edit"></i>
                            </button>
                            <button class="icon-btn delete-btn" onclick="deleteEvent(3)">
                                <i class="fa fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>

                <!-- Attendance Marking Panel -->
                <div class="attendance-panel">
                    <h2><i class="fa fa-check-circle"></i> Attendance Marking</h2> <br>
                    <label for="Teacher_view_event_tab">Batch:</label>
                    <select id="eventBatch_attendence" name="eventBatch" required>
                        <option value="" disabled selected>Select a batch</option>
                        <option value="DSE23.2f">DSE23.2f</option>
                        <option value="DSE23.3f">DSE23.3f</option>
                        <option value="HDSE23.2f">HDSE23.2f</option>
                        <option value="HDSE24.2f">HDSE24.2f</option><br>
                    </select>
                    <ul id="attendanceList">
                        <!-- Dynamic checkboxes for marking attendance go here -->
                    </ul>
                    <button onclick="submitAttendance()">Submit Attendance</button>
                </div>
                <!-- Feedback Box -->
                <div class="feedback-box">
                    <h2><i class="fa fa-comment-dots"></i> Feedback</h2> <!-- Feedback icon added here -->
                    <textarea id="feedbackBox" placeholder="Enter feedback for the event..."></textarea>
                    <button onclick="submitFeedback()">Submit Feedback</button>
                </div>

            </div>
        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
<script src="${pageContext.request.contextPath}/js/event.js"></script>
</body>
</html>
