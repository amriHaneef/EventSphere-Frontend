package com.example.eventspherefrontend.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AdminEventsController", urlPatterns = "/pages/AdminEvents")
public class eventcontroller extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to AdminEvents.jsp (UI page)
        request.getRequestDispatcher("/pages/AdminEvents.jsp").forward(request, response);
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
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action: " + action);
        }
    }

    private void addEvent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve event details from the request and process them
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
        String batch = request.getParameter("batch");
        String progress = request.getParameter("progress");

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
        response.getWriter().write("[{\"eventId\":1,\"eventName\":\"Sample Event\",\"eventDate\":\"2024-12-25\",\"batch\":\"Batch A\",\"progress\":75}]");
    }
}
