
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
    <title>EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
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
        <div class="announcements-notification">
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
                            <li class="item">
                                <div class="item-content">
                                    <p>Mock Interview on 2024/12/30.</p>
                                </div>
                            </li>
                            <li class="item">
                                <div class="item-content">
                                    <p>Mock Interview on 2024/12/30.</p>
                                </div>
                            </li>
                            <li class="item">
                                <div class="item-content">
                                    <p>Mock Interview on 2024/12/30.</p>
                                </div>
                            </li>
                            <li class="item">
                                <div class="item-content">
                                    <p>Mock Interview on 2024/12/30.</p>
                                </div>
                            </li>
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
    </nav><!-- End of navbar  -->

    <main id="main-content">
        <h1>hello</h1>
    </main>
</div>


<script>
    const pageContextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/students.js"></script>
<script src="${pageContext.request.contextPath}/js/announcement.js"></script>
<script src="${pageContext.request.contextPath}/js/Users.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
</body>
</html>
