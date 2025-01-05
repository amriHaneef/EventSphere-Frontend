<%@ page import="java.util.List" %>
<%@ page import="java.lang.String" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String role = (String) session.getAttribute("role");
%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/batch.css">
<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
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
                <a href="#" class="active">Events</a>
            </li>
        </ul>
    </div>
    <%
        if ("teacher".equalsIgnoreCase(role)) {
    %>
    <a class="report">
        <i class="bx bx-plus"></i>
        <span>Add Events</span>
    </a>
    <%
        }
    %>
</div>

<div class="bottom-data">
    <div class="orders">
        <div class="header">
            <i class="bx bx-calendar-check"></i>
            <h3>Batch</h3>
            <div class="search-container">
                <label>
                    <input type="text" id="search-bar" class="search-bar" placeholder="Search...">
                </label>
            </div>
        </div>
        <table>
            <thead>
            <tr>
                <th>Batch ID</th>
                <th>Batch Name</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Lecturer</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <%
                // Retrieve and safely cast events
                Object eventsObject = request.getAttribute("batches"); // Correct attribute name
                if (eventsObject instanceof List) {
                    List<String[]> events = (List<String[]>) eventsObject;
                    for (String[] event : events) {
            %>
            <tr>
                <td><%= event[0] %></td>
                <td><%= event[1] %></td>
                <td><%= event[2] %></td>
                <td><%= event[3] %></td>
                <td><%= event[4] %></td>
                <%
                    if ("admin".equalsIgnoreCase(role) || "teacher".equalsIgnoreCase(role)) {
                %>
                <td>
                    <button class="delete">
                        <i class="bx bxs-trash bin"></i>
                    </button>
                </td>
                <%
                    if ("teacher".equalsIgnoreCase(role)) {
                %>
                <td>
                    <button class="edit">
                        <i class="bx bx-edit write"></i>
                    </button>
                </td>
                <%
                        }
                    }
                %>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="6">No data available</td>
            </tr>
            <%
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

<!-- Feedback Box -->
<section>
    <div class="feedback">
        <h2 id="feedbackHeading"><i class="fa fa-comment-dots"></i> Feedback</h2>
        <div class="feedback-box">
            <textarea id="feedbackBox_student" placeholder="Enter feedback for the batch..."></textarea>
            <button onclick="submitFeedback()">Submit Feedback</button>
        </div>
    </div>
</section>

<script>
    const pageContextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/batch.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
