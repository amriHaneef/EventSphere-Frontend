<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EventSphere</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/event.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dashboard.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Include Chart.js -->
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
    <main id="admin_view_event_tab" >
        <div class="header">
            <div class="left">
                <ul class="breadcrumb">
                    <li>
                        <a href="#">Admin/Event</a>
                    </li>
                </ul>
            </div>
            <div class="batch-container-box">
                <!-- Search Box -->
                <div class="header-box">
                    <input type="text" id="eventSearch" onkeyup="searchEvent()" placeholder="Search for Event ID or Name...">
                </div>

                <!-- Event Table -->
                <table class="event-table" id="event_tab_table">
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

                <!-- Metrics Dashboard -->
            <div class="metrics-dashboard">
                <h3>Event Metrics</h3>
                <div id="metrics">
                    <canvas id="progressPieChart" width="400" height="400"></canvas> <!-- Placeholder for pie chart -->
                </div>
            </div>
            </div><br>

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

        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
<script src="${pageContext.request.contextPath}/js/event.js"></script>
</body>
</html>
