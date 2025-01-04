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

@WebServlet(name = "AdminEventsController", urlPatterns = "/pages/events")
public class eventcontroller extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Prepare the list of events
        List<String[]> events = new ArrayList<>();
        events.add(new String[]{"01", "Mock Interview", "14-08-2024","9.30 A.M","Zoom","Mrs.Sandaruwani","Done"});
        // Adding multiple events
        events.add(new String[]{"02", "Mock Interview", "14-08-2024","9.30 A.M","Zoom","Mrs.Sandaruwani","Done"});
        events.add(new String[]{"03", "Mock Interview", "14-08-2024","9.30 A.M","Zoom","Mrs.Sandaruwani","Done"});

        // Add announcements to the request
        request.setAttribute("events", events);


        // Example: Retrieve user role (e.g., from database or session)
        String userRole = "teacher"; // This should be dynamically retrieved

        // Set the role in the request or session
        HttpSession session = request.getSession();
        session.setAttribute("role", userRole);

        // Forward the request to AdminEvents.jsp (UI page)
        request.getRequestDispatcher("/pages/events.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle form submissions or API requests here
        String action = request.getParameter("action");

        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action is required");
            return;
        }

        switch (action) {
            case "addEvent":
                addEvent(request, response);
                break;
            case "editEvent":
                editEvent(request, response);
                break;
            case "deleteEvent":
                deleteEvent(request, response);
                break;
            case "searchEvent":
                searchEvent(request, response);
                break;
            case "markAttendance":
                markAttendance(request, response);
                break;
            case "submitFeedback":
                submitFeedback(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action: " + action);
        }
    }

    private void addEvent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String eventName = request.getParameter("eventName");
        String eventDate = request.getParameter("eventDate");
        String batch = request.getParameter("batch");
        String progress = request.getParameter("progress");

        // Logic to add the event (e.g., database logic here)

        response.getWriter().write("Event added successfully!");
    }

    private void editEvent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String eventId = request.getParameter("eventId");
        String eventName = request.getParameter("eventName");
        String eventDate = request.getParameter("eventDate");
        String time = request.getParameter("time");
        String platform = request.getParameter("platform");

        // Logic to edit the event (e.g., database logic here)

        response.getWriter().write("Event updated successfully!");
    }

    private void deleteEvent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String eventId = request.getParameter("eventId");

        // Logic to delete the event (e.g., database logic here)

        response.getWriter().write("Event deleted successfully!");
    }

    private void searchEvent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String query = request.getParameter("query");

        // Logic to search events (e.g., database query and JSON response here)

        response.setContentType("application/json");
        response.getWriter().write("[{\"eventId\":1,\"eventName\":\"Java Workshop\",\"eventDate\":\"2024-12-25\",\"time\":\"9.30 A.M\",\"platform\":Zoom}]");
    }

    private void markAttendance(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] attendeeIds = request.getParameterValues("attendeeIds");

        if (attendeeIds == null || attendeeIds.length == 0) {
            response.getWriter().write("No attendees marked for attendance.");
            return;
        }

        // Logic to save attendance in the database
        // Example: Iterate through attendeeIds and mark attendance in the database

        response.getWriter().write("Attendance marked successfully for attendees: " + String.join(", ", attendeeIds));
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
