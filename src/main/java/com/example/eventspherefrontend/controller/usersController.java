package com.example.eventspherefrontend.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "usersController", urlPatterns = "/pages/users")
public class usersController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        // Prepare the list of users
        List<String[]> users = new ArrayList<>();
        users.add(new String[]{"001", "John Doe","JohnDoe@gmail.com", "24-12-2002","GAHDSE24.2"});
        // Adding multiple users
        users.add(new String[]{"002", "John Doe","JohnDoe@gmail.com", "03-01-2000","GADSE21.3"});

        // Add students to the request
        request.setAttribute("users", users);


        // Example: Retrieve user role (e.g., from database or session)
        String userRole = "admin"; // This should be dynamically retrieved

        // Set the role in the request or session
        HttpSession session = request.getSession();
        session.setAttribute("role", userRole);

        // Forward the request to students.jsp
        request.getRequestDispatcher("/pages/Users.jsp").forward(request, response);
    }
}