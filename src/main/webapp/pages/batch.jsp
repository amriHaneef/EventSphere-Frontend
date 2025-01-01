<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>eventsphere</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/batch.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dashboard.css">
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
        <li>
            <a href="${pageContext.request.contextPath}/pages/events"><i class="bx bx-calendar-check"></i>Events</a>
        </li>
        <li >
            <a href="#"><i class='bx bxs-megaphone'></i>Announcements</a>
        </li>
        <li class="active">
            <a href="${pageContext.request.contextPath}/pages/batch.jsp"><i class='bx bxs-book-open'></i>Batches</a>
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
    <main id="admin_view_batch_tab" >
        <div class="header">
            <div class="left">
                <ul class="breadcrumb">
                    <li>
                        <a href="#">Admin/Batch</a>
                    </li>
                </ul><br>
            </div>

            <div class="batch-container-box">
                <!-- Search Box and Add Button -->
                <div class="header-box">
                    <input type="text" id="batchSearch" onkeyup="searchBatch()" placeholder="Search for Batch ID or Name..">
                    <button class="add-batch-btn" onclick="addBatch()">
                        <i class="fa fa-plus"></i> Add Batch
                    </button>
                </div>

                <!-- Batch Table -->
                <table class="batch-table" id="Admin_batch_tab_table">
                    <thead>
                    <tr>
                        <th>Batch ID</th>
                        <th>Batch Name</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Assign Teacher</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1</td>
                        <td>DSE232f</td>
                        <td>2025-12-25</td>
                        <td>2025-12-25</td>
                        <td>Mrs.Sandaruwani</td>
                        <td>
                            <button class="icon-btn edit-btn" onclick="editBatch(1)">
                                <i class="fa fa-edit"></i>
                            </button>
                            <button class="icon-btn delete-btn" onclick="deleteBatch(1)">
                                <i class="fa fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>DSE232f</td>
                        <td>2025-12-25</td>
                        <td>2025-12-25</td>
                        <td>Mrs.Sandaruwani</td>
                        <td>
                            <button class="icon-btn edit-btn" onclick="editBatch(2)">
                                <i class="fa fa-edit"></i>
                            </button>
                            <button class="icon-btn delete-btn" onclick="deleteBatch(2)">
                                <i class="fa fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>DSE232f</td>
                        <td>2025-12-25</td>
                        <td>2025-12-25</td>
                        <td>Mrs.Sandaruwani</td>
                        <td>
                            <button class="icon-btn edit-btn" onclick="editBatch(3)">
                                <i class="fa fa-edit"></i>
                            </button>
                            <button class="icon-btn delete-btn" onclick="deleteBatch(3)">
                                <i class="fa fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>

            </div>


            <div id="createBatchModal" class="modal">
                <div class="modal-content">
                    <span class="close-btn" onclick="closeModal()">&times;</span><br>
                    <h2 id="modalTitle">Create a New Batch</h2> <!-- Title changes dynamically -->
                    <form id="batchForm">
                        <label for="batchName">Batch Name:</label>
                        <input type="text" id="batchName" name="batchName" required>

                        <label for="startDate">Start Date:</label>
                        <input type="date" id="startDate" name="startDate" required>

                        <label for="endDate">End Date:</label>
                        <input type="date" id="endDate" name="endDate" required>

                        <label for="teacher">Assign Teacher:</label>
                        <select id="teacher" name="teacher" required>
                            <option value="" disabled selected>Select a teacher</option>
                            <option value="Mrs.Sandaruwani">Mrs.Sandaruwani</option>
                            <option value="Mrs.Thilini">Mrs.Thilini</option>
                        </select>

                        <button type="submit" id="createBatch">Create Batch</button>
                    </form>
                </div>
            </div>

            <!-- batch Table teacher -->
            <table class="batch-table" id="Teacher_view_batch_tab_table" style="display: none">
                <thead>
                <tr>
                    <th>Batch ID</th>
                    <th>Batch Name</th>
                    <th>Assign Students</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>DSE232f</td>
                    <td>37</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>DSE232f</td>
                    <td>37</td>

                </tr>
                <tr>
                    <td>3</td>
                    <td>DSE232f</td>
                    <td>37</td>

                </tr>
                </tbody>
            </table><br>

            <!-- batch Table student -->
            <table class="batch-table" id="Student_view_batch_tab_table" style="display: none">
                <thead>
                <tr>
                    <th>Student Index</th>
                    <th>Student Name</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>DSE232F-001</td>
                    <td>Amri Haneef</td>
                </tr>
                <tr>
                    <td>DSE232F-002</td>
                    <td>Harindu da Silva</td>
                </tr>
                <tr>
                    <td>DSE232F-003</td>
                    <td>Shan Indeewa</td>
                </tr>
                <tr>
                    <td>DSE232F-004</td>
                    <td>Adeesha Nanayakkara</td>
                </tr>
                <tr>
                    <td>DSE232F-005</td>
                    <td>NIduli Wijesiriwardana</td>
                </tr>
                <tr>
                    <td>DSE232F-006</td>
                    <td>Induwara Bhagya</td>
                </tr>

                </tbody>
            </table>

        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/batch.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
</body>
</html>