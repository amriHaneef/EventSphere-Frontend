package com.example.eventspherefrontend.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "announcementController", urlPatterns = "/pages/announcement")
public class announcementController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        // Prepare the list of announcements
        List<String[]> announcements = new ArrayList<>();
        announcements.add(new String[]{"Mock Interview", "John Doe", "14-08-2024",});
        // Adding multiple announcements
        announcements.add(new String[]{"Mock Interview", "John Doe", "14-08-2024"});
        announcements.add(new String[]{"Hackathon", "Alice Smith", "15-08-2024"});
        announcements.add(new String[]{"Seminar", "Bob Johnson", "16-08-2024"});

        // Add announcements to the request
        request.setAttribute("announcements", announcements);


        // Example: Retrieve user role (e.g., from database or session)
        String userRole = "student"; // This should be dynamically retrieved

        // Set the role in the request or session
        HttpSession session = request.getSession();
        session.setAttribute("role", userRole);

        // Forward the request to announcement.jsp
        request.getRequestDispatcher("/pages/announcement.jsp").forward(request, response);
    }
}

