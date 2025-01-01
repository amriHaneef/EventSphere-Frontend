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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Users.css">
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
    <li>
      <a href="#"><i class='bx bxs-megaphone'></i>Announcements</a>
    </li>
    <li>
      <a href="#"><i class='bx bxs-book-open'></i>Batches</a>
    </li>

    <%
      if ("admin".equalsIgnoreCase(role)) {
    %>

    <li class="active">
      <a href="${pageContext.request.contextPath}/pages/users"><i class="bx bx-group"></i>Users</a>
    </li>
    <%
      }
    %>
    <%
      if ("teacher".equalsIgnoreCase(role)) {
    %>
    <li >
      <a href=""><i class="bx bx-group"></i>Students</a>
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
            <a href="#" class="active">Users</a>
          </li>
        </ul>
      </div>
      <a href="#" class="report" onclick="openModal(event)">
        <i class="bx bx-plus"></i>
        <span>Add Users</span>
      </a>
      <!-- Modal Form -->
      <div class="modal" id="userForm">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Fill the Form</h4>
              <i class='bx bx-x close'  onclick="closeModal()"></i>
            </div>
            <div class="modal-body">
              <form action="#" id="myForm">
                <div class="card imgholder">
                  <label for="imgInput" class="upload">
                    <input type="file" name="" id="imgInput">
                    <i class='bx bx-plus'></i>
                  </label>
                  <img id="imagePreview" alt="" width="200" height="200" class="img">
                </div>
                <div class="inputField">
                  <label for="name">Name:</label>
                  <input type="text" name="" id="name" required>

                  <label for="email">E-mail:</label>
                  <input type="email" name="" id="email" required>

                  <label for="birthday">Birthday:</label>
                  <input type="date" name="birthday" id="birthday" required>

                  <label for="phone">Number:</label>
                  <input type="text" name="" id="phone" minlength="11" maxlength="11" required>

                  <label for="userType">User Type:</label>
                  <select id="userType" required>
                    <option value="" disabled selected>Select a User Type</option>
                    <option value="admin">Admin </option>
                    <option value="teacher">Teacher </option>
                    <option value="student">Student</option>
                    <!-- Add more options as needed -->
                  </select>

                  <div id="batchField" style="display: none;">
                    <label for="batch">Batch:</label>
                    <select id="batch" required>
                      <option value="" disabled selected>Select a batch</option>
                      <option value="batch1">Batch 1</option>
                      <option value="batch2">Batch 2</option>
                      <option value="batch3">Batch 3</option>
                      <!-- Add more options as needed -->
                    </select>
                  </div>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" onclick="closeModal()">Close</button>
              <button type="submit" form="myForm" class="btn btn-primary submit">Submit</button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="bottom-data">
      <div class="orders">
        <div class="header">
          <i class="bx bx-group"></i>
          <h3>User Details</h3>
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
            <th>Name</th>
            <th>Email</th>
            <th>Birthday</th>
            <th>Batch</th>
            <th></th>
          </tr>
          </thead>
          <tbody>
          <%
            // Retrieve and safely cast students
            Object usersObject = request.getAttribute("users");
            if (usersObject instanceof List) {
              List<String[]> users = (List<String[]>) usersObject;
              for (String[] user : users) {
          %>
          <tr>
            <td><%= user[0] %></td>
            <td><%= user[1] %></td>
            <td><%= user[2] %></td>
            <td><%= user[3] %></td>
            <td><%= user[4] %></td>
            <td>
              <button class="edit">
                <i class="bx bx-edit write"></i>
              </button>
            </td>
          </tr>
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
            <h3>Edit Student Details</h3>
            <form id="editForm">
              <div class="form-group">
                <label for="student-id">ID:</label>
                <input type="text" id="student-id" class="form-control" name="id" required disabled>
              </div>
              <div class="form-group">
                <label for="student-name">Name:</label>
                <input type="text" id="student-name" class="form-control" name="name" required>
              </div>
              <div class="form-group">
                <label for="student-email">Email:</label>
                <input type="email" id="student-email" class="form-control" name="email" required>
              </div>
              <div class="form-group">
                <label for="student-birthday">Birthday:</label>
                <input type="text" id="student-birthday" class="form-control" name="birthday" required>
              </div>
              <div class="form-group">
                <label for="student-batch">Batch:</label>
                <input type="text" id="student-batch" class="form-control" name="batch" required disabled>
              </div>
              <div class="popup-buttons">
                <button type="button" class="cancel">Cancel</button>
                <button type="submit" class="ok-btn">Save</button>
              </div>
            </form>
          </div>
        </div>

      </div>
    </div>
  </main>
</div>


<script src="${pageContext.request.contextPath}/js/Users.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
</body>
</html>
