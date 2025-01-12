<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role = (String) session.getAttribute("role");
%>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/MyAccount.css">

<div class="header">
    <div class="left">
        <ul class="breadcrumb">
            <li>
                <a href="#">${sessionScope.role}</a>
            </li>
            /
            <li>
                <a href="#" class="active">My Account</a>
            </li>
        </ul>
    </div>
</div>
<div class="bottom-data">
    <div class="orders">
        <div class="container1">
            <div class="leftbox">
                <nav>
                    <a href="#" class="active">
                        <i class="fa fa-user"></i>
                    </a>
                </nav>
            </div>

            <div class="rightbox">
                <div class="profile">
                    <h1>Personal Info</h1>
                    <h2>Full Name</h2>
                    <p><input type="text" placeholder=" Hassnain Haider ">
                        <button class="btn">update</button>
                    </p>
                    <h2>Birthday</h2>
                    <p><input type="text" placeholder="January 5" disabled> </p>
                    <h2>Gender</h2>
                    <p><input type="text" placeholder="Male" disabled></p>
                    <h2>Email</h2>
                    <p><input type="email" placeholder="example@example.com "> <button class="btn">update</button></p>
                    <h2>Password</h2>
                    <p><input type="password" placeholder="********">  <button class="btn change">Change</button></p>
                </div>
            </div>
        </div>

        <!-- Popup Form -->
        <div class="change-overlay">
            <div class="change-content">
                <span class="change-close">&times;</span>
                <h3>Change Your Password Here!</h3>
                <form id="changeForm">
                    <div class="form-group">
                        <label for="current-password">Current Password:</label>
                        <input type="password" id="current-password" class="form-control" name="current-password" required>
                    </div>
                    <div class="form-group">
                        <label for="new-password">New Password:</label>
                        <input type="password" id="new-password" class="form-control" name="new-password" required>
                    </div>
                    <div class="form-group">
                        <label for="re-enter-new-password">Re Enter New Password:</label>
                        <input type="password" id="re-enter-new-password" class="form-control" name="re-enter-new-password" required>
                    </div>
                    <div class="popup-buttons">
                        <button type="button" class="change-cancel">Cancel</button>
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
<script src="${pageContext.request.contextPath}/js/MyAccount.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>

