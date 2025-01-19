<%@ page import="java.util.List" %>
<%@ page import="java.lang.String" %>
<%@ page import="com.example.eventspherefrontend.model.Batch" %>
<%@ page import="com.example.eventspherefrontend.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  // Check if 'role' is already declared;
  String role = (String) session.getAttribute("role");
%>
<html>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Users.css">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
  <style>
      /* Hide the batch field initially */
      /*#batchField {*/
      /*    display: none;*/
      /*}*/
  </style>


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
              <form id="UserAddForm" action="${pageContext.request.contextPath}/pages/users" method="post" >

                <div class="card imgholder">
                  <img src="${pageContext.request.contextPath}/images/noprofil.jpg" id="imagePreview" alt="" width="200" height="200" class="img">
                </div>
                <div class="inputField">
                  <label for="name">Name:</label>
                  <input type="text" name="username" id="name" required>

                  <label for="email">E-mail:</label>
                  <input type="email" name="email" id="email" required>

                  <label for="birthday">Birthday:</label>
                  <input type="date" name="birthday" id="birthday" required>

                  <label for="age">Age:</label>
                  <input type="number" name="age" id="age" min="16" max="100" required>

                  <label for="password">Password:</label>
                  <input type="password" name="password" id="password"  required>

                  <label for="userType">User Type:</label>
                  <select id="userType" name="userType" required>
                    <option value="" disabled selected>Select a User Type</option>
                    <option value="ADMIN">Admin </option>
                    <option value="TEACHER">Teacher </option>
                    <option value="STUDENT">Student</option>
                    <!-- Add more options as needed -->
                  </select>

