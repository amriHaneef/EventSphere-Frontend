<%@ page import="java.util.List" %>
<%@ page import="java.lang.String" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Check if 'role' is already declared;
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/announcement.css">
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
        <li>
            <a href="${pageContext.request.contextPath}/pages/Home"><i class='bx bx-home'></i>Home</a>
        </li>
        <li>
            <a href="#"><i class="bx bx-calendar-check"></i>Events</a>
        </li>
        <li class="active">
            <a href="#"><i class='bx bxs-megaphone'></i>Announcements</a>
        </li>
        <li>
            <a href="#"><i class='bx bxs-book-open'></i>Batches</a>
        </li>
        <%
            if ("admin".equalsIgnoreCase(role)) {
        %>
        <li>
            <a href="#"><i class="bx bx-group"></i>Users</a>
        </li>
        <%
            }
        %>
        <%
            if ("teacher".equalsIgnoreCase(role)) {
        %>
        <li>
            <a href="#"><i class="bx bx-group"></i>Students</a>
        </li>
        <%
            }
        %>
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
        <div class="header">
            <div class="left">
                <ul class="breadcrumb">
                    <li>
                        <a href="#">${sessionScope.role}</a>
                    </li>
                    /
                    <li>
                        <a href="#" class="active">Announcements</a>
                    </li>
                </ul>
            </div>
            <%
                if ("admin".equalsIgnoreCase(role) || "teacher".equalsIgnoreCase(role)) {
            %>
            <a class="report" onclick="openModal(event)">
                <i class="bx bx-plus"></i>
                <span>Add Announcements</span>
            </a>
            <%
                }
            %>

        </div>

        <div class="bottom-data">
            <div class="orders">
                <div class="header">
                    <i class="bx bxs-megaphone"></i>
                    <h3>Recent Announcements</h3>
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
                        <th>Title</th>
                        <th>Announcement By</th>
                        <th>Date</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        // Retrieve and safely cast announcements
                        Object announcementsObject = request.getAttribute("announcements");
                        if (announcementsObject instanceof List) {
                            List<String[]> announcements = (List<String[]>) announcementsObject;
                            for (String[] announcement : announcements) {
                    %>
                    <tr>
                        <td><%= announcement[0] %></td>
                        <td><%= announcement[1] %></td>
                        <td><%= announcement[2] %></td>

                        <%
                            if  ("admin".equalsIgnoreCase(role) || "teacher".equalsIgnoreCase(role)) {
                        %>
                        <td>
                            <button class="delete">
                                <i class="bx bxs-trash bin"></i>
                            </button>
                        </td>
                        <%
                        }
                        %></tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
                <!-- Popup Form -->
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
    </main>
</div>

<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
<script src="${pageContext.request.contextPath}/js/announcement.js"></script>
</body>
</html>

