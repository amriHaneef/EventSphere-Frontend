<%@ page import="java.util.List" %>
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

<div class="add-batch-popup">
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
        <%
            if ("admin".equalsIgnoreCase(role) || "teacher".equalsIgnoreCase(role)) {
        %>
        <table>
            <thead>
            <tr>
                <th>Batch ID</th>
                <th>Batch Name</th>
                <th>Start Date</th>
                <th>Created Date</th>
<%--                <th>Assign Students</th>--%>
                <% if ("admin".equalsIgnoreCase(role)) { %>
                <th>Consultant</th>
                <th>Actions</th>
                <% } %>
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
                <td><%= batch[3] %></td>
                <td><%= batch[5] %></td>
<%--                <td><%= (batch.length > 7) ? batch[7] : "N/A" %></td>--%>
                <% if ("admin".equalsIgnoreCase(role)) { %>
                <td><%= batch[2] %></td>
                <td>
                    <button class="edit"><i class="bx bx-edit write"></i></button>
                    <button class="delete"><i class="bx bxs-trash bin"></i></button>
                </td>
                <% } %>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7">No batches available.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <%
            }
        %>

        <% if ("student".equalsIgnoreCase(role)) { %>
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
                <td colspan="2">No students available.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>
</div>

<script>
    const pageContextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/batch.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
