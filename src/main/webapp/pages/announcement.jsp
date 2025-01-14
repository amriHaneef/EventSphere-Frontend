<%@ page import="java.util.List" %>
<%@ page import="java.lang.String" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/announcement.css">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">

<%
    String role = (String) session.getAttribute("role");
%>

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
    <a class="report">
        <i class="bx bx-plus"></i>
        <span>Add Announcements</span>
    </a>
    <%
        }
    %>
    <div class="announcement-background">
        <div class="popup-announcement">
            <div class="popup-header">
                <h2>Add Announcement</h2>
                <span class="close-btn">&times;</span>
            </div>
            <form id="announcementForm">
                <label for="announcementName">Announcement Name</label>
                <input type="text" id="announcementName" name="announcementName" placeholder="Enter name" required>

                <label for="announcementDate">Date</label>
                <input type="date" id="announcementDate" name="announcementDate" required>

                <label for="batches">Assign Batches</label>
                <select id="batches" name="batches" multiple>
                    <option value="batch1">Batch 1</option>
                    <option value="batch2">Batch 2</option>
                    <option value="batch3">Batch 3</option>
                </select>

                <div class="buttons">
                    <button type="button" class="cancel">Cancel</button>
                    <button type="submit" class="submit-btn">Submit</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="bottom-data">
    <div class="orders">
        <div class="header">
            <i class="bx bxs-megaphone"></i>
            <h3>Recent Announcements</h3>
            <div class="search-container">
                <label>
                    <input type="text" id="search-bar" class="search-bar" placeholder="Search...">
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
<script>
    const pageContextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/announcement.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>

