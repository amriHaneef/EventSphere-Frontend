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

@WebServlet(name = "EventController", urlPatterns = "/pages/events")
public class EventController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");

        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }


        // Prepare the list of events
        List<String[]> events = new ArrayList<>();
        events.add(new String[]{"01", "Mock Interview", "14-08-2024", "9.30 A.M", "Zoom", "Mrs.Sandaruwani", "Done"});
        // Adding multiple events
        events.add(new String[]{"02", "Mock Interview", "14-08-2024", "9.30 A.M", "Zoom", "Mrs.Sandaruwani", "Done"});
        events.add(new String[]{"03", "Mock Interview", "14-08-2024", "9.30 A.M", "Zoom", "Mrs.Sandaruwani", "Done"});

        // Add announcements to the request
        request.setAttribute("events", events);



        // Forward the request to AdminEvents.jsp (UI page)
        request.getRequestDispatcher("/pages/events.jsp").forward(request, response);
    }

    private void submitFeedback(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String eventId = request.getParameter("eventId");
        String feedback = request.getParameter("feedback");

        if (feedback == null || feedback.trim().isEmpty()) {
            response.getWriter().write("Feedback cannot be empty.");
            return;
        }

        // Logic to save feedback in the database
        // Example: Insert feedback associated with the eventId into the database

        response.getWriter().write("Feedback submitted successfully for event ID: " + eventId);
    }
}