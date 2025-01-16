<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.eventspherefrontend.model.Event" %>
<%@ page import="java.util.List" %>
<%@ page import="java.lang.String" %>
<%@ page import="com.example.eventspherefrontend.model.Announcement" %>
<%
    String redirected = request.getParameter("redirected");
    if (redirected == null) {
        String contextPath = request.getContextPath();
        response.sendRedirect(contextPath + "/pages/Home?redirected=true");
    }
%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role"); // Get the role from the session

    if (role == null) {
        role = "guest"; // Default role if none is set
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/DashboardHome.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
    <title>EventSphere</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
    <script>
        const role = "<%= role != null ? role : "guest" %>"; // Pass role from server-side
        console.log("Role from JSP:", role);
    </script>
</head>
<body >
<input type="hidden" id="pageContextPath" value="${pageContext.request.contextPath}">
<%
    // Retrieve the List<Announcement> from request attributes
    List<Announcement> announcements = (List<Announcement>) request.getAttribute("announcements");
%>
<%
    List<Event> events = (List<Event>) request.getAttribute("events");
%>

<!-- Sidebar -->
<div class="sidebar ">
    <a href="#" class="logo">
        <i class="bx bx-code-alt"></i>
        <div class="logo-name"><span>Event</span>Sphere</div>
    </a>
    <ul class="side-menu">
        <li class="active">
            <a href="${pageContext.request.contextPath}/pages/Home"><i class='bx bx-home'></i>Home</a>
        </li>
        <li id="events-link">
            <a href="#"><i class="bx bx-calendar-check"></i>Events</a>
        </li>
        <li id="announcements-link">
            <a href="#"><i class='bx bxs-megaphone'></i>Announcements</a>
        </li>
        <li id="batches-link">
            <a href="#"><i class='bx bxs-book-open'></i>Batches</a>
        </li>
        <li id="users-link">
            <a href="#"><i class="bx bx-group"></i>Users</a>
        </li>
        <li id="students-link">
            <a href="#"><i class="bx bx-group"></i>Students</a>
        </li>
        <li id="accounts-link">
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
        <div class="announcements">
            <a href="#" class="notif">
                <i class="bx bx-bell"></i>
                <span class="count">12</span>
            </a>
            <div class="mini-cart">
                <div class="cartcontent">
                    <div class="cart-head">
                        <h1><i class="bx bxs-megaphone"></i> Announcements</h1>
                    </div>
                    <div class="cart-body">
                        <ul class="products mini">
                            <%
                                if (announcements != null) {
                                // Iterate through the List<Announcement>
                                for (Announcement announcement : announcements) {
                            %>
                            <li class="item">
                                <div class="item-content">
                                    <p><%= announcement.getTitle() %> on <%= announcement.getCreatedAt().substring(0, 10) %>.</p>
                                </div>
                            </li>
                            <%
                                    }
                                }
                            %>
                        </ul>
                    </div>

                    <div class="cart-footer">
                        <div class="actions">
                            <a href="#" class="primary-button">Done</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <a href="#" class="profile">
            <img src="${pageContext.request.contextPath}/images/noprofil.jpg" alt="profile_image">
        </a>
    </nav>
    <!-- End of navbar  -->
    <main id="main-content">
        <div class="header">
            <div class="left">
                <h1>Dashboard</h1>
                <ul class="breadcrumb">
                    <li>
                        <a href="#">${sessionScope.role}</a>
                    </li>
                    /
                    <li>
                        <a href="#" class="active">Home</a>
                    </li>
                </ul>
            </div>
            <%
                if("student".equalsIgnoreCase(role)){
            %>
            <a href="${pageContext.request.contextPath}/pages/Portfolio.jsp" class="report">
                <i class='bx bxs-edit-alt'></i>
                <span>Portfolio</span>
            </a>
            <%
                }
            %>
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
                <li >
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
                    <h3>Events</h3>
                    <div class="date-selection">
                        <form id="date-form" action="${pageContext.request.contextPath}/pages/Home" method="post">
                            <input type="date" name="eventDate" class="date-input" id="date-input" value="${eventDate}">
                            <button type="submit" class="date-btn" id="submit-btn">submit</button>
                        </form>
                    </div>
                    <div id="message"></div>
                    <div class="search-container">
                        <label>
                            <input type="text" id="search-bar" class="search-bar" placeholder="Search...">
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
                    <%
                        if (events != null && !events.isEmpty()) {
                            for (Event event : events) {
                    %>
                    <tr onclick="openEventDetails(this)">
                        <td><%= event.getId() %></td>
                        <td>
                            <p><%= event.getTitle() %></p>
                        </td>
                        <td><%= event.getEventDate().substring(0, 10) %></td>
                        <td style="display: none"><%= event.getPlatform()%></td>
                        <td><span class="status completed"><%=event.getStatus()%> </span></td>
                    </tr>
                    <%
                            }
                        }else{
                    %>
                    <tr>
                        <td></td>
                        <td colspan="1" style="text-align: center;  ">No Events Found on ${eventDate} <i class="bx bx-search" style="font-size: 14px;"></i></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <%
                        }
                    %>
                    <!-------------------------- Event Details card ------------------------------>
                    <div class="container" id="eventDetails">
                        <div class="card">
                            <div class="top">
                                <div class="title">Event Details</div>
                            </div>
                            <div class="info">Here, you have some details about the event that you are looking for!</div>
                            <div class="details">
                                <div class="plan">
                                    <span><strong>Name:</strong> </span>
                                    <i class="bx bx-check"></i>
                                </div>
                                <div class="plan">
                                    <span><strong>Date:</strong></span>
                                    <i class="bx bx-check"></i>
                                </div>
                                <div class="plan">
                                    <span><strong>Platform:</strong></span>
                                    <i class="bx bx-check"></i>
                                </div>
                                <div class="plan">
                                    <span><strong>Status: </strong> </span>
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
                    <%
                        if (announcements != null) {
                        // Iterate through the List<Announcement>
                        for (Announcement announcement : announcements) {
                    %>
                    <li class="completed">
                        <div class="task-title">
                            <i class="bx bx-check-circle"></i>
                            <p><%= announcement.getTitle() %> On <%= announcement.getCreatedAt().substring(0, 10)  %></p>
                        </div>
                        <i class="bx bx-dots-vertical-rounded"></i>
                    </li>
                    <%
                            }
                        }
                    %>
                </ul>
            </div>
            <!-- End of Reminders  -->
        </div>
    </main>
</div>
<script>
    const pageContextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/DashboardHome.js"></script>
<script src="${pageContext.request.contextPath}/js/MyAccount.js"></script>
<script src="${pageContext.request.contextPath}/js/batch.js"></script>
<script src="${pageContext.request.contextPath}/js/students.js"></script>
<script src="${pageContext.request.contextPath}/js/announcement.js"></script>
<script src="${pageContext.request.contextPath}/js/Users.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
</body>
</html>