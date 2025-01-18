
<%@ page import="java.util.List" %>
<%@ page import="java.lang.String" %>
<%@ page import="com.example.eventspherefrontend.model.Announcement" %>
<%@ page import="com.example.eventspherefrontend.model.Batch" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.example.eventspherefrontend.model.User" %>
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
            <form id="announcementForm" action="${pageContext.request.contextPath}/pages/announcement" method="post">
                <input type="hidden" name="action" value="createAnnouncement">

                <label for="announcementName">Announcement Title</label>
                <input type="text" id="announcementName" name="announcementTitle" placeholder="Enter name" required>

                <label for="announcementContent">Announcement Content</label>
                <input type="text" id="announcementContent" name="announcementContent" placeholder="Enter name" required>

                <div class="buttons">
                    <button type="button" class="cancel">Cancel</button>
                    <button type="submit" name="submit" class="submit-btn" value="submit">Submit</button>
                </div>
            </form>
            <div id="successMessage" style="display:none; color: green;"></div>
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
                <th>ID</th>
                <th></th>
                <th>Title</th>
                <th>Content</th>
                <th>Created Date</th>
                <th></th>
            </tr>

            </thead>
            <tbody>

            <%
                // Retrieve the List<Announcement> from request attributes
                List<Announcement> announcements = (List<Announcement>) request.getAttribute("announcements");
                if (announcements != null && !announcements.isEmpty()) {
                    // Reverse the list to start from the last ID to the first
                    Collections.reverse(announcements);
                // Iterate through the List<Announcement>
                for (Announcement announcement : announcements) {
            %>
            <tr>
                <td><%= announcement.getId() %></td>
                <td></td>
                <td><%= announcement.getTitle() %></td>
                <td><%= announcement.getContent()  %></td>
                <td><%= announcement.getCreatedAt().substring(0, 10) %></td>

                <%
                    if  ("admin".equalsIgnoreCase(role) || "teacher".equalsIgnoreCase(role)) {
                %>
                <td>
                    <button class="BatchAdd">
                        <i class='bx bxs-book-open Batch' title="click here to add batches "></i>
                    </button>
                    <button class="studentAdd">
                        <i class="bx bx-group add" title="click here to add students"></i>
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
<%--        -----------Student popup --------------%>
        <div class="student-background">
            <div class="popup-student">
                <div class="popup-header">
                    <h2>Add Students</h2>
                    <span class="student-close-btn">&times;</span>
                </div>
                <form id="studentForm" action="${pageContext.request.contextPath}/pages/announcement" method="post">
                    <input type="hidden" name="action" value="studentAddAnnouncement">
                    <label for="studentAnnouncementName">Announcement Title</label>
                    <input type="text" id="studentAnnouncementName" name="studentAnnouncementName" placeholder="Enter name" disabled required>

                    <input type="hidden" id="studentAnnouncementID" name="studentAnnouncementID"  >

                    <label for="students">Assign Students</label>
                    <select id="students" name="students" multiple required>
                        <%
                            // Retrieve the List<Batch> from request attributes
                            List<User> users = (List<User>) request.getAttribute("users");

                            // Iterate through the List<Batch>
                            for (User user : users) {
                                if("STUDENT".equals(user.getRole())){
                        %>
                        <option value="<%= user.getId()%>"><%= user.getName() %></option>
                        <%
                                }
                            }
                        %>
                    </select>

                    <div class="buttons">
                        <button  class="student-cancel-btn">Cancel</button>
                        <button type="submit" name="student-submit-btn" class="student-submit-btn" value="addStudent">Submit</button>
                    </div>
                </form>
            </div>
        </div>


<%--        --------------batch popup-------------------%>
        <div class="batch-background">
            <div class="popup-batch">
                <div class="popup-header">
                    <h2>Add Batches</h2>
                    <span class="batch-close-btn">&times;</span>
                </div>
                <form id="BatchForm" action="${pageContext.request.contextPath}/pages/announcement" method="post">

                    <input type="hidden" name="action" value="batchAddAnnouncement">

                    <label for="batchAnnouncementName">Announcement Title</label>
                    <input type="text" id="batchAnnouncementName" name="batchAnnouncementName" placeholder="Enter name" disabled>

                    <input type="hidden" id="batchAnnouncementID" name="batchAnnouncementID"  required>

                    <label for="batches">Assign batches</label>
                    <select id="batches" name="batches" multiple>
                        <%
                            // Retrieve the List<Batch> from request attributes
                            List<Batch> batches = (List<Batch>) request.getAttribute("batches");

                            // Iterate through the List<Batch>
                            for (Batch batch : batches) {
                        %>
                        <option value="<%= batch.getId() %>"><%= batch.getName() %></option>
                        <%
                            }
                        %>
                    </select>

                    <div class="buttons">
                        <button  class="batch-cancel-btn">Cancel</button>
                        <button type="submit" name="batch-submit-btn" class="batch-submit-btn" value="addBatch">Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    const pageContextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/announcement.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
