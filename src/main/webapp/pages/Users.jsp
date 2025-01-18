<%@ page import="java.util.List" %>
<%@ page import="java.lang.String" %>
<%@ page import="com.example.eventspherefrontend.model.Batch" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  // Check if 'role' is already declared;
  String role = (String) session.getAttribute("role");
%>
<html>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Users.css">
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

                  <label for="age">Age:</label>
                  <input type="number" name="age" id="age" min="16" max="100" required>

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

  <div class="data">
      <div class="batch-container">
          <%
              // Retrieve the List<Batch> from request attributes
              List<Batch> batches = (List<Batch>) request.getAttribute("batches");

              // Iterate through the List<Batch>
              for (Batch batch : batches) {
          %>
          <div class="header student-head" data-batch-id="batch-<%= String.valueOf(batch.getId()).replaceAll("[^a-zA-Z0-9-_]", "_") %>">
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
                      <th>Batch</th>
                      <th>Age</th>
                      <th>Phone</th>
                      <th></th>
                      <th></th>
                  </tr>
              </thead>
              <tbody>
              <%
                  Object studentsObject = request.getAttribute("students");
                  List<String[]> students = (List<String[]>) studentsObject;
                  for (String[] student : students) {
                      String studentBatch = student[4];
                      if (batch.getName().equals(studentBatch)) {  // Compare with batch name or id
              %>
                <tr>
                  <td><%= student[0] %></td>
                  <td><%= student[1] %></td>
                  <td><%= student[2] %></td>
                  <td><%= student[3] %></td>
                  <td><%= student[4] %></td>
                  <td><%= student[5] %></td>
                  <td><%= student[6] %></td>
                  <td>
                      <button class="edit">
                          <i class="bx bx-edit write"></i>
                      </button>
                  </td>
                  <td>
                      <button class="delete">
                          <i class="bx bxs-trash bin"></i>
                      </button>
                  </td>
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
            <td>
              <button class="edit">
                <i class="bx bx-edit write"></i>
              </button>
            </td>
            <td>
              <button class="delete">
                <i class="bx bxs-trash bin"></i>
              </button>
            </td>
          </tr>
          <%
              }
            }
          %>
          </tbody>
            </table>
            </div>
            <div class="delete-overlay">
                <div class="delete-content">
                    <span class="delete-close">&times;</span>
                    <p>Do you want to delete this announcement?</p>
                    <div class="delete-buttons">
                        <button class="cancel-btn-delete">Cancel</button>
                        <button class="ok-btn-delete">OK</button>
                    </div>
                </div>
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
    </div>

<script>
  const pageContextPath = "${pageContext.request.contextPath}";
</script>

<script src="${pageContext.request.contextPath}/js/Users.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>

</html>
