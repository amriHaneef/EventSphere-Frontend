<%@ page import="java.util.List" %>
<%@ page import="java.lang.String" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role"); // Get the role from the session

    if (role == null) {
        role = "guest"; // Default role if none is set
    }
%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/students.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">

        <div class="header">
            <div class="left">
                <ul class="breadcrumb">
                    <li>
                        <a href="#">${sessionScope.role}</a>
                    </li>
                    /
                    <li>
                        <a href="#" class="active">Students</a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="bottom-data">
            <div class="orders">
                <div class="header">
                    <i class="bx bx-group"></i>
                    <h3>Student Details</h3>
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
                        Object studentsObject = request.getAttribute("students");
                        if (studentsObject instanceof List) {
                            List<String[]> students = (List<String[]>) studentsObject;
                            for (String[] student : students) {
                    %>
                    <tr>
                        <td><%= student[0] %></td>
                        <td><%= student[1] %></td>
                        <td><%= student[2] %></td>
                        <td><%= student[3] %></td>
                        <td><%= student[4] %></td>
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

<script>
    const pageContextPath = "${pageContext.request.contextPath}";
</script>

<script src="${pageContext.request.contextPath}/js/students.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
