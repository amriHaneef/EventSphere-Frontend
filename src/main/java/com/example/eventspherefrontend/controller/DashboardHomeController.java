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

@WebServlet(name = "DashboardHomeController", urlPatterns = "/pages/Home")
public class DashboardHomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Prepare the list of announcements
        List<String[]> events = new ArrayList<>();
        events.add(new String[]{"001","Mock Interview", "14-08-2024","GADSE23.1","sadaruwani"});
        // Adding multiple events
        events.add(new String[]{"002","Mock Interview", "14-08-2024","GADSE24.1","sadaruwani"});
        events.add(new String[]{"003","Hackathon", "15-08-2024","GADSE22.1","sadaruwani"});
        events.add(new String[]{"004","Seminar", "16-08-2024","GADSE23.2", "Bob Johnson",});

        // Add events to the request
        request.setAttribute("events", events);



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
        if (session.getAttribute("role") == null) {
            session.setAttribute("role", userRole);
        }
        // Forward the request to DashboardHome.jsp
        request.getRequestDispatcher("/pages/DashboardHome.jsp").forward(request, response);
    }
}
