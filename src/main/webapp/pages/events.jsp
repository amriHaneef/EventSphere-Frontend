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

    <main id="Teacher_view_event_tab" style="display: none">
        <div class="header">
            <div class="left">
                <ul class="breadcrumb">
                    <li>
                        <a href="#">Teacher</a>
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
                    <input type="text" id="searchInput_techer" placeholder="Search...">
                    <button onclick="searchEvent()">Search</button>
                </div>

                <!-- Buttons -->
                <div class="button-panel">
                    <button onclick="addEvent()">Add Event</button>
                    <button onclick="editEvent()">Edit Event</button>
                    <button onclick="deleteEvent()">Delete Event</button>
                </div>


                <section>
                    <!-- Popup Form -->
                    <div id="popupForm" class="popup-form">
                        <div class="popup-content">
                            <span class="close-btn" onclick="closePopup()">&times;</span>
                            <h2>Add Event</h2><br>
                            <form id="addEventForm">
                                <label for="eventType">Event Type:</label>
                                <select id="eventType" name="eventType" required>
                                    <option value="" disabled selected>Select a event name</option>
                                    <option value="Session-Workshop">Session/Workshop</option>
                                    <option value="mock interviews">Mock Interviews</option>
                                </select><br><br>

                                <label for="eventBatch">Batch:</label>
                                <select id="eventBatch" name="eventBatch" required>
                                    <option value="" disabled selected>Select a batch</option>
                                    <option value="DSE23.2f">DSE23.2f</option>
                                    <option value="DSE23.3f">DSE23.3f</option>
                                    <option value="HDSE23.2f">HDSE23.2f</option>
                                    <option value="HDSE24.2f">HDSE24.2f</option>
                                </select><br><br>

                                <label for="studentId">Student ID:</label>
                                <select id="studentId" name="studentId" required>
                                    <option value="" disabled selected>Select a student Index</option>
                                    <option value="DSE23.2f">DSE232F-001</option>
                                    <option value="DSE23.3f">DSE232F-002</option>
                                    <option value="DSE23.2f">DSE232F-003</option>
                                    <option value="DSE24.2f">DSE232F-004</option>
                                </select><br><br>

                                <label for="eventDate">Date:</label>
                                <input type="date" id="eventDate" name="eventDate" required><br><br>

                                <label for="eventProgress">Progress:</label>
                                <input type="number" id="eventProgress" name="eventProgress" min="0" max="100" required><br><br>

                                <button type="submit">Add Event</button>
                            </form>
                        </div>
                    </div>
                </section>

                <!-- Event Table -->
                <table class="event-table" id=" Teacher_view_event_tab_table">
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
            </div>
        </div>
    </main>

    <main id="Student_view_event_tab" >
        <div class="header">
            <div class="left">
                <ul class="breadcrumb">
                    <li>
                        <a href="#">Student/Event</a>
                    </li>
                </ul><br>
            </div>
        </div>

        <div class="container">
            <!-- Search Bar -->
            <div class="search-bar">
                <input type="text" id="searchInput_student" placeholder="Search...">
                <button onclick="searchEvent()">Search</button>
            </div>
        </div>

        <!-- Assigned  Events Table student -->
        <div class="assigned-event">
            <h2>
                <span class="material-icons-sharp">event</span> Assigned Events
            </h2>
            <br>
            <table class="event-table" id="student_view_event_tab_table">
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
                    <td>Mrs.Thilini</td>
                    <td>Missed</td>
                </tr>
                </tbody>
            </table>
        </div>
        </section>

        <!-- Circular Progress Bar -->
        <section>
            <div class="insight ">
                <div class="sales">
                <span class="material-icons-sharp">analytics
                </span>
                    <div class="middle">
                        <div class="left"><br>
                            <h1>Student</h1>
                            <h3>Progress</h3>
                        </div>
                        <div class="progress">
                            <svg>
                                <circle cx='38' cy='38' r='36' style="stroke-dashoffset: 80"></circle>
                            </svg>
                            <div class="number">
                                <p>81%</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section><br>

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

    </main>
</div>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
<script src="${pageContext.request.contextPath}/js/event.js"></script>
</body>
</html>
