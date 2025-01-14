<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">


</head>
<body class="body">
<div class="container">
  <div class="box">
    <!-- Login Form -->
    <div class="box-login" id="login">
      <div class="top-header">
        <h3>Hello, Again</h3>
        <small>We are happy to have you back</small>
      </div>
      <form action="${pageContext.request.contextPath}/pages/login" method="post">
      <div class="input-group">
          <div class="input-field">
            <input type="text" id="username" name="username" class="input-box" required>
            <label for="username">Username</label>
          </div>
          <div class="input-field">
            <input type="password" id="password" name="password" class="input-box" required>
            <label for="password">Password</label>
            <div class="eye-area">
              <div class="eye-box" onclick="togglePasswordVisibility('password', 'eye', 'eye-slash')">
                <i class="fa-regular fa-eye" id="eye"></i>
                <i class="fa-regular fa-eye-slash" id="eye-slash"></i>
              </div>
            </div>
          </div>
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="error-message">
          <%= request.getAttribute("errorMessage") %>
        </div>
        <% } %>
          <div class="remember">
            <input type="checkbox" name="rememberMe" id="rememberMe">
            <label for="rememberMe">Remember Me</label>
          </div>
          <div class="input-field">
            <input type="submit" value="Sign In" class="input-submit">
          </div>
          <div class="forgot">
            <a href="#">Forgot Password?</a>
          </div>
        </div>
      </form>
    </div>
  </div>

</div>
<canvas id="dotsCanvas"></canvas>
<script src="${pageContext.request.contextPath}/js/login.js"></script>
</body>
</html>
