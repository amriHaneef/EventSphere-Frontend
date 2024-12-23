<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
    <title>EventSphere</title>
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
        <li class="active">
            <a href="#"><i class='bx bx-home'></i>Home</a>
        </li>
        <li>
            <a href="#"><i class="bx bx-calendar-check"></i>Events</a>
        </li>
        <li >
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
    <main id="admin_view_home_tab">
        <div class="header">
            <div class="left">
                <h1>Dashboard</h1>
                <ul class="breadcrumb">
                    <li>
                        <a href="#">Admin</a>
                    </li>
                    /
                    <li>
                        <a href="#" class="active">Home</a>
                    </li>
                </ul>
            </div>

        </div>

        <!-- Insights -->

        <div class="insight ">
            <div class="sales">
                <span class="material-icons-sharp">analytics</span>
                <div class="middle">
                    <div class="left">
                        <h3>Attendance for Events</h3>
                        <p>Events: 25,024</p>
                        <p>Students: 25,024</p>
                    </div>
                    <div class="progress">
                        <svg>
                            <circle cx='38' cy='38' r='36' style="stroke-dashoffset: 120"></circle>
                        </svg>
                        <div class="number">
                            <p>45%</p>
                        </div>
                    </div>
                </div>
                <small class="text-muted">Last 24 Hours</small>

            </div>

            <!-- -------------------End Of Sales--------------------  -->

            <!-- --------------------------------------------End Of Insight---------------------------------------------------  -->
        </div>
        <ul class="insights">
            <a href="#">
                <li>
                    <i class="bx bx-group"></i>
                    <span class="info">
                            <h3>
                                1,074
                            </h3>
                            <p>Users</p>
                        </span>
                </li>
            </a>
            <a href="#">
                <li>
                    <i class="bx bx-calendar-check"></i>
                    <span class="info">
                            <h3>
                                1,074
                            </h3>
                            <p>Events</p>
                        </span>
                </li>
            </a>
            <a href="#">
                <li>
                    <i class='bx bxs-book-open'></i>
                    <span class="info">
                            <h3>
                                1,074
                            </h3>
                            <p>Batches</p>
                        </span>
                </li>
            </a>
        </ul>
        <!-- End of Insights  -->


        <div class="bottom-data">
            <div class="orders">
                <div class="header">
                    <i class="bx bx-calendar-check"></i>
                    <h3>Recent Events</h3>
                    <i class="bx bx-filter"></i>
                    <div class="search-container">
                        <i class="bx bx-search"></i>
                        <label>
                            <input type="text" class="search-bar" placeholder="Search...">
                        </label>
                    </div>
                </div>
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Event</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr onclick="openEventDetails()">
                        <td>1</td>
                        <td>
                            <p>Mock Interview</p>
                        </td>
                        <td>14-08-2024</td>
                        <td><span class="status completed">Completed</span></td>
                    </tr>
                    <!-------------------------- Event Details card ------------------------------>
                    <div class="container" id="eventDetails">
                        <div class="card">
                            <div class="top">
                                <div class="title">Event Details</div>
                            </div>
                            <div class="info">Here, you have some details about the event that you are looking for!</div>
                            <div class="details">
                                <div class="plan">
                                    <span><strong>Name:</strong> Mock Interview</span>
                                    <i class="bx bx-check"></i>
                                </div>
                                <div class="plan">
                                    <span><strong>Consultant:</strong> Mrs.Sandaruwani</span>
                                    <i class="bx bx-check"></i>
                                </div>
                                <div class="plan">
                                    <span><strong>Participated Batch:</strong> GAHDSE24.2f</span>
                                    <i class="bx bx-check"></i>
                                </div>
                                <div class="plan">
                                    <span><strong>Assigned Students: </strong> 30</span>
                                    <i class="bx bx-check"></i>
                                </div>
                                <button onclick="closeEventDetails()">Done</button>
                            </div>
                        </div>
                    </div>
                    <!-------------------------- End of Event Details card ----------------------->

                    </tbody>
                </table>
            </div>

            <!-- Reminders -->
            <div class="reminders">
                <div class="header">
                    <i class="bx bxs-megaphone"></i>
                    <h3>Recent Announcements</h3>
                </div>
                <ul class="task-list">

                    <li class="completed">
                        <div class="task-title">
                            <i class="bx bx-check-circle"></i>
                            <p>Your Meeting will start at 9 a.m.</p>
                        </div>
                        <i class="bx bx-dots-vertical-rounded"></i>
                    </li>

                </ul>
            </div>
            <!-- End of Reminders  -->
        </div>
    </main>
</div>

<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
</body>
</html>
