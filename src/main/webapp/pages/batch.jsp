<%@ page import="java.util.List" %>
<%@ page import="com.example.eventspherefrontend.model.Batch" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String role = (String) session.getAttribute("role");
    String name = (String) session.getAttribute("username");
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
        <form id="addBatchForm" method="post" action="${pageContext.request.contextPath}/pages/batches">
            <input type="hidden" name="addBatch" value="createBatch">

            <div class="form-group">
                <label for="batchname">Batch Name:</label>
                <input type="text" id="batchname" name="batchName" required>
            </div>
            <div class="form-group">
                <label for="consultTd">consultantId:</label>
                <input type="text" id="consultTd" name="consultant" required>
            </div>

            <div class="form-group">
                <label for="startdate">Start Date:</label>
                <input type="date" id="startdate" name="startDate" required>
            </div>

            <div class="form-group">
                <label for="status">status:</label>
                <input type="text" id="status" name="lecturer" required>
            </div>
            <div class="popup-buttons">
                <button type="button" class="cancel-btn">Cancel</button>
                <button type="submit"  class="save-btn">Save</button>
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
        <%
            if ("admin".equalsIgnoreCase(role) || "teacher".equalsIgnoreCase(role) ) {
        %>
        <table>
            <thead>
            <tr>
                <th>Batch ID</th>
                <th>Batch Name</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Status</th>
                <%
                    if ("admin".equalsIgnoreCase(role) ) {
                %>
                <th>Lecturer</th>
                <th>Actions</th>
                <%
                    }
                %>
            </tr>
            </thead>
            <tbody>
            <%
                // Retrieve the List<Batch> from request attributes
                List<Batch> batches = (List<Batch>) request.getAttribute("batches");

                // Iterate through the List<Batch>
                for (Batch batch : batches) {
                    if ("teacher".equalsIgnoreCase(role)) {
                        if(name.equals(batch.getConsultantName())){
            %>
            <tr>
                <td><%= batch.getId() %></td>
                <td><%= batch.getName() %></td>
                <td><%= batch.getStartDate().substring(0, 10) %></td>
                <td><%= batch.getCreatedAt().substring(0, 10) %></td>
                <td><%= batch.getStatus() %></td>
                <%
                    if ("admin".equalsIgnoreCase(role)) {
                %>
                <td><%= batch.getConsultantName() %></td>
                <td>
                    <button class="edit"><i class="bx bx-edit write"></i></button>
                    <button class="delete"><i class="bx bxs-trash bin"></i></button>
                </td>
                <%
                            }
                %>
                <%
                            }
                    }else{
                %>
                <td><%= batch.getId() %></td>
                <td><%= batch.getName() %></td>
                <td><%= batch.getStartDate().substring(0, 10) %></td>
                <td><%= batch.getCreatedAt().substring(0, 10) %></td>
                <td><%= batch.getStatus() %></td>
                <%
                    if ("admin".equalsIgnoreCase(role)) {
                %>
                <td><%= batch.getConsultantName() %></td>
                <td>
                    <button class="edit"><i class="bx bx-edit write"></i></button>
                    <button class="delete"><i class="bx bxs-trash bin"></i></button>
                </td>
                <%
                    }
                %>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
        <%
            }
        %>

        <%
            if ("student".equalsIgnoreCase(role)) {
        %>
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
        <%
            }
        %>

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

<!-- Popup Form -->
<div class="edit-overlay">
    <div class="edit-content">
        <span class="edit-close">&times;</span>
        <h3>Edit Student Details</h3>
        <form id="editForm">
            <div class="form-group">
                <label for="batch-id">Batch ID</label>
                <input type="text" id="batch-id" class="form-control" name="id" required disabled>
            </div>
            <div class="form-group">
                <label for="batch-name">Batch Name</label>
                <input type="text" id="batch-name" class="form-control" name="batch-name" required>
            </div>
            <div class="form-group">
                <label for="start-date">Start Date</label>
                <input type="email" id="start-date" class="form-control" name="start-date" required>
            </div>
            <div class="form-group">
                <label for="end-date">End Date</label>
                <input type="text" id="end-date" class="form-control" name="end-date" required>
            </div>
            <div class="form-group">
                <label for="students">Assigned Students</label>
                <input type="text" id="students" class="form-control" name="students" required disabled>
            </div>
            <div class="form-group">
                <label for="lecturers">Lecturer</label>
                <input type="text" id="lecturers" class="form-control" name="lecturers" required >
            </div>
            <div class="edit-buttons">
                <button type="button" class="edit-cancel">Cancel</button>
                <button type="submit" class="ok-btn">Save</button>
            </div>
        </form>
    </div>
</div>


<script>
    const pageContextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/batch.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
