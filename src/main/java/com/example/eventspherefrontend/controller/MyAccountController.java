package com.example.eventspherefrontend.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "MyAccountController", urlPatterns = "/pages/accounts")
public class MyAccountController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Example: Retrieve user role (e.g., from database or session)
        String userRole = "teacher"; // This should be dynamically retrieved

        // Set the role in the request or session
        HttpSession session = request.getSession();
        session.setAttribute("role", userRole);

        // Forward the request to students.jsp
        request.getRequestDispatcher("/pages/MyAccount.jsp").forward(request, response);
    }
}