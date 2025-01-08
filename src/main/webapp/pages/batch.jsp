<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String role = (String) session.getAttribute("role");
%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/batch.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<div class="header">
    <div class="left">
        <ul class="breadcrumb">
            <li>
                <a href="#">${sessionScope.role}</a>
            </li>
            /
            <li>
                <a href="#" class="active">Batch</a>
            </li>
        </ul>
    </div>
    <% if ("admin".equalsIgnoreCase(role)) { %>
    <a class="report">
        <i class="bx bx-plus"></i>
        <span>Add Batches</span>
    </a>
    <% } %>
</div>


<div class="add-batch-popup" >
    <div class="popup-container">
        <span class="popup-close">&times;</span>
        <h3>Add Batch Details</h3>
        <form id="addBatchForm">
            <div class="form-group">
                <label for="batchname">Batch Name:</label>
                <input type="text" id="batchname" name="batchName" required>
            </div>
            <div class="form-group">
                <label for="startdate">Start Date:</label>
                <input type="date" id="startdate" name="startDate" required>
            </div>
            <div class="form-group">
                <label for="enddate">End Date:</label>
                <input type="date" id="enddate" name="endDate" required>
            </div>
            <div class="form-group">
                <label for="lecturer">Lecturer:</label>
                <input type="text" id="lecturer" name="lecturer" required>
            </div>
            <div class="popup-buttons">
                <button type="button" class="cancel-btn">Cancel</button>
                <button type="submit" class="save-btn">Save</button>
            </div>
        </form>
    </div>
</div>


<div class="bottom-data">
    <div class="orders">
        <div class="header">
            <i class="bx bxs-book-open"></i>
            <h3>Batch</h3>
            <div class="search-container">
                <label>
                    <input type="text" id="search-bar" class="search-bar" placeholder="Search...">
                </label>
            </div>
        </div>

        <% if ("admin".equalsIgnoreCase(role)) { %>
        <!-- Admin Table -->
        <table>
            <thead>
            <tr>
                <th>Batch ID</th>
                <th>Batch Name</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Lecturer</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                Object adminBatches = request.getAttribute("batches");
                if (adminBatches instanceof List) {
                    List<String[]> batches = (List<String[]>) adminBatches;
                    for (String[] batch : batches) {
            %>
            <tr>
                <td><%= batch[0] %></td>
                <td><%= batch[1] %></td>
                <td><%= batch[2] %></td>
                <td><%= batch[3] %></td>
                <td><%= batch[4] %></td>
                <td>
                    <button class="delete"><i class="bx bxs-trash bin"></i></button>
                    <button class="edit"><i class="bx bx-edit write"></i></button>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="6">No batches available.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else if ("teacher".equalsIgnoreCase(role)) { %>
        <!-- Teacher Table -->
        <table>
            <thead>
            <tr>
                <th>Batch ID</th>
                <th>Batch Name</th>
                <th>Assign Students</th>
            </tr>
            </thead>
            <tbody>
            <%
                Object teacherBatches = request.getAttribute("batches");
                if (teacherBatches instanceof List) {
                    List<String[]> batches = (List<String[]>) teacherBatches;
                    for (String[] batch : batches) {
            %>
            <tr>
                <td><%= batch[0] %></td>
                <td><%= batch[1] %></td>
                <td><%= batch[7]%></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="8">No batches available.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else if ("student".equalsIgnoreCase(role)) { %>
        <!-- Student Table -->
        <table>
            <thead>
            <tr>
                <th>Student Index</th>
                <th>Student Name</th>
            </tr>
            </thead>
            <tbody>
            <%
                Object studentData = request.getAttribute("batches");
                if (studentData instanceof List) {
                    List<String[]> students = (List<String[]>) studentData;
                    for (String[] student : students) {
            %>
            <tr>
                <td><%= student[5] %></td>
                <td><%= student[6] %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="8">No students available.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p>No data available for the current role.</p>
        <% } %>

        <!-- Popup delete Form -->
        <div class="popup-overlay">
            <div class="popup-content">
                <span class="popup-close-delete">&times;</span>
                <p>Do you want to delete this batch?</p>
                <div class="popup-buttons">
                    <button class="cancel-btn-delete">Cancel</button>
                    <button class="ok-btn">OK</button>
                </div>
            </div>
        </div>
    </div>
</div>

        <!-- Popup edit Form -->
        <div class="edit-batch">
            <div class="batch-content">
                <span class="batch-close">&times;</span>
                <h3>Edit Batch Details</h3>
                <form id="editFormbatch">
                    <div class="form-group">
                        <label for="batch-id">Batch ID:</label>
                        <input type="text" id="batch-id" class="form-control" name="id" required disabled>
                    </div>
                    <div class="form-group">
                        <label for="batch-name">Batch Name:</label>
                        <input type="text" id="batch-name" class="form-control" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="start-date">Start Date:</label>
                        <input type="date" id="start-date" class="form-control" name="startDate" required>
                    </div>
                    <div class="form-group">
                        <label for="end-date">End Date:</label>
                        <input type="date" id="end-date" class="form-control" name="endDate" required>
                    </div>
                    <div class="form-group">
                        <label for="lecture">Lecturer:</label>
                        <input type="text" id="lecture" class="form-control" name="lecture" required>
                    </div>
                    <div class="popup-buttons">
                        <button type="button" class="cancel">Cancel</button>
                        <button type="submit" class="ok-btn">Save</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Feedback Box -->
        <section>
            <div class="feedback">
                <h2 id="feedbackHeading"><i class="fa fa-comment-dots"></i> Feedback</h2>
                <div class="feedback-box">
                    <textarea id="feedbackBox_batch" placeholder="Enter feedback for the batch..."></textarea>
                    <button onclick="submitFeedback()">Submit Feedback</button>
                </div>
            </div>
        </section>


<script>
    const pageContextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/batch.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