<%--                  <div id="batchField">--%>
<%--                    <label for="batch">Batch:</label>--%>
<%--                      <br>--%>
<%--                    <select id="batch">--%>
<%--                      <option value="" disabled selected>Select a batch</option>--%>
<%--                        <%--%>
<%--                            List<Batch> batches = (List<Batch>) request.getAttribute("batches");--%>
<%--                            for (Batch batch : batches) {--%>
<%--                        %>--%>
<%--                      <option value="<%= batch.getId() %>"><%= batch.getName() %></option>--%>
<%--                        <%--%>
<%--                            }--%>
<%--                        %>--%>
<%--                    </select>--%>
<%--                  </div>--%>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" onclick="closeModal()">Close</button>
              <button type="submit" form="UserAddForm" class="btn btn-primary submit">Submit</button>
            </div>
          </div>
        </div>
      </div>
    </div>

  <div class="data">
      <div class="batch-container">
          <%
              List<Batch> batches = (List<Batch>) request.getAttribute("batches");
              // Iterate through the List<Batch>
              for (Batch batch : batches) {
          %>
          <div class="header student-head" data-batch-id="batch-<%= String.valueOf(batch.getId()).replaceAll("[^a-zA-Z0-9-_]", "_") %>" url-batch-id="<%=String.valueOf(batch.getId()) %>">
              <div class="batch" >
                  <h3>Batch: <%= batch.getName() %></h3>
              </div>
          </div>
          <table id="batch-<%= String.valueOf(batch.getId()).replaceAll("[^a-zA-Z0-9-_]", "_") %>" class="student-details hidden">
              <thead>
                  <tr>
                      <th>ID</th>
                      <th>Name</th>
                      <th>Email</th>
                      <th>Birthday</th>
                      <th>Age</th>
                      <th></th>
                      <th></th>
                  </tr>
              </thead>
              <tbody>
              <%
                  List<User> students = (List<User>) request.getAttribute("students");

                  // Iterate through the List<Batch>
                  for (User student : students) { // Compare with batch name or id

              %>
                <tr>
                  <td><%= student.getId() %></td>
                  <td><%= student.getName() %></td>
                  <td><%= student.getEmail() %></td>
                  <td><%= student.getAge() %></td>
                  <td>
                      <button class="edit">
                          <i class="bx bx-edit write"></i>
                      </button>
                  </td>
                  <td>
                      <button class="delete" data-user-id="<%= student.getId()%>">
                          <i class="bx bxs-trash bin"></i>
                      </button>
                  </td>
                </tr>
                <%
                            }
                %>
              </tbody>
          </table>
          <%
              }
          %>

      </div>
  </div>

    <div class="bottom-data">
        <div class="orders">
            <div class="header">
                  <i class="bx bx-group"></i>
                  <h3>Teacher Details</h3>
                  <div class="search-container">
                <label>
                    <input type="text" id="search-bar" class="search-bar" placeholder="Search...">
                </label>
            </div>
        <table>
          <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Birthday</th>
            <th></th>
            <th></th>
          </tr>
          </thead>
          <tbody class="teacher-details">
          <%
              // Retrieve the List<Batch> from request attributes
              List<User> users = (List<User>) request.getAttribute("users");

              // Iterate through the List<Batch>
              for (User user : users) {
                      if("TEACHER".equals(user.getRole())){
          %>
          <tr>
            <td><%= user.getId() %></td>
            <td><%= user.getName()   %></td>
            <td><%= user.getEmail() %></td>
              <%
                  if (user.getDob() == null || user.getDob().length() < 10) {
                      user.setDob("N/A");
              %>
              <td>N/A</td>
              <%
                  }else{
              %>
            <td><%= user.getDob().substring(0, 10) %></td>
              <%
                  }
              %>
            <td>
              <button class="edit">
                <i class="bx bx-edit write"></i>
              </button>
            </td>
            <td>
                <button class="delete" >
                    <i class="bx bxs-trash bin"></i>
                </button>
            </td>
          </tr>
          <div class="delete-overlay">
              <div class="delete-content">
                  <span class="delete-close">&times;</span>
                  <p>Do you want to delete this announcement?</p>
                  <div class="delete-buttons">
                      <button class="cancel-btn-delete">Cancel</button>
                      <button class="ok-btn-delete" data-user-id="<%= user.getId()%>">OK</button>
                  </div>
              </div>
          </div>
          <%
              }
            }
          %>
          </tbody>
            </table>
            </div>

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




        <div class="orders">
            <div class="header">
                  <i class="bx bx-group"></i>
                  <h3>Admin Details</h3>
                  <div class="search-container">
                <label>
                    <input type="text" id="search-bar" class="search-bar" placeholder="Search...">
                </label>
            </div>
        <table>
          <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Birthday</th>
            <th></th>
            <th></th>
          </tr>
          </thead>
          <tbody class="teacher-details">
          <%
              // Iterate through the List<Batch>
              for (User user : users) {
                      if("ADMIN".equals(user.getRole())){
          %>
          <tr>
            <td><%= user.getId() %></td>
            <td><%= user.getName()   %></td>
            <td><%= user.getEmail() %></td>
              <%
                  if (user.getDob() == null || user.getDob().length() < 10) {
                      user.setDob("N/A");
              %>
              <td>N/A</td>
              <%
                  }else{
              %>
            <td><%= user.getDob().substring(0, 10) %></td>
              <%
                  }
              %>
            <td>
              <button class="edit">
                <i class="bx bx-edit write"></i>
              </button>
            </td>
            <td>
                <button class="delete" >
                    <i class="bx bxs-trash bin"></i>
                </button>
            </td>
          </tr>
          <div class="delete-overlay">
              <div class="delete-content">
                  <span class="delete-close">&times;</span>
                  <p>Do you want to delete this announcement?</p>
                  <div class="delete-buttons">
                      <button class="cancel-btn-delete">Cancel</button>
                      <button class="ok-btn-delete" data-user-id="<%= user.getId()%>">OK</button>
                  </div>
              </div>
          </div>
          <%
              }
            }
          %>
          </tbody>
            </table>
            </div>


        </div>
        </div>


<script>
  const pageContextPath = "${pageContext.request.contextPath}";
</script>

<script src="${pageContext.request.contextPath}/js/Users.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>

</html>
