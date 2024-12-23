package com.example.eventspherefrontend.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve username and password from the login form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Perform basic validation
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Example authentication (Replace with database verification)
        if ("admin".equals(username) && "password123".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", username);
            response.sendRedirect("home.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
